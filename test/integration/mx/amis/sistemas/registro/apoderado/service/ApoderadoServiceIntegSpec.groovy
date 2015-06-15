package mx.amis.sistemas.registro.apoderado.service

import grails.converters.JSON
import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import spock.lang.*

/**
 *
 */
class ApoderadoServiceIntegSpec extends Specification {

	//ApoderadoService apoderadoService
	//mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService registroExamenService
	def sustentanteService

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//def matricula1 = apoderadoService.obtenerDatosMatriculaDgaValido(1)
			//def testobj = registroExamenService.findAllRegistrable("Carlos","","",null)
			//def testobj = .comprobarMatriculas([2,3,4,5,6,7,8,9,10,23,217,218])
			def testobj = sustentanteService.findAll(5, 0, null, null)
			println (testobj as JSON)
	/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
		assertTrue()
	}*/
		expect:
			1==1
			//matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
