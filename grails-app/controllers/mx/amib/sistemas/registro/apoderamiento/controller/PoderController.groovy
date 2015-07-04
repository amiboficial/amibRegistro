package mx.amib.sistemas.registro.apoderamiento.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.utils.service.ArchivoTO

class PoderController {

	def figuraService
	def entidadFinancieraService
	def notarioService
	def sepomexService
	
    def index() { 
		
	}
	
	def show(){ 
		
	}
	
	def create() { 
		CreateViewModel cvm = this.getCreateViewModel()
		render(view:'create', model: [viewModelInstance:cvm]) 
	}
	
	private CreateViewModel getCreateViewModel(){
		CreateViewModel cvm = new CreateViewModel()
		
		cvm.poderInstance = new PoderTO()
		cvm.archivoDocumentoRespaldo = new ArchivoTO()
		cvm.notario = new NotarioTO()
		cvm.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		cvm.figuraList = figuraService.list()
		cvm.gruposFinancieroList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		cvm.institucionList = new ArrayList<InstitucionTO>()
				
		return cvm
	}
	
	def edit() {
		
	}
	
	def editAgregarApoderados(){
		
	}
	
	def editQuitarApoderados(){
		
	}
	
	def getNotario(){
		Map res = null
		long idEntidadFederativa = -1L
		int numeroNotario = -1
		
		try{
			idEntidadFederativa = params.'idEntidadFederativa'
			numeroNotario = params.'numeroNotario'
			res = [ 'status':'OK', 'object': notarioService.findAllBy(100,0,"desc","nombreCompleto",idEntidadFederativa,numeroNotario,"") ]
		}
		catch(Exception ex) {
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render res as JSON
	}
	
}

class CreateViewModel{
	PoderTO poderInstance
	
	ArchivoTO archivoDocumentoRespaldo
	boolean validDocumentosCargados
	NotarioTO notario
	Collection<EntidadFederativaTO> entidadFederativaList 
	Collection<FiguraTO> figuraList
	Collection<GrupoFinancieroTO> gruposFinancieroList
	Collection<InstitucionTO> institucionList
}
