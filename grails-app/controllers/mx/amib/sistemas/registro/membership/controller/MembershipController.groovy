package mx.amib.sistemas.registro.membership.controller

import grails.converters.JSON

class MembershipController {

	String applicationGuid = '30873f55-c21f-4589-aa66-883f3563ab34' 
	def userService
	
	
    def logIn() {
		LogInViewModel vm = new LogInViewModel()
		
		vm.userName = ''
		vm.cleanPassword = ''
		vm.errorBlankUserName = false
		vm.errorBlankPassword = false
		vm.errorCredentialsNotFound = false
		vm.errorFetchingData = false
		
		render('logIn', model:[vm:vm])
	}
	
	def validateUserNameAndPassword(LogInViewModel vm){
		Map<String,Object> responseMap = new HashMap<>()
		boolean valid = false
		
		if(vm.validateFields()){
			if(userService.validateUserNameAndPasswordAndApplication(vm.userName, vm.cleanPassword, applicationGuid)){
				responseMap.put('status', 'OK')
				responseMap.put('valid', true)
				responseMap.put('vm', vm)
			}
			else{
				vm.errorCredentialsNotFound = true
				
				responseMap.put('status', 'ERROR')
				responseMap.put('valid', false)
				responseMap.put('vm', vm)
			}
		}
		else{
			responseMap.put('status', 'ERROR')
			responseMap.put('valid', false)
			responseMap.put('vm', vm)
		}
		
		render (responseMap as JSON)
	}
	
	def authenticate(){
		
	}
	
	class LogInViewModel{
		String userName
		String cleanPassword
		
		boolean errorBlankUserName
		boolean errorBlankPassword
		boolean errorCredentialsNotFound
		boolean errorFetchingData
		
		public void validateFields(){
			
			errorBlankUserName = false
			errorBlankPassword = false
			errorCredentialsNotFound = false
			errorFetchingData = false
			
			if(this.userName.trim().compareTo('') == 0){
				errorBlankUserName = true
			}
			if(this.cleanPassword.trim().compareTo('') == 0){
				errorBlankUserName = true
			}
			
		}
	}
	
	def logOut() { }
	
	def show() { }
	
	def edit() { }
}
