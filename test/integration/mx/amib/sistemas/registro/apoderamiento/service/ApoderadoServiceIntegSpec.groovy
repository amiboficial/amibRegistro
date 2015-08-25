package mx.amib.sistemas.registro.apoderamiento.service



import grails.converters.JSON
import java.util.Set;
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

    void "test findAllByIdCertificacionIn"() {
		given:
			ApoderadoResultTO ares = null
			Set<Long> idsCertificacion = new HashSet<Long>()
			idsCertificacion.add(30)
			idsCertificacion.add(31)
			idsCertificacion.add(32)
			idsCertificacion.add(33)
		when:
			ares = apoderadoService.findAllByIdCertificacionIn(idsCertificacion)
			println "EL RESULTADO FUE -> " + (ares as JSON)
		then:
			ares != null
    }
	
}
