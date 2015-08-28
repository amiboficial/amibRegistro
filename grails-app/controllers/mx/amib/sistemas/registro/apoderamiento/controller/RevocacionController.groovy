package mx.amib.sistemas.registro.apoderamiento.controller

import java.util.List;

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.service.PoderService


class RevocacionController {

	def notarioService
	def sepomexService
	def poderService
	def apoderamientoService
	def sustentanteService
	def entidadFinancieraService
	
    def index() {
		
		
	}
	
	def create() {
		def vm = RevocacionFormViewModel.getForCreate(sepomexService, entidadFinancieraService)
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
	
	def findByNumeroMatricula(){
		int numeroMatricula = -1
		Map<String,Object> resultado = new HashMap<String,Object>()
		Map<String,Object> respuesta = new HashMap<String,Object>()
		
		List<Map<String,String>> listadoApoderamientos = new ArrayList<Map<String,String>>()
		Map<String,String> apoEncontrado = new HashMap<String,String>()
		
		PoderTO poderCurInstance
		List<ApoderadoTO> apoderados
		SustentanteTO sustentante
		
		numeroMatricula = params.int('numeroMatricula')
		
		sustentante = sustentanteService.findByMatricula(numeroMatricula)
		
		if(sustentante != null){
			apoderados = apoderamientoService.obtenerApoderamientosRevocables(numeroMatricula)
			
			apoEncontrado.put('id', '-1')
			apoEncontrado.put('text', '-Seleccione-')
			listadoApoderamientos.add(apoEncontrado)
			apoderados.each{ x ->
				poderCurInstance = poderService.get(x.idPoder)
				apoEncontrado = new HashMap<String,String>()
				apoEncontrado.put('id', x.id.toString())
				apoEncontrado.put('text', 'Numero de escritura: ' + poderCurInstance.numeroEscritura)
				listadoApoderamientos.add(apoEncontrado)
			}
			
			resultado = [
				idSustentante: sustentante.id,
				nombreCompleto: sustentante.nombre + ' ' + sustentante.primerApellido + ' ' + sustentante.segundoApellido,
				nombre: sustentante.nombre,
				primerApellido: sustentante.primerApellido,
				segundoApellido: sustentante.segundoApellido,
				idApoderado: -1,
				apoderamientosEncontrados: listadoApoderamientos
			]
			
			respuesta = [ 'status' : 'OK' , 'object' : resultado ]
		}
		else{
			respuesta = [ 'status' : 'ERROR' , 'object' : 'SUSTENTANTE_NOT_FOUND' ]
		}
		
		render(respuesta as JSON)
	}
	
	public static class RevocacionFormViewModel{
		RevocacionTO revocacion
		Collection<EntidadFederativaTO> entidadesFed
		Collection<GrupoFinancieroTO> gfins
		
		public static getForCreate(SepomexService sepomexService, EntidadFinancieraService entidadFinancieraService){
			RevocacionFormViewModel vm = new RevocacionFormViewModel()
			vm.fillEntidades(sepomexService)
			vm.fillEntidadesFinancieras(entidadFinancieraService)
			return vm
		}
		
		private void fillEntidades(SepomexService sepomexService){
			entidadesFed = sepomexService.obtenerEntidadesFederativas()
		}
		
		private void fillEntidadesFinancieras(EntidadFinancieraService entidadFinancieraService){
			gfins = entidadFinancieraService.obtenerGruposFinancierosVigentes().sort{ it.nombre }
		}
	}
	
	public static class NotarioResult{
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
