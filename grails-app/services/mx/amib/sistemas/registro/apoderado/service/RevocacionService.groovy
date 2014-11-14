package mx.amib.sistemas.registro.apoderado.service

import java.util.Date

import org.junit.After;

import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRevocacionRepositorioTO
import mx.amib.sistemas.external.expediente.service.SustentanteService
import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import mx.amib.sistemas.registro.apoderamiento.model.Revocado
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.notario.service.NotarioService;
import groovy.json.StringEscapeUtils

@Transactional
class RevocacionService {

	def sustentanteService
	def notarioService
	def entidadFinancieraService
	def documentoRepositorioService
	
    def serviceMethod() {

    }
	
	def save(Revocacion revocacion, List<String> revocadosJson, List<String> documentosJson, int notarioIdEntidadFederativa, int notarioNumero ){
		List<DocumentoRepositorioTO> docsAEnviar = new ArrayList<DocumentoRepositorioTO>()
		
		def n = notarioService.obtenerNotario(notarioIdEntidadFederativa, notarioNumero)
		revocacion.notario = n
		
		revocacion.revocados = new HashSet<Revocado>()
		revocadosJson.each{ String _revocadoJson -> 
			def parsedJson = JSON.parse(_revocadoJson)
			def sustentante = sustentanteService.obtenerPorMatricula(parsedJson.'numeroMatricula');
			
			Revocado revocado = new Revocado()
			revocado.numeroMatricula = parsedJson.'numeroMatricula'
			revocado.nombreCompleto = sustentante.nombre + ' ' + sustentante.primerApellido +  ' ' + sustentante.segundoApellido
			revocado.numeroEscritura = parsedJson.'numeroEscritura'
			revocado.motivo = parsedJson.'motivo'
			revocado.fechaBaja = Date.parse('yyyyMMdd',parsedJson.'fechaBajaAnyo'+parsedJson.'fechaBajaMes'+parsedJson.'fechaBajaDia');
			
			revocado.revocacion = revocacion
			revocacion.revocados.add(revocado)
		}
		
		
		//en cuanto se implemente la sesión con atributos
		//debera adecuarse de acuerdo a si quien esta subiendo el cambio
		//es una entidadFinanciera o institucion
		//o en caso de ser un ADMON, se omite este paso
		
		//SOLO PARA EFECTOS DE PRUEBA, SE ASIGNA A TODOS 6
		//HASTA QUE ESTEN IMPLEMENTADO SPRING SECURITY
		//SE PODRÁ HACER EL CAMBIO
		if(revocacion.idGrupofinanciero == null)
		{
			revocacion.idGrupofinanciero = 6
			revocacion.idInstitucion = null
		}
		
		if(revocacion.idInstitucion == null)
			revocacion.esRegistradoPorGrupoFinanciero = true
		else
			revocacion.esRegistradoPorGrupoFinanciero = false
		
		revocacion.documentosRespaldoRevocacion = new HashSet<DocumentoRespaldoRevocacion>()
		documentosJson.each{ String _docJson -> 
			def parsedJson = JSON.parse(_docJson)
			
			DocumentoRespaldoRevocacion drr = new DocumentoRespaldoRevocacion()
			drr.uuidDocumentoRepositorio = parsedJson.'uuid'
			drr.tipoDocumentoRespaldoRevocacion = TipoDocumentoRespaldoRevocacion.get( parsedJson.'idTipo' )
			
			drr.revocacion = revocacion
			revocacion.documentosRespaldoRevocacion.add(drr)
			
			DocumentoRevocacionRepositorioTO dr = new DocumentoRevocacionRepositorioTO()
			dr.uuid = parsedJson.'uuid'
			dr.clave = ''
			dr.tipoDocumentoRespaldo = TipoDocumentoRespaldoRevocacion.get( parsedJson.'idTipo' ).descripcion 
			dr.representanteLegalNombre = revocacion.representanteLegalNombre
			dr.representanteLegalApellido1 = revocacion.representanteLegalApellido1
			dr.representanteLegalApellido2 = revocacion.representanteLegalApellido2
			dr.esRegistradoPorGrupoFinanciero = revocacion.esRegistradoPorGrupoFinanciero
			dr.numeroEscritura = revocacion.numeroEscritura
			dr.fechaRevocacion = revocacion.fechaRevocacion
			dr.jsonRevocados = revocacion.revocados as JSON
			dr.jsonNotario = revocacion.notario as JSON
			if(revocacion.esRegistradoPorGrupoFinanciero == true)
			{
				dr.jsonGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacion.idGrupofinanciero) as JSON
				dr.jsonGrupoFinanciero = StringEscapeUtils.unescapeJava(dr.jsonGrupoFinanciero)
				dr.jsonInstitucion = null
			}
			else
			{
				dr.jsonGrupoFinanciero = null
				dr.jsonInstitucion = entidadFinancieraService.obtenerInstitucion(revocacion.idInstitucion) as JSON
				dr.jsonInstitucion = StringEscapeUtils.unescapeJava(dr.jsonInstitucion)
			}
			docsAEnviar.add(dr)
		}
		
