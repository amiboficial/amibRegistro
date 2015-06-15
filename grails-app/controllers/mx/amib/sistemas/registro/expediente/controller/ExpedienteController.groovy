package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class ExpedienteController {

	def figuraService
	
	def sustentanteService
	
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
			//TODO: busqueda avanzada
		}
		
		println (vm as JSON)
		
		respond vm
	}

	private IndexViewModel getIndexViewModel(Map params){
		IndexViewModel vm = new IndexViewModel();
		
		bindData(vm,params)
		
		//Carga listas
		vm.figuraList = figuraService.list()
		if(vm.fltFig != null && vm.fltFig > 0)
			vm.varianteFiguraList = figuraService.get(fltFig).variantes
		
		if(vm.sort == null || vm.sort == ''|| 
			(vm.sort != 'id' && vm.sort != 'numeroMatricula' && vm.sort != 'nombre' 
			&& vm.sort != 'primerApellido' && vm.sort != 'segundoApellido') )
				vm.sort = "id"
			
		if(vm.order == null || vm.order == '')
			vm.order = "asc"
			
		if(vm.max == null || vm.max <= 0)	
			vm.max = 100
			
		if(vm.offset == null || vm.offset <= 0)
			vm.offset = 0
		
		if(vm.fltTB == null || vm.fltTB == '' || (vm.fltTB != 'A' && vm.fltTB != 'M' && vm.fltTB != 'F' && vm.fltTB != 'T'))
			vm.fltTB='T'
			
		/*
		if(params.fltTB != null && params.fltTB != ""){
			if(params.fltTB != 'A' && params.fltTB != 'M' && params.fltTB != 'F')
				vm.fltTB = 'A'
			else
				vm.fltTB = params.fltTB
			
			vm.fltMat = params.fltMat //Matrícula
			vm.fltFol = params.fltFol //Folio
			vm.fltNom = params.fltNom //Nombre
			vm.fltAp1 = params.fltAp1 //Primer apellido
			vm.fltAp2 = params.fltAp2 //Segundo apellido
			vm.fltFig = params.fltFig //Identificador de figura
			vm.fltVFig = params.fltVFig //Identificador de variante de figura
			vm.fltStCt = params.fltStCt //Identificador de estatus de certificacion
			vm.fltStAt = params.fltStAt //Identificador de estatus de autorizacion
		
			vm.sort = params.sort
			vm.max = params.max
			vm.order = params.order
		}
		*/
		
		
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
