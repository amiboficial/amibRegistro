package mx.amib.sistemas.external.documentos.service



import grails.converters.JSON

import java.net.URL

import mx.amib.sistemas.util.service.ArchivoTemporalService
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
		documentoRepositorioService.descargarATemporal('TEST','88f3b04f-1e85-4f92-b217-6d11f84a1c8a')
		//println (algo as JSON)
		expect:
			1==1
    }
}
