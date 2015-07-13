package mx.amib.sistemas.external.documentos.service



import grails.converters.JSON

import java.net.URL
import java.util.Date;

import mx.amib.sistemas.utils.service.ArchivoTemporalService
import spock.lang.*

/**
 *
 */
class DocumentoRepositorioServiceIntegSpec extends Specification {

	DocumentoRepositorioService documentoRepositorioService
	ArchivoTemporalService archivoTemporalService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		setup:
			//documentoRepositorioService.eliminarDocumento('03ccf96d-089c-4429-8304-c8d535dbf586')
		/*def algo = archivoTemporalService.descargarArchivoTemporal('TEST', '88f3b04f-1e85-4f92-b217-6d11f84a1c8a', 
																	'TASK1UPPER2_ARTICLE_WRI.docx', 
																	'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 
																	new URL('http://localhost:8083/amibDocumentos/archivoDocumento/descargarArchivoDocumentoUuid?uuid=88f3b04f-1e85-4f92-b217-6d11f84a1c8a'))*/
		//documentoRepositorioService.descargarATemporal('TEST','88f3b04f-1e85-4f92-b217-6d11f84a1c8a')
		//println (algo as JSON)
		/*def cosa = new DocumentoPoderRepositorioTO()
		cosa.id = null
		cosa.uuid = '67b5ce76-d5a0-4d9c-a6d1-867a229f3b01'
		cosa.tipoDocumentoRespaldo = 'TEST MOD 1'
		cosa.representanteLegalNombre = 'TEST MOD 2'
		cosa.representanteLegalApellido1 = 'TEST MOD 3'
		cosa.representanteLegalApellido2 = 'TEST MOD 4'
		cosa.esRegistradoPorGrupoFinanciero = true
		cosa.numeroEscritura = 666
		cosa.fechaApoderamiento = new Date()
		cosa.jsonApoderados = null
		cosa.jsonNotario = null
		cosa.jsonGrupoFinanciero = null
		cosa.jsonInstitucion = null*/
		println "== PRUEBA DEL SERVICIO =="
		//def docsPorMatricula = documentoRepositorioService.obtenerTodosPorMatricula(2)
		//def docsPorMatricula = documentoRepositorioService.obtenerTodosPorDescripcionILike("Esquer Aguirre")
		/*def docsPorMatricula = documentoRepositorioService.obtenerTodos(ClaseDocumento.REVOCACION)
		docsPorMatricula.each{
			println (it as JSON)
		}*/
		def doc = documentoRepositorioService.obtenerMetadatosDocumentoNew('13ca1e9f-465e-4d7c-8514-142c757dcde0')
		println (doc as JSON)
		expect:
			1==1
    }
}
