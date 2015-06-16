package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class ExpedienteController {

	def figuraService
	
	def sustentanteService
	def statusAutorizacionService
	def statusCertificacionService
	
    def index() {
		IndexViewModel vm = this.getIndexViewModel(params)
		
		if(vm.fltTB == 'T'){
			def sr = sustentanteService.findAll(vm.max, vm.offset, vm.sort, vm.order)
			vm.resultList = sr.list
			vm.count = sr.count
		}
		else if(vm.fltTB == 'M'){
			
			def result = sustentanteService.findByMatricula(vm.fltMat.value)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			vm.offset = 0
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
			
		}
		else if(vm.fltTB == 'F'){
			def result = sustentanteService.get(vm.fltFol)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
		}
		else if(vm.fltTB == 'A'){
			def sr = sustentanteService.findAllAdvancedSearch(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.fltFig, vm.fltVFig, vm.fltStCt, vm.fltStAt, vm.max, vm.offset, vm.sort, vm.order)
			vm.resultList = sr.list
			vm.count = sr.count
		}
		
		//println (vm as JSON)
		
		render(view:'index', model: [viewModelInstance:vm])
	}

	private IndexViewModel getIndexViewModel(Map params){
		IndexViewModel vm = new IndexViewModel();
		
		bindData(vm,params)
		
		//Carga listas
		vm.figuraList = figuraService.list()
		vm.statusAutorizacionList = statusAutorizacionService.list()
		vm.statusCertificacionList = statusCertificacionService.list()
		
		if(vm.fltFig != null && vm.fltFig > 0)
			vm.varianteFiguraList = figuraService.get(fltFig).variantes
		
		if(vm.sort == null || vm.sort == ''|| 
			(vm.sort != 'id' && vm.sort != 'numeroMatricula' && vm.sort != 'nombre' 
			&& vm.sort != 'primerApellido' && vm.sort != 'segundoApellido') )
				vm.sort = "id"
			
		if(vm.order == null || vm.order == '')
			vm.order = "asc"
			
		if(vm.max == null || vm.max <= 0)	
			vm.max = 10
			
		if(vm.offset == null || vm.offset <= 0)
			vm.offset = 0
		
		if(vm.fltTB == null || vm.fltTB == '' || (vm.fltTB != 'A' && vm.fltTB != 'M' && vm.fltTB != 'F' && vm.fltTB != 'T'))
			vm.fltTB='T'
	
		if(vm.fltNom == null) vm.fltNom = ""
		if(vm.fltAp1 == null) vm.fltAp1 = "" 
		if(vm.fltAp2 == null) vm.fltAp2 = ""
			
		if(vm.fltFig == null) vm.fltFig = -1 
		if(vm.fltVFig == null) vm.fltVFig = -1
		if(vm.fltStCt == null) vm.fltStCt = -1
		if(vm.fltStAt == null) vm.fltStAt = -1
		
		return vm
	}
	
	def listEnDictamen(){}
	
	def listEnAutorizacion(){}

	def show(){ }

}

class IndexViewModel{
	
	//No bindeables
	Collection<VarianteFiguraTO> varianteFiguraList
	Collection<FiguraTO> figuraList
	Collection<StatusCertificacionTO> statusCertificacionList
	Collection<StatusAutorizacionTO> statusAutorizacionList
	
	Collection<SustentanteTO> resultList
	Integer count
	
	//Bindeables
	String fltTB //Tipo de Búsqueda 'A',Avanzada;'M',Matricula;'F',Folio(Id);'T',Todos
	Integer fltMat //Matrícula
	Long fltFol //Folio
	String fltNom //Nombre
	String fltAp1 //Primer apellido
	String fltAp2 //Segundo apellido
	Long fltFig //Identificador de figura
	Long fltVFig //Identificador de variante de figura
	Long fltStCt //Identificador de estatus de certificacion
	Long fltStAt //Identificador de estatus de autorizacion

	String sort
	Integer max
	String order
	Integer offset
}
