package mx.amib.sistemas.registro.apoderamiento.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NotarioTO
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
	
	def apoderamientoService
	
    def index() { 
		
	}
	
	def show(){ 
		
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
		
		try{
			apoderamientoService.altaPoder(poder)
			flash.successMessage = "El poder ha sido dado de alta"
		}
		catch(Exception e){
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
		def res = null
		SustentanteTO sustentanteApoderable = null
		
		try{
			numeroMatricula = Integer.parseInt(params.'numeroMatricula'?:"-1")
			sustentanteApoderable = apoderamientoService.obtenerApoderable(numeroMatricula)
			if(sustentanteApoderable == null){
				res = [ 'status': 'NOT_FOUND' ]
			}
			else{
				res = [ 'status': 'OK', 'object': [ 'sustentante': sustentanteApoderable,'certificacion':sustentanteApoderable.certificaciones.last() ] ]
			}
		}
		catch(Exception ex) {
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render res as JSON
	}
	
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
