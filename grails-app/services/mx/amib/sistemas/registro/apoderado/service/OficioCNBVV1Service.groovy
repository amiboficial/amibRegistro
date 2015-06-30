package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional
import grails.converters.JSON
import mx.amib.sistemas.registro.apoderamiento.model.Apoderado
import mx.amib.sistemas.registro.apoderamiento.model.AutorizadoCNBV
import mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV

@Transactional
class OficioCNBVV1Service {
	class SearchResult {
		def list
		def count
	}
	class TransactionResult {
		def instance
		boolean valid = true;
		String errMsg
	}
	
	def save(OficioCNBV oficioCNBVInstance, List<String> autorizadosJson){
		
		oficioCNBVInstance.autorizadosCNBV = new HashSet<OficioCNBV>()
		autorizadosJson.each{
			def parsedJson = JSON.parse(it)
			
			AutorizadoCNBV autorizadoCNBV = new AutorizadoCNBV()
			autorizadoCNBV.numeroMatricula = parsedJson.'numeroMatricula'
			autorizadoCNBV.nombreCompleto = parsedJson.'nombreCompleto'
			
			autorizadoCNBV.oficioCNBV = oficioCNBVInstance
			oficioCNBVInstance.autorizadosCNBV.add(autorizadoCNBV)
		}
		
		oficioCNBVInstance.fechaCreacion = new Date()
		oficioCNBVInstance.fechaModificacion = new Date()
		
		oficioCNBVInstance.save(flush:true, failOnError: true)
		
		return oficioCNBVInstance
	}
	
	def update(OficioCNBV oficioCNBVInstance, List<String> autorizadosJson){
		TransactionResult tr = new TransactionResult()
		StringBuilder errMsgSb = new StringBuilder()
		tr.valid = true
		
		List<AutorizadoCNBV> autsToDelete = new ArrayList<AutorizadoCNBV>();
		List<AutorizadoCNBV> autsToAdd = new ArrayList<AutorizadoCNBV>();
		oficioCNBVInstance.autorizadosCNBV.each{
			it.toBeDeleted = true
		}
		autorizadosJson.each{ _autorizadoJson ->
			def parsedJson = JSON.parse(_autorizadoJson)
			AutorizadoCNBV autorizadoCNBV = oficioCNBVInstance.autorizadosCNBV.find{ it.numeroMatricula == parsedJson.'numeroMatricula' }
			if(autorizadoCNBV == null){
				autorizadoCNBV = new AutorizadoCNBV()
				autorizadoCNBV.numeroMatricula = parsedJson.'numeroMatricula'
				autorizadoCNBV.nombreCompleto = parsedJson.'nombreCompleto'
				autsToAdd.add(autorizadoCNBV)
			}
			autorizadoCNBV.toBeDeleted = false
		}
		oficioCNBVInstance.autorizadosCNBV.each{
			if(it.toBeDeleted == true)
			{
				autsToDelete.add(it)
			}
		}
		
		//valida que no se borre algún autorizado asociado con algún poder
		autsToDelete.each{
			if(it.apoderados.size() > 0){
				tr.valid = false
				def sbEachPoderes = new StringBuilder()
				it.apoderados.each { Apoderado ap ->
					sbEachPoderes.append(ap?.poder?.id).append(";")
				}
				errMsgSb.append("El autorizado con matrícula " + it?.numeroMatricula + " tiene poder(es) (id(s):"+ sbEachPoderes.toString() +") asociado(s); ")
			}
			else{
				oficioCNBVInstance.removeFromAutorizadosCNBV(it)
			}
		}
		/*
		autsToDelete.each{
			oficioCNBVInstance.removeFromAutorizadosCNBV(it)
			it.delete(flush:true)
		}*/
		autsToAdd.each{
			it.oficioCNBV = oficioCNBVInstance
			oficioCNBVInstance.autorizadosCNBV.add(it)
		}
		
		oficioCNBVInstance.fechaCreacion = new Date()
		oficioCNBVInstance.fechaModificacion = new Date()
		
		
		oficioCNBVInstance.validate()
		if(oficioCNBVInstance.hasErrors()){
			tr.valid = false
			oficioCNBVInstance.errors.each{
				errMsgSb.append(it?.field).append(it).append("; ")
			}
		}
		
		if(tr.valid == true){
			tr.valid = true
			tr.errMsg = null
			autsToDelete.each{
				it.delete(flush:true)
			}
			tr.instance = oficioCNBVInstance.save(flush:true, failOnError: true)
		}
		else{
			tr.instance = oficioCNBVInstance
			tr.errMsg = "No es posible actualizar datos en el OficioCNBV: " + errMsgSb.toString()
		}
		return tr
	}
	
