package mx.amib.sistemas.registro.apoderamiento.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.utils.service.ArchivoTO
import org.codehaus.groovy.grails.web.json.JSONArray

class PoderController {

	def figuraService
	def entidadFinancieraService
	def notarioService
	def sepomexService
	def documentoRepositorioService
	
	def apoderamientoService
	def poderService
	
	def autorizacionService
	def certificacionService
	
    def index() { 
		IndexViewModel ivm = this.getIndexViewModel(params)
		render(view: "index", model: [ viewModelInstance : ivm ])
	}
	
	private IndexViewModel getIndexViewModel(def params){
		IndexViewModel ivm = new IndexViewModel()
		Calendar c = null
		
		ivm.max = Integer.parseInt( params.max ?: '10' )
		ivm.offset = Integer.parseInt( params.offset ?: '0' )
		ivm.sort = params.sort ?: 'id'
		ivm.order = params.order ?: 'asc'
		
		ivm.fne = Integer.parseInt( params.fne ?: '-1' )
		ivm.ffpd_day = Integer.parseInt( params.ffpd_day ?: '-1' )
		ivm.ffpd_month = Integer.parseInt( params.ffpd_month ?: '-1' )
		ivm.ffpd_year = Integer.parseInt( params.ffpd_year ?: '-1' )
		ivm.ffpa_day = Integer.parseInt( params.ffpa_day ?: '-1' )
		ivm.ffpa_month = Integer.parseInt( params.ffpa_month ?: '-1' )
		ivm.ffpa_year = Integer.parseInt( params.ffpa_year ?: '-1' )
		ivm.fgf = Integer.parseInt( params.fgf ?: '-1' )
		ivm.fi = Integer.parseInt( params.fi ?: '-1' )
		
		//setea la fecha con un calendar
		c = Calendar.getInstance()
		if(ivm.ffpd_year > 0){
			c.set(ivm.ffpd_year, ivm.ffpd_month-1, ivm.ffpd_day)
			ivm.ffpd = c.getTime()
		}
		c = Calendar.getInstance()
		if(ivm.ffpa_year > 0){
			c.set(ivm.ffpa_year, ivm.ffpa_month-1, ivm.ffpa_day)
			ivm.ffpa = c.getTime()
		}
		
		//Si hubo un grupo financiero seleccionado
		if(ivm.fgf > 0)
			ivm.institucionList = entidadFinancieraService.obtenerGrupoFinanciero(ivm.fgf).instituciones.sort{ it.nombre }
		ivm.gruposFinancieroList = entidadFinancieraService.obtenerGruposFinancierosVigentes().sort{ it.nombre }
		
		//Filtra parámetros de sort y order fuera de "rango"
		if(ivm.sort != 'id' && ivm.sort != 'numeroEscritura' && ivm.sort != 'fechaApoderamiento' && 
			ivm.sort != 'representanteLegalNombre' && ivm.sort != 'representanteLegalApellido1' &&
			ivm.sort != 'representanteLegalApellido2' ){
			ivm.sort = 'id'
		}
		if(ivm.order != "asc" && ivm.order != "desc"){
			ivm.order = 'asc'
		}
		
		def res = poderService.findAllBy(ivm.max, ivm.offset, ivm.sort, ivm.order, ivm.fne, 
													ivm.ffpd_day, ivm.ffpd_month, ivm.ffpd_year,
													ivm.ffpa_day, ivm.ffpa_month, ivm.ffpa_year, 
													ivm.fgf, ivm.fi)
		ivm.poderResults = res.list
		ivm.count = res.count
		//Obtiene los notarios
		//TODO: hacer un metodo getAll para obtner notarios de una sola llamada
		ivm.notariosMap = new TreeMap<Long,NotarioTO>();
		ivm.poderResults.each { x ->
			NotarioTO n = notarioService.get(x.idNotario)
			if(n.id>0){
				ivm.notariosMap.put(n.id, n)
			}
		}
		
		return ivm
	}
	
	def show(Long id){ 
		ShowViewModel svm = null
		
		if(id != null && id > 0)
			svm = this.getShowViewModel(id)
			
		render(view:'show', model: [viewModelInstance:svm])
	}
	
