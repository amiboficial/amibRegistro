package mx.amib.sistemas.external.membership.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.membership.RoleTO

@Transactional
class RoleService {

	def dataSource_membership
	static datasource = 'membership'
	
    Set<RoleTO> getUserRoles(long idUser, long idApplication){
		return null
	}
	
}
