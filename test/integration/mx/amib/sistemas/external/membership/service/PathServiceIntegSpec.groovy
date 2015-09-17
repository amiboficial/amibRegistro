package mx.amib.sistemas.external.membership.service


import grails.converters.JSON

import java.util.Set
import mx.amib.sistemas.external.membership.PathTO

import spock.lang.*

/**
 *
 */
class PathServiceIntegSpec extends Specification {

	PathService pathService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test getRestrictedPaths"() {
		given:
			long idUser
			String uuidApplication
			Set<PathTO> res
		when:
			idUser = 1
			uuidApplication = '30873f55-c21f-4589-aa66-883f3563ab34'
			res = pathService.getRestrictedPaths(idUser,uuidApplication)
			println (res as JSON)
		then:
			res.size() > 0
    }
}
