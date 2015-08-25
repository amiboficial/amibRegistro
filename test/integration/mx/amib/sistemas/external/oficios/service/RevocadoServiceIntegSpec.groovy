package mx.amib.sistemas.external.oficios.service



import grails.converters.JSON
import spock.lang.*

/**
 *
 */
class RevocadoServiceIntegSpec extends Specification {

	def revocadoService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test revocadoService.containsRevocados"() {
		given:
			Set<Long> idsApoderado = new HashSet<Long>()
			idsApoderado.add(33L)
			idsApoderado.add(35L)
			idsApoderado.add(32L)
			idsApoderado.add(34L)
			
		when:
			def res = revocadoService.containsRevocados(idsApoderado)
			println 'resultado de objeto: -> ' + (res as JSON)
		then:
			res != null
    }
}
