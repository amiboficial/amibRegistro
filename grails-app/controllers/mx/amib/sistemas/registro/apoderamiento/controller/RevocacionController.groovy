package mx.amib.sistemas.registro.apoderamiento.controller

import java.util.Date;
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
import mx.amib.sistemas.external.oficios.revocacion.RevocadoTO
import mx.amib.sistemas.external.oficios.service.PoderService
import org.codehaus.groovy.grails.web.json.JSONElement


class RevocacionController {

	def revocacionService
	def apoderadoService
	def notarioService
	def sepomexService
	def poderService
	def apoderamientoService
	def sustentanteService
	def entidadFinancieraService
	
    def index() {
		def vm = RevocacionIndexViewModel.getInstance(entidadFinancieraService)
		render( view:'index', model: [viewModelInstance:vm] )
	}
	
	def create() {
		def vm = RevocacionFormViewModel.getInstanceForCreate(sepomexService, entidadFinancieraService)
		render( view:'create', model: [viewModelInstance:vm] )
	}
	
	def save(RevocacionTO revocacion) {
		//variable de calendar a usar
		Calendar cFechaRevocacion = Calendar.getInstance()
		//obtiene parametros
		def pApoderadosARevocar = params.list('revocados.apoderado') //recibe una lista de Strings con formato JSON por objeto
		def pFechaRevocacionDay = params.int('revocacion.fechaRevocacion_day')
		def pFechaRevocacionMonth = params.int('revocacion.fechaRevocacion_month')
		def pFechaRevocacionYear = params.int('revocacion.fechaRevocacion_year')		
		//idsApoderadoARevocar = pIdsApoderadosARevocar.collect{ Long.parseLong(it) }
		//idsCertificacionARevocar = apoderadoService.getAll( new HashSet<Long>(idsApoderadoARevocar) ).apoderados.collect{ it.idCertificacion } //igual y eso se mueve al service
		
		//bindea "restantes"
		cFechaRevocacion.set(pFechaRevocacionYear, pFechaRevocacionMonth - 1, pFechaRevocacionDay,0,0,0)
		revocacion.fechaRevocacion = cFechaRevocacion.getTime()
		revocacion.revocados = new ArrayList<RevocadoTO>()
		pApoderadosARevocar.each { x ->
			JSONElement jx = JSON.parse(x)
			RevocadoTO rev = new RevocadoTO()
			Calendar cFechaBaja = Calendar.getInstance()
			
			rev.id = null
			rev.idRevocacion = null
			rev.idApoderado = Long.parseLong(jx.'idApoderado')
			rev.motivo = jx.'motivo'
			cFechaBaja.set(Integer.parseInt(jx.'fechaBaja_year'), Integer.parseInt(jx.'fechaBaja_month') - 1, Integer.parseInt(jx.'fechaBaja_day'),0,0,0)
			rev.fechaBaja = cFechaBaja.getTime()
			
			revocacion.revocados.add(rev)
		}
		
		revocacion = apoderamientoService.altaRevocacion(revocacion)
		
		render (revocacion as JSON)
	}
	
	def show() { }
	
	def isNumeroEscrituraAvailable(){
		int numeroEscritura = -1
		boolean resultado
		def responseObj = null
		
		try{
			numeroEscritura = Integer.parseInt(params.'numeroEscritura'?:"-1")
			resultado = revocacionService.isNumeroEscrituraAvailable(numeroEscritura)
			if(resultado == true){
				responseObj = [ 'status': 'OK', 'object': [ 'isNumeroEscrituraAvailable': true ] ]
			}
			else{
				responseObj = [ 'status': 'OK', 'object': [ 'isNumeroEscrituraAvailable': false ] ]
			}
		}
		catch(Exception ex) {
			responseObj = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render responseObj as JSON
	}
	
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
	
	public static class RevocacionIndexViewModel{
		Collection<GrupoFinancieroTO> gfins
		
		public static getInstance(EntidadFinancieraService entidadFinancieraService){
			RevocacionFormViewModel vm = new RevocacionFormViewModel()
			vm.fillEntidadesFinancieras(entidadFinancieraService)
			return vm
		}
		
		private void fillEntidadesFinancieras(EntidadFinancieraService entidadFinancieraService){
			gfins = entidadFinancieraService.obtenerGruposFinancierosVigentes().sort{ it.nombre }
		}
	}
	
	public static class RevocacionFormViewModel{
		RevocacionTO revocacion
		Collection<EntidadFederativaTO> entidadesFed
		Collection<GrupoFinancieroTO> gfins
		
		public static getInstanceForCreate(SepomexService sepomexService, EntidadFinancieraService entidadFinancieraService){
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
