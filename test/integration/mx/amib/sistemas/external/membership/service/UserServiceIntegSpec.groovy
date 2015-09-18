package mx.amib.sistemas.external.membership.service



import mx.amib.sistemas.external.membership.UserTO
import spock.lang.*

/**
 *
 */
class UserServiceIntegSpec extends Specification {

	static transactional = false
	
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
/*
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
*/
	
	void "test validateUserNameAndPasswordAndApplication"(){
		given:
			String userName
			String password
			String uuidApp
			boolean valid
		when:
			userName = 'nachito2'
			password = 'decanoescom2'
			uuidApp = '30873f55-c21f-4589-aa66-883f3563ab34'
			
			valid = userService.validateUserNameAndPasswordAndApplication(userName, password, uuidApp)
			//println valid
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
			u.userName = 'nachito2'
			u.password = 'decanoescom2'
			u.email = 'ignacio2@gmail.com'
			id = userService.save(u)
			println id
		then:
			id > 0
	}
*/
}
