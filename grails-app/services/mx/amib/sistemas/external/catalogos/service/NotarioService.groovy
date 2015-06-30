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
	
	def list(Integer max, Integer offset, String sort, String order){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		SearchResult sr = new SearchResult()
		
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			resp.json.remove('class')
			resp.json.'list'.each{
				it.remove('class')
				it.'fechaCreacion' = df.parse(it.'fechaCreacion')
				it.'fechaModificacion' = df.parse(it.'fechaModificacion')
			}
			sr = new SearchResult(resp.json)
		}
		return sr
	}
	
    def get(Long id) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		NotarioTO n = new NotarioTO()
		n.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			resp.json.remove('class')
			resp.json.'fechaCreacion' = df.parse(resp.json.'fechaCreacion')
			resp.json.'fechaModificacion' = df.parse(resp.json.'fechaModificacion')
			n = new NotarioTO(resp.json)
		}
		return n
    }
	
	def save(NotarioTO n){
		n.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (n as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_CREATED )
			throw new Exception("STATUS CODE: " + resp.statusCode)
	}
	
	def update(NotarioTO n){
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + n.id){
			contentType "application/json;charset=UTF-8"
			json (n as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.SC_OK )
			throw new Exception("STATUS CODE: " + resp.statusCode)
	}
	
	def delete(Long id){
		def rest = new RestBuilder( + n.id)
		def resp = rest.put(deleteUrl + n.id)
		
		
		if(resp.statusCode.value() != HttpStatus.SC_NO_CONTENT )
			throw new Exception("STATUS CODE: " + resp.statusCode)
		
	}
	
	def findAllBy(Integer max, Integer offset, String sort, String order, 
					Long idEntidadFederativa, Integer numeroNotario, String nombreCompleto) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
		SearchResult sr = new SearchResult()
		
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&idEntidadFederativa=${idEntidadFederativa}&numeroNotario=${numeroNotario}&nombreCompleto=${nombreCompleto}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			resp.json.remove('class')
			resp.json.'list'.each{
				it.remove('class')
				it.'fechaCreacion' = df.parse(it.'fechaCreacion')
				it.'fechaModificacion' = df.parse(it.'fechaModificacion')
			}
			sr = new SearchResult(resp.json)
		}
		return sr
	}
	
}

class SearchResult {
	List<NotarioTO> list
	Integer count
	Boolean error
	String errorDetails
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


