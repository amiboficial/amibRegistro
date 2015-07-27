package mx.amib.sistemas.external.expediente.service

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class CertificacionService {

	String getAllUrl
	String getWithSustentante
	
	CertificacionTO get(Long id){
		CertificacionTO c = null
		def rest = new RestBuilder()
		def resp = rest.post( this.getWithSustentante + id ){
			contentType "application/json;charset=UTF-8"
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			SustentanteTO s = SustentanteService.obtenerSustentanteFromJSON(resp.json.'sustentante')
			c = s.certificaciones.find{ it.id = id }
		}
		
		return c
	}
	
    List<CertificacionTO> getAll(List<Long> ids) {
		List<Long> idsCerts = new ArrayList<Long>()
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def rest = new RestBuilder()
		def resp = rest.post( this.getAllUrl ){
			contentType "application/json;charset=UTF-8"
			json (ids as JSON)
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){					
			resp.json.'sustentantes'.each{ x -> 
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
		}
		
		return certificaciones
    }
}
