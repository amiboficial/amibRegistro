package mx.amib.sistemas.external.oficios.service



import grails.converters.JSON
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO;
import mx.amib.sistemas.utils.SearchResult;
import spock.lang.*

/**
 *
 */
class OficioCnbvServiceIntegSpec extends Specification {

	def oficioCnbvService
	
    def setup() {
    }

    def cleanup() {
    }
/*
    void "probando llamada a \"list\""() {
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			SearchResult<OficioCnbvTO> sr = null
		when:
			sr = oficioCnbvService.list(max,offset,sort,order)
			
			println ("Resultado de llamada a servicio -> ")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
    }*/
	
	void "probando llamada a findAllByMultipleIdCertificacionInAutorizados"(){
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			SearchResult<OficioCnbvTO> sr = null
		when:
			sr = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max,offset,sort,order, [12] )
			
			println ("Resultado de llamada a servicio -> ")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
	}
}
