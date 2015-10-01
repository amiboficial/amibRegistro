package mx.amib.sistemas.registro.apoderamiento.controller

import java.text.SimpleDateFormat
import java.util.Date;
import java.util.List;

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.NotarioService
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.external.expediente.service.SustentanteService
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.revocacion.RevocadoTO
import mx.amib.sistemas.external.oficios.service.ApoderadoService
import mx.amib.sistemas.external.oficios.service.PoderService
import mx.amib.sistemas.external.oficios.service.RevocacionService
import mx.amib.sistemas.registro.apoderamiento.service.ApoderamientoService
import mx.amib.sistemas.utils.SearchResult

import org.codehaus.groovy.grails.web.json.JSONElement


class RevocacionController {

	RevocacionService revocacionService
	ApoderadoService apoderadoService
	NotarioService notarioService
	CertificacionService certificacionService
	DocumentoRepositorioService documentoRepositorioService
	SepomexService sepomexService
	PoderService poderService
	ApoderamientoService apoderamientoService
	SustentanteService sustentanteService
	EntidadFinancieraService entidadFinancieraService
	
	def index() {
		def vm = RevocacionIndexViewModel.getInstance(entidadFinancieraService)
		render( view:'index', model: [viewModelInstance:vm] )
	}
	
	def findAllByNumeroEscritura(){
		Map<String,Object> responseMap = new HashMap<String,Object>()
		SearchResult<RevocadoTO> revServResult
		
		int numeroEscritura = Integer.parseInt(params.'numeroEscritura'?:'-1')
		
		revServResult = revocacionService.findAllByNumeroEscritura(numeroEscritura)
		
		responseMap.put('status','OK')
		responseMap.put('list', RevocacionSearchResultViewModel.getListInstance(revServResult.list, this.notarioService) )
		responseMap.put('count', revServResult.count)
		
		render(responseMap as JSON)
	}
	def findAllByFechaRevocacion(){
		Map<String,Object> responseMap = new HashMap<String,Object>()
		SearchResult<RevocadoTO> revServResult
		
		int max = Integer.parseInt(params.'max'?:'10')
		int offset = Integer.parseInt(params.'offset'?:'0')
		String sort = params.'sort'?:''
		String order = params.'order'?:''
		
		int fechaRevocacionDelDay = Integer.parseInt(params.'fechaRevocacionDel_day'?:'1')
		int fechaRevocacionDelMonth = Integer.parseInt(params.'fechaRevocacionDel_month'?:'1')
		int fechaRevocacionDelYear = Integer.parseInt(params.'fechaRevocacionDel_year'?:'1900')
		int fechaRevocacionAlDay = Integer.parseInt(params.'fechaRevocacionAl_day'?:'31')
		int fechaRevocacionAlMonth = Integer.parseInt(params.'fechaRevocacionAl_month'?:'12')
		int fechaRevocacionAlYear = Integer.parseInt(params.'fechaRevocacionAl_year'?:'2099')
		
		revServResult = revocacionService.findAllByFechaRevocacion(max, offset, sort, order,
														fechaRevocacionDelDay, fechaRevocacionDelMonth, fechaRevocacionDelYear,
														fechaRevocacionAlDay, fechaRevocacionAlMonth, fechaRevocacionAlYear)
		
		responseMap.put('status','OK')
		responseMap.put('list', RevocacionSearchResultViewModel.getListInstance(revServResult.list, notarioService) )
		responseMap.put('count', revServResult.count)
		
		render(responseMap as JSON)
	}
	def findAllByGrupoFinanciero(){
		Map<String,Object> responseMap = new HashMap<String,Object>()
		SearchResult<RevocadoTO> revServResult
		
		int max = Integer.parseInt(params.'max'?:'10')
		int offset = Integer.parseInt(params.'offset'?:'0')
		String sort = params.'sort'?:''
		String order = params.'order'?:''
		
		int idGrupoFinanciero = Integer.parseInt(params.'idGrupoFinanciero'?:'-1')
		
		revServResult = revocacionService.findAllByGrupoFinanciero(max, offset, sort, order, idGrupoFinanciero)
		
		responseMap.put('status','OK')
		responseMap.put('list', RevocacionSearchResultViewModel.getListInstance(revServResult.list, notarioService) )
		responseMap.put('count', revServResult.count)
		
		render(responseMap as JSON)
	}
	def findAllByInstitucion(){
		Map<String,Object> responseMap = new HashMap<String,Object>()
		SearchResult<RevocadoTO> revServResult
		
		int max = Integer.parseInt(params.'max'?:'10')
		int offset = Integer.parseInt(params.'offset'?:'0')
		String sort = params.'sort'?:''
		String order = params.'order'?:''
		
		int idInstitucion = Integer.parseInt(params.'idInstitucion'?:'-1')
		
		revServResult = revocacionService.findAllByInstitucion(max, offset, sort, order, idInstitucion)
		
		responseMap.put('status','OK')
		responseMap.put('list', RevocacionSearchResultViewModel.getListInstance(revServResult.list, notarioService) )
		responseMap.put('count', revServResult.count)
		
		render(responseMap as JSON)
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

		try{
			flash.successMessage = "La revocación con el número de escritura " + revocacion.numeroEscritura + " ha sido dado de alta [ID:" + revocacion.id + "]"
		}
		catch(Exception e){
			flash.errorMessage = "Ha ocurrido un error al dar de alta la revocación"
		}
		
		redirect (action: "index")
	}
	
