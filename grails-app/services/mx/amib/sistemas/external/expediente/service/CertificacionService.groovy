package mx.amib.sistemas.external.expediente.service

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class CertificacionService {

	//TODO: Hacer test de integración para certificación service
	
	String getAllUrl

	String getWithSustentante
	String findAllEnDictamenPrevioUrl
	String findAllEnDictamenPrevioByMatriculaUrl
	String findAllEnDictamenPrevioByFolioUrl
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
	
	List<CertificacionTO> findAllEnDictamenPrevio(Integer max, Integer offset, String sort, String order, 
											String nom, String ap1, String ap2, 
											Long idfig, Long idvarfig){
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnDictamenPrevioUrl + "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&nom=${nom}&ap1=${ap1}&ap2=${ap2}&idfig=${idfig}&idvarfig=${idvarfig}"
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
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
	
	List<CertificacionTO> findAllEnDictamenPrevioByMatricula(Integer numeroMatricula){
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnDictamenPrevioByMatriculaUrl + numeroMatricula
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
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
	
	List<CertificacionTO> findAllEnDictamenPrevioByFolio(Long idSustentante){
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnDictamenPrevioByFolioUrl + idSustentante
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
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
	}

}
