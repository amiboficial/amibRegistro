package mx.amib.sistemas.external.oficios.service

import java.util.List

import org.springframework.http.HttpStatus

import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.utils.SearchResult

import org.codehaus.groovy.grails.web.json.JSONObject

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

@Transactional
class OficioCnbvService {

	String listUrl
	String findAllByUrl
	String findAllByIdCertificacionInAutorizadosUrl
	String findAllByMultipleIdCertificacionInAutorizadosUrl
	String findAllByNumeroOficioUrl
	String findAllByClaveDgaUrl
	String findAllByFechaOficioUrl
	String checkUniqueClaveDgaUrl
	String checkUniqueNumeroOficioUrl
	String getUrl
	String saveUrl
	String updateUrl
	
    public SearchResult<OficioCnbvTO> list(Integer max, Integer offset, String sort, String order){
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
    }
	
	public SearchResult<OficioCnbvTO> findAllBy(Integer max, Integer offset, String sort, String order, String claveDga, Integer fechaDelDia, Integer fechaDelMes, Integer fechaDelAnio,
			Integer fechaAlDia, Integer fechaAlMes, Integer fechaAlAnio){
		
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&claveDga=${claveDga}&fechaDelDia=${fechaDelDia}&fechaDelMes=${fechaDelMes}&fechaDelAnio=${fechaDelAnio}&fechaAlDia=${fechaAlDia}&fechaAlMes=${fechaAlMes}&fechaAlAnio=${fechaAlAnio}"
		def rest = new RestBuilder()
		def resp = rest.get(findAllByUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
	}

	public SearchResult<OficioCnbvTO> findAllByIdCertificacionInAutorizados(Integer max, Integer offset, String sort, String order, Long idCertificacion){
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&idCertificacion=${idCertificacion}"
		def rest = new RestBuilder()
		def resp = rest.get(findAllByIdCertificacionInAutorizadosUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
	}
	
	public SearchResult<OficioCnbvTO> findAllByMultipleIdCertificacionInAutorizados(Integer max, Integer offset, String sort, String order, Collection<Long> multipleIds){
		
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		
		println "la lista es: " + (multipleIds as JSON)
		println findAllByMultipleIdCertificacionInAutorizadosUrl + qs.toString()
		
		def resp = rest.post(findAllByMultipleIdCertificacionInAutorizadosUrl + qs.toString()){
			contentType "application/json;charset=UTF-8"
			json (multipleIds as JSON)
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		return sr
	}
	
	public SearchResult<OficioCnbvTO> findAllByNumeroOficio(Integer numeroOficio){
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?numeroOficio=${numeroOficio}"
		def rest = new RestBuilder()
		
		println findAllByNumeroOficioUrl + qs.toString()
		
		def resp = rest.get(findAllByNumeroOficioUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		
		return sr
	}
	
	public SearchResult<OficioCnbvTO> findAllByClaveDga(String claveDga){
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?claveDga=${claveDga}"
		def rest = new RestBuilder()
		
		println findAllByClaveDgaUrl + qs.toString()
		
		def resp = rest.get(findAllByClaveDgaUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		
		return sr
	}
	
	public SearchResult<OficioCnbvTO> findAllByFechaOficio(Integer max, Integer offset, String sort, String order, Date fechaOficioDel, Date fechaOficioAl){
		long fechaOficioDelMilis = fechaOficioDel.getTime()
		long fechaOficioAlMilis = fechaOficioAl.getTime()
		
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&fechaOficioDel=${fechaOficioDelMilis}&fechaOficioAl=${fechaOficioAlMilis}"
		def rest = new RestBuilder()
		
		println findAllByFechaOficioUrl + qs.toString()
		
		def resp = rest.get(findAllByFechaOficioUrl + qs.toString())
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>( this.fixSearchResultJsonObject(resp.json) )
		}
		
		return sr
	}
	
	public boolean checkUniqueClaveDga(String claveDga){
		def rest = new RestBuilder()
		def resp
		def qs = "?claveDga=${claveDga}"
		String url
		boolean res = false
		
		url = checkUniqueClaveDgaUrl + qs
		resp = rest.get(url)
		
		println 'SE LLAMA A checkUniqueClaveDgaUrl: ' + url
		println 'Respuesta: ' + resp.text
		
		if(resp.text == "true"){
			res = true
		}
		
		return res
	}
	
	public boolean checkUniqueNumeroOficio(int numeroOficio){
		def rest = new RestBuilder()
		def resp
		def qs = "?numeroOficio=${numeroOficio}"
		String url
		boolean res = false
		
		url = checkUniqueNumeroOficioUrl + qs
		resp = rest.get(url)
		
		println 'SE LLAMA A checkUniqueNumeroOficio: ' + url
		println 'Respuesta: ' + resp.text
		
		if(resp.text == "true"){
			res = true
		}
		
		return res
	}
	
	
	
	public OficioCnbvTO get(Long id){
		OficioCnbvTO o = new OficioCnbvTO()
		o.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			println("respuesta del getcosa jaja")
			println(resp.json)
			o = new OficioCnbvTO( this.fixOficioCnbvJsonObject(resp.json) )
		}
		return o
	}
	public OficioCnbvTO save(OficioCnbvTO o){
		o.id = null
		
		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json this.customServiceJson(o)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			o = new OficioCnbvTO( this.fixOficioCnbvJsonObject(resp.json) )
		}
		return o
	}
	public OficioCnbvTO update(OficioCnbvTO o){
		
		def rest = new RestBuilder()
		def resp = rest.put(updateUrl + o.id){
			contentType "application/json;charset=UTF-8"
			json this.customServiceJson(o)
		}
		
		if(resp.statusCode.value() != HttpStatus.OK.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
			
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			o = new OficioCnbvTO( this.fixOficioCnbvJsonObject(resp.json) )
		}
		return o
	}
	
	private JSON customServiceJson(OficioCnbvTO o){
		def pMap = o.properties
		pMap.'fechaOficio' = o.fechaOficio.getTime()
		pMap.'fechaCreacion' = null
		pMap.'fechaModificacion' = null
		pMap.'autorizados'.each{
			it.'fechaCreacion' = null
			it.'fechaModificacion' = null
		}
		return new JSON(pMap)
	}
	private JSONObject fixOficioCnbvJsonObject(JSONObject je){
		je.remove('class')
		je.'fechaOficio' = new Date(je.'fechaOficio')
		je.'fechaCreacion' = new Date(je.'fechaCreacion')
		je.'fechaModificacion' = new Date(je.'fechaModificacion')
		je.'autorizados'.each{
			it.'fechaCreacion' = new Date(it.'fechaCreacion')
			it.'fechaModificacion' = new Date(it.'fechaModificacion')
		}
		
		return je
	}
	private JSONObject fixSearchResultJsonObject(JSONObject je){
		je.remove('class')
		je.'list'.each{
			it = this.fixOficioCnbvJsonObject(it)
		}
		return je
	}
}