	private ShowViewModel getShowViewModel(Long idPoder){
		ShowViewModel svm = new ShowViewModel()
		svm.poder = poderService.get(idPoder)
		svm.notario = notarioService.get(svm.poder.idNotario)
		svm.certificacionesApoderados = certificacionService.getAll( svm.poder.apoderados.collect{it.idCertificacion} ).sort{ it.sustentante.numeroMatricula }
		//println "EL UUID ES: " + svm.poder.uuidDocumentoRespaldo
		svm.documentoRespaldo = documentoRepositorioService.obtenerMetadatosDocumento(svm.poder.uuidDocumentoRespaldo)
		//println "METADATOS DEL DOCUMENTOS: " + (svm.documentoRespaldo as JSON)
		svm.grupoFinanciero = entidadFinancieraService.obtenerGrupoFinanciero(svm.poder.idGrupoFinanciero)
		svm.institucion = entidadFinancieraService.obtenerInstitucion(svm.poder.idInstitucion)
		return svm
	}
	
	def create() { 
		CreateViewModel cvm = this.getCreateViewModel()
		render(view:'create', model: [viewModelInstance:cvm]) 
	}
	
	private CreateViewModel getCreateViewModel(){
		CreateViewModel cvm = new CreateViewModel()
		
		cvm.poderInstance = new PoderTO()
		cvm.archivoDocumentoRespaldo = new ArchivoTO()
		cvm.notario = new NotarioTO()
		cvm.entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		cvm.figuraList = figuraService.list()
		cvm.gruposFinancieroList = entidadFinancieraService.obtenerGruposFinancierosVigentes()
		cvm.institucionList = new ArrayList<InstitucionTO>()
				
		return cvm
	}
	
	def edit() {
		
	}
	
	def editAgregarApoderados(){
		
	}
	
	def editQuitarApoderados(){
		
	}
	
	def save(PoderTO poder){
		
		//Seteo de fechas en poder
		Calendar c = Calendar.getInstance()
		int faDay = Integer.parseInt(params.'poder.fechaApoderamiento_day')
		int faMonth = Integer.parseInt(params.'poder.fechaApoderamiento_month') - 0
		int faYear = Integer.parseInt(params.'poder.fechaApoderamiento_year')
		c.set(faYear,faMonth,faDay);
		poder.fechaApoderamiento = c.getTime()
		
		//Recuperacion de datos de apoderados a traves de un JSON
		List<ApoderadoTO> apoderadosList = new ArrayList()
		String apoderadosStrJson = params.'apoderados.json'
		def apoderadosJson = JSON.parse(apoderadosStrJson)
		if(apoderadosJson != null && apoderadosJson instanceof JSONArray){
			apoderadosJson.each { x ->
				ApoderadoTO apoderado = new ApoderadoTO()
				apoderado.idCertificacion = x.'idCertificacion'
				apoderado.idPoder = x.'idPoder'
				apoderadosList.add(apoderado)
			}
		}
		poder.apoderados = apoderadosList
		/*
		def listIdCerts = poder.apoderados.collect{ it.idCertificacion }
		autorizacionService.apoderar(listIdCerts)
		
		render poder as JSON*/
		
		try{	
			poder = apoderamientoService.altaPoder(poder)
			flash.successMessage = "El poder con el número de escritura " + poder.numeroEscritura + " ha sido dado de alta [ID:" + poder.id + "]"
		}
		catch(Exception e){
			e.printStackTrace()
			flash.errorMessage = "Ha ocurrido un error al dar de alta el poder"
		}
		
		redirect (action: "index")
	}
		
