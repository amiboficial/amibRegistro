package mx.amib.sistemas.external.oficios.service

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class RevocadoService {

	String getIdsCertificacionUrl
	String containsRevocadosUrl
	
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
	
	Map<Long,Boolean> containsRevocados(Set<Long> idsApoderado){
		Map<Long,Boolean> res = new HashMap<Long,Boolean>()
		def rest = new RestBuilder()
		def resp
		
		println 'SE VA A ENVIAR A LA URL -> ' + containsRevocadosUrl
		println 'LO SIGUIENTE -> ' + (idsApoderado as JSON)
		
		resp = rest.post(containsRevocadosUrl){
			contentType "application/json;charset=UTF-8"
			json (idsApoderado)
		}
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			println 'la respuesta json -> ' + (resp.json as JSON)
			
			for(Long idApoderado : idsApoderado){
				String strIdApoderado = idApoderado.toString()
				res.put(idApoderado, ((JSONObject)resp.json).getBoolean(strIdApoderado))
			}
		}
		
		return res
	}
	
}