	//Valida el borrado; de no ser valido, se devolvera un mensaje ó conjunto de mensajes
	def delete(OficioCNBV oficioCNBVInstance){
		TransactionResult tr = new TransactionResult()
		tr.valid = true
		StringBuilder sbValidation = new StringBuilder()
		StringBuilder sbEachPoderes
		//valida que no se haya asociado algun autorizado con algún poder
		oficioCNBVInstance.autorizadosCNBV.each{
			if(it.apoderados.size() > 0){
				tr.valid = false;
				sbEachPoderes = new StringBuilder()
				it.apoderados.each { Apoderado ap ->
					sbEachPoderes.append(ap?.poder?.id).append(";")
				}
				sbValidation.append("El autorizado con matrícula " + it?.numeroMatricula + " tiene poder(es) (id(s):"+ sbEachPoderes.toString() +") asociado(s) al oficio que intenta borrar; ")
			}
		}
		if(tr.valid == true){
			tr.valid = true
			tr.errMsg = null
			tr.instance = null
		}
		else{
			tr.valid = false
			tr.errMsg =  "No es posible borrar el OficioCNBV: " + sbValidation.toString()
			tr.instance = oficioCNBVInstance
		}
		
		return tr
	}
	
	def searchByDatosOficio(Integer max, Integer offset, String sort, String order,
							String filterClaveDga, Integer filterFechaDelDia, Integer filterFechaDelMes, Integer filterFechaDelAnio, 
							Integer filterFechaAlDia, Integer filterFechaAlMes, Integer filterFechaAlAnio){
		
		List<String> hqlFilters = new ArrayList<String>();
		String whereKeyword = "where ";
		Boolean whereKeywordNeeded = false;
		StringBuilder sbHql = new StringBuilder()
		Map<String,Object> namedParameters = new HashMap<String,Object>()
		
		Calendar filterCalFechaDel = null
		Calendar filterCalFechaAl = null
		
		if(max == null || max <= 0){
			max = 10
		}
		if(offset == null || offset <= 0){
			offset = 0
		}
		if(sort == null || sort == ""){
			sort = "id"
		}
		else if(["id","claveDga","fechaFinVigencia"].find{ sort == it } == null){
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
		
		if(filterClaveDga != null && filterClaveDga != "" ){
			hqlFilters.add("o.claveDga = :claveDga ")
			whereKeywordNeeded = true
			namedParameters.put("claveDga",filterClaveDga)
		}
		
		//rangos de fecha
		//si ambos son nulos, se omite; si uno es nulo, el que no es nulo se toma como unico
		if( filterCalFechaDel != null && filterCalFechaAl == null){
			hqlFilters.add("o.fechaFinVigencia >= :fechaFinVigencia ")
			whereKeywordNeeded = true
			namedParameters.put("fechaFinVigencia",filterCalFechaDel.getTime())
		}
		if( filterCalFechaDel == null && filterCalFechaAl != null){
			hqlFilters.add("o.fechaFinVigencia <= :fechaFinVigencia ")
			whereKeywordNeeded = true
			namedParameters.put("fechaFinVigencia",filterCalFechaAl.getTime())
		}
		if( filterCalFechaDel != null && filterCalFechaAl != null){
			hqlFilters.add("o.fechaFinVigencia between :fechaDel and :fechaAl ")
			whereKeywordNeeded = true
			namedParameters.put("fechaDel",filterCalFechaDel.getTime())
			namedParameters.put("fechaAl",filterCalFechaAl.getTime())
		}
		
		sbHql.append("from OficioCNBV as o ")
		if(whereKeywordNeeded){
			sbHql.append(whereKeyword)
			hqlFilters.each{
				if(it != hqlFilters.last())
					sbHql.append(it).append("and ")
				else
					sbHql.append(it)
			}
		}
		
		def results = new SearchResult()
		
		def totalResults = OficioCNBV.executeQuery("select count(o) " + sbHql.toString(),namedParameters)
		results.count = totalResults[0];
		sbHql.append("order by o.").append(sort).append(" ").append(order)
		results.list =  OficioCNBV.executeQuery(sbHql.toString(),namedParameters,[max: max, offset: offset])
		
		return results
	}
	
	def searchByMatricula(Integer max, Integer offset, String sort, String order, Integer filterMatricula){
		List<String> hqlFilters = new ArrayList<String>()
		String whereKeyword = "where "
		Boolean whereKeywordNeeded = false
		StringBuilder sbHql = new StringBuilder()
		StringBuilder strHqlCount = new StringBuilder()
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
		else if(["id","claveDga","fechaFinVigencia"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		
		if(filterMatricula != null && filterMatricula > 0 ){
			hqlFilters.add("a.numeroMatricula = :numeroMatricula ")
			whereKeywordNeeded = true
			namedParameters.put("numeroMatricula",filterMatricula)
		}
		
		strHqlCount.append("select count(distinct a.oficioCNBV) from AutorizadoCNBV as a ")
		sbHql.append("select distinct o from AutorizadoCNBV as a inner join a.oficioCNBV o ")
		if(whereKeywordNeeded){
			sbHql.append(whereKeyword)
			strHqlCount.append(whereKeyword)
			hqlFilters.each{
				if(it != hqlFilters.last()){
					sbHql.append(it).append("and ")
					strHqlCount.append(it).append("and ")
				}
				else{
					sbHql.append(it)
					strHqlCount.append(it)
				}
			}
		}
		sbHql.append("order by o.").append(sort).append(" ").append(order)
		
		def searchResult = new SearchResult()
		searchResult.count = OficioCNBV.executeQuery(strHqlCount.toString(),namedParameters)[0]
		searchResult.list = OficioCNBV.executeQuery(sbHql.toString(),namedParameters,[max: max, offset: offset])
		return searchResult
	}
	
	def searchByNombre(Integer max, Integer offset, String sort, String order, String filterNombre){
		
		List<String> hqlFilters = new ArrayList<String>()
		String whereKeyword = "where "
		Boolean whereKeywordNeeded = false
		StringBuilder sbHql = new StringBuilder()
		StringBuilder strHqlCount = new StringBuilder()
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
		else if(["id","claveDga","fechaFinVigencia"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		
		if(filterNombre != null && filterNombre != ""){
			hqlFilters.add("a.nombreCompleto like :nombreCompleto ")
			whereKeywordNeeded = true
			namedParameters.put("nombreCompleto","%"+filterNombre+"%")
		}
		strHqlCount.append("select count(distinct a.oficioCNBV.id) from AutorizadoCNBV as a ")
		sbHql.append("select distinct o from AutorizadoCNBV as a inner join a.oficioCNBV o ")
		if(whereKeywordNeeded){
			sbHql.append(whereKeyword)
			strHqlCount.append(whereKeyword)
			hqlFilters.each{
				if(it != hqlFilters.last()){
					sbHql.append(it).append("and ")
					strHqlCount.append(it).append("and ")
				}
				else{
					sbHql.append(it)
					strHqlCount.append(it)
				}
			}
		}
		sbHql.append("order by o.").append(sort).append(" ").append(order)
		
		def searchResult = new SearchResult()
		searchResult.count = OficioCNBV.executeQuery(strHqlCount.toString(), namedParameters)[0]
		searchResult.list = OficioCNBV.executeQuery(sbHql.toString(),namedParameters,[max: max, offset: offset])
		return searchResult
	}
}
