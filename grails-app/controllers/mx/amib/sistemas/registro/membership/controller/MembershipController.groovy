package mx.amib.sistemas.registro.membership.controller

import grails.converters.JSON
import mx.amib.sistemas.external.membership.service.BlockedUserException
import mx.amib.sistemas.external.membership.service.NonApprovedUserException
import mx.amib.sistemas.registro.membership.service.MembershipService

class MembershipController {

	static allowedMethods = [authenticate:'POST']
	static scope = "prototype"
	
	MembershipService membershipService
	
    def logIn() {
		LogInViewModel vm = new LogInViewModel()
		
		vm.userName = ''
		vm.cleanPassword = ''
		vm.errorBlankUserName = false
		vm.errorBlankPassword = false
		vm.errorCredentialsNotFound = false
		vm.errorFetchingData = false
		
		render(view:'logIn', model:[vm:vm])
	}
	
	def authenticate(LogInViewModel vm){
		boolean valid = false
		
		if(vm.validateFields()){
			try{
				if(membershipService.authenticate(vm.userName, vm.cleanPassword)){
					valid = true
				}
				else{
					vm.errorCredentialsNotFound = true
					valid = false
				}
			}
			catch(NonApprovedUserException naue){
				vm.errorNonApproved = true
				valid = false
			}
			catch(BlockedUserException bue){
				vm.errorIsLockedOut = true
				valid = false
			}
		}
		else{
			valid = false
		}
		
		if(valid){
			redirect(url: "/", absolute:false)
		}
		else{
			render(view:'logIn', model:[vm:vm])
		}
	}
	
	def logOut() {
		session.invalidate()
		redirect(action: 'logIn')
	}
	
	def unauthorized(){
		render(view:'unauthorized')
	}
	
	def show() { }
	
	def edit() { }
}

class LogInViewModel{
	String userName
	String cleanPassword
	
	boolean errorBlankUserName
	boolean errorBlankPassword
	boolean errorCredentialsNotFound
	boolean errorFetchingData
	boolean errorNonApproved
	boolean errorIsLockedOut
	
	public boolean validateFields(){
		
		boolean valid = true
		
		errorBlankUserName = false
		errorBlankPassword = false
		errorCredentialsNotFound = false
		errorFetchingData = false
		errorNonApproved = false
		errorIsLockedOut = false
		
		if(this.userName.trim().compareTo('') == 0){
			errorBlankUserName = true
			valid = false
		}
		if(this.cleanPassword.trim().compareTo('') == 0){
			errorBlankUserName = true
			valid = false
		}
		
		return valid
	}
}
