package mx.amib.sistemas.external.catalogos.service

import org.apache.http.HttpStatus

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import groovy.json.JsonBuilder;
import groovy.json.JsonOutput;

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.List;

import org.codehaus.groovy.grails.web.json.JSONObject

import com.google.gson.JsonObject;

class NotarioService {
	
	def grailsApplication
	
	String listUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/index"
	String getUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/show/"
	String saveUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/save"
	String updateUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/update/"
	String deleteUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/delete/"
	String findAllByUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/notarioRestful/findAllBy"
	
	SearchResult list(Integer max, Integer offset, String sort, String order){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		SearchResult sr = new SearchResult()
		
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = this.searchResultFromRespJSON(resp.json)
		}
		return sr
	}
	
    NotarioTO get(Long id) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		NotarioTO n = new NotarioTO()
		n.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			n = this.notarioTOFromRespJSON(resp.json)
		}
		return n
    }
	
	NotarioTO save(NotarioTO n){
		n.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (n as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_CREATED )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			n = this.notarioTOFromRespJSON(resp.json)
		}
		return n
	}
	
	NotarioTO update(NotarioTO n){
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + n.id){
			contentType "application/json;charset=UTF-8"
			json (n as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_OK )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			n = this.notarioTOFromRespJSON(resp.json)
		}
		return n
	}
	
	Boolean delete(Long id){
		Boolean result
		
		def rest = new RestBuilder()
		def resp = rest.delete(deleteUrl + id)
		
		if(resp.statusCode.value() != HttpStatus.SC_NO_CONTENT )
			//throw new Exception("STATUS CODE: " + resp.statusCode)
			result = false
		else
			result = true
		
		return result
	}
	
	SearchResult findAllBy(Integer max, Integer offset, String sort, String order, 
					Long idEntidadFederativa, Integer numeroNotario, String nombreCompleto) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		SearchResult sr = new SearchResult()
		
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&idEntidadFederativa=${idEntidadFederativa}&numeroNotario=${numeroNotario}&nombreCompleto=${nombreCompleto}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = this.searchResultFromRespJSON(resp.json)
		}
		return sr
	}
	
	private SearchResult searchResultFromRespJSON(JSONObject jsonObject){
		jsonObject.remove('class')
		jsonObject.'list'.each{
			it = this.notarioTOFromRespJSON(it)
		}
		return new SearchResult(jsonObject)
	}
	
	private NotarioTO notarioTOFromRespJSON(JSONObject jsonObject){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		jsonObject = this.fixNotarioResp(jsonObject)
		return new NotarioTO(jsonObject)
	}
	
	private JSONObject fixNotarioResp(JSONObject jsonObject){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		jsonObject.remove('class')
		jsonObject.'fechaCreacion' = df.parse(jsonObject.'fechaCreacion')
		jsonObject.'fechaModificacion' = df.parse(jsonObject.'fechaModificacion')
		return jsonObject
	}
	
}

class SearchResult {
	List<NotarioTO> list
	Integer count
	Boolean error
	String errorMessage
}

class NotarioTO {
	Long id
	Long numeroVersion
	Long idEntidadFederativa
	Integer numeroNotaria
	String nombreCompleto
	Boolean vigente
	
	Date fechaCreacion
	Date fechaModificacion
}


