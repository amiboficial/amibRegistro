package mx.amib.sistemas.registro.portal.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConsultaTipoServicioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ConsultaTipoServicio.list(params), model:[consultaTipoServicioInstanceCount: ConsultaTipoServicio.count()]
    }

    def show(ConsultaTipoServicio consultaTipoServicioInstance) {
        respond consultaTipoServicioInstance
    }

    def create() {
        respond new ConsultaTipoServicio(params)
    }

    @Transactional
    def save(ConsultaTipoServicio consultaTipoServicioInstance) {
        if (consultaTipoServicioInstance == null) {
            notFound()
            return
        }

        if (consultaTipoServicioInstance.hasErrors()) {
            respond consultaTipoServicioInstance.errors, view:'create'
            return
        }

        consultaTipoServicioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'consultaTipoServicio.label', default: 'ConsultaTipoServicio'), consultaTipoServicioInstance.id])
                redirect consultaTipoServicioInstance
            }
            '*' { respond consultaTipoServicioInstance, [status: CREATED] }
        }
    }

    def edit(ConsultaTipoServicio consultaTipoServicioInstance) {
        respond consultaTipoServicioInstance
    }

    @Transactional
    def update(ConsultaTipoServicio consultaTipoServicioInstance) {
        if (consultaTipoServicioInstance == null) {
            notFound()
            return
        }

        if (consultaTipoServicioInstance.hasErrors()) {
            respond consultaTipoServicioInstance.errors, view:'edit'
            return
        }

        consultaTipoServicioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConsultaTipoServicio.label', default: 'ConsultaTipoServicio'), consultaTipoServicioInstance.id])
                redirect consultaTipoServicioInstance
            }
            '*'{ respond consultaTipoServicioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConsultaTipoServicio consultaTipoServicioInstance) {

        if (consultaTipoServicioInstance == null) {
            notFound()
            return
        }

        consultaTipoServicioInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConsultaTipoServicio.label', default: 'ConsultaTipoServicio'), consultaTipoServicioInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'consultaTipoServicio.label', default: 'ConsultaTipoServicio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
