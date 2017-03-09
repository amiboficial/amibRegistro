package mx.amib.sistemas.registro.portal.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConsultaTipoServicio5Controller {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ConsultaTipoServicio5.list(params), model:[consultaTipoServicio5InstanceCount: ConsultaTipoServicio5.count()]
    }

    def show(ConsultaTipoServicio5 consultaTipoServicio5Instance) {
        respond consultaTipoServicio5Instance
    }

    def create() {
        respond new ConsultaTipoServicio5(params)
    }

    @Transactional
    def save(ConsultaTipoServicio5 consultaTipoServicio5Instance) {
        if (consultaTipoServicio5Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio5Instance.hasErrors()) {
            respond consultaTipoServicio5Instance.errors, view:'create'
            return
        }

        consultaTipoServicio5Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'consultaTipoServicio5.label', default: 'ConsultaTipoServicio5'), consultaTipoServicio5Instance.id])
                redirect consultaTipoServicio5Instance
            }
            '*' { respond consultaTipoServicio5Instance, [status: CREATED] }
        }
    }

    def edit(ConsultaTipoServicio5 consultaTipoServicio5Instance) {
        respond consultaTipoServicio5Instance
    }

    @Transactional
    def update(ConsultaTipoServicio5 consultaTipoServicio5Instance) {
        if (consultaTipoServicio5Instance == null) {
            notFound()
            return
        }

        if (consultaTipoServicio5Instance.hasErrors()) {
            respond consultaTipoServicio5Instance.errors, view:'edit'
            return
        }

        consultaTipoServicio5Instance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConsultaTipoServicio5.label', default: 'ConsultaTipoServicio5'), consultaTipoServicio5Instance.id])
                redirect consultaTipoServicio5Instance
            }
            '*'{ respond consultaTipoServicio5Instance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConsultaTipoServicio5 consultaTipoServicio5Instance) {

        if (consultaTipoServicio5Instance == null) {
            notFound()
            return
        }

        consultaTipoServicio5Instance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConsultaTipoServicio5.label', default: 'ConsultaTipoServicio5'), consultaTipoServicio5Instance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'consultaTipoServicio5.label', default: 'ConsultaTipoServicio5'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
