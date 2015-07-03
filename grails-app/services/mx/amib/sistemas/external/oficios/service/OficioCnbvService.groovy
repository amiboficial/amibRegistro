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

	String listUrl = "http://localhost:8085/oficioCnbv/index"
	String findAllByUrl = "http://localhost:8085/oficioCnbv/findAllBy"
	String findAllByIdCertificacionInAutorizadosUrl = "http://localhost:8085/oficioCnbv/findAllByIdCertificacionInAutorizados"
	String findAllByMultipleIdCertificacionInAutorizadosUrl = "http://localhost:8085/oficioCnbv/findAllByMultipleIdCertificacionInAutorizados"
	String getUrl = "http://localhost:8085/oficioCnbv/show/"
	String saveUrl = "http://localhost:8085/oficioCnbv/save"
	String updateUrl = "http://localhost:8085/oficioCnbv/update/"
	
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
	
	public SearchResult<OficioCnbvTO> findAllByMultipleIdCertificacionInAutorizados(Integer max, Integer offset, String sort, String order, List<Long> multipleIds){
		
		SearchResult<OficioCnbvTO> sr = new SearchResult<OficioCnbvTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.post(findAllByMultipleIdCertificacionInAutorizadosUrl + qs.toString()){
			contentType "application/json;charset=UTF-8"
			json (multipleIds as JSON)
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = new SearchResult<OficioCnbvTO>(resp.json)
		}
		return sr
	}
	
	public OficioCnbvTO get(Long id){
		OficioCnbvTO o = new OficioCnbvTO()
		o.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
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
	public OficioCnbvTO put(OficioCnbvTO o){
		
		def rest = new RestBuilder()
		def resp = rest.post(updateUrl + o.id){
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
		pMap.'fechaInicioVigencia' = o.fechaInicioVigencia.getTime()
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
		je.'fechaInicioVigencia' = new Date(je.'fechaInicioVigencia')
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
