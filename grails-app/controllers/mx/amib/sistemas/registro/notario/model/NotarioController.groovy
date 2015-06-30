package mx.amib.sistemas.registro.notario.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO

@Transactional(readOnly = true)
class NotarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: ["DELETE","GET"]]

	def sepomexService
	def notarioV1Service
	
    def index(Integer max) {
		
        params.max = Math.min(max ?: 10, 100)
		params.offset = params.offset?:'0'
		//params.sort = params.sort?:'id'
		//params.order = params.order?:'desc'
		params.filterIdEntidadFederativa = params.filterIdEntidadFederativa?:'-1'
		params.filterNumero = params.filterNumero?:'-1'
		
		NotarioIndexViewModel nivm = this.getIndexViewModel(params)
		
		def result = notarioV1Service.search(params.max, params.offset.toInteger(), params.sort, params.order, params.filterIdEntidadFederativa?.toInteger(),
										params.filterNombre, params.filterApellido1, params.filterApellido2, params.filterNumero?.toInteger())
        respond result.list, model:[notarioInstanceCount: result.count, viewModelInstance:nivm]
    }

	private NotarioIndexViewModel getIndexViewModel(def params){
		NotarioIndexViewModel nivm = new NotarioIndexViewModel()
		nivm.entidadesFederativasList = sepomexService.obtenerEntidadesFederativas()
		nivm.entidadesFederativasNombresMap = new HashMap()
		nivm.entidadesFederativasList.each{
			nivm.entidadesFederativasNombresMap.put(it.id, it.nombre)
		}
		
		nivm.filterIdEntidadFederativa = params.filterIdEntidadFederativa?.toInteger()
		nivm.filterNombre = params.filterNombre
		nivm.filterApellido1 = params.filterApellido1
		nivm.filterApellido2 = params.filterApellido2
		if(params.filterNumero == '-1')
			nivm.filterNumero = ""
		
		return nivm
	}
	
    def show(Notario notarioInstance) {
		notarioInstance.nombreEntidadFederativa = sepomexService.obtenerEntidadFederativa(notarioInstance.idEntidadFederativa).nombre
        respond notarioInstance
    }

    def create() {
        respond new Notario(params), model:[viewModelInstance: this.getViewModel()]
    }
	private NotarioViewModel getViewModel(){
		NotarioViewModel nvm = new NotarioViewModel()
		nvm.entidadesFederativasList = sepomexService.obtenerEntidadesFederativas()
		return nvm
	}
    @Transactional
    def save(Notario notario) {
		def notarioInstance = notario
		
        if (notarioInstance == null) {
            notFound()
            return
        }

		notarioV1Service.save(notarioInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'notario.label', default: 'Notario'), notarioInstance.id])
                redirect notarioInstance
            }
            '*' { respond notarioInstance, [status: CREATED] }
        }
    }

    def edit(Notario notarioInstance) {
        respond notarioInstance, model:[viewModelInstance: this.getViewModel()]
    }

    @Transactional
    def update(Notario notario) {
		def notarioInstance = notario
		
        if (notarioInstance == null) {
            notFound()
            return
        }

        /*if (notarioInstance.hasErrors()) {
            respond notarioInstance.errors, view:'edit'
            return
        }*/

		notarioV1Service.update(notarioInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Notario.label', default: 'Notario'), notarioInstance.id])
                redirect notarioInstance
            }
            '*'{ respond notarioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Notario notarioInstance) {

        if (notarioInstance == null) {
            notFound()
            return
        }

        notarioInstance.delete flush:true

        request.withFormat {
            '*'{
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Notario.label', default: 'Notario'), notarioInstance.id])
                redirect action:"index", method:"GET"
            }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'notario.label', default: 'Notario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

class NotarioIndexViewModel{
	Collection<EntidadFederativaTO> entidadesFederativasList
	HashMap<String,String> entidadesFederativasNombresMap
	
	Integer filterIdEntidadFederativa
	String filterNombre
	String filterApellido1
	String filterApellido2
	String filterNumero
}

class NotarioViewModel{
	Collection<EntidadFederativaTO> entidadesFederativasList
}