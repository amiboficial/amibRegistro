package mx.amib.sistemas.external.catalogos.service

import grails.transaction.Transactional

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

/**
 * Este servicio permite obtener detalles sobre el
 * versionamiento de los catálogos del sistema amibCatalogos
 *
 * @author Gabriel
 * @version 1.0 - (Última actualización) 8/01/2015
 *
 */
@Transactional
class VersionCatalogoService {

	// TODO: Mover la asignación del valor a la configuración de spring
	String obtenerUltimaVersionUrl = "http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/versionCatalogoRestful/obtenerUltimaVersion/"
	
    def obtenerUltimaVersion(Integer id) {
		String restUrl = obtenerUltimaVersionUrl + id
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		return resp.json
    }
	
}
