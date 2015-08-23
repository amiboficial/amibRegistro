package mx.amib.sistemas.registro.apoderamiento.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO

class RevocacionController {

	def notarioService
	def sepomexService
	
    def index() {
		
		
	}
	
	def create() {
		def vm = RevocacionFormViewModel.getForCreate(sepomexService)
		render( view:'create', model: [viewModelInstance:vm] )
	}
	
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
	
	public static class RevocacionFormViewModel{
		RevocacionTO revocacion
		Collection<EntidadFederativaTO> entidadesFed
		
		public static getForCreate(SepomexService sepomexService){
			RevocacionFormViewModel vm = new RevocacionFormViewModel()
			vm.fillEntidades(sepomexService)
			return vm
		}
		
		private void fillEntidades(SepomexService sepomexService){
			entidadesFed = sepomexService.obtenerEntidadesFederativas()
		}
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
