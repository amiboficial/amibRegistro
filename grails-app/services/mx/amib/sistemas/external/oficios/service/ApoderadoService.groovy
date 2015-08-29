package mx.amib.sistemas.external.oficios.service

import java.util.Date;

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.oficios.poder.utils.PoderJsonTransportConverter
import mx.amib.sistemas.external.oficios.poder.utils.ApoderadoJsonTranportConverter
import mx.amib.sistemas.external.oficios.poder.ApoderadoResultTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.poder.PoderTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class ApoderadoService {

	String findAllByIdCertificacionInUrl
	String getAllUrl
	
    ApoderadoResultTO findAllByIdCertificacionIn(Set<Long> idsCertificacion) {
		ApoderadoResultTO result = new ApoderadoResultTO()
		def rest = new RestBuilder()
		def resp
		
		result.apoderados = new ArrayList<ApoderadoTO>();
		result.poderes = new ArrayList<PoderTO>();
		
		println ('se envia a url: ' + findAllByIdCertificacionInUrl)
		println ('el siguiente dato' + (idsCertificacion as JSON))
		
		resp = rest.post(findAllByIdCertificacionInUrl){
			contentType "application/json;charset=UTF-8"
			json (idsCertificacion as JSON)
		}
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			result.apoderados = ApoderadoJsonTranportConverter.fromJsonArrayToTranport(resp.json.'apoderados')
			result.poderes = PoderJsonTransportConverter.fromJsonArrayToTranport(resp.json.'poderes')
		}
		
		return result
    }
	
	ApoderadoResultTO getAll(Set<Long> ids){
		ApoderadoResultTO result = new ApoderadoResultTO()
		def rest = new RestBuilder()
		def resp
		
		result.apoderados = new ArrayList<ApoderadoTO>();
		result.poderes = new ArrayList<PoderTO>();
		
		println ('se envia a url: ' + getAllUrl)
		println ('el siguiente dato' + (ids as JSON))
		
		resp = rest.post(getAllUrl){
			contentType "application/json;charset=UTF-8"
			json (ids as JSON)
		}
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			result.apoderados = ApoderadoJsonTranportConverter.fromJsonArrayToTranport(resp.json.'apoderados')
			result.poderes = PoderJsonTransportConverter.fromJsonArrayToTranport(resp.json.'poderes')
		}
		
		return result
	}
	
}
