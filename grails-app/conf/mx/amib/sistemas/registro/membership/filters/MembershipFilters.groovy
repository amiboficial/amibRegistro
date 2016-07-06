package mx.amib.sistemas.registro.membership.filters

import mx.amib.sistemas.registro.membership.service.MembershipService

class MembershipFilters {
	
	def membershipServiceScopedProxy
	
	def filters = {
		restrictPages(controller: '*', uriExclude: '/assets/**'){
			before = {
				if( actionName.equals('consulta') ||  actionName.equals('showless') ){
					//si la accion es consulta entonces no intercepta
				}
				else{
						if(!(actionName.equals('logIn') || actionName.equals('authenticate'))){
							if(!membershipServiceScopedProxy.isAuthenticated()){
								redirect( controller: 'membership', action: 'logIn' )
							}
							else{
								if(membershipServiceScopedProxy.checkIfRestricted( controllerName, actionName )){
									redirect( controller: 'membership', action: 'unauthorized' )
								}
							}
						}
				}
			}
		}
	}
}
