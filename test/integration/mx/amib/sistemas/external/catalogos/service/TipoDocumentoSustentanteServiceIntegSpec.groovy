package mx.amib.sistemas.external.catalogos.service

import grails.converters.JSON
import spock.lang.*

/**
 *
 */
class TipoDocumentoSustentanteServiceIntegSpec extends Specification {

	TipoDocumentoSustentanteService tipoDocumentoSustentanteService 
	
    def setup() {
    }

    def cleanup() {
    }

    void "test catalogo"() {
		given:
			List<TipoDocumentoSustentanteTO> listElements
			TipoDocumentoSustentanteTO element
		when:
			//tipoDocumentoSustentanteService.descargarCatalogo()
			listElements = tipoDocumentoSustentanteService.list()
			element = tipoDocumentoSustentanteService.get(1)
			
			println (listElements as JSON)
			println (element as JSON)
			
		then:
			listElements.size() > 0 && element.id == 1
    }
}
