package mx.amis.sistemas.registro.apoderado.service

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
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
	def poderService
	//def autorizacionService
	def apoderamientoService
	
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

			
			def jsonElement = JSON.parse("""{
								   "id": -1,
								   "version": 1,
								   "idGrupoFinanciero": 1122,
								   "idInstitucion": 1122,
								   "idNotario": 1234551,
								   "numeroEscritura": 113334,
								   "representanteLegalNombre": "Jean-Claude",
								   "representanteLegalApellido1": "Le Blanc",
								   "representanteLegalApellido2": "Cruz",
								   "fechaApoderamiento": new Date(1435817056000),
								   "uuidDocumentoRespaldo": "62b376f0-b923-4a2e-a71d-b3fd2dfe447f",
								   "apoderados": [
									{
									   "id": -1,
									   "idCertificacion": 15,
									   "idPoder": -1,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									},
									{
									   "id": -1,
									   "idCertificacion": 16,
									   "idPoder": -1,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									},
									{
									   "id": -1,
									   "idCertificacion": 17,
									   "idPoder": -1,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									}
								   ],
								   "fechaCreacion": new Date(1435817056000),
								   "fechaModificacion": new Date(1435817056000)
								}""")
			//jsonElement.'fechaApoderamiento' = new Date(jsonElement.'fechaApoderamiento')
			//PoderTO p = new PoderTO(jsonElement)
			//p = apoderamientoService.altaPoder(p)
			//p = poderService.save(p)
			def testobj = poderService.findAllBy(10,0,'id','desc',77,null,null,null,null,null,null,null,null)
			println (testobj as JSON)
			//def testobj = autorizacionService.autorizar([4L,5L,8L,9L,18L])
			//def testobj = poderService.get(1)
			//println (testobj as JSON)
			//println testobj
	/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
		assertTrue()
	}*/
		expect:
			1==1
			//matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
