package mx.amib.sistemas.registro.apoderado.service

import java.util.Date

import org.junit.After;

import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRevocacionRepositorioTO
import mx.amib.sistemas.external.expediente.service.SustentanteService
import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.apoderamiento.model.Poder;
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import mx.amib.sistemas.registro.apoderamiento.model.Revocado
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.notario.service.NotarioService;
import groovy.json.StringEscapeUtils

@Transactional
class RevocacionService {

	class SearchResult {
		def list
		def count
	}
	
	def sustentanteService
	def notarioService
	def entidadFinancieraService
	def documentoRepositorioService
	
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
		
		revocacion.documentosRespaldoRevocacion = new HashSet<DocumentoRespaldoRevocacion>()
		documentosJson.each{ String _docJson -> 
			String matriculasRevocados = ""
			String nombresRevocados = ""
			
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
			dr.representanteLegalNombreCompleto = revocacion.representanteLegalNombre+" "+revocacion.representanteLegalApellido1+" "+revocacion.representanteLegalApellido2
			dr.numeroEscritura = revocacion.numeroEscritura
			dr.fechaRevocacion = revocacion.fechaRevocacion
			revocacion.revocados.each{ r ->
				matriculasRevocados += r.numeroMatricula + ";"
				nombresRevocados += r.nombreCompleto + ";"
			}
			dr.matriculasRevocados = matriculasRevocados
			dr.nombresRevocados = nombresRevocados
			dr.notario = revocacion?.notario?.nombre + " " + revocacion?.notario?.apellido1 + " " + revocacion?.notario?.apellido2
			dr.grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacion?.idGrupofinanciero)?.nombre
			dr.institucion = entidadFinancieraService.obtenerInstitucion(revocacion?.idGrupofinanciero)?.nombre

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
		
		List<DocumentoRepositorioTO> docsAEnviar = new ArrayList<DocumentoRepositorioTO>()
		List<DocumentoRepositorioTO> docsAActualizar = new ArrayList<DocumentoRepositorioTO>()
		List<String> uuidsDocsABorrar = new ArrayList<DocumentoRepositorioTO>()
		List<DocumentoRespaldoRevocacion> drrABorrar = new ArrayList<DocumentoRespaldoRevocacion>()
		List<DocumentoRespaldoRevocacion> drrAAgregar = new ArrayList<DocumentoRespaldoRevocacion>()
		revocacion.documentosRespaldoRevocacion.each{ 
			it.toBeUpdated = false
		}
		documentosJson.each{ String _documentoJson ->
			String matriculasRevocados = ""
			String nombresRevocados = ""
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
			dr.tipoDocumentoRespaldo = TipoDocumentoRespaldoRevocacion.get( parsedJson.'idTipo' ).descripcion 
			dr.representanteLegalNombreCompleto = revocacion.representanteLegalNombre+" "+revocacion.representanteLegalApellido1+" "+revocacion.representanteLegalApellido2
			dr.numeroEscritura = revocacion.numeroEscritura
			dr.fechaRevocacion = revocacion.fechaRevocacion
			revocacion.revocados.each{ r ->
				matriculasRevocados += r.numeroMatricula + ";"
				nombresRevocados += r.nombreCompleto + ";"
			}
			dr.matriculasRevocados = matriculasRevocados
			dr.nombresRevocados = nombresRevocados
			dr.notario = revocacion?.notario?.nombre + " " + revocacion?.notario?.apellido1 + " " + revocacion?.notario?.apellido2
			dr.grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacion?.idGrupofinanciero)?.nombre
			dr.institucion = entidadFinancieraService.obtenerInstitucion(revocacion?.idGrupofinanciero)?.nombre
			
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
	
	def delete(Revocacion revocacionInstance){
		List<String> uuidsDocsABorrar = new ArrayList<String>()
		revocacionInstance.documentosRespaldoRevocacion.each{
			uuidsDocsABorrar.add(it.uuidDocumentoRepositorio)
		}
		revocacionInstance.delete(flush:true,failOnError:true)
		documentoRepositorioService.eliminarDocumentos(uuidsDocsABorrar)
	}
	