	def show(Long id) {
		RevocacionShowViewModel rsvm = RevocacionShowViewModel.getInstance(id,
			revocacionService, apoderadoService, certificacionService, documentoRepositorioService,
			notarioService, sepomexService, entidadFinancieraService)
		
		println ('EL MODEL A SACAR ES -> ')
		println (rsvm as JSON)
		
		render( view:'show', model: [vm:rsvm] )
	}
	
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
	
	public static class RevocacionSearchResultViewModel{
		long grailsId
		int numeroEscritura
		long fechaRevocacionUnixEpoch
		String fechaRevocacionDDMMYYYY
		String nombreCompletoNotario
		
		public static RevocacionSearchResultViewModel getInstance(RevocacionTO revocacion, NotarioService notarioService){
			RevocacionSearchResultViewModel vm = new RevocacionSearchResultViewModel()
			
			NotarioTO notario
			SimpleDateFormat df = new SimpleDateFormat("dd MM yyyy")
			
			notario = notarioService.get(revocacion.idNotario)
			
			vm.grailsId = revocacion.id
			vm.numeroEscritura = revocacion.numeroEscritura
			vm.fechaRevocacionUnixEpoch = revocacion.fechaRevocacion.getTime()/1000
			vm.fechaRevocacionDDMMYYYY = df.format(revocacion.fechaRevocacion)
			vm.nombreCompletoNotario = notario.nombreCompleto
			
			return vm
		}
		
		public static List<RevocacionSearchResultViewModel> getListInstance(Collection<RevocacionTO> revocaciones, NotarioService notarioService){
			List<RevocacionSearchResultViewModel> list = new ArrayList<RevocacionSearchResultViewModel>()
			revocaciones.each{ x ->
				list.add( RevocacionSearchResultViewModel.getInstance(x, notarioService) )
			}
			return list
		}
		
	}
	
	public static class RevocacionShowViewModel{
		RevocacionTO revocacion
		List<SustentanteTO> sustentantes
		DocumentoRepositorioTO docRespaldo
		NotarioTO notario
		String nombreEntidadFederativaNotario
		String nombreGrupoFinanciero
		String nombreInstitucion
		
		public static RevocacionShowViewModel getInstance(Long idRevocacion,
			RevocacionService revocacionService, ApoderadoService apoderadoService,
			CertificacionService certificacionService,
			DocumentoRepositorioService documentoRepositorioService,
			NotarioService notarioService, SepomexService sepomexService,
			EntidadFinancieraService entidadFinancieraService){
			
			//Declaración de variables
			RevocacionShowViewModel rsvm = new RevocacionShowViewModel()
			List<ApoderadoTO> apoderados
			List<CertificacionTO> certs
			
			rsvm.revocacion = revocacionService.get(idRevocacion)
			
			rsvm.sustentantes = new ArrayList<SustentanteTO>()
			apoderados = apoderadoService.getAll( new HashSet<Long>(rsvm.revocacion.revocados.collect{ it.idApoderado }) ).apoderados
			certs = certificacionService.getAll( apoderados.collect{ it.idCertificacion } )
			certs.each { x ->
				rsvm.sustentantes.add(x.sustentante)
			}
			
			rsvm.docRespaldo = documentoRepositorioService.obtenerMetadatosDocumento(rsvm.revocacion.uuidDocumentoRespaldo)
			
			rsvm.notario = notarioService.get(rsvm.revocacion.idNotario)
			rsvm.nombreEntidadFederativaNotario = sepomexService.obtenerEntidadFederativa((int)rsvm.notario.idEntidadFederativa.value).nombre
			
			rsvm.nombreGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(rsvm.revocacion.idGrupoFinanciero).nombre
			if(rsvm.revocacion.idInstitucion != null || rsvm.revocacion.idInstitucion != -1 ){
				rsvm.nombreInstitucion = entidadFinancieraService.obtenerInstitucion(rsvm.revocacion.idInstitucion).nombre
			}
			
			return rsvm
		}
	}
	
	public static class RevocacionFormViewModel{
		RevocacionTO revocacion
		Collection<EntidadFederativaTO> entidadesFed
		Collection<GrupoFinancieroTO> gfins
		
		public static RevocacionFormViewModel getInstanceForCreate(SepomexService sepomexService, EntidadFinancieraService entidadFinancieraService){
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
