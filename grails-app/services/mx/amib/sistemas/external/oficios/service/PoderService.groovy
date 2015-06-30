package mx.amib.sistemas.external.oficios.service

import org.codehaus.groovy.grails.web.json.JSONObject;

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.oficios.poder.PoderTO

@Transactional
class PoderService {

	def grailsApplication
	
	String listUrl = "http://localhost:8085/poder/index"
	String findAllByUrl = "http://localhost:8085/poder/findAllBy"
	String getUrl = "http://localhost:8085/poder/show/"
	String saveUrl = "http://localhost:8085/poder/save"
	String updateUrl = "http://localhost:8085/update/"
	
	public PoderService.SearchResult list(Integer max, Integer offset, String sort, String order){
		PoderService.SearchResult sr = new PoderService.SearchResult()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new PoderService.SearchResult(resp.json)
		}
	}
	public PoderService.SearchResult findAllBy(Integer max, Integer offset, String sort, String order,
			Integer numeroEscritura, Integer fechaDelDia, Integer fechaDelMes, Integer fechaDelAnio,
			Integer fechaAlDia, Integer fechaAlMes, Integer fechaAlAnio,
			Long idGrupoFinanciero, Long idInstitucion){
		PoderService.SearchResult sr = new PoderService.SearchResult()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&numeroEscritura=${numeroEscritura}&fechaDelDia=${fechaDelDia}&fechaDelMes=${fechaDelMes}&fechaDelAnio=${fechaDelAnio}&fechaAlDia=${fechaAlDia}&fechaAlMes=${fechaAlMes}&fechaAlAnio=${fechaAlAnio}&idGrupoFinanciero=${idGrupoFinanciero}&idInstitucion=${idInstitucion}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new PoderService.SearchResult(resp.json)
		}
	}
	public PoderTO get(Long id){
		PoderTO p = new PoderTO()
		p.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO(resp.json)
		}
		return p
	}
	public PoderTO save(PoderTO p){
		p.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (p as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_CREATED )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO(resp.json)
		}
		return p
	}
	public PoderTO update(PoderTO p){
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + n.id){
			contentType "application/json;charset=UTF-8"
			json (p as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_OK )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO(resp.json)
		}
		return p
	}
	
	class SearchResult{
		List<PoderTO> list;
		Long count;
		Boolean error;
	}
}