	def search(Integer max, Integer offset, String sort, String order, Integer filterNumeroEscritura, 
				Integer filterFechaDelDia, Integer filterFechaDelMes, Integer filterFechaDelAnio, 
				Integer filterFechaAlDia, Integer filterFechaAlMes, Integer filterFechaAlAnio,
				Long filterIdGrupoFinanciero, Long filterIdInstitucion,
				Boolean fltNoVerificado, Boolean fltNoAprobado){
				
		Calendar filterCalFechaDel = null
		Calendar filterCalFechaAl = null
						
		String strHqlCount = null
		List<String> hqlFilters = new ArrayList<String>();
		String whereKeyword = "where ";
		Boolean whereKeywordNeeded = false;
		StringBuilder sbHql = new StringBuilder()
		Map<String,Object> namedParameters = new HashMap<String,Object>()
		
		if(max == null || max <= 0){
			max = 10
		}
		if(offset == null || offset <= 0){
			offset = 0
		}
		if(sort == null || sort == ""){
			sort = "id"
		}
		else if(["id","fechaRevocacion","numeroEscritura"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		
		//formar fechas
		if( (filterFechaDelDia != null && filterFechaDelMes != null && filterFechaDelAnio != null) &&
			(filterFechaDelDia > 0 && filterFechaDelMes > 0 && filterFechaDelAnio > 0) ){
			filterCalFechaDel = new GregorianCalendar(filterFechaDelAnio,filterFechaDelMes-1,filterFechaDelDia,00,00,00);
		}
		if( (filterFechaAlDia != null && filterFechaAlMes != null && filterFechaAlAnio != null) &&
			(filterFechaAlDia > 0 && filterFechaAlMes > 0 && filterFechaAlAnio > 0) ){
			filterCalFechaAl = new GregorianCalendar(filterFechaAlAnio,filterFechaAlMes-1,filterFechaAlDia,00,00,00);
		}
		
		//formar filtros

		//filterNumeroEscritura
		println "el numero de escritura es: " + filterNumeroEscritura
		if(filterNumeroEscritura != null && filterNumeroEscritura != -1 && filterNumeroEscritura != ""){
			hqlFilters.add("n.numeroEscritura like :numeroEscritura ")
			whereKeywordNeeded = true
			namedParameters.put("numeroEscritura",filterNumeroEscritura)
		}
		//rangos de fecha
		//si ambos son nulos, se omite; si uno es nulo, el que no es nulo se toma como unico
		if( filterCalFechaDel != null && filterCalFechaAl == null){
			hqlFilters.add("n.fechaRevocacion >= :fechaRevocacion ")
			whereKeywordNeeded = true
			namedParameters.put("fechaRevocacion",filterCalFechaDel.getTime())
		}
		if( filterCalFechaDel == null && filterCalFechaAl != null){
			hqlFilters.add("n.fechaRevocacion <= :fechaRevocacion ")
			whereKeywordNeeded = true
			namedParameters.put("fechaRevocacion",filterCalFechaAl.getTime())
		}
		if( filterCalFechaDel != null && filterCalFechaAl != null){
			hqlFilters.add("n.fechaRevocacion between :fechaRevocacionDel and :fechaRevocacionAl ")
			whereKeywordNeeded = true
			namedParameters.put("fechaRevocacionDel",filterCalFechaDel.getTime())
			namedParameters.put("fechaRevocacionAl",filterCalFechaAl.getTime())
		}
		//filterIdGrupoFinanciero
		if(filterIdGrupoFinanciero != null && filterIdGrupoFinanciero != -1 && filterIdGrupoFinanciero != ""){
			hqlFilters.add("n.idGrupofinanciero like :idGrupofinanciero ")
			whereKeywordNeeded = true
			namedParameters.put("idGrupofinanciero",filterIdGrupoFinanciero)
		}
		//filterIdInstitucion
		if(filterIdInstitucion != null && filterIdInstitucion != -1 && filterIdInstitucion != ""){
			hqlFilters.add("n.idInstitucion like :idInstitucion ")
			whereKeywordNeeded = true
			namedParameters.put("idInstitucion",filterIdInstitucion)
		}
		
		if(fltNoVerificado != null){
			hqlFilters.add("n.verificado != :noVerificado ")
			namedParameters.put("noVerificado",fltNoVerificado)
			whereKeywordNeeded = true
			if(fltNoVerificado == false){
				if(fltNoAprobado != null){
					hqlFilters.add("n.aprobado != :noAprobado ")
					namedParameters.put("noAprobado",fltNoAprobado)
					whereKeywordNeeded = true
				}
			}
		}
		
		sbHql.append("from Revocacion as n ")
		if(whereKeywordNeeded){
			sbHql.append(whereKeyword)
			hqlFilters.each{
				if(it != hqlFilters.last())
					sbHql.append(it).append("and ")
				else
					sbHql.append(it)
			}
		}
		strHqlCount = "select count(n) " + sbHql.toString()
		sbHql.append("order by n.").append(sort).append(" ").append(order)
		
		def searchResult = new SearchResult()
		searchResult.count = (Revocacion.executeQuery(strHqlCount,namedParameters))[0]
		searchResult.list = Revocacion.findAll(sbHql.toString(),namedParameters,[max: max, offset: offset])
		return searchResult
		
	}
	
	def findAllByIdGrupofinanciero(Long idGrupoFinanciero){
		def result = Revocacion.findAllByIdGrupofinanciero(idGrupoFinanciero,[sort: "fechaCreacion", order: "desc"])
		return result
	}
			
	def findAllByIdInstitucion(Long idInstitucion){
		def result = Revocacion.findAllByIdInstitucion(idInstitucion,[sort: "fechaCreacion", order: "desc"])
		return result
	}
	
	def countPendientes(){
		def strHqlCount = "select count(r) from Revocacion as r where r.verificado = false";
		return (Revocacion.executeQuery(strHqlCount))[0]
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