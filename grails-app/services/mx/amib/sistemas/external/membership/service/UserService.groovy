package mx.amib.sistemas.external.membership.service

import java.util.Date
import java.util.UUID
import java.security.MessageDigest
import grails.transaction.Transactional
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import mx.amib.sistemas.external.membership.UserTO

@Transactional
class UserService {

	def dataSource_membership
	static datasource = 'membership'
	
	final int MAX_ATTEMPTS = 10
	final String PASSWORD_FORMAT = 'MD5'
	
	final String getByIdSql = """SELECT [id_user],[tx_uuid],[tx_username],[tx_loweredusername],[fh_lastactivitydate]
								      ,[tx_password],[tx_pwdformat],[tx_pwdsalt],[tx_email],[tx_loweredemail]
								      ,[tx_pwdquestion],[tx_pwdanswer],[st_isapproved],[fh_lastlogindate]
								      ,[fh_lastpwdchangedate],[st_islockedout],[fh_lastlockedoutdate]
									  ,[nu_failedattempts],[nu_failedanswerattempts],[tx_comment],[fh_createdate]
								  FROM [dbo].[t001_t_user]
								  WHERE [id_user] = :id;"""
	
	final String getByUuidSql = """SELECT [id_user],[tx_uuid],[tx_username],[tx_loweredusername],[fh_lastactivitydate]
								      ,[tx_password],[tx_pwdformat],[tx_pwdsalt],[tx_email],[tx_loweredemail]
								      ,[tx_pwdquestion],[tx_pwdanswer],[st_isapproved],[fh_lastlogindate]
								      ,[fh_lastpwdchangedate],[st_islockedout],[fh_lastlockedoutdate]
									  ,[nu_failedattempts],[nu_failedanswerattempts],[tx_comment],[fh_createdate]
								  FROM [dbo].[t001_t_user]
								  WHERE [tx_uuid] = :uuid;""" 
	
	final String findByUserNameSql = """SELECT [id_user],[tx_uuid],[tx_username],[tx_loweredusername],[fh_lastactivitydate]
										      ,[tx_password],[tx_pwdformat],[tx_pwdsalt],[tx_email],[tx_loweredemail]
										      ,[tx_pwdquestion],[tx_pwdanswer],[st_isapproved],[fh_lastlogindate]
										      ,[fh_lastpwdchangedate],[st_islockedout],[fh_lastlockedoutdate]
											  ,[nu_failedattempts],[nu_failedanswerattempts],[tx_comment],[fh_createdate]
										  FROM [dbo].[t001_t_user]
										  WHERE [tx_username] = :userName;""" 
							
	final String saveSql = """INSERT INTO t001_t_user(tx_uuid, tx_username, tx_loweredusername, fh_lastactivitydate, 
													tx_password, tx_pwdformat, tx_pwdsalt, tx_email, tx_loweredemail, 
													tx_pwdquestion, tx_pwdanswer, st_isapproved, 
													fh_lastpwdchangedate, st_islockedout, 
													nu_failedattempts, nu_failedanswerattempts, tx_comment, fh_createdate) 
							VALUES (:uuid, :userName, :userNameLowercase, :lastActivity, 
									:password, :passwordFormat, :passwordSalt, :email, :emailLowercase, 
									:passwordQuestion, :passwordAnswer, :isApproved, 
									:lastPasswordChange, :isLockedOut, 
									:failedAttempts, :failedAnswerAttempts, :comment, :createdDate);"""
						
	final String validateUserNameAndPasswordAndApplicationSql = """
		SELECT T001.id_user,tx_password,tx_pwdformat,tx_pwdsalt,T002.tx_uuid,st_isapproved,st_islockedout 
		  FROM t001_t_user T001 
		  INNER JOIN t005_t_userinrole T005 ON T001.id_user = T005.id_user 
		  INNER JOIN t002_c_application T002 ON T005.id_application = T002.id_application 
		  WHERE T001.tx_username = :userName AND T002.tx_uuid = :uuidApp;"""
	
	final String updateNotifyFailedValidationSql = """
		UPDATE t001_t_user
		SET 
		  nu_failedattempts=:failedAttempts,
		  fh_lastactivitydate=:lastActivity,
		  st_islockedout=:isLockedOut,
		  fh_lastlockedoutdate=:lastLockedOut
		WHERE
		  id_user=:id;"""
		  	
