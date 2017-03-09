package mx.amib.sistemas.registro.portal.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConsultaTipoServicio6Controller {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ConsultaTipoServicio6.list(params), model:[consultaTipoServicio6InstanceCount: ConsultaTipoServicio6.count()]
    }

    def show(ConsultaTipoServicio6 consultaTipoServicio6Instance) {
        respond consultaTipoServicio6Instance
    }

    def create() {
        respond new ConsultaTipoServicio6(params)
    }

    @Transactional
    def save(ConsultaTipoServicio6 consultaTipoServicio6Instance) {
        if (consultaTipoServicio6Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio6Instance.hasErrors()) {
            respond consultaTipoServicio6Instance.errors, view:'create'
            return
        }

        consultaTipoServicio6Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'consultaTipoServicio6.label', default: 'ConsultaTipoServicio6'), consultaTipoServicio6Instance.id])
                redirect consultaTipoServicio6Instance
            }
            '*' { respond consultaTipoServicio6Instance, [status: CREATED] }
        }
    }

    def edit(ConsultaTipoServicio6 consultaTipoServicio6Instance) {
        respond consultaTipoServicio6Instance
    }

    @Transactional
    def update(ConsultaTipoServicio6 consultaTipoServicio6Instance) {
        if (consultaTipoServicio6Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio6Instance.hasErrors()) {
            respond consultaTipoServicio6Instance.errors, view:'edit'
            return
        }

        consultaTipoServicio6Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConsultaTipoServicio6.label', default: 'ConsultaTipoServicio6'), consultaTipoServicio6Instance.id])
                redirect consultaTipoServicio6Instance
            }
            '*'{ respond consultaTipoServicio6Instance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConsultaTipoServicio6 consultaTipoServicio6Instance) {

        if (consultaTipoServicio6Instance == null) {
            notFound()
            return
        }

        consultaTipoServicio6Instance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConsultaTipoServicio6.label', default: 'ConsultaTipoServicio6'), consultaTipoServicio6Instance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'consultaTipoServicio6.label', default: 'ConsultaTipoServicio6'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
