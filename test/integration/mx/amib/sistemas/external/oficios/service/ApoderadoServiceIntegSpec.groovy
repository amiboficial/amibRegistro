package mx.amib.sistemas.external.oficios.service



import grails.converters.JSON
import mx.amib.sistemas.external.oficios.poder.ApoderadoResultTO
import spock.lang.*

/**
 *
 */
class ApoderadoServiceIntegSpec extends Specification {

	def apoderadoService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test apoderadoService.findAllByIdCertificacionIn"() {
		given:
			Set<Long> idsCertificacion = new HashSet<Long>();
			ApoderadoResultTO apres = new ApoderadoResultTO();
			
			idsCertificacion.add(21L)
			idsCertificacion.add(20L)
			idsCertificacion.add(22L)
			idsCertificacion.add(23L)
			idsCertificacion.add(44L)
		when:
			apres = apoderadoService.findAllByIdCertificacionIn(idsCertificacion)
			println 'el resultado es -> ' + (apres as JSON)
		then:
			apres != null
    }
	
	void "test apoderadoService.getAll"(){
		given:
			Set<Long> ids = new HashSet<Long>();
			ApoderadoResultTO apres = new ApoderadoResultTO();
			ids.add(20048L)
			ids.add(20049L)
			ids.add(20050L)
			ids.add(20051L)
		when:
			apres = apoderadoService.findAllByIdCertificacionIn(ids)
			println 'el resultado es -> ' + (apres as JSON)
		then:
			apres != null
	}
}