	final String updateNotifySuccessfulValidationSql = """
		UPDATE t001_t_user
		SET 
		  nu_failedattempts=:failedAttempts,
		  fh_lastlogindate=:lastLogin,
		  fh_lastactivitydate=:lastActivity
		WHERE
		  id_user=:id;"""
		  
	long save(UserTO user) {
		
		Sql sql = new Sql(dataSource_membership)
		def sqlParams = null
		def keys = null
		long savedId = 0
		
		//setea datos por defecto
		user.userNameLowercase = user.userName.toLowerCase()
		user.lastActivity = new Date()
		user.emailLowercase = user.email.toLowerCase()
		user.lastPasswordChange = new Date()
		user.isApproved = true
		user.isLockedOut = false
		user.failedAttempts = 0
		user.failedAnswerAttempts = 0
		user.createdDate = new Date()
		//setea un uuid
		user.uuid = UUID.randomUUID().toString()
		//setea el uuid asignado en reversa y sin guiones como salt
		user.passwordSalt = user.uuid.replace('-', '').reverse()
		//setea el campo password "encriptado"
		user.password = MessageDigest.getInstance(this.PASSWORD_FORMAT).digest( (user.passwordSalt + user.password).bytes ).encodeHex().toString()
		
		sqlParams = [ uuid:user.uuid, userName:user.userName, userNameLowercase:user.userNameLowercase, lastActivity:user.lastActivity.toTimestamp(), 
						password:user.password, passwordFormat:this.PASSWORD_FORMAT, passwordSalt:user.passwordSalt, email:user.email, emailLowercase:user.emailLowercase, 
						passwordQuestion:user.passwordQuestion, passwordAnswer:user.passwordAnswer, isApproved:user.isApproved,
						lastPasswordChange:user.lastPasswordChange.toTimestamp(), isLockedOut:user.isLockedOut, failedAttempts:user.failedAttempts, 
						failedAnswerAttempts:user.failedAnswerAttempts, comment:user.comment, createdDate:user.createdDate.toTimestamp()]
		
		keys = sql.executeInsert(this.saveSql,sqlParams)
		savedId = keys[0][0]
		
		return savedId
    }
	
	UserTO get(long id){
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		UserTO userResult = new UserTO()
		
		resRows = sql.rows(getByIdSql,[id:id])
		if(resRows.size() > 0){
			userResult = this.fromRowToUser(resRows.get(0))
		}
		
		return userResult
	}
	
	UserTO get(String uuid){
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		UserTO userResult = new UserTO()
		
		resRows = sql.rows(getByUuidSql,[uuid:uuid])
		if(resRows.size() > 0){
			userResult = this.fromRowToUser(resRows.get(0))
		}
		
		return userResult
	}
	
	UserTO findByUserName(String userName){
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		UserTO userResult = new UserTO()
		
		resRows = sql.rows(findByUserNameSql,[userName:userName])
		if(resRows.size() > 0){
			userResult = this.fromRowToUser(resRows.get(0))
		}
		
		return userResult
	}
	
	boolean validateUserNameAndPassword( String userName, String password )
		throws NonApprovedUserException, BlockedUserException{
			
		UserTO usuario = new UserTO()
		boolean res = false
		String hashedSaltedPwd
		
		usuario = this.findByUserName(userName)
		if(usuario.id > 0){
			hashedSaltedPwd = usuario.passwordSalt + password
			hashedSaltedPwd = MessageDigest.getInstance(usuario.passwordFormat).digest( hashedSaltedPwd.bytes ).encodeHex().toString()
			
			if( usuario.isLockedOut ){
				throw new BlockedUserException()
			}
			if( usuario.password.compareTo(hashedSaltedPwd) == 0 ){
				if( !usuario.isApproved ){
					throw new NonApprovedUserException()
				}
				res = true
				this.updateNotifySuccessfulValidation(usuario.id)
			}
			else{
				this.updateNotifyFailedValidation(usuario.id)
			}
		}
		
		return res
	}
	
