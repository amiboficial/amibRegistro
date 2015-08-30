package mx.amib.sistemas.registro.apoderamiento.service

import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.documentos.service.DocumentoPoderRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRevocacionRepositorioTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoResultTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO
import mx.amib.sistemas.registro.apoderado.service.RevocadoTO

// TODO: Implementar logging en este servicio dado que en estos métodos se hace 
// llamada a múltiples servicios, si alguno falla, se rastrea inmediatamente el 
// error. (cuestiones de integridad en "transacciones distribuidas")
@Transactional
class ApoderamientoService {

	def sustentanteService
	def documentoRepositorioService
	
	def autorizacionService
	def poderService
	def apoderadoService
	def revocacionService
	def revocadoService
	
    PoderTO altaPoder(PoderTO poder) {
		//Llama al servicio de oficios donde guarda los datos del poder
		PoderTO savedPoder = poderService.save(poder)
		
		//Llama al servicio de autorizacion (amibExpediente) para apoderar las autorizaciones correspondientes
		//a una determinada certificación
		def listIdCerts = poder.apoderados.collect{ it.idCertificacion }
		autorizacionService.apoderar(listIdCerts)
		
		//Llama al servicio de repositorio de documentos (amibDocumentos) para
		//enviar el documento de respaldo que ha sido cargado previamiente
		//en el espacio temporal otorgado por el servicio de Archivos Temporales
		def documentoCol = new ArrayList<DocumentoRepositorioTO>()
		documentoCol.add( this.obtenerDocumentoConMetadatos(poder) )
		documentoRepositorioService.enviarDocumentosArchivoTemporal( documentoCol )
		
		//Regresa una instancia con el poder ya guardado
		return savedPoder
    }
	SustentanteTO obtenerApoderable(int numeroMatricula){
		SustentanteTO s = sustentanteService.findByMatricula(numeroMatricula)
		boolean isApoderable = false
		
		//println (s as JSON)
		
		if(s != null){
			if(s.certificaciones.size() > 0){
				//ordena las certificaciones por fecha
				s.certificaciones = s.certificaciones.sort{it.fechaFin}
				//revisa la ultima certificación
				CertificacionTO c = s.certificaciones.last()
				//revisa que sea vigente
				if(Calendar.getInstance().getTime().before(c.fechaFin)){
					//revisa que el status se encuentre en autorizado sin poderes
					if(c.statusAutorizacion.id.value == StatusAutorizacionTypes.AUTORIZADO_SIN_PODERES){
						isApoderable = true
					}	
				}
			}
		}
		if(!isApoderable) s = null 
		
		return s
	}
	PoderTO editarDatosPoder(PoderTO poder) {
		def modobj = poderService.get(poder.id)
		//Edita solo los datos de poder y no sus apoderados
		modobj.idGrupoFinanciero = poder.idGrupoFinanciero
		modobj.idInstitucion = poder.idInstitucion
		modobj.idNotario = poder.idNotario
		modobj.numeroEscritura = poder.numeroEscritura
		modobj.representanteLegalNombre = poder.representanteLegalNombre
		modobj.representanteLegalApellido1 = poder.representanteLegalApellido1
		modobj.representanteLegalApellido2 = poder.representanteLegalApellido2
		modobj.fechaApoderamiento = poder.fechaApoderamiento
		modobj.uuidDocumentoRespaldo = poder.uuidDocumentoRespaldo
		
		return poderService.update(modobj)
	}
	PoderTO quitarApoderados(Long idPoder, List<Long> multipleIdApoderado){
		def modobj = poderService.get(idPoder)
		List<ApoderadoTO> toDelete = new ArrayList<ApoderadoTO>()
		modobj.apoderados.each{
			if( multipleIdApoderado.contains(it.id) )
				toDelete.add(it)
		}
		toDelete.each {
			modobj.apoderados.remove(it)
		}
		
		autorizacionService.deshacerApoderar( modobj.apoderados.collect{ it.idCertificacion }  )
		return poderService.update(modobj)
	}
	PoderTO agregarApoderados(Long idPoder, List<ApoderadoTO> apoderados){
		def modobj = poderService.get(idPoder)
		modobj.apoderados.addAll(apoderados)
		
		autorizacionService.apoderar( modobj.apoderados.collect{ it.idCertificacion } )
		return poderService.update(modobj)
	}
	
