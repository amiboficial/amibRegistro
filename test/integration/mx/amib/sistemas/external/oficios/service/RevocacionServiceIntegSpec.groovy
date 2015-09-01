package mx.amib.sistemas.external.oficios.service


import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO;
import mx.amib.sistemas.utils.SearchResult;
import grails.converters.JSON
import spock.lang.*

/**
 *
 */
class RevocacionServiceIntegSpec extends Specification {

	RevocacionService revocacionService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test revocacionService.findAllByNumeroEscritura"() {
		given:
			int numeroMatricula
			SearchResult<RevocacionTO> res
		when:
			res = revocacionService.findAllByNumeroEscritura(numeroMatricula)
			println 'res findAllByNumeroEscritura -> '
			println (res as JSON)
		then:
			res != null
    }
	
	void "test revocacionService.findAllByFechaRevocacion"() {
		given:
			int max = 10
			int offset = 0
			String sort = 'id'
			String order = 'asc'
			int fechaDelDay = 1
			int fechaDelMonth = 1
			int fechaDelYear = 1990
			int fechaAlDay = 1
			int fechaAlMonth = 1
			int fechaAlYear = 2099
			SearchResult<RevocacionTO> res
		when:
			res = revocacionService.findAllByFechaRevocacion(max, offset, sort, order, fechaDelDay, fechaDelMonth, fechaDelYear, fechaAlDay, fechaAlMonth, fechaAlYear)
			println 'res findAllByNumeroEscritura -> '
			println (res as JSON)
		then:
			res != null
	}
	
	void "test revocacionService.findAllByGrupoFinanciero"() {
		given:
			int max = 10
			int offset = 0
			String sort = 'id'
			String order = 'asc'
			int idGrupoFinanciero = 666
			SearchResult<RevocacionTO> res
		when:
			res = revocacionService.findAllByGrupoFinanciero(max, offset, sort, order,idGrupoFinanciero)
			println 'res findAllByNumeroEscritura -> '
			println (res as JSON)
		then:
			res != null
	}
	
	void "test revocacionService.findAllByInstitucion"() {
		given:
			int max = 10
			int offset = 0
			String sort = 'id'
			String order = 'asc'
			int idInstitucion = 2
			SearchResult<RevocacionTO> res
		when:
			res = revocacionService.findAllByInstitucion(max, offset, sort, order,idInstitucion)
			println 'res findAllByNumeroEscritura -> '
			println (res as JSON)
		then:
			res != null
	}
	
}
