package mx.amib.sistemas.external.oficios.service

import java.util.List
import org.springframework.http.HttpStatus
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject

import groovy.json.*
import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.utils.SearchResult

@Transactional
class PoderService {

	def grailsApplication
	
	String listUrl
	String findAllByUrl
	String getUrl
	String saveUrl
	String updateUrl
	String isNumeroEscrituraAvailableUrl
	
	public SearchResult<PoderTO> list(Integer max, Integer offset, String sort, String order){
		SearchResult<PoderTO> sr = new SearchResult<PoderTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			println "el recibido es: " + resp.json.toString()
			def j = this.fixSearchResultJsonObject(resp.json)
			sr = new SearchResult<PoderTO>( j )
		}
		return sr
	}
	public SearchResult<PoderTO> findAllBy(Integer max, Integer offset, String sort, String order,
			Integer numeroEscritura, Integer fechaDelDia, Integer fechaDelMes, Integer fechaDelAnio,
			Integer fechaAlDia, Integer fechaAlMes, Integer fechaAlAnio,
			Long idGrupoFinanciero, Long idInstitucion){
		SearchResult<PoderTO> sr = new SearchResult<PoderTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&numeroEscritura=${numeroEscritura}&fechaDelDia=${fechaDelDia}&fechaDelMes=${fechaDelMes}&fechaDelAnio=${fechaDelAnio}&fechaAlDia=${fechaAlDia}&fechaAlMes=${fechaAlMes}&fechaAlAnio=${fechaAlAnio}&idGrupoFinanciero=${idGrupoFinanciero}&idInstitucion=${idInstitucion}"
		def rest = new RestBuilder()
		def resp = rest.get(findAllByUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<PoderTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		
		println "LA URL ES: " + findAllByUrl + qs.toString()
		
		return sr
	}
	public PoderTO get(Long id){
		PoderTO p = new PoderTO()
		p.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO( this.fixPoderJsonObject(resp.json) )
		}
		return p
	}
	public PoderTO save(PoderTO p){
		p.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json this.customServiceJson(p)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO( this.fixPoderJsonObject(resp.json) )
		}
		
		return p
	}
	public PoderTO update(PoderTO p){
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + p.id){
			contentType "application/json;charset=UTF-8"
			json this.customServiceJson(p)
		}
		
		if(resp.statusCode.value() != HttpStatus.OK.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			p = new PoderTO( this.fixPoderJsonObject(resp.json) )
		}
		return p
	}
	
	public boolean isNumeroEscrituraAvailable(int numeroEscritura){
		
		def rest = new RestBuilder()
		
		
		println isNumeroEscrituraAvailableUrl + numeroEscritura
		
		def resp = rest.get(isNumeroEscrituraAvailableUrl + numeroEscritura)
		
		println resp.text
		
		if(resp.text == "true"){
			return true
		}
		else{
			return false
		}
	}
	
	private JSON customServiceJson(PoderTO p){
		def pMap = p.properties
		pMap.'fechaApoderamiento' = p.fechaApoderamiento.getTime()
		pMap.'fechaCreacion' = null
		pMap.'fechaModificacion' = null
		pMap.'apoderados'.each{
			it.'fechaCreacion' = null
			it.'fechaModificacion' = null
		}
		return new JSON(pMap)
	}
	private JSONObject fixPoderJsonObject(JSONObject je){
		
		je.remove('class')
		
		je.'fechaApoderamiento' = new Date(je.'fechaApoderamiento')
		je.'fechaCreacion' = new Date(je.'fechaCreacion')
		je.'fechaModificacion' = new Date(je.'fechaModificacion')
		je.'apoderados'.each{
			it.'fechaCreacion' = new Date(it.'fechaCreacion')
			it.'fechaModificacion' = new Date(it.'fechaModificacion')
		}
		
		return je
	}
	private JSONObject fixSearchResultJsonObject(JSONObject je){
		
		je.remove('class')
		
		je.'list'.each{
			it = this.fixPoderJsonObject(it)
		}
		return je
	}
	
}
