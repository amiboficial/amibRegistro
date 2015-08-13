package mx.amib.sistemas.registro.expediente.service



import grails.converters.JSON
import mx.amib.sistemas.external.expediente.service.CertificacionService
import spock.lang.*

/**
 *
 */
class FormatoSolicitudAutorizacionServiceIntegSpec extends Specification {

	CertificacionService certificacionService
	FormatoSolicitudAutorizacionService formatoSolicitudAutorizacionService
	
    def setup() {
    }

    def cleanup() {
    }

    void "probar archivo con algunas certificaciones en pendiente de dictamen"() {
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			CertificacionService.ResultSet rs = null
			FileOutputStream fos = new FileOutputStream("H:\\Temp\\amibRegistro\\testArchivo.xlsx")
		when:
			rs = certificacionService.findAllEnAutorizacion(max, offset, sort, order, "","","",-1,-1)
			//println (rs as JSON)
			formatoSolicitudAutorizacionService.fill(rs.list)
			formatoSolicitudAutorizacionService.renderAsXLSX(fos);
			formatoSolicitudAutorizacionService.flush()
			fos.close();
		then:
			1 == 1
    }
}
