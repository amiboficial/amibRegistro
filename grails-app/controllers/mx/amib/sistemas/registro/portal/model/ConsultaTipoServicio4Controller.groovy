package mx.amib.sistemas.registro.portal.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConsultaTipoServicio4Controller {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ConsultaTipoServicio4.list(params), model:[consultaTipoServicio4InstanceCount: ConsultaTipoServicio4.count()]
    }

    def show(ConsultaTipoServicio4 consultaTipoServicio4Instance) {
        respond consultaTipoServicio4Instance
    }

    def create() {
        respond new ConsultaTipoServicio4(params)
    }

    @Transactional
    def save(ConsultaTipoServicio4 consultaTipoServicio4Instance) {
        if (consultaTipoServicio4Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio4Instance.hasErrors()) {
            respond consultaTipoServicio4Instance.errors, view:'create'
            return
        }

        consultaTipoServicio4Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'consultaTipoServicio4.label', default: 'ConsultaTipoServicio4'), consultaTipoServicio4Instance.id])
                redirect consultaTipoServicio4Instance
            }
            '*' { respond consultaTipoServicio4Instance, [status: CREATED] }
        }
    }

    def edit(ConsultaTipoServicio4 consultaTipoServicio4Instance) {
        respond consultaTipoServicio4Instance
    }

    @Transactional
    def update(ConsultaTipoServicio4 consultaTipoServicio4Instance) {
        if (consultaTipoServicio4Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio4Instance.hasErrors()) {
            respond consultaTipoServicio4Instance.errors, view:'edit'
            return
        }

        consultaTipoServicio4Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConsultaTipoServicio4.label', default: 'ConsultaTipoServicio4'), consultaTipoServicio4Instance.id])
                redirect consultaTipoServicio4Instance
            }
            '*'{ respond consultaTipoServicio4Instance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConsultaTipoServicio4 consultaTipoServicio4Instance) {

        if (consultaTipoServicio4Instance == null) {
            notFound()
            return
        }

        consultaTipoServicio4Instance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConsultaTipoServicio4.label', default: 'ConsultaTipoServicio4'), consultaTipoServicio4Instance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'consultaTipoServicio4.label', default: 'ConsultaTipoServicio4'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
