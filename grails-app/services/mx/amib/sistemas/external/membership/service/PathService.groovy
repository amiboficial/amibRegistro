package mx.amib.sistemas.external.membership.service

import grails.transaction.Transactional
import groovy.sql.GroovyRowResult;
import groovy.sql.Sql
import mx.amib.sistemas.external.membership.PathTO

@Transactional
class PathService {

	def dataSource_membership
	static datasource = 'membership'
	
	//Este query obtiene los paths a los cuales no esta permido que acceda el usuario de acuerdo a su conjunto de roles.
	//Los 'calcula' obteniendo el numero total de roles por aplicación del usuario (nu_rolesperuser) 
	//con el numero total de restricciones de path por cada rol que tenga (nu_rolepathrestricperuser)
	//Si ambos son iguales, es decir, todos los roles de usuario en aplicación aplican la misma restricción, entonces la 
	//la restricción es efectiva.
	//Eso quiere decir que si un solo rol del conjunto no aplica X restricción, entonces X restricción no se aplicará.
	final String GET_RESTRICTED_PATHS_PER_USER_PER_APPLICATION = """
	SELECT T006.id_application, T006.seq_path, T004.tx_path,T004.tx_loweredpath, TOTAL_ROLES_PER_USER.nu_rolesperuser, COUNT(T006.seq_path) nu_rolepathrestricperuser
	  FROM t004_c_path T004
	    INNER JOIN t002_c_application T002 ON T004.id_application = T002.id_application 
	    INNER JOIN t006_t_pathrestric T006 ON T004.id_application = T006.id_application AND T004.seq_path = T006.seq_path 
		INNER JOIN t005_t_userinrole T005 ON T006.id_application = T005.id_application AND T006.seq_role = T005.seq_role
		INNER JOIN (
		  SELECT T002.id_application, T005.id_user, COUNT(T005.id_user) nu_rolesperuser
		    FROM t002_c_application T002
			  INNER JOIN t003_c_role T003 ON T002.id_application = T003.id_application
			  INNER JOIN t005_t_userinrole T005 ON T003.id_application = T005.id_application AND T003.seq_role = T005.seq_role
	        GROUP BY T002.id_application, T005.id_user
		) TOTAL_ROLES_PER_USER ON T005.id_application = TOTAL_ROLES_PER_USER.id_application AND T005.id_user = TOTAL_ROLES_PER_USER.id_user
	  WHERE T005.id_user = :idUser AND T002.tx_uuid = :uuidApplication 
	  GROUP BY T006.id_application, T006.seq_path, T004.tx_path, T004.tx_loweredpath, TOTAL_ROLES_PER_USER.nu_rolesperuser
	  HAVING COUNT(T006.seq_path) = TOTAL_ROLES_PER_USER.nu_rolesperuser;"""
	
    Set<PathTO> getRestrictedPaths(long idUser, String uuidApplication) {
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		
		Set<PathTO> resultSet = new HashSet<PathTO>()
		
		resRows = sql.rows(GET_RESTRICTED_PATHS_PER_USER_PER_APPLICATION,[idUser:idUser, uuidApplication:uuidApplication])
		resRows.each{ x ->
			resultSet.add( this.fromRowToPath(x) )
		}
		
		return resultSet
    }
	
	PathTO fromRowToPath(GroovyRowResult grr){
		PathTO path = new PathTO()
		
		path.idApplication = (Long)grr.get('id_application')
		path.numberPath = (Long)grr.get('seq_path')
		
		path.path = (String)grr.get('tx_path')
		path.pathLowercase = (String)grr.get('tx_loweredpath')
		
		return path
	}
	
}
