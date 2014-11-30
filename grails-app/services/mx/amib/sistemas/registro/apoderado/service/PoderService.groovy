package mx.amib.sistemas.registro.apoderado.service

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;

import grails.transaction.Transactional
import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import mx.amib.sistemas.registro.apoderamiento.model.Apoderado
import mx.amib.sistemas.registro.apoderamiento.model.AutorizadoCNBV
import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoPoder
import mx.amib.sistemas.registro.apoderamiento.model.Poder
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.documentos.service.DocumentoPoderRepositorioTO;
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService;
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO;
import mx.amib.sistemas.registro.notario.model.Notario
import mx.amib.sistemas.registro.notario.service.NotarioService
import groovy.json.StringEscapeUtils

@Transactional
class PoderService {

	NotarioService notarioService
	DocumentoRepositorioService documentoRepositorioService
	SepomexService sepomexService
	EntidadFinancieraService entidadFinancieraService
		
	Collection<TipoDocumentoRespaldoPoder> obtenerListadoTipoDocumentoRespaldoPoder() {
		return TipoDocumentoRespaldoPoder.findAllByVigente(true)
	}
			
	//Obtiene errores de acuerdo a validaciones de reglas de negocio
	//Este tipo de método validaría que la información sea coherente,
	//dado que apesar de que haya validaciones del lado del cliente
	//en javascript, siempre es posible "inyectar" valores a las
	//peticiones HTTP
	Collection<PoderIntegrityError> validateBusinessIntegrity(Poder poder){
		return null
	}
	
	//Guarda el modelo
	Poder save(Poder poder, int notarioNumero, int notarioIdEntidadFederativa, 
								List<Long> apoderadosIdAutorizadoCNBV, List<DocumentoRespaldoPoderTO> documentosGuardados){
		//arma el poder de acuerdo a los paramtros recibidos
		poder = this.buildFromParamsToSave(poder, notarioNumero, notarioIdEntidadFederativa, apoderadosIdAutorizadoCNBV, documentosGuardados)
		//guarda los documentos en el repositorio
		this.saveDocsOnRepository(poder)
		//guarda en la BD
		return poder.save(flush:true)
	}
	
	//Contruye el modelo a guardar
	private Poder buildFromParamsToSave(Poder poder, int notarioNumero, int notarioIdEntidadFederativa,
								List<Long> apoderadosIdAutorizadoCNBV, List<DocumentoRespaldoPoderTO> documentosGuardados){
								
		//los parametros numericos que son -1, se convierten a null
		if(poder.idGrupofinanciero==-1){ poder.idGrupofinanciero=null }
		if(poder.idInstitucion==-1){ poder.idInstitucion=null }
		
		Notario n = notarioService.obtenerNotario(notarioIdEntidadFederativa, notarioNumero)
		poder.notario = n
		
		poder.apoderados = new HashSet<Apoderado>()
		apoderadosIdAutorizadoCNBV.each {
			AutorizadoCNBV acnbv = AutorizadoCNBV.get(it)
						
			Apoderado a = new Apoderado()
			a.poder = poder
			a.autorizado = acnbv
			
			poder.apoderados.add(a)
		}
		
		poder.documentosRespaldoPoder = new HashSet<DocumentoRespaldoPoder>()
		documentosGuardados.each {
			DocumentoRespaldoPoder drp = new DocumentoRespaldoPoder()
			
			drp.uuidDocumentoRepositorio = it.uuid
			drp.tipoDocumentoRespaldoPoder = TipoDocumentoRespaldoPoder.get(it.idTipoDocumento)
			drp.poder = poder
			
			poder.documentosRespaldoPoder.add(drp)
		}
		
		//en cuanto se implemente la sesión con atributos
		//debera adecuarse de acuerdo a si quien esta subiendo el cambio
		//es una entidadFinanciera o institucion
		//o en caso de ser un ADMON, se omite este paso
		
		//SOLO PARA EFECTOS DE PRUEBA, SE ASIGNA A TODOS 6
		//HASTA QUE ESTEN IMPLEMENTADO SPRING SECURITY
		//SE PODRÁ HACER EL CAMBIO
		if(poder.idGrupofinanciero == null)
		{
			poder.idGrupofinanciero = 6
			poder.idInstitucion = null
		}
		
		if(poder.idInstitucion == null)
			poder.esRegistradoPorGrupoFinanciero = true
		else
			poder.esRegistradoPorGrupoFinanciero = false
		
		
		//fechas
		poder.fechaCreacion = new Date()
		poder.fechaModificacion = new Date()
		
		return poder
	}
	
