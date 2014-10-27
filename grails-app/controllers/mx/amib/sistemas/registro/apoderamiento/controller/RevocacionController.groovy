package mx.amib.sistemas.registro.apoderamiento.controller



import static org.springframework.http.HttpStatus.*

import java.util.Collection;

import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO;
import mx.amib.sistemas.external.catalogos.service.SepomexService;
import mx.amib.sistemas.external.expediente.service.SustentanteService

@Transactional(readOnly = true)
class RevocacionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	SepomexService sepomexService
	SustentanteService sustentanteService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Revocacion.list(params), model:[revocacionInstanceCount: Revocacion.count()]
    }

    def show(Revocacion revocacionInstance) {
        respond revocacionInstance
    }

    def create() {
		RevocacionViewModel revocacionViewModel = this.createViewModel()
        respond new Revocacion(params), model:[viewModelInstance: revocacionViewModel]
    }
	
	private RevocacionViewModel createViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		//este se tiene que cambiar en cuanto se tenga el rol de spring security
		revocacionViewModel.entidadFinanciera = entidadFinancieraService.obtenerGrupoFinanciero(6)
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		revocacionViewModel.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		return revocacionViewModel
	}

    @Transactional
    def save(Revocacion revocacionInstance) {
        if (revocacionInstance == null) {
            notFound()
            return
        }

        if (revocacionInstance.hasErrors()) {
            respond revocacionInstance.errors, view:'create'
            return
        }

        revocacionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'revocacion.label', default: 'Revocacion'), revocacionInstance.id])
                redirect revocacionInstance
            }
            '*' { respond revocacionInstance, [status: CREATED] }
        }
    }

    def edit(Revocacion revocacionInstance) {
        respond revocacionInstance
    }

    @Transactional
    def update(Revocacion revocacionInstance) {
        if (revocacionInstance == null) {
            notFound()
            return
        }

        if (revocacionInstance.hasErrors()) {
            respond revocacionInstance.errors, view:'edit'
            return
        }

        revocacionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Revocacion.label', default: 'Revocacion'), revocacionInstance.id])
                redirect revocacionInstance
            }
            '*'{ respond revocacionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Revocacion revocacionInstance) {

        if (revocacionInstance == null) {
            notFound()
            return
        }

        revocacionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Revocacion.label', default: 'Revocacion'), revocacionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacion.label', default: 'Revocacion'), params.id])
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

class RevocacionViewModel {
	EntidadFinancieraTO entidadFinanciera
	Collection<EntidadFederativaTO> entidadFederativaList
	Collection<GrupoFinancieroTO> gruposFinancierosList
}