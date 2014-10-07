package mx.amib.sistemas.registro.external.catalgos.service



import spock.lang.*

import grails.converters.*

/**
 *
 */
class SepomexServiceIntegSpec extends Specification {

	SepomexService sepomexService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			def catEntidadesFed = sepomexService.obtenerEntidadesFederativas()
			println catEntidadesFed as JSON
		expect:
			1 == 1
    }
}