	Poder update(Poder poder, int notarioNumero, int notarioIdEntidadFederativa,
				List<Long> apoderadosIdAutorizadoCNBV, List<DocumentoRespaldoPoderTO> documentosActuales,
				List<DocumentoRespaldoPoderTO> documentosNuevos){
							
		//los parametros numericos que son -1, se convierten a null
		if(poder.idGrupofinanciero==-1){ poder.idGrupofinanciero=null }
		if(poder.idInstitucion==-1){ poder.idInstitucion=null }
								
		Notario n = notarioService.obtenerNotario(notarioIdEntidadFederativa, notarioNumero)
		poder.notario = n
		
		//borra apoderados que no se hayan guardado y conserva los que no se modificaron
		def apoant = Apoderado.findAllByPoder(poder)
		def apBorrar = new ArrayList<Apoderado>();
		def apSinModificar = new ArrayList<Apoderado>();
		apoant.each{ apant ->
			if( apoderadosIdAutorizadoCNBV.find{ _apid -> _apid.longValue() == apant.autorizado.id.longValue() } == null ){
				//println "no encontro id de autorizado: " + _apid
				apBorrar.add(apant)
			}
			else{
				apSinModificar.add(apant)
			}
		}
		apBorrar.each{
			poder.apoderados.remove(it)
			it.delete(flush:true)
		}
		//inserta nuevos
		apoderadosIdAutorizadoCNBV.each { _apid ->
			//si no se encuentra en la lista "sin modificar"
			if( apSinModificar.find{ _ap -> _ap.autorizado.id.longValue() == _apid.longValue() } == null ){
				AutorizadoCNBV acnbv = AutorizadoCNBV.get(_apid)
				Apoderado a = new Apoderado()
				a.poder = poder
				a.autorizado = acnbv
				poder.apoderados.add(a)
			}
		}
		
		//obtiene docs a borrar
		List<DocumentoRespaldoPoderTO> docsBorrar = new ArrayList<DocumentoRespaldoPoder>()
		def uuidsDocsBorrar = new ArrayList<String>()
		//por cada documento ya guardado
		poder.documentosRespaldoPoder.each{ drp ->
			//si no se encuentra dentro de los que se van a guardar, entonces será borrado
			if( documentosActuales.find{drptoAct -> drptoAct.uuid == drp.uuidDocumentoRepositorio } == null ){
				docsBorrar.add( new DocumentoRespaldoPoderTO([id:drp.id,uuid:drp.uuidDocumentoRepositorio]) )
				uuidsDocsBorrar.add( drp.uuidDocumentoRepositorio )
			}
		}
		
		//borra registros de docs que ya no se guardaran
		docsBorrar.each{
			def doc = DocumentoRespaldoPoder.get(it.id)
			poder.documentosRespaldoPoder.remove(doc)
			doc.delete(flush:true)
		}
		//inserta nuevos registros
		documentosNuevos.each{
			DocumentoRespaldoPoder drp = new DocumentoRespaldoPoder()
			drp.uuidDocumentoRepositorio = it.uuid
			drp.tipoDocumentoRespaldoPoder = TipoDocumentoRespaldoPoder.get(it.idTipoDocumento)
			drp.poder = poder
			poder.documentosRespaldoPoder.add(drp)
		}
		
		
		//en cuanto se implemente la sesión con atributos
		//debera adecuarse de acuerdo a si quien esta subiendo el cambio
		//es una entidadFinanciera o institucion
		//o en caso de ser un ADMON, se omite este paso
		
		//SOLO PARA EFECTOS DE PRUEBA, SE ASIGNA A TODOS 6
		//HASTA QUE ESTEN IMPLEMENTADO SPRING SECURITY
		//SE PODRÁ HACER EL CAMBIO
		if(poder.idGrupofinanciero == null)
		{
			poder.idGrupofinanciero = 6
			poder.idInstitucion = null
		}
		//poder.idInstitucion = null
		
		if(poder.idInstitucion == null)
			poder.esRegistradoPorGrupoFinanciero = true
		else
			poder.esRegistradoPorGrupoFinanciero = false
		
		
		//fechas
		poder.fechaModificacion = new Date()
		
		//borra los documentos que ya no se usarán mas
		documentoRepositorioService.eliminarDocumentos(uuidsDocsBorrar)
		//actualiza los metadatos de los documentos que no se movieron
		this.updateDocsOnRepository(poder,documentosActuales)
		//envía unicamente documentos nuevos
		this.updateNewDocsOnRepository(poder,documentosNuevos)
		
		//guarda en la BD
			return poder.save(flush:true)
	}
															
