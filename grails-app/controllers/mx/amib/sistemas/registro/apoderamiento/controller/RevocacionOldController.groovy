package mx.amib.sistemas.registro.apoderamiento.controller



import static org.springframework.http.HttpStatus.*

import java.util.Collection;

import mx.amib.sistemas.registro.apoderado.service.RevocacionV1Service
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion
import mx.amib.sistemas.registro.notario.service.NotarioV1Service
import grails.converters.JSON
import grails.transaction.Transactional
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO;
import mx.amib.sistemas.external.catalogos.service.InstitucionTO;
import mx.amib.sistemas.external.catalogos.service.SepomexService;
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService
import mx.amib.sistemas.external.expediente.service.SustentanteService

@Transactional(readOnly = true)
class RevocacionOldController {

    static allowedMethods = [save: "POST", update: "PUT", delete: ["DELETE","GET"]]

	//servicios
	EntidadFinancieraService entidadFinancieraService
	SepomexService sepomexService
	SustentanteService sustentanteService
	NotarioV1Service notarioV1Service
	RevocacionV1Service revocacionV1Service
	DocumentoRepositorioService documentoRepositorioService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
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
		
		def result = revocacionV1Service.search(params.max, params.offset, params.sort, params.order, params.fltNumEsc?.toInteger(),
									params.fltFecIni_day?.toInteger(), params.fltFecIni_month?.toInteger(), params.fltFecIni_year?.toInteger(),
									params.fltFecFn_day?.toInteger(), params.fltFecFn_month?.toInteger(), params.fltFecFn_year?.toInteger(),
									params.filterIdGrupoFinanciero?.toLong(), params.filterIdInstitucion?.toLong(),
									params.fltNoVerificado, params.fltNoAprobado)
		respond result.list, model:[revocacionInstanceCount: result.count, viewModelInstance: this.getIndexViewModel(params)]
    }

	private RevocacionIndexViewModel getIndexViewModel(def params){
		RevocacionIndexViewModel rivw = new RevocacionIndexViewModel()
		rivw.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		rivw.institucionesGpoFinList = entidadFinancieraService.obtenerGrupoFinanciero( params.filterIdGrupoFinanciero?.toLong() )?.instituciones
		
		rivw.fltNumEsc = params.fltNumEsc?.toInteger()
		rivw.fltFecIniDay = params.fltFecIni_day?.toInteger()
		rivw.fltFecIniMonth = params.fltFecIni_month?.toInteger()
		rivw.fltFecIniYear = params.fltFecIni_year?.toInteger()
		rivw.fltFecFnDay = params.fltFecFn_day?.toInteger()
		rivw.fltFecFnMonth = params.fltFecFn_month?.toInteger()
		rivw.fltFecFnYear = params.fltFecFn_year?.toInteger()
		rivw.filterIdGrupoFinanciero = params.filterIdGrupoFinanciero?.toLong()
		rivw.filterIdInstitucion = params.filterIdInstitucion?.toLong()
		rivw.fltNoVerificado = params.fltNoVerificado
		rivw.fltNoAprobado = params.fltNoAprobado
		
		rivw.countPendientes = revocacionV1Service.countPendientes()
		
		return rivw
	}
	
	def indexPendientes(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		
		def total = revocacionV1Service.countPendientes()
		def result = Revocacion.findAllByVerificado(false,[max: params.max, sort:'fechaCreacion', order:'asc',offset: params.offset, cache: true])
				
		respond result, model:[revocacionInstanceCount: total]
	}
	
    def show(Revocacion revocacionInstance) {
		revocacionInstance.nombreGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacionInstance.idGrupofinanciero)?.nombre
		revocacionInstance.nombreInstitucion = entidadFinancieraService.obtenerInstitucion(revocacionInstance.idInstitucion)?.nombre
		revocacionInstance.documentosRespaldoRevocacion.each{
			it.nombreDeArchivo = documentoRepositorioService.obtenerMetadatosDocumento(it.uuidDocumentoRepositorio)?.nombre;
		}
		revocacionInstance.notario.nombreEntidadFederativa = sepomexService.obtenerEntidadFederativa( revocacionInstance.notario.idEntidadFederativa ).nombre
        respond revocacionInstance
    }

	def showEntidadFinanciera(Revocacion revocacionInstance) {
		revocacionInstance.nombreGrupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(revocacionInstance.idGrupofinanciero)?.nombre
		revocacionInstance.nombreInstitucion = entidadFinancieraService.obtenerInstitucion(revocacionInstance.idInstitucion)?.nombre
		revocacionInstance.documentosRespaldoRevocacion.each{
			it.nombreDeArchivo = documentoRepositorioService.obtenerMetadatosDocumento(it.uuidDocumentoRepositorio)?.nombre;
		}
		revocacionInstance.notario.nombreEntidadFederativa = sepomexService.obtenerEntidadFederativa( revocacionInstance.notario.idEntidadFederativa ).nombre
		respond revocacionInstance
	}
	
    def create() {
		RevocacionViewModel revocacionViewModel = this.createViewModel()
        respond new Revocacion(params), model:[viewModelInstance: revocacionViewModel]
    }
	
	def createSolGpoFin(){
		RevocacionViewModel revocacionViewModel = this.createSolGpoFinViewModel()
		respond new Revocacion(params), model:[viewModelInstance: revocacionViewModel]
	}
	
	def createSolInst(){
		RevocacionViewModel revocacionViewModel = this.createSolInstViewModel()
		respond new Revocacion(params), model:[viewModelInstance: revocacionViewModel]
	}
	
	private RevocacionViewModel createViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		revocacionViewModel.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = false
		revocacionViewModel.action = "create"
		return revocacionViewModel
	}
	private RevocacionViewModel createSolGpoFinViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		
		//estos atributos se asignarán de acuerdo al usuario en sesión
		revocacionViewModel.grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4)
		revocacionViewModel.institucionesList = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones
		
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = false
		revocacionViewModel.action = "createSolGpoFin"
		return revocacionViewModel
	}
	private RevocacionViewModel createSolInstViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		
		//estos atributos se asignarán de acuerdo al usuario en sesión
		revocacionViewModel.grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4)
		revocacionViewModel.institucion = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones[0]
		
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = false
		revocacionViewModel.action = "createSolInst"
		return revocacionViewModel
	}

    @Transactional
    def save(Revocacion revocacion) {
		def revocacionInstance = revocacion
		def originAction = params.'originAction'
		
		def revocadosToBind = params.list('revocado')
		def documentosToBind = params.list('documento')
		def documentosToEraseStrParam = params.'idsDocumentosBorrados'
		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
        def documentosToErase = null
		
		String destAction = null
		String destCtrl = null
		String msg = null
		
		if(documentosToEraseStrParam != null || documentosToEraseStrParam != ""){
			documentosToErase = documentosToEraseStrParam.split("\\|")
		}
		
		if (revocacionInstance == null) {
            notFound()
            return
        }

		if(originAction == 'createSolGpoFin'){
			//obtiene el dato del grupo financiero en sesión
			//rellena datos relativos a verificación
			revocacionInstance.idGrupofinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4).id
			revocacionInstance.verificado = false
			revocacionInstance.verificadoPor = null
			revocacionInstance.aprobado = false
			revocacionInstance.motivoRechazo = null
			destCtrl = 'solicitudes'
			destAction = 'index'
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.save.alta.message')
		}
		else if(originAction == 'createSolInst'){
			//obtiene el dato de la institución en sesión
			//rellena datos relativos a verificación
			revocacionInstance.idGrupofinanciero = entidadFinancieraService.obtenerGrupoFinanciero(4).id
			revocacionInstance.idInstitucion = entidadFinancieraService.obtenerGrupoFinanciero(4).instituciones[0].id
			revocacionInstance.verificado = false
			revocacionInstance.verificadoPor = null
			revocacionInstance.aprobado = false
			revocacionInstance.motivoRechazo = null
			destCtrl = 'solicitudes'
			destAction = 'index'
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.save.alta.message')
		}
		else{
			destCtrl = 'revocacion'
			destAction = 'show'
			msg = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.save.message', args: [revocacionInstance.numeroEscritura])
		}
		revocacionV1Service.save(revocacionInstance, revocadosToBind, documentosToBind, notarioIdEntidadFederativa, notarioNumero)
		
        request.withFormat {
            form multipartForm {
                flash.message = msg
                redirect(controller: destCtrl, action: destAction, id: revocacionInstance.id)
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
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		revocacionViewModel.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = true
		revocacionViewModel.action = "edit"
		return revocacionViewModel
	}

	def editVerify(Revocacion revocacionInstance) {
		RevocacionViewModel revocacionViewModel = this.editVerifyViewModel()
		revocacionInstance = this.cargaNombresArchivo(revocacionInstance)
		respond revocacionInstance, model:[viewModelInstance: revocacionViewModel]
	}
	
	private RevocacionViewModel editVerifyViewModel(){
		RevocacionViewModel revocacionViewModel = new RevocacionViewModel()
		revocacionViewModel.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		revocacionViewModel.gruposFinancierosList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		revocacionViewModel.tipoDocumentoList = TipoDocumentoRespaldoRevocacion.findAllByVigente(true)
		revocacionViewModel.validDocumentosCargados = true
		revocacionViewModel.action = "editVerify"
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

		def notarioNumero = params.'notarioNumero'.toInteger()
		def notarioIdEntidadFederativa = params.'notarioIdEntidadFederativa'.toInteger()
		
		def originAction = params.'originAction'
		String mensaje = null
		//String destAction = null
		//String destCtrl = null
		
		if (revocacionInstance == null) {
			notFound()
			return
		}
		
		//si la accion se trata de una verificación
		if(originAction == "editVerify"){
			revocacionInstance.verificado = true
			revocacionInstance.verificadoPor = 'OPERATIVO' //debe tomar el nombre de usuario en sesión que esta verificando
			mensaje = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.update.verify.message')
		}
		else{
			mensaje = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.update.message', args: [revocacion.numeroEscritura,revocacion.id])
		}

		revocacionV1Service.update(revocacionInstance, revocadosToBind, documentosToBind, notarioIdEntidadFederativa, notarioNumero)

        request.withFormat {
            form multipartForm {
                flash.message = mensaje
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

        //revocacionInstance.delete flush:true
		revocacionV1Service.delete(revocacionInstance)
		
        request.withFormat {
            '*'{
                flash.message = message(code: 'mx.amib.sistemas.registro.apoderamiento.revocacion.deleted.message', args: [revocacionInstance.numeroEscritura,revocacionInstance.id])
                redirect action:"index", method:"GET"
            }
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
	
	//obtiene instituciones dado un id de grupo financiero
	def obtenerInstituciones(long id){
		def gp = entidadFinancieraService.obtenerGrupoFinanciero(id)
		def instituciones = gp.instituciones
		render instituciones as grails.converters.deep.JSON
	}
}

class RevocacionViewModel {
	GrupoFinancieroTO grupoFinanciero
	InstitucionTO institucion
	
	Collection<EntidadFederativaTO> entidadFederativaList
	Collection<GrupoFinancieroTO> gruposFinancierosList
	Collection<InstitucionTO> institucionesList
	
	Collection<TipoDocumentoRespaldoRevocacion> tipoDocumentoList
	
	boolean validDocumentosCargados
	
	String action
}

class RevocacionIndexViewModel {
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
	
	String action
}