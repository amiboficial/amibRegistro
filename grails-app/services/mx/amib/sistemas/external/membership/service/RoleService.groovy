package mx.amib.sistemas.external.membership.service

import grails.transaction.Transactional
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import mx.amib.sistemas.external.membership.RoleTO

@Transactional
class RoleService {

	def dataSource_membership
	static datasource = 'membership'
	
	final String GET_USER_ROLES_SQL = """
		SELECT T003.id_application id_application
			  ,T003.seq_role seq_role
			  ,T003.tx_name tx_name
			  ,T003.tx_description  tx_description
			  ,T003.st_active st_active
		  FROM t002_c_application T002
			INNER JOIN t003_c_role T003 ON T002.id_application = T003.id_application
			INNER JOIN t005_t_userinrole T005 ON T003.id_application = T005.id_application AND T003.seq_role = T005.seq_role
		  WHERE T005.id_user = :idUser AND T002.tx_uuid = :uuidApplication;"""
	
		  
    Set<RoleTO> getUserRoles(long idUser, String uuidApplication){
		
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		
		Set<RoleTO> resultSet = new HashSet<RoleTO>()
		
		resRows = sql.rows(GET_USER_ROLES_SQL,[idUser:idUser, uuidApplication:uuidApplication])
		resRows.each{ x ->
			resultSet.add( this.fromRowToRole(x) )
		}
		
		return resultSet
	}
	
	RoleTO fromRowToRole(GroovyRowResult grr){
		RoleTO role = new RoleTO()
		
		role.idApplication = (Long)grr.get('id_application')
		role.numberRole = (Long)grr.get('seq_role')
		
		role.name = (String)grr.get('tx_name')
		role.description = (String)grr.get('tx_description')
		role.active = (Boolean)grr.get('st_active')
		
		return role
	}
}
