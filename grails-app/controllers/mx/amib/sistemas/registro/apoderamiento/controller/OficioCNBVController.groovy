package mx.amib.sistemas.registro.apoderamiento.controller

import static org.springframework.http.HttpStatus.*
import mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV;
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OficioCNBVController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def sustentanteService
	def oficioCNBVService
	
	// fltType (filtro de búsqueda)
	// 'DO' -> Datos de OficioCNBV
	// 'AMAT' -> Por matricula de autorizado
	// 'ANOM' -> Por nombre de autorizado
    def index(Integer max) {
		def result = null
        def resultList = null
		long resultListCount = 0
		
		params.max = Math.min(max ?: 10, 100)
		params.offset = params.offset?:0
		params.fltType = params.fltType?:'' 
		OficioCNBVIndexViewModel oivm = this.getIndexViewModel(params)
		
		if(params.fltType == ''){
			resultList = OficioCNBV.list(params)
			resultListCount = OficioCNBV.count()
		}
		else if(params.fltType == 'DO'){
			params.fltDOFhDel_day = (params.fltDOFhDel_day==null || params.fltDOFhDel_day=='null')?'-1':params.fltDOFhDel_day
			params.fltDOFhDel_month = (params.fltDOFhDel_month==null || params.fltDOFhDel_month=='null')?'-1':params.fltDOFhDel_month
			params.fltDOFhDel_year = (params.fltDOFhDel_year==null || params.fltDOFhDel_year=='null')?'-1':params.fltDOFhDel_year
			params.fltDOFhAl_day = (params.fltDOFhAl_day==null || params.fltDOFhAl_day=='null')?'-1':params.fltDOFhAl_day
			params.fltDOFhAl_month = (params.fltDOFhAl_month==null || params.fltDOFhAl_month=='null')?'-1':params.fltDOFhAl_month
			params.fltDOFhAl_year = (params.fltDOFhAl_year==null || params.fltDOFhAl_year=='null')?'-1':params.fltDOFhAl_year
			
			result = oficioCNBVService.searchByDatosOficio(params.max, params.offset.toInteger(), params.sort, params.order, params.fltDODga, 
																params.fltDOFhDel_day.toInteger(), params.fltDOFhDel_month.toInteger(), params.fltDOFhDel_year.toInteger(), 
																params.fltDOFhAl_day.toInteger(), params.fltDOFhAl_month.toInteger(), params.fltDOFhAl_year.toInteger())
			resultList = result.list
			resultListCount = result.count
		}
		else if(params.fltType == 'AMAT'){
			params.fltAMat = params.fltAMat?:'-1'
			result = oficioCNBVService.searchByMatricula(params.max, params.offset.toInteger(), params.sort, params.order, params.fltAMat.toInteger())
			resultList = result.list
			resultListCount = result.count
		}
		else if(params.fltType == 'ANOM'){
			params.fltANom = params.fltANom?:""
			result = oficioCNBVService.searchByNombre(params.max, params.offset.toInteger(), params.sort, params.order, params.fltANom)
			resultList = result.list
			resultListCount = result.count
		}
		
        respond resultList, model:[oficioCNBVInstanceCount: resultListCount, viewModelInstance: oivm]
    }

	private OficioCNBVIndexViewModel getIndexViewModel(def params){
		OficioCNBVIndexViewModel oivm = new OficioCNBVIndexViewModel()
		
		oivm.fltType = (params.fltType==null || params.fltType=='null' || (params.fltType!='DO' && params.fltType!='AMAT' && params.fltType!='ANOM') )?'':params.fltType 
		
		oivm.fltDODga = (params.fltDODga==null || params.fltDODga=='null')?'':params.fltDODga 
		oivm.fltDOFhDelDay = (params.fltDOFhDel_day==null || params.fltDOFhDel_day=='null'|| !params.fltDOFhDel_day.isNumber())?-1:params.fltDOFhDel_day.toInteger()
		oivm.fltDOFhDelMonth = (params.fltDOFhDel_month==null || params.fltDOFhDel_month=='null'|| !params.fltDOFhDel_month.isNumber())?-1:params.fltDOFhDel_month.toInteger()
		oivm.fltDOFhDelYear = (params.fltDOFhDel_year==null || params.fltDOFhDel_year=='null'|| !params.fltDOFhDel_year.isNumber())?-1:params.fltDOFhDel_year.toInteger()
		oivm.fltDOFhAlDay = (params.fltDOFhAl_day==null || params.fltDOFhAl_day=='null'|| !params.fltDOFhAl_day.isNumber())?-1:params.fltDOFhAl_day.toInteger()
		oivm.fltDOFhAlMonth = (params.fltDOFhAl_month==null || params.fltDOFhAl_month=='null'|| !params.fltDOFhAl_month.isNumber())?-1:params.fltDOFhAl_month.toInteger()
		oivm.fltDOFhAlYear = (params.fltDOFhAl_year==null || params.fltDOFhAl_year=='null'|| !params.fltDOFhAl_year.isNumber())?-1:params.fltDOFhAl_year.toInteger()
		
		oivm.fltAMat = (params.fltAMat==null || !params.fltAMat.isNumber())?-1:(params.fltAMat.toInteger())
		oivm.fltANom = (params.fltANom==null || params.fltANom=='null')?"":params.fltANom
		
		return oivm
	}
	
    def show(OficioCNBV oficioCNBVInstance) {
        respond oficioCNBVInstance
    }

    def create() {
        respond new OficioCNBV(params)
    }

    @Transactional
    def save(OficioCNBV oficioCNBV) {
		def oficioCNBVInstance = oficioCNBV
		def jsonStrLstAutorizados = params.list('autorizado')
		
        if (oficioCNBVInstance == null) {
            notFound()
            return
        }
		oficioCNBVService.save(oficioCNBVInstance, jsonStrLstAutorizados)
		
		/*
		if (oficioCNBVInstance.hasErrors()) {
            respond oficioCNBVInstance.errors, view:'create'
            return
        }
        oficioCNBVInstance.save flush:true
		*/
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'oficioCNBV.label', default: 'OficioCNBV'), oficioCNBVInstance.id])
                redirect oficioCNBVInstance
            }
            '*' { respond oficioCNBVInstance, [status: CREATED] }
        }
    }

    def edit(OficioCNBV oficioCNBVInstance) {
        respond oficioCNBVInstance
    }

    @Transactional
    def update(OficioCNBV oficioCNBV) {
		def oficioCNBVInstance = oficioCNBV
		def jsonStrLstAutorizados = params.list('autorizado')
        if (oficioCNBVInstance == null) {
            notFound()
            return
        }
		oficioCNBVService.update(oficioCNBVInstance, jsonStrLstAutorizados)
		
		/*
        if (oficioCNBVInstance.hasErrors()) {
            respond oficioCNBVInstance.errors, view:'edit'
            return
        }

        oficioCNBVInstance.save flush:true
		*/
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'OficioCNBV.label', default: 'OficioCNBV'), oficioCNBVInstance.id])
                redirect oficioCNBVInstance
            }
            '*'{ respond oficioCNBVInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(OficioCNBV oficioCNBVInstance) {

        if (oficioCNBVInstance == null) {
            notFound()
            return
        }

        oficioCNBVInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'OficioCNBV.label', default: 'OficioCNBV'), oficioCNBVInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'oficioCNBV.label', default: 'OficioCNBV'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	//el id es la matricula
	def obtenerSustentantePorMatricula(int id){
		def sustentante = sustentanteService.obtenerPorMatricula(id)
		def res = null
		if(sustentante != null){
			res = [ status: 'OK' , object: sustentante ]
		}
		else{
			res = [ status: 'NOT_FOUND' ]
		}
		render res as JSON
	}
}

class OficioCNBVIndexViewModel{
	String fltType //'DO','AMAT','ANOM'
	
	String fltDODga
	Integer fltDOFhDelDay
	Integer fltDOFhDelMonth
	Integer fltDOFhDelYear
	Integer fltDOFhAlDay
	Integer fltDOFhAlMonth
	Integer fltDOFhAlYear
	
	Integer fltAMat
	String fltANom
}