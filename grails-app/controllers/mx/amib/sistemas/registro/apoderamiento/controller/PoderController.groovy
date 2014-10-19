package mx.amib.sistemas.registro.apoderamiento.controller

import static org.springframework.http.HttpStatus.*
import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO
import mx.amib.sistemas.registro.apoderado.service.DocumentoRespaldoPoderTO
import mx.amib.sistemas.registro.apoderamiento.model.Poder
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService;
import mx.amib.sistemas.registro.notario.service.NotarioService
import mx.amib.sistemas.registro.apoderado.service.PoderService
import mx.amib.sistemas.util.service.*

import org.codehaus.groovy.grails.web.json.JSONObject
import org.junit.After
import org.springframework.web.multipart.commons.CommonsMultipartFile

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PoderController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	ApoderadoService apoderadoService
	ArchivoTemporalService archivoTemporalService
	DocumentoRepositorioService documentoRepositorioService
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
		//Inicializa listados
		def apoderadosList = new ArrayList<ApoderadoTO>()
		def documentosList = new ArrayList<DocumentoRespaldoPoderTO>()
		def tipoDocumentoList = poderService.obtenerListadoTipoDocumentoRespaldoPoder()
		
		//Inicializa listado de tipos documento
		tipoDocumentoList.each{
			documentosList.add( new DocumentoRespaldoPoderTO([ 
				id: -it.id,
				idTipoDocumento: it.id,
				tipoDocumento: it.descripcion,
			]) )
		}
		
        respond new Poder(params), model:[entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											entidadFinancieraInstance: entidadFinancieraService.obtenerGrupoFinanciero(6),
											apoderadosListInstance: apoderadosList,
											documentosListInstance: documentosList
											]
    }

    @Transactional
    def save(Poder poder) {
		
		Poder poderInstance = poder
		
		//parametros adicionales al modelo
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		def _apoderadosIdAutorizadoCNBV = params.list('apoderadoIdAutorizadoCNBV')
		def _documentos = params.list('documento')
		
		List<Integer> apoderadosIdAutorizadoCNBV = new ArrayList<Integer>()
		List<DocumentoRespaldoPoderTO> documentos = new ArrayList<DocumentoRespaldoPoderTO>()
		
		//si "deplano" no se recibe el modelo
		if (poderInstance == null) {
			notFound()
			return
		}
		
		_apoderadosIdAutorizadoCNBV.each{
			apoderadosIdAutorizadoCNBV.add(it)
		}
		
		_documentos.each{
			def documento = JSON.parse(it)
			DocumentoRespaldoPoderTO docTO = new DocumentoRespaldoPoderTO()
			docTO.uuid = documento.'uuid'
			docTO.sessionId = session.id
			docTO.idTipoDocumento = documento.'idTipoDocumento'
			documentos.add(docTO)
		}
		
		//adapta los parametros recibidos al modelo
		poderInstance = poderService.buildFromParamsToSave(poderInstance, notarioNumero, notarioIdEntidadFederativa, 
															apoderadosIdAutorizadoCNBV, documentos)
		
		//valida errores del domain
		poderInstance.validate()
        if (poderInstance.hasErrors()) {
			poderInstance.errors.allErrors.each { println it }
            respond poderInstance.errors, view:'create'
            return
        }
		//valida errores en el negocio
		//validateBusinessIntegrity(poderInstance)
		
		//manda al servicio de guardado
		poderService.save(poderInstance)
        //poderInstance.save flush:true

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
		String uuidAnterior = params.'uuidAnterior'
		
		ArchivoTO archivo = null
		
		archivo = archivoTemporalService.guardarArchivoTemporal(session.id, uploadFile)
		archivoTemporalService.eliminarArchivoTemporal(uuidAnterior)
		
		//se elimina el contenido de estos parametros por motivos de seguridad
		ArchivoTO archivoToRender = archivo.clone()
		archivoToRender.temploc = null
		archivoToRender.caducidad = null
		
		render archivoToRender as JSON
	}
	
	def descargarPrecargado(){
		String documentoUuid = params.'uuid'		
		ArchivoTO fileDocumento = archivoTemporalService.obtenerArchivoTemporal(documentoUuid)
		
		if(fileDocumento == null){
			response.sendError(404)
			return
		}
		else{
			File f = new File(fileDocumento.temploc)
			if (f.exists()) {
				response.setContentType(f.mimeType)
				response.setHeader("Content-disposition", "attachment;filename=\"${fileDocumento.filename}\"")
				response.outputStream << f.bytes
				return
			}
			else {
				response.sendError(404)
				return
			}
		}
	}
}
