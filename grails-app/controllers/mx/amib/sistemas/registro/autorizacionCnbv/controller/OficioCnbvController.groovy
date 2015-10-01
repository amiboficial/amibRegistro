package mx.amib.sistemas.registro.autorizacionCnbv.controller

import grails.converters.JSON
import java.text.SimpleDateFormat
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.service.SustentanteService
import mx.amib.sistemas.external.oficios.oficioCnbv.AutorizadoCnbvTO
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.registro.expediente.controller.CertificacionDictamenPrevioController;
import mx.amib.sistemas.utils.SearchResult

class OficioCnbvController {

	private static final MAX_SUSTENTANTE_RESULTS = 100
	
	def oficioCnbvService
	def autorizacionCnbvService
	SustentanteService sustentanteService
	def certificacionService
	def documentoRepositorioService
	
	
    def index() { }
	
	def show(long id) {
		OficioCnbvTO ofiServRes
		List<CertificacionTO> certServRes
		DocumentoRepositorioTO docServRes
		ShowVM vm
		
		ofiServRes = oficioCnbvService.get(id)
		certServRes = certificacionService.getAll( ofiServRes.autorizados.collect{ it.idCertificacion } )
		docServRes = documentoRepositorioService.obtenerMetadatosDocumento(ofiServRes.uuidDocumentoRespaldo)
		vm = ShowVM.copyFromServicesResults(ofiServRes, certServRes, docServRes)
		
		println (vm as JSON)
		
		render(view:'show', model: [viewModelInstance:vm])
	}
	
	def create() { }
	
	def save(OficioCnbvTO oficioCnbv){
		def idsCertificacion
		def certsFromIds
		int fechaOficio_day
		int fechaOficio_month
		int fechaOficio_year
		Calendar calFechaOficio
		
		//BINDINGS MANUALES
		idsCertificacion = params.list('autorizadosCnbv.idCertificacion').collect{ Long.parseLong(it) }
		fechaOficio_day = params.int('oficioCnbv.fechaOficio_day')
		fechaOficio_month = params.int('oficioCnbv.fechaOficio_month')
		fechaOficio_year = params.int('oficioCnbv.fechaOficio_year')
		
		calFechaOficio = Calendar.getInstance()
		calFechaOficio.set(Calendar.DAY_OF_MONTH, fechaOficio_day )
		calFechaOficio.set(Calendar.MONTH, fechaOficio_month - 1 )
		calFechaOficio.set(Calendar.YEAR, fechaOficio_year )
		calFechaOficio.set(Calendar.MINUTE, 0 )
		calFechaOficio.set(Calendar.SECOND, 0 )
		calFechaOficio.set(Calendar.MILLISECOND, 0 )
		oficioCnbv.fechaOficio = calFechaOficio.getTime()
		
		certsFromIds = certificacionService.getAll(idsCertificacion)
		oficioCnbv.autorizados = new ArrayList<AutorizadoCnbvTO>()
		certsFromIds.each { x -> 
			def aut = new AutorizadoCnbvTO()
			aut.id = null
			aut.idCertificacion = x.id
			aut.idOficioCnbv = null
			oficioCnbv.autorizados.add(aut)
		}
		
		//try{	
			//Ya teniendo todo bindeado a oficioCnbv
			oficioCnbv = autorizacionCnbvService.altaOficioCnbv(oficioCnbv)
			flash.successMessage = "El oficio con la Clave DGA: " + oficioCnbv.claveDga + " ha sido dado de alta [ID:" + oficioCnbv.id + "]"
		//}
		//catch(Exception e){
		//	flash.errorMessage = "Ha ocurrido un error al dar de alta el oficio de autorización"
		//}
		
		redirect (action: "index")
	}
	
