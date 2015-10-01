package mx.amib.sistemas.external.expediente.service



import grails.converters.JSON
import spock.lang.*

/**
 *
 */
class SustentanteServiceIntegSpec extends Specification {

	SustentanteService sustentanteService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test findAllByIdCertificacionIn"() {
		given:
			List<Long> idsCertificacion
			def res
		when:
			idsCertificacion = [15,17,23,21,22] as List
			res = sustentanteService.findAllByIdCertificacionIn(idsCertificacion)
			println (res as JSON)
		then:
			res.size() > 0
    }
}
