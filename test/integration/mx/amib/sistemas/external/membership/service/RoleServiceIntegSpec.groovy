package mx.amib.sistemas.external.membership.service



import grails.converters.JSON
import java.util.Set;

import mx.amib.sistemas.external.membership.RoleTO;
import spock.lang.*

/**
 *
 */
class RoleServiceIntegSpec extends Specification {

	RoleService roleService
	
    def setup() {
    }

    def cleanup() {
    }

    void "test getUserRoles"() {
		given:
			long idUser
			String uuidApplication
			Set<RoleTO> res
		when:
			idUser = 1
			uuidApplication = '30873f55-c21f-4589-aa66-883f3563ab34'
			res = roleService.getUserRoles(idUser,uuidApplication)
			println (res as JSON)
		then:
			res.size() > 0
    }
}
