package mx.amib.sistemas.external.oficios.service

import java.util.List

import org.springframework.http.HttpStatus

import mx.amib.sistemas.utils.SearchResult
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO

import org.codehaus.groovy.grails.web.json.JSONObject

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

@Transactional
class RevocacionService {

	String listUrl = "http://localhost:8085/revocacion/index"
	String findAllByUrl = "http://localhost:8085/revocacion/findAllBy"
	String getUrl = "http://localhost:8085/revocacion/show/"
	String saveUrl = "http://localhost:8085/revocacion/save"
	String updateUrl = "http://localhost:8085/revocacion/update/"
	
    public SearchResult<RevocacionTO> list(Integer max, Integer offset, String sort, String order){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<RevocacionTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
    }
	public SearchResult<RevocacionTO> findAllBy(Integer max, Integer offset, String sort, String order,
			Integer numeroEscritura, Integer fechaDelDia, Integer fechaDelMes, Integer fechaDelAnio,
			Integer fechaAlDia, Integer fechaAlMes, Integer fechaAlAnio,
			Long idGrupoFinanciero, Long idInstitucion){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&numeroEscritura=${numeroEscritura}&fechaDelDia=${fechaDelDia}&fechaDelMes=${fechaDelMes}&fechaDelAnio=${fechaDelAnio}&fechaAlDia=${fechaAlDia}&fechaAlMes=${fechaAlMes}&fechaAlAnio=${fechaAlAnio}&idGrupoFinanciero=${idGrupoFinanciero}&idInstitucion=${idInstitucion}"
		def rest = new RestBuilder()
		def resp = rest.get(findAllByUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<RevocacionTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
	}
	public RevocacionTO get(Long id){
		RevocacionTO r = new RevocacionTO()
		r.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			r = new RevocacionTO( this.fixRevocacionJsonObject(resp.json) )
		}
		return r
	}
	public RevocacionTO save(RevocacionTO r){
		r.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (r as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			r = new RevocacionTO( this.fixRevocacionJsonObject(resp.json) )
		}
		return r
	}
	public RevocacionTO update(RevocacionTO r){
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + r.id){
			contentType "application/json;charset=UTF-8"
			json (r as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.OK.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			r = new RevocacionTO( this.fixRevocacionJsonObject(resp.json) )
		}
		return r
	}
	
	private JSON customServiceJson(RevocacionTO r){
		def pMap = r.properties
		pMap.'fechaRevocacion' = r.fechaRevocacion.getTime()
		pMap.'fechaCreacion' = null
		pMap.'fechaModificacion' = null
		pMap.'revocados'.each{
			it.'fechaCreacion' = null
			it.'fechaModificacion' = null
		}
		return new JSON(pMap)
	}
	private JSONObject fixRevocacionJsonObject(JSONObject je){
		je.remove('class')
		
		je.'fechaRevocacion' = new Date(je.'fechaRevocacion')
		je.'fechaCreacion' = new Date(je.'fechaCreacion')
		je.'fechaModificacion' = new Date(je.'fechaModificacion')
		je.'revocados'.each{
			it.'fechaCreacion' = new Date(it.'fechaCreacion')
			it.'fechaModificacion' = new Date(it.'fechaModificacion')
		}
		
		return je
	}
	private JSONObject fixSearchResultJsonObject(JSONObject je){
		je.remove('class')
		
		je.'list'.each{
			it = this.fixRevocacionJsonObject(it)
		}
		return je
	}
}