	//Actualiza los metadatos de los documentos
	def updateDocsOnRepository(Poder poder, Collection<DocumentoRepositorioTO> drpts){
		List<DocumentoRepositorioTO> docsEnviar = new ArrayList<DocumentoRepositorioTO>()
		
		drpts.each{
			DocumentoPoderRepositorioTO docEnviar = new DocumentoPoderRepositorioTO()
			
			docEnviar.id = null
			docEnviar.uuid = it.uuid
			
			docEnviar.tipoDocumentoRespaldo = TipoDocumentoRespaldoPoder.get(it.idTipoDocumento).descripcion
			docEnviar.representanteLegalNombre = poder.representanteLegalNombre
			docEnviar.representanteLegalApellido1 = poder.representanteLegalApellido1
			docEnviar.representanteLegalApellido2 = poder.representanteLegalApellido2
			docEnviar.esRegistradoPorGrupoFinanciero = poder.esRegistradoPorGrupoFinanciero
			docEnviar.numeroEscritura = poder.numeroEscritura
			docEnviar.fechaApoderamiento = poder.fechaApoderamiento
			docEnviar.jsonApoderados = poder.apoderados as JSON
			docEnviar.jsonNotario = poder.notario as JSON
			
			docEnviar.jsonApoderados = StringEscapeUtils.unescapeJava(docEnviar.jsonApoderados)
			docEnviar.jsonNotario = StringEscapeUtils.unescapeJava(docEnviar.jsonNotario)
				
			if(poder.esRegistradoPorGrupoFinanciero == true)
			{
				docEnviar.jsonGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(poder.idGrupofinanciero) as JSON
				docEnviar.jsonInstitucion = null
				docEnviar.jsonGrupoFinanciero = StringEscapeUtils.unescapeJava(docEnviar.jsonGrupoFinanciero)
			}
			else
			{
				docEnviar.jsonGrupoFinanciero = null
				docEnviar.jsonInstitucion = entidadFinancieraService.obtenerInstitucion(poder.idInstitucion) as JSON
				docEnviar.jsonInstitucion = StringEscapeUtils.unescapeJava(docEnviar.jsonInstitucion)
			}
			docsEnviar.add(docEnviar)
		}
		documentoRepositorioService.actualizaMetadatosDocumentos(docsEnviar)
	}
	
	//Sube al repostorio nuevos documentos
	def updateNewDocsOnRepository(Poder poder, Collection<DocumentoRepositorioTO> drpts){
		List<DocumentoRepositorioTO> docsEnviar = new ArrayList<DocumentoRepositorioTO>()
		
		drpts.each{
			DocumentoPoderRepositorioTO docEnviar = new DocumentoPoderRepositorioTO()
			
			docEnviar.id = null
			docEnviar.uuid = it.uuid
			
			docEnviar.tipoDocumentoRespaldo = TipoDocumentoRespaldoPoder.get(it.idTipoDocumento).descripcion
			docEnviar.representanteLegalNombre = poder.representanteLegalNombre
			docEnviar.representanteLegalApellido1 = poder.representanteLegalApellido1
			docEnviar.representanteLegalApellido2 = poder.representanteLegalApellido2
			docEnviar.esRegistradoPorGrupoFinanciero = poder.esRegistradoPorGrupoFinanciero
			docEnviar.numeroEscritura = poder.numeroEscritura
			docEnviar.fechaApoderamiento = poder.fechaApoderamiento
			docEnviar.jsonApoderados = poder.apoderados as JSON
			docEnviar.jsonNotario = poder.notario as JSON
			
			docEnviar.jsonApoderados = StringEscapeUtils.unescapeJava(docEnviar.jsonApoderados)
			docEnviar.jsonNotario = StringEscapeUtils.unescapeJava(docEnviar.jsonNotario)
				
			if(poder.esRegistradoPorGrupoFinanciero == true)
			{
				docEnviar.jsonGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(poder.idGrupofinanciero) as JSON
				docEnviar.jsonInstitucion = null
				docEnviar.jsonGrupoFinanciero = StringEscapeUtils.unescapeJava(docEnviar.jsonGrupoFinanciero)
			}
			else
			{
				docEnviar.jsonGrupoFinanciero = null
				docEnviar.jsonInstitucion = entidadFinancieraService.obtenerInstitucion(poder.idInstitucion) as JSON
				docEnviar.jsonInstitucion = StringEscapeUtils.unescapeJava(docEnviar.jsonInstitucion)
			}
			docsEnviar.add(docEnviar)
		}
		documentoRepositorioService.enviarDocumentosArchivoTemporal(docsEnviar)
	}
	
