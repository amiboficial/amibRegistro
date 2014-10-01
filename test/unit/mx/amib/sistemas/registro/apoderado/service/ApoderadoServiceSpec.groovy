package mx.amib.sistemas.registro.apoderado.service

import grails.test.mixin.TestFor
import spock.lang.Specification

import mx.amib.sistemas.registro.apoderamiento.model.AutorizadoCNBV

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(ApoderadoService)
@Mock([AutorizadoCNBV])
class ApoderadoServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			def matricula1 = service.obtenerDatosMatriculaDgaValido(1)
		/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
			assertTrue()
		}*/
		expect:
			matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
