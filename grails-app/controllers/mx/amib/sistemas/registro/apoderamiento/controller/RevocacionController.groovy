package mx.amib.sistemas.registro.apoderamiento.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.NotarioTO

class RevocacionController {

	def notarioService
	
    def index() { }
	
	def create() { }
	
	def show() { }
	
	
	def findNotarioByNumeroNotariaAndIdEntidadFederativa(){
		int numeroNotaria = params.int('numeroNotaria')
		long idEntidadFederativa = params.long('idEntidadFederativa')
		
		List<NotarioResult> resObj = null
		Map<String,Object> res = new HashMap<String,Object>()
		
		resObj = NotarioResult.copyFromServicesResults( notarioService.findAllBy(100, 0, "id", "asc", idEntidadFederativa, numeroNotaria, "").list )
		
		res.put('status', 'OK')
		res.put('object', resObj )
		
		render(res as JSON)
	}
	
	static class NotarioResult{
		long id
		String text
		
		public static List<NotarioResult> copyFromServicesResults(List<NotarioTO> notarios){
			List<NotarioResult> lres = new ArrayList<NotarioResult>()
			
			lres.add( (new NotarioResult()).setViewNullValues() )
			notarios.each { x ->
				NotarioResult nr = new NotarioResult()
				nr.id = x.id
				nr.text = x.nombreCompleto
				lres.add(nr)
			}
			
			return lres
		}
		
		public NotarioResult setViewNullValues(){
			this.id = -1
			this.text = '-Seleccione-'
			return this
		}
	}
}