	//Envía los documentos pertenecientes al Poder (que 
	//hayas sido cargados a temporales) al repositorio "amibDocumentos"
	//NOTA: Los datos cargados son unicamente auxiliares para la 
	//búsqueda del documento en el respositorio
	//Si hay un cambio fuera de la aplicación (a nivel BD), se tendrá
	//que hacer manualmente en la base del repositorio
	def saveDocsOnRepository(Poder poder){
		
		List<DocumentoRepositorioTO> docsEnviar = new ArrayList<DocumentoRepositorioTO>()
		
		poder.documentosRespaldoPoder.each{
			DocumentoPoderRepositorioTO docEnviar = new DocumentoPoderRepositorioTO()
			
			docEnviar.id = null
			docEnviar.uuid = it.uuidDocumentoRepositorio
			
			docEnviar.tipoDocumentoRespaldo = it.tipoDocumentoRespaldoPoder.descripcion
			docEnviar.representanteLegalNombre = it.poder.representanteLegalNombre
			docEnviar.representanteLegalApellido1 = it.poder.representanteLegalApellido1
			docEnviar.representanteLegalApellido2 = it.poder.representanteLegalApellido2
			docEnviar.esRegistradoPorGrupoFinanciero = it.poder.esRegistradoPorGrupoFinanciero
			docEnviar.numeroEscritura = it.poder.numeroEscritura
			docEnviar.fechaApoderamiento = it.poder.fechaApoderamiento
			docEnviar.jsonApoderados = it.poder.apoderados as JSON
			docEnviar.jsonNotario = it.poder.notario as JSON
			
			docEnviar.jsonApoderados = StringEscapeUtils.unescapeJava(docEnviar.jsonApoderados)
			docEnviar.jsonNotario = StringEscapeUtils.unescapeJava(docEnviar.jsonNotario)
				
			if(it.poder.esRegistradoPorGrupoFinanciero == true)
			{
				docEnviar.jsonGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(it.poder.idGrupofinanciero) as JSON 
				docEnviar.jsonInstitucion = null
				docEnviar.jsonGrupoFinanciero = StringEscapeUtils.unescapeJava(docEnviar.jsonGrupoFinanciero)
			}
			else
			{				
				docEnviar.jsonGrupoFinanciero = null
				docEnviar.jsonInstitucion = entidadFinancieraService.obtenerInstitucion(it.poder.idInstitucion) as JSON 
				docEnviar.jsonInstitucion = StringEscapeUtils.unescapeJava(docEnviar.jsonInstitucion)
			}

			docsEnviar.add(docEnviar)
		}
		documentoRepositorioService.enviarDocumentosArchivoTemporal(docsEnviar)
	}
	
	def delete(Poder poderInstance){
		List<String> uuidsDocsABorrar = new ArrayList<String>()
		poderInstance.documentosRespaldoPoder.each{
			uuidsDocsABorrar.add(it.uuidDocumentoRepositorio)
		}
		poderInstance.delete(flush:true,failOnError:true)
		documentoRepositorioService.eliminarDocumentos(uuidsDocsABorrar)
	}
	
}

class DocumentoRespaldoPoderTO {
	String sessionId
	
	Long id
	String uuid
	Long idTipoDocumento
	String tipoDocumento
	
	String nombreArchivo
}

class PoderIntegrityError {
	String clave
	String descripcion
}