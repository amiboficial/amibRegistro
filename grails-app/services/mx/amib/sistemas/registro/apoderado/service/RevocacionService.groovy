package mx.amib.sistemas.registro.apoderado.service

import java.util.Date

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
		
		documentoRepositorioService.enviarDocumentosArchivoTemporal(docsAEnviar) //envía documentos a repositorio
		revocacion.validate() //valida de acuerdo a domains
		revocacion.save(flush:true, failOnError: true) //guarda
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