package mx.amib.sistemas.external.expediente.service

import org.springframework.http.HttpStatus
import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.persona.service.DocumentoSustentanteTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class DocumentoSustentanteService {

	String updateDocumentosDeSustentanteUrl
	
    void updateDocumentosDeSustentante(long idSustentante, List<DocumentoSustentanteTO> documentosSustentante){
		def rest = new RestBuilder()
		
		println updateDocumentosDeSustentanteUrl + "/" + idSustentante
		println (documentosSustentante as JSON)
		
		def resp = rest.post(updateDocumentosDeSustentanteUrl + "/" + idSustentante){
			contentType "application/json;charset=UTF-8"
			json (documentosSustentante as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value )
			throw new Exception("STATUS CODE: " + resp.statusCode)
	}
	
}
