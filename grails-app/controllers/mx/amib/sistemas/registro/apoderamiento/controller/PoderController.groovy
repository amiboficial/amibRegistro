package mx.amib.sistemas.registro.apoderamiento.controller

import static org.springframework.http.HttpStatus.*

import java.util.Collection;
import java.util.List;

import mx.amib.sistemas.registro.apoderado.service.ApoderadoService
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO
import mx.amib.sistemas.registro.apoderado.service.AutorizacionCnbvTO;
import mx.amib.sistemas.registro.apoderado.service.DocumentoRespaldoPoderTO
import mx.amib.sistemas.registro.apoderamiento.model.Poder
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.documentos.service.ClaseDocumento
import mx.amib.sistemas.registro.notario.service.NotarioV1Service
import mx.amib.sistemas.registro.apoderado.service.PoderService
import mx.amib.sistemas.util.service.*

import org.codehaus.groovy.grails.web.json.JSONObject
import org.junit.After
import org.springframework.web.multipart.commons.CommonsMultipartFile

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PoderController {

    static allowedMethods = [save: "POST", update: "PUT", delete: ["DELETE","GET"]]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	ApoderadoService apoderadoService
	ArchivoTemporalService archivoTemporalService
	DocumentoRepositorioService documentoRepositorioService
	SepomexService sepomexService
	NotarioV1Service notarioV1Service
	PoderService poderService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		params.offset = params.offset?:0
		
		params.fltNumEsc = params.fltNumEsc?:'-1'
		
		params.fltFecIni_day = (params.fltFecIni_day==null || params.fltFecIni_day=='null')?'-1':params.fltFecIni_day
		params.fltFecIni_month = (params.fltFecIni_month==null || params.fltFecIni_month=='null')?'-1':params.fltFecIni_month
		params.fltFecIni_year = (params.fltFecIni_year==null || params.fltFecIni_year=='null')?'-1':params.fltFecIni_year
		params.fltFecFn_day = (params.fltFecFn_day==null || params.fltFecFn_day=='null')?'-1':params.fltFecFn_day
		params.fltFecFn_month = (params.fltFecFn_month==null || params.fltFecFn_month=='null')?'-1':params.fltFecFn_month
		params.fltFecFn_year = (params.fltFecFn_year==null || params.fltFecFn_year=='null')?'-1':params.fltFecFn_year
		params.filterIdGrupoFinanciero = params.filterIdGrupoFinanciero?:'-1'
		params.filterIdInstitucion = params.filterIdInstitucion?:'-1'
		params.fltNoVerificado = (params.fltNoVerificado==null||params.fltNoVerificado=='false')?false:true
		params.fltNoAprobado = (params.fltNoAprobado==null||params.fltNoAprobado=='false')?false:true
		
		def result = poderService.search(params.max, params.offset.toInteger(), params.sort, params.order, params.fltNumEsc?.toInteger(),
									params.fltFecIni_day?.toInteger(), params.fltFecIni_month?.toInteger(), params.fltFecIni_year?.toInteger(), 
									params.fltFecFn_day?.toInteger(), params.fltFecFn_month?.toInteger(), params.fltFecFn_year?.toInteger(), 
									params.filterIdGrupoFinanciero?.toLong(), params.filterIdInstitucion?.toLong(),
									params.fltNoVerificado, params.fltNoAprobado)
        respond result.list, model:[poderInstanceCount: result.count, viewModelInstance: this.getIndexViewModel(params)]
    }

	private PoderIndexViewModel getIndexViewModel(def params){
		PoderIndexViewModel pivw = new PoderIndexViewModel()
		pivw.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		pivw.institucionesGpoFinList = entidadFinancieraService.obtenerGrupoFinanciero( params.filterIdGrupoFinanciero?.toLong() )?.instituciones
		
		pivw.fltNumEsc = params.fltNumEsc?.toInteger()
		pivw.fltFecIniDay = params.fltFecIni_day?.toInteger()
		pivw.fltFecIniMonth = params.fltFecIni_month?.toInteger()
		pivw.fltFecIniYear = params.fltFecIni_year?.toInteger()
		pivw.fltFecFnDay = params.fltFecFn_day?.toInteger()
		pivw.fltFecFnMonth = params.fltFecFn_month?.toInteger()
		pivw.fltFecFnYear = params.fltFecFn_year?.toInteger()
		pivw.filterIdGrupoFinanciero = params.filterIdGrupoFinanciero?.toLong()
		pivw.filterIdInstitucion = params.filterIdInstitucion?.toLong()
		pivw.fltNoVerificado = params.fltNoVerificado
		pivw.fltNoAprobado = params.fltNoAprobado
		
		pivw.countPendientes = Poder.findAllByVerificado(false,[cache: true]).size
		
		return pivw
	}
	
	def indexPendientes(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		
		def total = Poder.findAllByVerificado(false,[cache: true]).size
		def result = Poder.findAllByVerificado(false,[max: params.max, sort:'fechaCreacion', order:'desc',offset: params.offset, cache: true])
				
		respond result, model:[poderInstanceCount: total]
	}
	
    def show(Poder poderInstance) {
		//obtiene nombres/descripciones de servicios
		poderInstance.nombreGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(poderInstance.idGrupofinanciero)?.nombre
		poderInstance.nombreInstitucion = entidadFinancieraService.obtenerInstitucion(poderInstance.idInstitucion)?.nombre
		poderInstance.documentosRespaldoPoder.each{
			it.nombreDeArchivo = documentoRepositorioService.obtenerMetadatosDocumento(it.uuidDocumentoRepositorio)?.nombre;
		}
		poderInstance.notario.nombreEntidadFederativa = sepomexService.obtenerEntidadFederativa( poderInstance.notario.idEntidadFederativa ).nombre
        respond poderInstance
    }

	//Este solo estará disponible para el rol de institución o grupo financiero
	def showEntidadFinanciera(Poder poderInstance){
		//obtiene nombres/descripciones de servicios
		poderInstance.nombreGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(poderInstance.idGrupofinanciero)?.nombre
		poderInstance.nombreInstitucion = entidadFinancieraService.obtenerInstitucion(poderInstance.idInstitucion)?.nombre
		poderInstance.documentosRespaldoPoder.each{
			it.nombreDeArchivo = documentoRepositorioService.obtenerMetadatosDocumento(it.uuidDocumentoRepositorio)?.nombre;
		}
		poderInstance.notario.nombreEntidadFederativa = sepomexService.obtenerEntidadFederativa( poderInstance.notario.idEntidadFederativa ).nombre
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
		
        respond new Poder(params), model:[apoderadosList: new ArrayList<ApoderadoTO>(),
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: false,
											action:'create']
    }

	def createAltaGpoFin(){
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
		
		//Obtiene datos del grupo financiero en sesión
		def grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4)
		def institucionesList = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones
		
		respond new Poder(params), model:[grupoFinanciero: grupoFinanciero,
											institucionesList: institucionesList,
											apoderadosList: new ArrayList<ApoderadoTO>(),
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: false,
											action:'createAltaGpoFin']
	}
	
	def createAltaInst(){
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
		
		//Obtiene datos de la institución en sesión
		def grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4)
		def institucion = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones[0]
		
		respond new Poder(params), model:[grupoFinanciero: grupoFinanciero,
											institucion: institucion,
											apoderadosList: new ArrayList<ApoderadoTO>(),
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: false,
											action:'createAltaInst']
	}
	
    @Transactional
    def save(Poder poder) {
		//BINDINGS MANUALES
		//parametros adicionales al modelo
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		def jsonLstApoderadosIdAutorizadoCNBV = params.list('apoderadoIdAutorizadoCNBV')
		def jsonLstDocumentos = params.list('documento')
		def originAction = params.'originAction'
		String destAction = null
		String destCtrl = null
		String msg = null
		
		List<Integer> apoderadosIdAutorizadoCNBV = new ArrayList<Integer>()
		List<DocumentoRespaldoPoderTO> documentos = new ArrayList<DocumentoRespaldoPoderTO>()
		
		//si "deplano" no se recibe el modelo
		if (poder == null) {
			notFound()
			return
		}
		
		//action

		if(originAction == 'createAltaGpoFin'){
			//obtiene el dato del grupo financiero en sesión
			//rellena datos relativos a verificación
			poder.idGrupofinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4).id
			poder.verificado = false
			poder.verificadoPor = null
			poder.aprobado = false
			poder.motivoRechazo = null
			destAction = "index"
			destCtrl = "solicitudes"
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.save.alta.message')
		}
		else if(originAction == 'createAltaInst'){
			//obtiene el dato de la institución en sesión
			//rellena datos relativos a verificación
			poder.idGrupofinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4).id
			poder.idInstitucion = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones[0].id
			poder.verificado = false
			poder.verificadoPor = null
			poder.aprobado = false
			poder.motivoRechazo = null
			destAction = "index"
			destCtrl = "solicitudes"
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.save.alta.message')
		}
		else{
			destAction = "show"
			destCtrl = "poder"
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.save.message', args: [poder.numeroEscritura])
		}
		
		//obtiene de la lista de paramatros con el mismo name="apoderadoIdAutorizadoCNBV"
		jsonLstApoderadosIdAutorizadoCNBV.each{
			apoderadosIdAutorizadoCNBV.add(it)
		}
		//obtiene de la lista de paramatros con el mismo name="documento"
		jsonLstDocumentos.each{
			def documento = JSON.parse(it)
			DocumentoRespaldoPoderTO docTO = new DocumentoRespaldoPoderTO()
			docTO.uuid = documento.'uuid'
			docTO.sessionId = session.id
			docTO.idTipoDocumento = documento.'idTipoDocumento'
			documentos.add(docTO)
		}

		//manda al servicio de guardado
		poderService.save(poder,notarioNumero,notarioIdEntidadFederativa,apoderadosIdAutorizadoCNBV,documentos)

        request.withFormat {
            form multipartForm {
                flash.message = msg
				redirect(controller: destCtrl, action: destAction, id: poder.id)
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
		
        respond poder, model:[entidadFinanciera: entidadFinanciera,
											apoderadosList: apoderadosList,
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: areDocumentosCompletados,
											action:'edit']
    }

	//este método es copia de edit, excepto que el paramtro "action" es diferente
	def editVerify(Poder poder){
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
		
		respond poder, model:[entidadFinanciera: entidadFinanciera,
											apoderadosList: apoderadosList,
											documentosList: documentosList,
											entidadFederativaList: sepomexService.obtenerEntidadesFederativas(),
											gruposFinancierosList: entidadFinancieraService.obtenerGruposFinancierosVigentes(),
											areDocumentosCompletados: areDocumentosCompletados,
											action:'editVerify']
	}
	
    @Transactional
    def update(Poder poder) {
        def mensaje = null
		
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
		def originAction = params.'originAction'
		
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

        //si la accion se trata de una verificación
		if(originAction == "editVerify"){
			poder.verificado = true
			poder.verificadoPor = 'OPERATIVO' //debe tomar el nombre de usuario en sesión que esta verificando
			mensaje = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.update.verify.message')
		}
		else{
			mensaje = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.update.message', args: [poder.numeroEscritura,poder.id])
		}
		
		poder = poderService.update(poder, notarioNumero, notarioIdEntidadFederativa,
			apoderadosIdAutorizadoCNBV, docsActual, docsNuevos)

        request.withFormat {
            form multipartForm {
                flash.message = mensaje
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
        poderService.delete(poderInstance)
		
        request.withFormat {
            '*'{
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'Poder.label', default: 'Poder'), poderInstance.id])
				flash.message = message(code: 'mx.amib.sistemas.registro.apoderamiento.poder.deleted.message', args: [poderInstance.numeroEscritura,poderInstance.id])
                redirect action:"index", method:"GET"
            }
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
			def notario = notarioV1Service.obtenerNotario(strIdEntidadFederativa.toInteger(),strNumeroNotario.toInteger())
			
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

class PoderIndexViewModel {
	Collection<GrupoFinancieroTO> gruposFinancierosList
	InstitucionTO[] institucionesGpoFinList
	
	Integer fltNumEsc
	Integer fltFecIniDay
	Integer fltFecIniMonth
	Integer fltFecIniYear
	Integer fltFecFnDay
	Integer fltFecFnMonth
	Integer fltFecFnYear
	Long filterIdGrupoFinanciero
	Long filterIdInstitucion
	Boolean fltNoVerificado
	Boolean fltNoAprobado

	Long countPendientes
}