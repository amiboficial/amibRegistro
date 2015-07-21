package mx.amis.sistemas.registro.apoderado.service

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
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
	def revocacionService
	def oficioCnbvService
	
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
								   "id": 10049,
								   "version": 1,
								   "idGrupoFinanciero": 1122,
								   "idInstitucion": 1122,
								   "idNotario": 1234551,
								   "numeroEscritura": 113334,
								   "representanteLegalNombre": "Jean-Claude",
								   "representanteLegalApellido1": "Le Blanc",
								   "representanteLegalApellido2": "Cruces",
								   "fechaApoderamiento": new Date(1435817056000),
								   "uuidDocumentoRespaldo": "62b376f0-b923-4a2e-a71d-b3fd2dfe447f",
								   "apoderados": [
									{
									   "id":10088,
									   "idCertificacion": 15,
									   "idPoder": 10049,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									},
									{
									   "id": 10089,
									   "idCertificacion": 16,
									   "idPoder":10049,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									},
									{
									   "id": 10090,
									   "idCertificacion": 17,
									   "idPoder":10049,
									   "fechaCreacion": new Date(1435817056000),
									   "fechaModificacion": new Date(1435817056000)
									}
								   ],
								   "fechaCreacion": new Date(1435817056000),
								   "fechaModificacion": new Date(1435817056000)
								}""")
			//jsonElement.'fechaApoderamiento' = new Date(jsonElement.'fechaApoderamiento')
			PoderTO p = new PoderTO(jsonElement)
			//p = apoderamientoService.altaPoder(p)
			//p = poderService.save(p)
			//def testobj = poderService.findAllBy(10,0,'id','desc',77,
			//																	-1,-1,-1,-1,-1,-1,-1,-1)
			//def testobj = poderService.update(p)
			//def testobj = revocacionService.list(10,0,'id','desc')
			/*def testobj = revocacionService.get(3)
			testobj.representanteLegalApellido1 = "PRUEBA 1"
			testobj.representanteLegalApellido2 = "PRUEBA 2"
			
			testobj.revocados.get(0).motivo = "MODIFICACION EN ENTORNO DE PRUEBA"
			
			testobj = revocacionService.update(testobj)
			println (testobj as JSON)*/
			
			//def testobj = oficioCnbvService.get(1)
			//testobj.claveDga = "DGA-1337TT"
			//testobj = oficioCnbvService.update(testobj)
			
			//def testobj = autorizacionService.autorizar([4L,5L,8L,9L,18L])
			//def testobj = poderService.get(1)
			//def 
			//def testobj = autorizacionService.quitarAutorizadosCnbv()
			
			
			jsonElement =  JSON.parse("""{
										   "id": -1,
										   "version": -1,
										   "idGrupoFinanciero": 88888,
										   "idInstitucion": 88888,
										   "idNotario": 1,
										   "numeroEscritura": 3344,
										   "representanteLegalNombre": "AAAA",
										   "representanteLegalApellido1": "BBBB",
										   "representanteLegalApellido2": "CCCC",
										   "fechaRevocacion": new Date(1435885349000),
										   "uuidDocumentoRespaldo": "e18f019a-eb91-4979-83fd-0b98d1a9604e",
										   "revocados": [
												{
												   "id": -1,
												   "idRevocacion": -1,
												   "idApoderado": 10088,
												   "motivo": "PRUEBA DE REVOCACION CON PROCESO 1",
												   "fechaBaja": new Date(1435885349000),
												   "fechaCreacion": new Date(1435885349000),
												   "fechaModificacion": new Date(1435885349000)
												},
												{
												   "id": -1,
												   "idRevocacion": -1,
												   "idApoderado": 10090,
												   "motivo": "PRUEBA DE REVOCACION CON PROCESO 2",
												   "fechaBaja": new Date(1435885349000),
												   "fechaCreacion": new Date(1435885349000),
												   "fechaModificacion": new Date(1435885349000)
												},
										   ],
										   "fechaCreacion": new Date(1435885349000),
										   "fechaModificacion": new Date(1435885349000)
										}""")
			//def objToSend = new RevocacionTO(jsonElement);
			//objToSend = revocacionService.save(objToSend)
			
			def r = revocacionService.get(7)
			r.representanteLegalApellido1 = "FILTH"
			revocacionService.update(r)
			
			
			println (r as JSON)
			
			//println testobj
	/*if(matricula1.nombreCompleto == "Carlos Cano Sosa"){
		assertTrue()
	}*/
		expect:
			1==1
			//matricula1.nombreCompleto == "Carlos Cano Sosa"
    }
}