		//fechas
		revocacion.fechaCreacion = new Date()
		revocacion.fechaModificacion = new Date()
		
		revocacion.validate() //valida de acuerdo a domains
		revocacion.save(flush:true, failOnError: true) //guarda
		
		documentoRepositorioService.enviarDocumentosArchivoTemporal(docsAEnviar) //envía documentos a repositorio
	}
	
	def update(Revocacion revocacion, List<String> revocadosJson, List<String> documentosJson, int notarioIdEntidadFederativa, int notarioNumero ){
	
		def n = notarioService.obtenerNotario(notarioIdEntidadFederativa, notarioNumero)
		revocacion.notario = n

		List<Revocado> revocadosToDelete = new ArrayList<Revocado>()
		List<Revocado> revocadosToAdd = new ArrayList<Revocado>()
		revocacion.revocados.each{ Revocado _r ->
			_r.toBeUpdated = false
		}
		revocadosJson.each{ String _revocadoJson ->
			Revocado revocado = null
			
			def parsedJson = JSON.parse(_revocadoJson)
			def sustentante = sustentanteService.obtenerPorMatricula(parsedJson.'numeroMatricula');
			
			revocado = Revocado.get(parsedJson.'id')
			if(revocado == null){
				revocado = new Revocado()
				revocadosToAdd.add(revocado)
			}
			revocado.numeroMatricula = parsedJson.'numeroMatricula'
			revocado.nombreCompleto = sustentante.nombre + ' ' + sustentante.primerApellido +  ' ' + sustentante.segundoApellido
			revocado.numeroEscritura = parsedJson.'numeroEscritura'
			revocado.motivo = parsedJson.'motivo'
			revocado.fechaBaja = Date.parse('yyyyMMdd',parsedJson.'fechaBajaAnyo'+parsedJson.'fechaBajaMes'+parsedJson.'fechaBajaDia')
			revocado.toBeUpdated = true
		}
		revocacion.revocados.each{ Revocado _r ->
			if(_r.toBeUpdated == false)
				revocadosToDelete.add(_r)
		}
		revocadosToDelete.each{ Revocado _r ->
			revocacion.removeFromRevocados(_r)
			_r.delete(flush:true)
		}
		revocadosToAdd.each{ Revocado _r ->
			_r.revocacion = revocacion
			revocacion.revocados.add(_r)
		}
		
		//en cuanto se implemente la sesión con atributos
		//debera adecuarse de acuerdo a si quien esta subiendo el cambio
		//es una entidadFinanciera o institucion
		//o en caso de ser un ADMON, se omite este paso
		
		//SOLO PARA EFECTOS DE PRUEBA, SE ASIGNA A TODOS 6
		//HASTA QUE ESTEN IMPLEMENTADO SPRING SECURITY
		//SE PODRÁ HACER EL CAMBIO
		if(revocacion.idGrupofinanciero == null)
		{
			revocacion.idGrupofinanciero = 6
			revocacion.idInstitucion = null
		}
		
		if(revocacion.idInstitucion == null)
			revocacion.esRegistradoPorGrupoFinanciero = true
		else
			revocacion.esRegistradoPorGrupoFinanciero = false
		
		
		List<DocumentoRepositorioTO> docsAEnviar = new ArrayList<DocumentoRepositorioTO>()
		List<DocumentoRepositorioTO> docsAActualizar = new ArrayList<DocumentoRepositorioTO>()
		List<String> uuidsDocsABorrar = new ArrayList<DocumentoRepositorioTO>()
		List<DocumentoRespaldoRevocacion> drrABorrar = new ArrayList<DocumentoRespaldoRevocacion>()
		List<DocumentoRespaldoRevocacion> drrAAgregar = new ArrayList<DocumentoRespaldoRevocacion>()
		revocacion.documentosRespaldoRevocacion.each{ 
			it.toBeUpdated = false
		}
		documentosJson.each{ String _documentoJson -> 
			DocumentoRespaldoRevocacion drr = null
			def parsedJson = JSON.parse(_documentoJson)
			DocumentoRevocacionRepositorioTO dr = new DocumentoRevocacionRepositorioTO()
			
			drr = DocumentoRespaldoRevocacion.get(parsedJson.'id')
			if(drr == null){
				drr = new DocumentoRespaldoRevocacion()
				drr.uuidDocumentoRepositorio = parsedJson.'uuid'
				drr.tipoDocumentoRespaldoRevocacion = TipoDocumentoRespaldoRevocacion.get( parsedJson.'idTipo' )
				
				drrAAgregar.add(drr)
				docsAEnviar.add(dr)
			}
			else{
				docsAActualizar.add(dr)
			}
			
			dr.uuid = parsedJson.'uuid'
			dr.clave = ''
			dr.tipoDocumentoRespaldo = drr.tipoDocumentoRespaldoRevocacion.descripcion
			dr.representanteLegalNombre = revocacion.representanteLegalNombre
			dr.representanteLegalApellido1 = revocacion.representanteLegalApellido1
			dr.representanteLegalApellido2 = revocacion.representanteLegalApellido2
			dr.esRegistradoPorGrupoFinanciero = revocacion.esRegistradoPorGrupoFinanciero
			dr.numeroEscritura = revocacion.numeroEscritura
			dr.fechaRevocacion = revocacion.fechaRevocacion
			dr.jsonRevocados = revocacion.revocados as JSON
			dr.jsonNotario = revocacion.notario as JSON
			if(revocacion.esRegistradoPorGrupoFinanciero == true)
			{
				dr.jsonGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacion.idGrupofinanciero) as JSON
				dr.jsonGrupoFinanciero = StringEscapeUtils.unescapeJava(dr.jsonGrupoFinanciero)
				dr.jsonInstitucion = null
			}
			else
			{
				dr.jsonGrupoFinanciero = null
				dr.jsonInstitucion = entidadFinancieraService.obtenerInstitucion(revocacion.idInstitucion) as JSON
				dr.jsonInstitucion = StringEscapeUtils.unescapeJava(dr.jsonInstitucion)
			}
			drr.toBeUpdated = true
		}
		revocacion.documentosRespaldoRevocacion.each{ 
			if(it.toBeUpdated == false){
				uuidsDocsABorrar.add(it.uuidDocumentoRepositorio)
				drrABorrar.add(it)
			}
		}
		drrABorrar.each{ 
			revocacion.removeFromDocumentosRespaldoRevocacion(it)
			it.delete(flush:true)
		}
		drrAAgregar.each{
			it.revocacion = revocacion
			revocacion.documentosRespaldoRevocacion.add(it)
		}
		
		revocacion.fechaModificacion = new Date()
		
		revocacion.validate() //valida de acuerdo a domains
		revocacion.save(flush:true, failOnError: true) //guarda
		
		documentoRepositorioService.enviarDocumentosArchivoTemporal(docsAEnviar) //envía documentos a repositorio
		documentoRepositorioService.actualizaMetadatosDocumentos(docsAActualizar)
		documentoRepositorioService.eliminarDocumentos(uuidsDocsABorrar)
	}
	
}

class RevocadoTO {
	long id
	int numeroMatricula
	String nombreCompleto
	int numeroEscritura
	String motivo
	Date fechaBaja
	long revocacionId
}