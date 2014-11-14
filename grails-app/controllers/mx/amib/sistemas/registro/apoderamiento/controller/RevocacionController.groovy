package mx.amib.sistemas.registro.apoderamiento.controller



import static org.springframework.http.HttpStatus.*

import java.util.Collection;

import mx.amib.sistemas.registro.apoderado.service.RevocacionService
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.notario.service.NotarioService
import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO;
import mx.amib.sistemas.external.catalogos.service.SepomexService;
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService
import mx.amib.sistemas.external.expediente.service.SustentanteService

@Transactional(readOnly = true)
class RevocacionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	SepomexService sepomexService
	SustentanteService sustentanteService
	NotarioService notarioService
	RevocacionService revocacionService
	DocumentoRepositorioService documentoRepositorioService
	
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
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = false
		return revocacionViewModel
	}

    @Transactional
    def save(Revocacion revocacion) {
		def revocacionInstance = revocacion
		
		def revocadosToBind = params.list('revocado')
		def documentosToBind = params.list('documento')
		def documentosToEraseStrParam = params.'idsDocumentosBorrados'
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
        def documentosToErase = null
		if(documentosToEraseStrParam != null || documentosToEraseStrParam != ""){
			documentosToErase = documentosToEraseStrParam.split("\\|")
		}
		
		if (revocacionInstance == null) {
            notFound()
            return
        }

		revocacionService.save(revocacionInstance, revocadosToBind, documentosToBind, notarioIdEntidadFederativa, notarioNumero)
		
		/*
        if (revocacionInstance.hasErrors()) {
            respond revocacionInstance.errors, view:'create'
            return
        }
        revocacionInstance.save flush:true
		*/
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'revocacion.label', default: 'Revocacion'), revocacionInstance.id])
                redirect revocacionInstance
            }
            '*' { respond revocacionInstance, [status: CREATED] }
        }
    }

    def edit(Revocacion revocacionInstance) {
		RevocacionViewModel revocacionViewModel = this.editViewModel()
		revocacionInstance = this.cargaNombresArchivo(revocacionInstance)
        respond revocacionInstance, model:[viewModelInstance: revocacionViewModel]
    }
	
	private RevocacionViewModel editViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		//este se tiene que cambiar en cuanto se tenga el rol de spring security
		revocacionViewModel.entidadFinanciera = entidadFinancieraService.obtenerGrupoFinanciero(6)
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		revocacionViewModel.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = true
		return revocacionViewModel
	}

	private Revocacion cargaNombresArchivo(Revocacion revocacionInstance){
		revocacionInstance.documentosRespaldoRevocacion.each{
			it.nombreDeArchivo = documentoRepositorioService.obtenerMetadatosDocumento(it.uuidDocumentoRepositorio).nombre
		}
		return revocacionInstance
	}
	
    @Transactional
    def update(Revocacion revocacion) {
		def revocacionInstance = revocacion
		
		def revocadosToBind = params.list('revocado')
		def documentosToBind = params.list('documento')
		def documentosToEraseStrParam = params.'idsDocumentosBorrados'
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		
		/*
		 * YA NO SE USO ESTE PARAMETRO - ELIMINAR DE CLIENTE
		def documentosToErase = null
		if(documentosToEraseStrParam != null || documentosToEraseStrParam != ""){
			documentosToErase = documentosToEraseStrParam.split("\\|")
		}
		*/
		if (revocacionInstance == null) {
			notFound()
			return
		}

		revocacionService.update(revocacionInstance, revocadosToBind, documentosToBind, notarioIdEntidadFederativa, notarioNumero)

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
	
	// "OK","NOT_FOUND","NOT_VALID_INPUT"
	def obtenerNombreNotario(){
		String strIdEntidadFederativa = params.'idEntidadFederativa'
		String strNumeroNotario = params.'numeroNotario'
		
		if(strIdEntidadFederativa.isInteger() && strNumeroNotario.isInteger()){
			def notario = notarioService.obtenerNotario(strIdEntidadFederativa.toInteger(),strNumeroNotario.toInteger())
			
			if(notario != null)
			{
				String nombreCompletoNotario = notario.nombre + ' ' + notario.apellido1 + ' ' + notario.apellido2
				def res = [ status: 'OK', id: notario.id, nombreCompleto: nombreCompletoNotario ]
				render res as JSON
			}
			else
			{
				def res = [ status: 'NOT_FOUND', id: -1, nombreCompleto: '' ]
				render res as JSON
			}
		}
		else
		{
			def res = [ status: 'NOT_VALID_INPUT', id: -1, nombreCompleto: '' ]
			render res as JSON
		}
	}
	
	//obtiene instituciones dado un id de grupo financiero
	def obtenerInstituciones(long id){
		def gp = entidadFinancieraService.obtenerGrupoFinanciero(id)
		def instituciones = gp.instituciones
		render instituciones as grails.converters.deep.JSON
	}
}

class RevocacionViewModel {
	EntidadFinancieraTO entidadFinanciera
	Collection<EntidadFederativaTO> entidadFederativaList
	Collection<GrupoFinancieroTO> gruposFinancierosList
	Collection<TipoDocumentoRespaldoRevocacion> tipoDocumentoList
	
	boolean validDocumentosCargados
}