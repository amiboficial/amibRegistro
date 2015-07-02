package mx.amis.sistemas.registro.apoderado.service

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.registro.apoderado.service.ApoderadoV1Service
import spock.lang.*

/**
 *
 */
class ApoderadoServiceIntegSpec extends Specification {

	//ApoderadoService apoderadoService
	//mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService registroExamenService
	//def sustentanteService
	//mx.amib.sistemas.external.catalogos.service.NotarioService notarioService
	//def poderService
	def autorizacionService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//def matricula1 = apoderadoService.obtenerDatosMatriculaDgaValido(1)
			//def testobj = registroExamenService.findAllRegistrable("Carlos","","",null)
			//def testobj = .comprobarMatriculas([2,3,4,5,6,7,8,9,10,23,217,218])
			//def testobj = sustentanteService.get(1)
			/*NotarioTO n = new NotarioTO()
			n.idEntidadFederativa = 9
			n.nombreCompleto = "AAAA BBBB CCCC DDDD"
			n.numeroNotaria = 666
			n.numeroVersion = 1
			n.vigente = true
			n.fechaCreacion = Calendar.getInstance().getTime()
			n.fechaModificacion = Calendar.getInstance().getTime()
			def testobj = notarioService.save(n)*/
			//def refobj = notarioService.get(27)
			//refobj.nombreCompleto = "AAAA BBBB CCCC DDDD XMOD"
			//def testobj = notarioService.delete(28)
			//def testobj = notarioService.findAllBy(10,0,'id','asc',9,-1,"AD")
			//println (testobj.fechaCreacion.toString()
			def testobj = autorizacionService.autorizar([4L,5L,8L,9L,18L])
			//def testobj = poderService.get(1)
			println (testobj as JSON)
			//println testobj
	/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
		assertTrue()
	}*/
		expect:
			1==1
			//matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
