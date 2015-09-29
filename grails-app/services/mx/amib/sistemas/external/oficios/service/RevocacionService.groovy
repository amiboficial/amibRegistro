package mx.amib.sistemas.external.oficios.service

import java.util.Date;
import java.util.List

import org.springframework.http.HttpStatus

import mx.amib.sistemas.utils.SearchResult
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.revocacion.RevocadoTO
import mx.amib.sistemas.external.oficios.revocacion.utils.*

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse
import grails.transaction.Transactional

@Transactional
class RevocacionService {

	String listUrl
	String findAllByUrl
	String getUrl
	String saveUrl
	String updateUrl
	String isNumeroEscrituraAvailableUrl
	String findAllByNumeroEscrituraUrl
	String findAllByFechaRevocacionUrl
	String findAllByGrupoFinancieroUrl
	String findAllByInstitucionUrl
	String getAllByIdCertficacionInSetUrl
	
    public SearchResult<RevocacionTO> list(Integer max, Integer offset, String sort, String order){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		def qs = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}"
		def rest = new RestBuilder()
		def resp = rest.get(listUrl + qs.toString())
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
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
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		return sr
	}
	
	public SearchResult<RevocacionTO> findAllByNumeroEscritura(int numeroEscritura){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		RestBuilder rest = new RestBuilder()
		RestResponse resp
		String queryString
		
		queryString = "?numeroEscritura=${numeroEscritura}"
		resp = rest.get(findAllByNumeroEscrituraUrl + queryString)
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		
		return sr
	}
	public SearchResult<RevocacionTO> findAllByFechaRevocacion(int max, int offset, String sort, String order,
																int fechaDelDia, int fechaDelMes, int fechaDelAnio,
																int fechaAlDia, int fechaAlMes, int fechaAlAnio){
		
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		RestBuilder rest = new RestBuilder()
		RestResponse resp
		String queryString
		
		queryString = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&fechaDelDia=${fechaDelDia}&fechaDelMes=${fechaDelMes}&fechaDelAnio=${fechaDelAnio}&fechaAlDia=${fechaAlDia}&fechaAlMes=${fechaAlMes}&fechaAlAnio=${fechaAlAnio}"
		resp = rest.get(findAllByFechaRevocacionUrl + queryString)
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		
		return sr
	}
	public SearchResult<RevocacionTO> findAllByGrupoFinanciero(int max, int offset, String sort, String order, int idGrupoFinanciero){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		RestBuilder rest = new RestBuilder()
		RestResponse resp
		String queryString
		
		queryString = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&idGrupoFinanciero=${idGrupoFinanciero}"
		resp = rest.get(findAllByGrupoFinancieroUrl + queryString)
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		
		return sr
	}
	public SearchResult<RevocacionTO> findAllByInstitucion(int max, int offset, String sort, String order, int idInstitucion){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		RestBuilder rest = new RestBuilder()
		RestResponse resp
		String queryString
		
		queryString = "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&idInstitucion=${idInstitucion}"
		resp = rest.get(findAllByInstitucionUrl + queryString)
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			sr = SearchResultJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		
		return sr
	}
	
	public Set<RevocacionTO> getAllByIdCertficacionInSet(Set<Long> idsCertficacion){
		Set<RevocacionTO> result = new HashSet<RevocacionTO>()
		RestBuilder rest = new RestBuilder()
		RestResponse resp
		String queryString
		
		println getAllByIdCertficacionInSetUrl
		println (idsCertficacion as JSON)
		
		resp = rest.post(getAllByIdCertficacionInSetUrl){
			contentType "application/json;charset=UTF-8"
			json (idsCertficacion as JSON)
		}
		
		if(resp.json instanceof JSONElement && !JSONObject.NULL.equals(resp.json)){			
			result = RevocacionJsonTranportConverter.fromJsonArrayToTranportSet((JSONArray)resp.json)
		}
		
		return result
	}
	
	public RevocacionTO get(Long id){
		RevocacionTO r = new RevocacionTO()
		r.id = -1
		
		def rest = new RestBuilder()
		def resp = rest.get(getUrl + id)
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			r = RevocacionJsonTranportConverter.fromJsonToTranport(resp.json)
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
			r = RevocacionJsonTranportConverter.fromJsonToTranport(resp.json)
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
			r = RevocacionJsonTranportConverter.fromJsonToTranport(resp.json)
		}
		return r
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
	
}
