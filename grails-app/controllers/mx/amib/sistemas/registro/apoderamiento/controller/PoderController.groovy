package mx.amib.sistemas.registro.apoderamiento.controller

import static org.springframework.http.HttpStatus.*
import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO
import mx.amib.sistemas.registro.apoderado.service.DocumentoService
import mx.amib.sistemas.registro.apoderado.service.DocumentoTO
import mx.amib.sistemas.registro.apoderado.service.EntidadFinancieraService
import mx.amib.sistemas.registro.apoderado.service.ClaseDocumento
import mx.amib.sistemas.registro.apoderamiento.model.Poder
import mx.amib.sistemas.registro.external.catalgos.service.SepomexService
import mx.amib.sistemas.registro.notario.service.NotarioService
import mx.amib.sistemas.registro.apoderado.service.PoderService

import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.commons.CommonsMultipartFile

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PoderController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	ApoderadoService apoderadoService
	DocumentoService documentoService
	SepomexService sepomexService
	NotarioService notarioService
	PoderService poderService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Poder.list(params), model:[poderInstanceCount: Poder.count()]
    }

    def show(Poder poderInstance) {
        respond poderInstance
    }

    def create() {
        respond new Poder(params), model:[entidadFederativaList: sepomexService.obtenerEntidadesFederativas(), 
											tipoDocumentoList: poderService.obtenerListadoTipoDocumentoRespaldoPoder(),
											entidadFinancieraInstance: entidadFinancieraService.obtenerGrupoFinanciero(5)]
    }

    @Transactional
    def save(Poder poderInstance) {
        if (poderInstance == null) {
            notFound()
            return
        }

        if (poderInstance.hasErrors()) {
            respond poderInstance.errors, view:'create'
            return
        }

        poderInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), poderInstance.id])
                redirect poderInstance
            }
            '*' { respond poderInstance, [status: CREATED] }
        }
    }

    def edit(Poder poderInstance) {
        respond poderInstance
    }

    @Transactional
    def update(Poder poderInstance) {
        if (poderInstance == null) {
            notFound()
            return
        }

        if (poderInstance.hasErrors()) {
            respond poderInstance.errors, view:'edit'
            return
        }

        poderInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Poder.label', default: 'Poder'), poderInstance.id])
                redirect poderInstance
            }
            '*'{ respond poderInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Poder poderInstance) {

        if (poderInstance == null) {
            notFound()
            return
        }

        poderInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Poder.label', default: 'Poder'), poderInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
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
	
	def obtenerDatosMatriculaDgaValido(int id){
		//int numeroMatricula = (params.'numeroMatricula').toInteger()
		
		//print "el numero de matricula es: "
		//print numeroMatricula
		
		ApoderadoTO apoderado = apoderadoService.obtenerDatosMatriculaDgaValido(id)
		
		if(apoderado == null){
			apoderado = new ApoderadoTO()
			apoderado.numeroMatricula = -1
		}
		
		render apoderado as JSON
	}
	
	def subirArchivo(){
		CommonsMultipartFile uploadFile = params.archivo
		int tipoDocumento = params.int('idTipoDocumento')
		DocumentoTO doc = null
		
		doc = documentoService.guardarDocumentoTemp(session.id,uploadFile,tipoDocumento,ClaseDocumento.PODER)
		
		render doc as JSON
	}
}