	def getNotario(){
		def res = null
		long idEntidadFederativa = -1L
		int numeroNotaria = -1
		
		try{
			idEntidadFederativa = Long.parseLong(params.'idEntidadFederativa'?:"-1")
			numeroNotaria = Integer.parseInt(params.'numeroNotaria'?:"-1")
			res = [ 'status':'OK', 'object': notarioService.findAllBy(25,0,"desc","nombreCompleto",idEntidadFederativa,numeroNotaria,"") ]
		}
		catch(Exception ex) {
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render res as JSON
	}
	
	def getInstituciones(){
		def res = null
		long idGrupoFinanciero = -1L
		
		try{
			idGrupoFinanciero = Long.parseLong(params.'idGrupoFinanciero'?:"-1")
			res = [ 'status':'OK', 'object': entidadFinancieraService.obtenerGrupoFinanciero(idGrupoFinanciero).instituciones.sort{ it.nombre } ]
		}
		catch(Exception ex) {
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render res as JSON
	}
	
	def getApoderable(){
		int numeroMatricula = -1
		int idGrupoFinanciero = -1
		def res = null
		SustentanteTO sustentanteApoderable = null
		
		try{
			numeroMatricula = Integer.parseInt(params.'numeroMatricula'?:"-1")
			idGrupoFinanciero = Integer.parseInt(params.'idGrupoFinanciero'?:"-1")
			if(idGrupoFinanciero != null && idGrupoFinanciero > 0){
			sustentanteApoderable = apoderamientoService.obtenerApoderableInstitucion(numeroMatricula,idGrupoFinanciero)
			}
			else{
			sustentanteApoderable = apoderamientoService.obtenerApoderable(numeroMatricula)
			}
			if(sustentanteApoderable != null){
			println("sustentanteApoderable" )
			println(sustentanteApoderable as JSON)
			}
			//bloque de codigo para determinar el nombre de la institucion a la que pertenece actualmente
			def puestoActual
			if(sustentanteApoderable != null && sustentanteApoderable.puestos != null && !sustentanteApoderable.puestos.isEmpty()){
				puestoActual = sustentanteApoderable.puestos.find{ it.esActual }
			}
			String institucionActual = ""
			if(puestoActual!= null && puestoActual.idInstitucion != null && puestoActual.idInstitucion > 0L){
				def inst = entidadFinancieraService.obtenerInstitucion(puestoActual.idInstitucion)
				institucionActual = inst.nombre
			}
			//end
			if(sustentanteApoderable == null){
				res = [ 'status': 'NOT_FOUND' ]
			}
			else{
				res = [ 'status': 'OK', 'object': [ 'sustentante': sustentanteApoderable,'certificacion':sustentanteApoderable.certificaciones.last(), 'institucion':institucionActual ] ]
			}
		}
		catch(Exception ex) {
			ex.printStackTrace()	
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render res as JSON
	}
	
	def isNumeroEscrituraAvailable(){
		int numeroEscritura = -1
		boolean resultado
		def responseObj = null
		
		try{
			numeroEscritura = Integer.parseInt(params.'numeroEscritura'?:"-1")
			resultado = poderService.isNumeroEscrituraAvailable(numeroEscritura)
			if(resultado == true){
				responseObj = [ 'status': 'OK', 'object': [ 'isNumeroEscrituraAvailable': true ] ]
			}
			else{
				responseObj = [ 'status': 'OK', 'object': [ 'isNumeroEscrituraAvailable': false ] ]
			}
		}
		catch(Exception ex) {
			responseObj = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render responseObj as JSON
	}
}

class IndexViewModel{
	Integer max
	Integer offset
	String sort
	String order
	Integer count
	
	//filtros empleados en los parametros
	Integer fne //numero de escritura
	Integer ffpd_day //fecha de apoderamiento del (dia)
	Integer ffpd_month //fecha de apoderamiento del (mes)
	Integer ffpd_year //fecha de apoderamiento del (año)
	Integer ffpa_day //fecha de apoderamiento al (dia)
	Integer ffpa_month //fecha de apoderamiento al (mes)
	Integer ffpa_year //fecha de apoderamiento al (año)
	Long fgf //grupo financiero
	Long fi //institucion
	
	Date ffpd
	Date ffpa
	
	Collection<InstitucionTO> institucionList
	Collection<GrupoFinancieroTO> gruposFinancieroList
	
	Collection<PoderTO> poderResults
	Map<Long,NotarioTO> notariosMap
}

class CreateViewModel{
	PoderTO poderInstance
	
	ArchivoTO archivoDocumentoRespaldo
	boolean validDocumentosCargados
	NotarioTO notario
	Collection<EntidadFederativaTO> entidadFederativaList 
	Collection<FiguraTO> figuraList
	Collection<GrupoFinancieroTO> gruposFinancieroList
	Collection<InstitucionTO> institucionList
}

class ShowViewModel{
	PoderTO poder
	NotarioTO notario
	Collection<CertificacionTO> certificacionesApoderados
	DocumentoRepositorioTO documentoRespaldo
	GrupoFinancieroTO grupoFinanciero
	InstitucionTO institucion
}


