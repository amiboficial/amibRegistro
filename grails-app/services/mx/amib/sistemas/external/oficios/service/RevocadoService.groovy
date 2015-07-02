package mx.amib.sistemas.external.oficios.service

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class RevocadoService {

	String getIdsCertificacionUrl = "http://localhost:8085/revocado/getIdsCertificacionFromIdsRevocados"
	
    List<Long> getIdsCertificacion(List<Long> ids) {
		List<Long> idsCertificacion = new ArrayList<Long>()
		
		def rest = new RestBuilder()
		def resp = rest.post(getIdsCertificacionUrl){
			contentType "application/json;charset=UTF-8"
			json (ids as JSON)
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			idsCertificacion = new ArrayList<Long>(resp.json)
		}
	
		return idsCertificacion	
    }
	
}
