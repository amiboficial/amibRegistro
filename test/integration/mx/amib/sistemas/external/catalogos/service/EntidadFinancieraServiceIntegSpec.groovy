package mx.amib.sistemas.external.catalogos.service



import grails.converters.JSON
import spock.lang.*

/**
 *
 */
class EntidadFinancieraServiceIntegSpec extends Specification {

	EntidadFinancieraService entidadFinancieraService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//def algo = entidadFinancieraService.obtenerGrupoFinanciero(1)
			def algo = entidadFinancieraService.obtenerInstitucion(5)
			println (algo as JSON)
		expect:
			1==1
    }
}
