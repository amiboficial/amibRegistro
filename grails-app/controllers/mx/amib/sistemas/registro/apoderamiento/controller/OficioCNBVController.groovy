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
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OficioCNBV.list(params), model:[oficioCNBVInstanceCount: OficioCNBV.count()]
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
    def update(OficioCNBV oficioCNBVInstance) {
        if (oficioCNBVInstance == null) {
            notFound()
            return
        }

        if (oficioCNBVInstance.hasErrors()) {
            respond oficioCNBVInstance.errors, view:'edit'
            return
        }

        oficioCNBVInstance.save flush:true

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
