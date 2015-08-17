package mx.amib.sistemas.registro.autorizacionCnbv.controller

import grails.converters.JSON
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.utils.SearchResult

class OficioCnbvController {

	private static final MAX_SUSTENTANTE_RESULTS = 100
	
	def oficioCnbvService
	def sustentanteService
	
    def index() { }
	
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
				'list' : ResultVM.copyFromServicesResults(servRes.list)
			] )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def findAllByNumeroOficio(){
		Map<String,Object> res = new HashMap<String,Object>()
		
		
		
		render (res as JSON)
	}
	
	def findAllByClaveDga(){
		Map<String,Object> res = new HashMap<String,Object>()
		render (res as JSON)
	}
	
	def findAllByFechaOficio(){
		Map<String,Object> res = new HashMap<String,Object>()
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
						'list' : ResultVM.copyFromServicesResults(servRes.list)
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
						'list' : ResultVM.copyFromServicesResults(servRes.list)
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
		
		String nom = params.nom?:''
		String ap1 = params.ap1?:''
		String ap2 = params.ap2?:''
		
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
							'list' : ResultVM.copyFromServicesResults(servRes.list)
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
				'list' : ResultVM.copyFromServicesResults(servRes.list)
			] )
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	public static class ResultVM{
		long id
		int numeroOficio
		String claveDga
		String fechaOficio
		
		public static List<ResultVM> copyFromServicesResults(Collection<OficioCnbvTO> resOficios){
			List<ResultVM> res = new ArrayList<ResultVM>()
			
			Iterator<OficioCnbvTO> iterator = resOficios.iterator()
			while(iterator.hasNext()){
				OficioCnbvTO x = iterator.next()
				ResultVM resItem = new ResultVM()
				resItem.id = x.id
				resItem.numeroOficio = x.numeroOficio
				resItem.claveDga = x.claveDga
				resItem.fechaOficio = x.fechaOficio.toString()
				
				res.add(resItem)
			}
			
			return res
		}
	}
}