	RevocacionTO altaRevocacion(RevocacionTO revocacion){
		RevocacionTO r
		List<Long> idsCert
		
		//guarda el oficio
		r = revocacionService.save(revocacion)
		//obtiene información de certificacion de los aporamientos a revocar
		idsCert = apoderadoService.getAll(r.revocados.collect{ it.idApoderado }.toSet()).apoderados.collect{ it.idCertificacion }
		//aplica el status de "Autorizado sin poderes" si es que se encontraba
		//"Autorizado con poderes"
		autorizacionService.revocar(idsCert)
		//Llama al servicio de repositorio de documentos (amibDocumentos) para
		//enviar el documento de respaldo que ha sido cargado previamiente
		//en el espacio temporal otorgado por el servicio de Archivos Temporales
		def documentoCol = new ArrayList<DocumentoRepositorioTO>()
		documentoCol.add( this.obtenerDocumentoConMetadatos(revocacion) )
		documentoRepositorioService.enviarDocumentosArchivoTemporal( documentoCol )
		
		//Regresa una instancia con la revocacion ya guardada
		return r
	}
	List<ApoderadoTO> obtenerApoderamientosRevocables(int numeroMatricula){
		SustentanteTO s
		ApoderadoResultTO ares
		Map<Long, Boolean> apoderadosRevocados
		List<CertificacionTO> certs
		List<ApoderadoTO> apoderadosSinRevocacion = new ArrayList<ApoderadoTO>()
		
		//obtiene al sustentante
		//obtiene sus certificaciones
		//obtiene los apoderamientos correspondientes a las certificaciones
		//obtiene las posibles revocaciones de esos apoderamientos
		//los apoderamientos ya revocados se descartan
		//se retorna la lista de apoderamientos
		s = sustentanteService.findByMatricula(numeroMatricula)
		if(s != null){
			certs = s.certificaciones //obtiene las ceritificaciones del sustentante
			ares = apoderadoService.findAllByIdCertificacionIn(new HashSet<Long>( s.certificaciones.collect{ it.id } )) //obtiene los "apoderados" por cada certificacion
			apoderadosRevocados = revocadoService.containsRevocados(new HashSet<Long>( ares.apoderados.collect{ it.id } )) //revisa que "apoderados" ya fueron revocados
			apoderadosRevocados.each{ x ->
				if(x.value.booleanValue() == false){
					apoderadosSinRevocacion.add(ares.apoderados.find{ it.id.longValue() == ((Long)x.key).longValue() });
				}			
			}
		}
		return apoderadosSinRevocacion
	}
	RevocacionTO editarDatosRevocacion(RevocacionTO revocacion){
		def modobj = revocacionService.get(revocacion.id)
		
		//Edita solo los datos de poder y no sus revocados
		modobj.idGrupoFinanciero = revocacion.idGrupoFinanciero
		modobj.idInstitucion = revocacion.idInstitucion
		modobj.idNotario = revocacion.idNotario
		modobj.numeroEscritura = revocacion.numeroEscritura
		modobj.representanteLegalNombre = revocacion.representanteLegalNombre
		modobj.representanteLegalApellido1 = revocacion.representanteLegalApellido1
		modobj.representanteLegalApellido2 = revocacion.representanteLegalApellido2
		modobj.fechaRevocacion = revocacion.fechaRevocacion
		modobj.uuidDocumentoRespaldo = revocacion.uuidDocumentoRespaldo
		//guarda el oficio
		return revocacionService.update(revocacion)
	}
	RevocacionTO quitarRevocados(Long idRevocacion, List<Long> multipleIdRevocado){
		def modobj = revocacionService.get(idRevocacion)
		List<RevocadoTO> toDelete = new ArrayList<RevocadoTO>()
		modobj.revocados.each{
			if( multipleIdRevocado.contains(it.id) )
				toDelete.add(it)
		}
		toDelete.each {
			modobj.revocados.remove(it)
		}
		//deshace el status si es posible, antes de que los ids se eliminen
		def listIdCerts = revocadoService.getIdsCertificacion(multipleIdRevocado)
		autorizacionService.deshacerRevocar(listIdCerts)
		//guarda el oficio
		return revocacionService.update(modobj)
	}
	RevocacionTO agregarRevocados(Long idRevocacion, List<RevocadoTO> revocados){
		def modobj = revocacionService.get(idRevocacion)
		modobj.revocados.addAll(revocados)
		
		//guarda el oficio
		def newRevocacion = revocacionService.update(modobj)
		//ya teniendo ids, aplica el status si es posible
		def listIdCerts = revocadoService.getIdsCertificacion(newRevocacion.revocados.collect{it.id})
		autorizacionService.revocar(listIdCerts)
		
		return newRevocacion
	}
	
	private DocumentoPoderRepositorioTO obtenerDocumentoConMetadatos(PoderTO poder){
		//TODO: Llamar a otros servicios para complementar los metadatos
		
		DocumentoPoderRepositorioTO d = new DocumentoPoderRepositorioTO()
		
		d.id = null
		d.uuid = poder.uuidDocumentoRespaldo
		d.tipoDocumentoRespaldo = "Escrito de apoderamiento"
		d.representanteLegalNombreCompleto = poder?.representanteLegalNombre + " " + poder?.representanteLegalApellido1 + " " + poder?.representanteLegalApellido2
		d.numeroEscritura = poder.numeroEscritura
		d.fechaApoderamiento = poder.fechaApoderamiento
		d.matriculasApoderados = ""
		d.nombresApoderados = ""
		poder.apoderados.each{ x ->
			d.matriculasApoderados += "X" + ";"
			d.nombresApoderados += "Y" + ";"
		}
		d.notario = "Número: " + "X" + "; " + "Nombre: " + "X" + "Y" + "Z"
		d.grupoFinanciero = poder.idGrupoFinanciero
		d.institucion = poder.idInstitucion
		
		return d
	}
	
	private DocumentoRevocacionRepositorioTO obtenerDocumentoConMetadatos(RevocacionTO revocacion){
		DocumentoRevocacionRepositorioTO d = new DocumentoRevocacionRepositorioTO()
		
		d.id = null
		d.uuid = revocacion.uuidDocumentoRespaldo
		d.tipoDocumentoRespaldo = "Escrito de revocación"
		d.representanteLegalNombreCompleto = revocacion?.representanteLegalNombre + " " + revocacion?.representanteLegalApellido1 + " " + revocacion?.representanteLegalApellido2
		d.numeroEscritura = revocacion.numeroEscritura
		d.fechaRevocacion = revocacion.fechaRevocacion
		d.matriculasRevocados = ""
		d.nombresRevocados = ""
		revocacion.revocados.each{ x ->
			d.matriculasRevocados += "X" + ";"
			d.nombresRevocados += "Y" + ";"
		}
		d.notario = "Número: " + "X" + "; " + "Nombre: " + "X" + "Y" + "Z"
		d.grupoFinanciero = revocacion.idGrupoFinanciero
		d.institucion = revocacion.idInstitucion
		
		return d
	}
}
