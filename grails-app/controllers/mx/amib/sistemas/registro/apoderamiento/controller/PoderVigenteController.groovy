package mx.amib.sistemas.registro.apoderamiento.controller

class PoderVigenteController {

	def poderVigenteV1Service
	
    def index(Integer max) {
		def result = null
		
		params.max = Math.min(max ?: 10, 100)
		params.offset = params.offset?:0
		
		if(params.fltOp != null && params.fltOp == "MAT"){ //por matricula
			result = poderVigenteV1Service.searchByMatricula(params.max, params.offset, params.sort, params.order, params.fltMat)
		}
		else if(params.fltOp != null && params.fltOp == "PAL"){ //por palabra en nombre y/o apellidos
			result = poderVigenteV1Service.searchByPalabraNombreApellido(params.max, params.offset, params.sort, params.order, params.fltPal)
		}
		else{
			result = poderVigenteV1Service.findAll(params.max, params.offset, params.sort, params.order)
		}
		
		respond result.list, model:[poderVigenteInstanceCount: result.count, viewModelInstance: this.getIndexViewModel(params)]
	}
	
	private PoderVigenteIndexViewModel getIndexViewModel(def params){
		PoderVigenteIndexViewModel pvivm = new PoderVigenteIndexViewModel()
		pvivm.fltOp = params.fltOp
		pvivm.fltMat = params.fltMat
		pvivm.fltPal = params.fltPal
		return pvivm
	}
	
}

class PoderVigenteIndexViewModel{
	String fltOp
	String fltMat
	String fltPal
}