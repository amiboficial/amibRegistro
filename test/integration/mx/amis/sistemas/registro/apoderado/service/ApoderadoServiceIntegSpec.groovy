package mx.amis.sistemas.registro.apoderado.service



import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import spock.lang.*

/**
 *
 */
class ApoderadoServiceIntegSpec extends Specification {

	ApoderadoService apoderadoService
	mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService registroExamenService

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//def matricula1 = apoderadoService.obtenerDatosMatriculaDgaValido(1)
			def testobj = registroExamenService.findRegistrableByNumeroMatricula(1)
	/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
		assertTrue()
	}*/
		expect:
			1==1
			//matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
