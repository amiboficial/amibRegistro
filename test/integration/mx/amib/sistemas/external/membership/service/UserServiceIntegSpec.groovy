package mx.amib.sistemas.external.membership.service



import mx.amib.sistemas.external.membership.UserTO
import spock.lang.*

/**
 *
 */
class UserServiceIntegSpec extends Specification {

	//static transactional = false
	
	def userService
	
    def setup() {
    }

    def cleanup() {
    }
/*
    void "test get with id param"() {
		given:
			long id
			UserTO res
		when:
			id = 6
			res = userService.get(id)
			println res.toString()
		then:
			res.id == id
    }
*/	
	void "test validateUserNameAndPassword"(){
		given:
			String userName
			String password
			boolean valid
		when:
			userName = "primigenio"
			password = "polloshermanos"
			
			valid = userService.validateUserNameAndPassword(userName, password)
			println valid
		then:
			valid == true
	}

/*	
	void "test save"(){
		given:
			UserTO u
			long id
		when:
			u = new UserTO()
			u.userName = 'nachito'
			u.password = 'decanoescom'
			u.email = 'ignacio@gmail.com'
			id = userService.save(u)
			println id
		then:
			id > 0
	}
*/
}
