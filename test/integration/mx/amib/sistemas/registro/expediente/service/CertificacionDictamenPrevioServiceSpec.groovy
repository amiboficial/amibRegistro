package mx.amib.sistemas.registro.expediente.service



import grails.converters.JSON
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO;
import spock.lang.*

/**
 *
 */
class CertificacionDictamenPrevioServiceSpec extends Specification {

	def certificacionDictamenPrevioService
	CertificacionTO c
	CertificacionTO wc
	
    def setup() {
    }

    def cleanup() {
    }

    void "probar obtener certificacion en emision dictamen"() {
		when:
			c = certificacionDictamenPrevioService.obtenerParaEmisionDictamen(20019)
			
			System.out.println(c as JSON)
		then:
			c.id == 20019
		
    }
}