	def findAllByDatosOficio(){ 
		Map<String,Object> res = new HashMap<String,Object>()
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		try{
			def servRes = oficioCnbvService.list(max, offset, sort, order)
			res.put("status", "OK")
			res.put("object", [
				'count': servRes.count, 
				'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
			] )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}	
	def findAllByNumeroOficio(){
		Map<String,Object> res = new HashMap<String,Object>()
		SearchResult<OficioCnbvTO> servRes = null
		
		int numeroOficio = Integer.parseInt(params.'numeroOficio'?:'-1')
		
		if(numeroOficio > -1){
			try{				
				servRes = oficioCnbvService.findAllByNumeroOficio(numeroOficio)
				res.put("status", "OK")
				res.put("object", [
					'count': servRes.count,
					'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
				] )
			}
			catch(Exception ex){
				res = [ 'status': 'ERROR', 'object': ex.message ]
			}
		}
		else{
			res = [ 'status': 'ERROR', 'object': 'DATA_NOT_GIVEN' ]
		}	
		
		render (res as JSON)
	}
	def findAllByClaveDga(){
		Map<String,Object> res = new HashMap<String,Object>()
		SearchResult<OficioCnbvTO> servRes = null
		
		String claveDga = params.'claveDga'?:''
		
		if(claveDga.compareTo("") != 0){
			try{				
				servRes = oficioCnbvService.findAllByClaveDga(claveDga, sustentanteService)
				res.put("status", "OK")
				res.put("object", [
					'count': servRes.count,
					'list' : ResultVM.copyFromServicesResults(servRes.list)
				] )
			}
			catch(Exception ex){
				res = [ 'status': 'ERROR', 'object': ex.message ]
			}
		}
		else{
			res = [ 'status': 'ERROR', 'object': 'DATA_NOT_GIVEN' ]
		}	
		
		render (res as JSON)
	}
	def findAllByFechaOficio(){
		Map<String,Object> res = new HashMap<String,Object>()
		SearchResult<OficioCnbvTO> servRes = null
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		int fechaOficioDel_day = Integer.parseInt(params.'fechaOficioDel_day'?:'1')
		int fechaOficioDel_month = Integer.parseInt(params.'fechaOficioDel_month'?:'1') - 1
		int fechaOficioDel_year = Integer.parseInt(params.'fechaOficioDel_year'?:'1900')
		int fechaOficioAl_day = Integer.parseInt(params.'fechaOficioAl_day'?:'31')
		int fechaOficioAl_month = Integer.parseInt(params.'fechaOficioAl_month'?:'12') - 1
		int fechaOficioAl_year = Integer.parseInt(params.'fechaOficioAl_year'?:'2999')
		
		Calendar cfodel = Calendar.getInstance()
		Calendar cfoal = Calendar.getInstance()
		
		cfodel.set(Calendar.DAY_OF_MONTH,fechaOficioDel_day);
		cfodel.set(Calendar.MONTH,fechaOficioDel_month);
		cfodel.set(Calendar.YEAR,fechaOficioDel_year);
		cfoal.set(Calendar.DAY_OF_MONTH,fechaOficioAl_day);
		cfoal.set(Calendar.MONTH,fechaOficioAl_month);
		cfoal.set(Calendar.YEAR,fechaOficioAl_year);

		try{				
			servRes = oficioCnbvService.findAllByFechaOficio(max, offset, sort, order, cfodel.getTime(), cfoal.getTime())
			res.put("status", "OK")
			res.put("object", [
				'count': servRes.count,
				'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
			] )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}

		render (res as JSON)
	}
	def findAllByNumeroMatricula(){ 
		Map<String,Object> res = new HashMap<String,Object>()
		SustentanteTO sustRes = null
		SearchResult<OficioCnbvTO> servRes = null
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		int numeroMatricula = Integer.parseInt(params.'numeroMatricula'?:'-1')
		
		if(numeroMatricula > -1){
			try{
				sustRes = sustentanteService.obtenerPorMatricula(numeroMatricula)
				
				println (sustRes as JSON)
				
				if(sustRes != null){
					servRes = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, sustRes.certificaciones.collect{ it.id } )
					res.put("status", "OK")
					res.put("object", [
						'count': servRes.count,
						'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
					] )
				}
				else{
					res = [ 'status': 'ERROR', 'object': 'ID_SUST_NOT_FOUND' ]
				}
			}
			catch(Exception ex){
				res = [ 'status': 'ERROR', 'object': ex.message ]
			}
		}
		else{
			res = [ 'status': 'ERROR', 'object': 'ID_NOT_GIVEN' ]
		}	
		
		render (res as JSON)
	}
	def findAllByIdSustentante(){ 
		Map<String,Object> res = new HashMap<String,Object>()
		SustentanteTO sustRes = null
		SearchResult<OficioCnbvTO> servRes = null
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		long idSustentante = Long.parseLong(params.'idSustentante'?:'-1')
		
		if(idSustentante > -1){
			try{
				sustRes = sustentanteService.get(idSustentante)
				if(sustRes != null){
					servRes = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, sustRes.certificaciones.collect{ it.id } )
					res.put("status", "OK")
					res.put("object", [
						'count': servRes.count,
						'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
					] )
				}
				else{
					res = [ 'status': 'ERROR', 'object': 'ID_SUST_NOT_FOUND' ]
				}
			}
			catch(Exception ex){
				res = [ 'status': 'ERROR', 'object': ex.message ]
			}
		}
		else{
			res = [ 'status': 'ERROR', 'object': 'ID_NOT_GIVEN' ]
		}	
		
