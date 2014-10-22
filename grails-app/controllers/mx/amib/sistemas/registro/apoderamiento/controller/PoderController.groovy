package mx.amib.sistemas.registro.apoderamiento.controller

import static org.springframework.http.HttpStatus.*

import java.util.List;

import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO
import mx.amib.sistemas.registro.apoderado.service.AutorizacionCnbvTO;
import mx.amib.sistemas.registro.apoderado.service.DocumentoRespaldoPoderTO
import mx.amib.sistemas.registro.apoderamiento.model.Poder
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService;
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
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
		def documentosList = new ArrayList<DocumentoRespaldoPoderTO>()
		
		//Inicializa listado de documento con sus respectivos tipos
		def tipoDocumentoList = poderService.obtenerListadoTipoDocumentoRespaldoPoder()
		tipoDocumentoList.each{
			documentosList.add( new DocumentoRespaldoPoderTO([ 
				id: -it.id,
				idTipoDocumento: it.id,
				tipoDocumento: it.descripcion,
			]) )
		}
		
        respond new Poder(params), model:[entidadFinanciera: entidadFinancieraService.obtenerGrupoFinanciero(6),
											apoderadosList: new ArrayList<ApoderadoTO>(),
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: false]
    }

    @Transactional
    def save(Poder poder) {
		//BINDINGS MANUALES
		//parametros adicionales al modelo
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		def _apoderadosIdAutorizadoCNBV = params.list('apoderadoIdAutorizadoCNBV')
		def _documentos = params.list('documento')
		
		List<Integer> apoderadosIdAutorizadoCNBV = new ArrayList<Integer>()
		List<DocumentoRespaldoPoderTO> documentos = new ArrayList<DocumentoRespaldoPoderTO>()
		
		//si "deplano" no se recibe el modelo
		if (poder == null) {
			notFound()
			return
		}
		//obtiene de la lista de paramatros con el mismo name="apoderadoIdAutorizadoCNBV"
		_apoderadosIdAutorizadoCNBV.each{
			apoderadosIdAutorizadoCNBV.add(it)
		}
		//obtiene de la lista de paramatros con el mismo name="documento"
		_documentos.each{
			def documento = JSON.parse(it)
			DocumentoRespaldoPoderTO docTO = new DocumentoRespaldoPoderTO()
			docTO.uuid = documento.'uuid'
			docTO.sessionId = session.id
			docTO.idTipoDocumento = documento.'idTipoDocumento'
			documentos.add(docTO)
		}

		//valida errores del domain
		/*poder.validate()
        if (poder.hasErrors()) {
			poder.errors.allErrors.each { println it }
            respond poder.errors, view:'create'
            return
        }*/
		//manda al servicio de guardado
		poderService.save(poder)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), poder.id])
                redirect poder
            }
            '*' { respond poder, [status: CREATED] }
        }
    }

    def edit(Poder poder) {
		//Inicializa listados
		def apoderadosList = new ArrayList<ApoderadoTO>()
		def documentosList = new ArrayList<DocumentoRespaldoPoderTO>()
		def entidadFinanciera = null
		boolean areDocumentosCompletados = true
		
		//Rellena listados con datos actuales dal modelo
		//Inicializa listado de documentos
		def tipoDocumentoList = poderService.obtenerListadoTipoDocumentoRespaldoPoder()
		tipoDocumentoList.each{
			def doc = poder.documentosRespaldoPoder.find{ drp -> drp.tipoDocumentoRespaldoPoder.id == it.id }
			if(doc == null){
				areDocumentosCompletados = false
				documentosList.add( new DocumentoRespaldoPoderTO([
					id: -it.id,
					idTipoDocumento: it.id,
					tipoDocumento: it.descripcion,
					uuid: '',
					nombreArchivo: ''
				]) )
			}
			else{
				documentosList.add( new DocumentoRespaldoPoderTO([
					id: doc.id,
					idTipoDocumento: it.id,
					tipoDocumento: it.descripcion,
					uuid: doc.uuidDocumentoRepositorio,
					nombreArchivo: documentoRepositorioService.obtenerMetadatosDocumento(doc.uuidDocumentoRepositorio).nombre
				]) )
			}
		}
		//Inicializa apoderados
		poder.apoderados.each{
			def apo = new ApoderadoTO()
			apo.numeroMatricula = it.autorizado.numeroMatricula
			apo.nombreCompleto = it.autorizado.nombreCompleto
			apo.autorizacionesCNBV = null
			apo.autorizacionAplicada = new AutorizacionCnbvTO([idAutorizadoCNBV:it.autorizado.id,
																idOficioCNBV:it.autorizado.oficioCNBV.id,
																claveDga:it.autorizado.oficioCNBV.claveDga])
			apoderadosList.add(apo)
		}
		//Inicializa entidad financiera (si esta loggeado como tal)
		if(poder.esRegistradoPorGrupoFinanciero == true)
			entidadFinanciera = entidadFinancieraService.obtenerGrupoFinanciero( poder.idGrupofinanciero )
		else{
			entidadFinanciera = entidadFinancieraService.obtenerInstitucion( poder.idInstitucion )
		}
		
        respond poder, model:[entidadFinanciera: entidadFinanciera,
											apoderadosList: apoderadosList,
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: areDocumentosCompletados]
    }

    @Transactional
    def update(Poder poder) {
        if (poder == null) {
            notFound()
            return
        }

		//BINDINGS MANUALES
		//parametros adicionales al modelo
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		def _apoderadosIdAutorizadoCNBV = params.list('apoderadoIdAutorizadoCNBV')
		def _documentos = params.list('documento')
		
		List<Long> apoderadosIdAutorizadoCNBV = new ArrayList<Long>()
		List<DocumentoRespaldoPoderTO> docsNuevos = new ArrayList<DocumentoRespaldoPoderTO>()
		List<DocumentoRespaldoPoderTO> docsActual = new ArrayList<DocumentoRespaldoPoderTO>()
		
		//obtiene de la lista de paramatros con el mismo name="apoderadoIdAutorizadoCNBV"
		_apoderadosIdAutorizadoCNBV.each{
			apoderadosIdAutorizadoCNBV.add(Long.parseLong(it,10))
		}
		//obtiene de la lista de paramatros con el mismo name="documento"
		_documentos.each{
			def documento = JSON.parse(it)
			DocumentoRespaldoPoderTO docTO = new DocumentoRespaldoPoderTO()
			docTO.uuid = documento.'uuid'
			docTO.sessionId = session.id
			docTO.idTipoDocumento = documento.'idTipoDocumento'
			if(documento.'status' == 'PRECARGADO'){
				docsActual.add(docTO)
			}
			else if(documento.'status' == 'CARGADO'){
				docsNuevos.add(docTO)
			}
		}

        /*if (poder.hasErrors()) {
			println (poder.errors as JSON)
            respond poder.errors, view:'edit'
            return
        }*/
		poder = poderService.update(poder, notarioNumero, notarioIdEntidadFederativa,
			apoderadosIdAutorizadoCNBV, docsActual, docsNuevos)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Poder.label', default: 'Poder'), poder.id])
                redirect poder
            }
            '*'{ respond poder, [status: OK] }
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
	
	//obtiene instituciones dado un id de grupo financiero
	def obtenerInstituciones(long id){
		def gp = entidadFinancieraService.obtenerGrupoFinanciero(id)
		def instituciones = gp.instituciones
		render instituciones as grails.converters.deep.JSON
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
	
	def descargar(){
		String documentoUuid = params.'uuid'
		DocumentoRepositorioTO drt = documentoRepositorioService.descargarATemporal(session.id, documentoUuid)
		
		if(drt != null){
			ArchivoTO fileDocumento = archivoTemporalService.obtenerArchivoTemporal(documentoUuid)
			if(fileDocumento == null){
				response.sendError(404)
				return
			}
			else{
				File f = new File(fileDocumento.temploc)
				if (f.exists()) {
					response.setContentType(fileDocumento.mimetype)
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
		else{
			response.sendError(404)
			return
		}
	}
	
	def descargarCargado(){
		String documentoUuid = params.'uuid'		
		ArchivoTO fileDocumento = archivoTemporalService.obtenerArchivoTemporal(documentoUuid)
		
		if(fileDocumento == null){
			response.sendError(404)
			return
		}
		else{
			File f = new File(fileDocumento.temploc)
			if (f.exists()) {
				response.setContentType(fileDocumento.mimetype)
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
