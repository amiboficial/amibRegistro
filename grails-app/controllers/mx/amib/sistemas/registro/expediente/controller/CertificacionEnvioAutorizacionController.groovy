package mx.amib.sistemas.registro.expediente.controller

import java.util.Collection;

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.FiguraService
import mx.amib.sistemas.external.catalogos.service.FiguraTO;
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.registro.expediente.service.LoteEnvioAutorizacionService

class CertificacionEnvioAutorizacionController {

	FiguraService figuraService
	CertificacionService certificacionService
	LoteEnvioAutorizacionService loteEnvioAutorizacionService
	
    def index() { 
		IndexViewModel ivm = this.getIndexViewModel()
		render(view: "index", model: [ viewModelInstance : ivm ])
	}
		
	private IndexViewModel getIndexViewModel(){
		IndexViewModel ivm = new IndexViewModel()
		ivm.figuraList = figuraService.list().sort{ it.nombre }
		return ivm
	}
	
	def indexOld(){
		
	}
	
	def findAllByMatricula(Integer id){
		Map<String,Object> res = null
		
		try{
			def certServRes = certificacionService.findAllEnAutorizacionByMatricula(id.value)
			def ctrlActResList = ResultElementViewModel.copyFromServicesResults(certServRes, loteEnvioAutorizacionService.getSet(session.id))
			res = [ 'status' : 'OK' , 'object' : [ 'count': certServRes.count , 'list' : ctrlActResList ] ]
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def findAllByIdSustentante(Long id){
		Map<String,Object> res = null
		
		try{
			def certServRes = certificacionService.findAllEnAutorizacionByFolio(id.value)
			def ctrlActResList = ResultElementViewModel.copyFromServicesResults(certServRes, loteEnvioAutorizacionService.getSet(session.id))
			res = [ 'status' : 'OK' , 'object' : [ 'count': certServRes.count , 'list' : ctrlActResList ] ]
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def findAll(){
		def res = null
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		String nom = params.nom?:""
		String ap1 = params.ap1?:""
		String ap2 = params.ap2?:""
		long idfig = Long.parseLong(params.idfig?:"-1")
		long idvarfig = Long.parseLong(params.idvarfig?:"-1")
		
		
		try{
			def certServRes = certificacionService.findAllEnAutorizacion(max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig)
			def ctrlActResList = ResultElementViewModel.copyFromServicesResults(certServRes, loteEnvioAutorizacionService.getSet(session.id))
			res = [ 'status' : 'OK' , 'object' : [ 'count': certServRes.count , 'list' : ctrlActResList ] ]
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	
	public static class IndexViewModel{
		Collection<FiguraTO> figuraList
	}
	
	public static class ResultElementViewModel{
		long id //id de la certificacion
		long idSustentante
		int numeroMatricula
		String nombre
		String primerApellido
		String segundoApellido
		long idFigura
		String dsFigura
		long idVarianteFigura
		String dsVarianteFigura
		boolean yaEnLote
		String fechaEntrega
		String fechaEnvio
		String tipoSolicitud
		
		public static List<ResultElementViewModel> copyFromServicesResults(CertificacionService.ResultSet rs, Set<Long> idsCertEnLote){
			List<ResultElementViewModel> newResults = new ArrayList<ResultElementViewModel>()
			rs.list.each{ x ->
				ResultElementViewModel revm = new ResultElementViewModel();
				revm.id = x.id.value
				revm.idSustentante = x.sustentante.id.value
				revm.numeroMatricula = x.sustentante.numeroMatricula.value
				revm.nombre = x.sustentante.nombre
				revm.primerApellido = x.sustentante.primerApellido
				revm.segundoApellido = x.sustentante.segundoApellido
				revm.idFigura = x.varianteFigura.idFigura.value
				revm.dsFigura = x.varianteFigura.nombreFigura
				revm.idVarianteFigura = x.varianteFigura.id.value
				revm.dsVarianteFigura = x.varianteFigura.nombre
				revm.yaEnLote = idsCertEnLote.contains( new Long(revm.id) )
				if(x.fechaEntregaRecepcion != null){
					revm.fechaEntrega = x.fechaEntregaRecepcion.format( 'yyyy-MM-dd' )
				}
				else{
					revm.fechaEntrega = ""
				}
				if(x.fechaEnvioComision != null){
					revm.fechaEnvio = x.fechaEnvioComision.format( 'yyyy-MM-dd' )
				}
				else{
					revm.fechaEnvio = ""
				}
				if(x.validaciones!= null && !x.validaciones.isEmpty()){
					Date lastone;
					for(ValidacionTO va: x.validaciones){
						if(lastone==null){
							lastone = va.fechaModificacion;
						}else if(lastone != null && lastone<va.fechaModificacion){
							lastone = va.fechaModificacion;
						}
					}
					def lastVali = x.validaciones.find{it.fechaModificacion == lastone}
					revm.tipoSolicitud = lastVali.metodoValidacion.descripcion
				}
				newResults.add(revm)
			}
			return newResults
		}
		
	}
	
}