		render (res as JSON)
	}
	def findAllByNombreApellidos(){ 
		Map<String,Object> res = new HashMap<String,Object>()
		def multSustRes = null
		SearchResult<OficioCnbvTO> servRes = null
		Set<Long> idsCertificacion = new HashSet<Long>()
		
		int max = Integer.parseInt(params.max?:'10')
		int offset = Integer.parseInt(params.offset?:'0')
		String sort = params.sort?:'id'
		String order = params.order?:'asc'
		
		String nom = params.nombre?:''
		String ap1 = params.primerApellido?:''
		String ap2 = params.segundoApellido?:''
		
		if(nom != '' || ap1 != '' || ap2 != ''){
			try{
				multSustRes = sustentanteService.findAllAdvancedSearch(nom,ap1,ap2,MAX_SUSTENTANTE_RESULTS,0,'id','asc')
				if(multSustRes != null && multSustRes.count > 0){
					
					if( multSustRes.count > MAX_SUSTENTANTE_RESULTS ){
						res = [ 'status': 'ERROR', 'object': 'MAX_SUSTENTANTE_RESULTS' ]
					}
					else{
						def nestedResult = multSustRes.list.collect{ it.certificaciones.collect{ it.id } }.findAll()
						nestedResult.each { x ->
							x.each{ y ->
								idsCertificacion.add(y)
							}
						}
						servRes = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, idsCertificacion )
						res.put("status", "OK")
						res.put("object", [
							'count': servRes.count,
							'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
						] )
					}
					
				}
				else{
					res = [ 'status': 'ERROR', 'object': 'ID_SUST_NOT_FOUND' ]
				}
			}
			catch(Exception ex){
				res = [ 'status': 'ERROR', 'object': ex.message ]
			}
		}
		else{
			res = [ 'status': 'ERROR', 'object': 'NAMES_NOT_GIVEN' ]
		}	
		
		render (res as JSON)
	}
	def findAll(){ 
		Map<String,Object> res = new HashMap<String,Object>()
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		try{
			def servRes = oficioCnbvService.list(max, offset, sort, order)
			res.put("status", "OK")
			res.put("object", [
				'count': servRes.count, 
				'list' : ResultVM.copyFromServicesResults(servRes.list, sustentanteService)
			] )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def checkUniqueClaveDga(String id){
		Map<String,Object> res = new HashMap<String,Object>()
		String claveDga = id
		def servRes
		
		try{
			servRes = oficioCnbvService.checkUniqueClaveDga(claveDga)
			res.put("status", "OK")
			res.put("object", servRes )
			
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	def checkUniqueNumeroOficio(Integer id){
		Map<String,Object> res = new HashMap<String,Object>()
		int numeroOficio = id
		def servRes
		
		try{
			servRes = oficioCnbvService.checkUniqueNumeroOficio(numeroOficio)
			res.put("status", "OK")
			res.put("object", servRes )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	def findAutorizableByNumeroMatricula(Integer id){
		Map<String,Object> res = new HashMap<String,Object>()
		int numeroMatricula = id
		def servRes
		
		try{
			servRes = certificacionService.findAllEnAutorizacionByMatricula(numeroMatricula)
			if( servRes.count > 0 ){
				res.put("status", "OK")
				res.put("object", AutorizableResultVM.copyFromServicesResults( servRes.list.first() ) )
			}
			else{
				res.put("status", "ERROR")
				res.put("object", "NOT_FOUND")
			}
		}
		catch(Exception e){
			res.put("status", "ERROR")
			res.put("object", e.message)
		}
		
		render (res as JSON)
	}
	
	public static class ResultVM{
		long id
		int numeroOficio
		String claveDga
		String fechaOficio
		String autorizados
		
		public static List<ResultVM> copyFromServicesResults(Collection<OficioCnbvTO> resOficios, SustentanteService sustentanteService){
			List<ResultVM> res = new ArrayList<ResultVM>()
			Collection<SustentanteTO> sustAutorizados
			SimpleDateFormat spdf = new SimpleDateFormat('dd-MM-yyyy')
			
			Iterator<OficioCnbvTO> iterator = resOficios.iterator()
			while(iterator.hasNext()){
				OficioCnbvTO x = iterator.next()
				ResultVM resItem = new ResultVM()
				
				resItem.id = x.id
				resItem.numeroOficio = x.numeroOficio
				resItem.claveDga = x.claveDga
				resItem.fechaOficio = spdf.format(x.fechaOficio)
				
				resItem.autorizados = ''
				sustAutorizados = sustentanteService.findAllByIdCertificacionIn( x.autorizados.collect{ it.idCertificacion } ).sort{ it.nombre }
				sustAutorizados.each { y ->
					resItem.autorizados += y.nombre + ' ' + y.primerApellido + ' ' + (y.segundoApellido?:'') + '<br/>'
				}
				
				res.add(resItem)
			}
			
			return res
		}
	}
	
	public static class AutorizableResultVM{
		long idCertificacion
		long idSustentante
		String nombreCompleto
		String nombre
		String primerApellido
		String segundoApellido
		String dsFigura
		String dsVarianteFigura
		String dsTipoAutorizacion
		
		public static AutorizableResultVM copyFromServicesResults(CertificacionTO resCert){
			AutorizableResultVM res = new AutorizableResultVM()
			
			res.idCertificacion = resCert.id
			res.idSustentante = resCert.sustentante.id
			res.nombre = resCert.sustentante.nombre
			res.primerApellido = resCert.sustentante.primerApellido
			res.segundoApellido = resCert.sustentante.segundoApellido
			res.nombreCompleto = res.nombre + ' ' + res.primerApellido + ' ' + res.segundoApellido
			res.dsFigura = resCert.varianteFigura.nombreFigura
			res.dsVarianteFigura = resCert.varianteFigura.nombre
			res.dsTipoAutorizacion = resCert.varianteFigura.tipoAutorizacionFigura
			
			return res
		}
		
	}
	
	public static class ShowVM{
		OficioCnbvTO oficioCnbv
		List<CertificacionTO> certAutList
		DocumentoRepositorioTO documentoRespaldo
		
		public static ShowVM copyFromServicesResults(OficioCnbvTO oficioCnbv, List<CertificacionTO> certAutList, DocumentoRepositorioTO documentoRespaldo){
			ShowVM vm = new ShowVM()
			vm.setOficioCnbv(oficioCnbv)
			vm.setCertAutList(certAutList)
			vm.setDocumentoRespaldo(documentoRespaldo)
			
			return vm
		}
	}
}
