package mx.amib.sistemas.registro.membership.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.membership.PathTO
import mx.amib.sistemas.external.membership.RoleTO
import mx.amib.sistemas.external.membership.UserTO
import mx.amib.sistemas.external.membership.service.BlockedUserException;
import mx.amib.sistemas.external.membership.service.NonApprovedUserException;
import mx.amib.sistemas.external.membership.service.PathService
import mx.amib.sistemas.external.membership.service.RoleService
import mx.amib.sistemas.external.membership.service.UserService

@Transactional
class MembershipService {

	UserService userService
	RoleService roleService
	PathService pathService
	
	String applicationGuid = '30873f55-c21f-4589-aa66-883f3563ab34'
	UserTO authenticatedUser = new UserTO()
	Set<RoleTO> authenticatedUserRoles = new HashSet<>()
	Set<PathTO> restrictedPaths = new HashSet<>()
	
	static scope = "session"
	
    boolean authenticate( String userName, String cleanPassword )
		throws NonApprovedUserException, BlockedUserException{
		
		boolean valid
		
		valid = userService.validateUserNameAndPasswordAndApplication(userName, cleanPassword, applicationGuid)
		if(valid){
			authenticatedUser = userService.findByUserName(userName)
			authenticatedUserRoles = roleService.getUserRoles(authenticatedUser.id, applicationGuid)
			restrictedPaths = pathService.getRestrictedPaths(authenticatedUser.id, applicationGuid)
		}
		
		return valid
    }
	
	boolean isAuthenticated(){
		if(authenticatedUser.id <= 0){
			return false
		}
		else{
			return true
		}
	}
	
	boolean checkIfRestricted( String ctrlrName,  String actnName ){
		
		String path
		StringBuilder pathSb = new StringBuilder<>()
		PathTO pathRef
		boolean isRestricted = false
		
		path = pathSb.append('/').append(ctrlrName).append('/').append(actnName).toString()
		
		for(Iterator<PathTO> it = restrictedPaths.iterator(); it.hasNext(); ){
			pathRef = it.next()
			isRestricted = (pathRef.path.compareTo(path) == 0)
			if(isRestricted)
				break;
		}
		
		return isRestricted
		
	}
	
}
