package mx.amib.sistemas.external.expediente.service



import grails.converters.JSON
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import spock.lang.*

/**
 *
 */
class CertificacionServiceIntegSpec extends Specification {

	def certificacionService
	CertificacionTO c
	
    def setup() {
		log.info "Starting tests"
    }

    def cleanup() {
    }

    void "probar servicio getWithSustentante"() {
		when:
			c = certificacionService.get(20019)
			System.out.println(c as JSON)
		then:
			c.id == 20019
    }
	
	void "test findAllEnDictamenPrevio"(){
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			CertificacionService.ResultSet rs = null
		when:
			rs = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, "","","",-1,-1)
			println rs
		then:
			rs.list.size() > 0
	}
	
	void "test findAllEnAutorizacion"(){
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			CertificacionService.ResultSet rs = null
		when:
			rs = certificacionService.findAllEnAutorizacion(max, offset, sort, order, "","","",-1,-1)
			println (rs as JSON)
		then:
			rs.list.size() > 0
	}
}
