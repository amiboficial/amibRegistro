package mx.amib.sistemas.registro.apoderado.service

import java.util.Date
import grails.converters.JSON
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.expediente.service.SustentanteService
import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import mx.amib.sistemas.registro.apoderamiento.model.Revocado
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.notario.service.NotarioService;
import grails.transaction.Transactional



@Transactional
class RevocacionService {

	def sustentanteService
	def notarioService
	
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
		
		revocacion.documentosRespaldoRevocacion = new HashSet<DocumentoRespaldoRevocacion>()
		documentosJson.each{ String _docJson -> 
			def parsedJson = JSON.parse(_docJson)
			
			DocumentoRespaldoRevocacion drr = new DocumentoRespaldoRevocacion()
			drr.uuidDocumentoRepositorio = parsedJson.'uuid'
			drr.tipoDocumentoRespaldoRevocacion = TipoDocumentoRespaldoRevocacion.get( parsedJson.'idTipo' )
			
			drr.revocacion = revocacion
			revocacion.documentosRespaldoRevocacion.add(drr)
			/*
			DocumentoRepositorioTO dr = new DocumentoRepositorioTO()
			dr.uuid
			dr.clave
			dr.nombre
			dr.mimetype*/
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
		
		
		//fechas
		revocacion.fechaCreacion = new Date()
		revocacion.fechaModificacion = new Date()
		
		revocacion.validate()
		revocacion.save(flush:true, failOnError: true)
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