	boolean validateUserNameAndPasswordAndApplication( String userName, String password, String uuidApp )
		throws NonApprovedUserException, BlockedUserException{
		
		Sql sql = new Sql(dataSource_membership)
		List<GroovyRowResult> resRows = null
		
		long idUserResult
		String hashedPwdResult
		String pwdFormatResult
		String pwdSaltResult
		String uuidAppResult
		boolean isApprovedResult
		boolean isLockedOutResult
		
		String hashedSaltedPwd
		boolean res = false
		
		resRows = sql.rows(validateUserNameAndPasswordAndApplicationSql,[userName:userName,uuidApp:uuidApp])
		if(resRows.size() > 0){
			idUserResult = (Long)resRows.get(0).get('id_user')
			hashedPwdResult = (String)resRows.get(0).get('tx_password')
			pwdFormatResult= (String)resRows.get(0).get('tx_pwdformat')
			pwdSaltResult = (String)resRows.get(0).get('tx_pwdsalt')
			uuidAppResult = (String)resRows.get(0).get('tx_uuid')
			isApprovedResult = (Boolean)resRows.get(0).get('st_isapproved')
			isLockedOutResult = (Boolean)resRows.get(0).get('st_islockedout')
			
			hashedSaltedPwd = pwdSaltResult + password
			hashedSaltedPwd = MessageDigest.getInstance(pwdFormatResult).digest( hashedSaltedPwd.bytes ).encodeHex().toString()
			
			if( isLockedOutResult ){
				throw new BlockedUserException()
			}
			if( hashedPwdResult.compareTo(hashedSaltedPwd) == 0 && uuidAppResult.compareTo(uuidApp) == 0 ){
				if( !isApprovedResult ){
					throw new NonApprovedUserException()
				}
				res = true
				this.updateNotifySuccessfulValidation(idUserResult)
			}
			else{
				this.updateNotifyFailedValidation(idUserResult)
			}
		}
		
		return res
	}
	
	void updateNotifyFailedValidation( long idUser ){
		
		Sql sql = new Sql(dataSource_membership)
		def sqlParams = null
		def keys = null
		long savedId = 0
		
		UserTO user = new UserTO()
		
		user = this.get(idUser)
		if(user.id > 0){
			user.failedAttempts++
			user.lastActivity = new Date()
			if(user.failedAttempts >= MAX_ATTEMPTS){
				user.isLockedOut = true
				user.lastLockedOut = new Date()
			}
			sql.executeUpdate(updateNotifyFailedValidationSql, [ id:user.id, failedAttempts:user.failedAttempts, 
				lastActivity:user.lastActivity.toTimestamp(), isLockedOut:user.isLockedOut, lastLockedOut:user.lastLockedOut?.toTimestamp() ])
		}
		
	}
	
	void updateNotifySuccessfulValidation( long idUser ){
		
		Sql sql = new Sql(dataSource_membership)
		def sqlParams = null
		def keys = null
		long savedId = 0
		
		UserTO user = new UserTO()
		
		user = this.get(idUser)
		if(user.id > 0){
			user.failedAttempts = 0
			user.lastActivity = new Date()
			user.lastLogin = new Date()
			sql.executeUpdate(updateNotifySuccessfulValidationSql, [ id:user.id, failedAttempts:user.failedAttempts, 
				lastActivity:user.lastActivity.toTimestamp(), lastLogin:user.lastLogin.toTimestamp() ])
		}
		
	}
	
	UserTO fromRowToUser(GroovyRowResult grr){
		UserTO user = new UserTO()
		user.id = (Long)grr.get('id_user')
		user.uuid = (String)grr.get('tx_uuid')
		
		user.userName = (String)grr.get('tx_username')
		user.userNameLowercase = (String)grr.get('tx_loweredusername')
		user.lastActivity = (Date)grr.get('fh_lastactivitydate')
		user.password = (String)grr.get('tx_password')
		user.passwordFormat = (String)grr.get('tx_pwdformat')
		user.passwordSalt = (String)grr.get('tx_pwdsalt')
		
		user.email = (String)grr.get('tx_email')
		user.emailLowercase = (String)grr.get('tx_loweredemail')
		
		user.passwordQuestion = (String)grr.get('tx_pwdquestion')
		user.passwordAnswer = (String)grr.get('tx_pwdanswer')
		
		user.isApproved = (Boolean)grr.get('st_isapproved')
		user.lastLogin = (Date)grr.get('fh_lastlogindate')
		user.lastPasswordChange = (Date)grr.get('fh_lastpwdchangedate')
		
		user.isLockedOut = (Boolean)grr.get('st_islockedout')
		user.lastLockedOut = (Date)grr.get('fh_lastlockedoutdate')
		
		user.failedAttempts = (Integer)grr.get('nu_failedattempts')
		user.failedAnswerAttempts = (Integer)grr.get('nu_failedanswerattempts')
		
		user.comment = (String)grr.get('tx_comment')
		
		user.createdDate = (Date)grr.get('fh_createdate')
		
		return user
	}
}

class NonApprovedUserException extends Exception{

}

class BlockedUserException extends Exception{
	
}
