package mx.amib.sistemas.registro.external.catalogos.service



import mx.amib.sistemas.external.catalogos.service.SepomexService;
import mx.amib.sistemas.external.expediente.service.SustentanteService
import spock.lang.*
import grails.converters.*

/**
 *
 */
class SepomexServiceIntegSpec extends Specification {

	SepomexService sepomexService
	SustentanteService sustentanteService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//def algo = sepomexService.obtenerDatosSepomexPorCodigoPostal("02450")
			def algo = sustentanteService.obtenerPorMatricula(1)
			println algo as JSON
		expect:
			1 == 1
    }
}
