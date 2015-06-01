package mx.amib.sistemas.registro.expediente.controller

import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NacionalidadTO
import mx.amib.sistemas.external.catalogos.service.NivelEstudiosTO
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.catalogos.service.TipoTelefonoTO

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.DocumentoSustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO

import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO

import mx.amib.sistemas.utils.CatalogConvertUtils
import org.codehaus.groovy.grails.web.json.JSONArray

import java.text.SimpleDateFormat
import grails.converters.JSON
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class ExpedienteRegistrableController {

	def entidadFinancieraService
	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def figuraService
	def registroExamenService
	def sustentanteService
	def tipoTelefonoService

	def metodoCertificacionService
	def statusAutorizacionService
	def statusCertificacionService

    def index() {
		def viewModelInstance = this.getIndexViewModel(params)
		respond new Object(), model: [viewModelInstance:viewModelInstance]
	}

	private IndexViewModel getIndexViewModel(Map params){
		IndexViewModel vm = new IndexViewModel()

		vm.fltTipoBusqueda = (params.'fltTipoBusqueda'==null)?"":params.'fltTipoBusqueda'
		vm.fltSimpMat = (params.'fltSimpMat'==null||params.'fltSimpMat'=="")?null:params.'fltSimpMat'.toInteger()
		vm.fltAvNombre = (params.'fltAvNombre'==null)?"":params.'fltAvNombre'
		vm.fltAvPrimerApellido = (params.'fltAvPrimerApellido'==null)?"":params.'fltAvPrimerApellido'
		vm.fltAvSegundoApellido = (params.'fltAvSegundoApellido'==null)?"":params.'fltAvSegundoApellido'
		vm.fltAvVarFigura = (params.'fltAvVarFigura'==null||params.'fltAvVarFigura'=="")?-1:params.'fltAvVarFigura'.toLong()

		//SOLO LOS PRIMEROS 25 RESULTADOS SON MOSTRADOS
		if(vm.fltTipoBusqueda == 'S'){ //simple
			vm.searchResults = registroExamenService.findAllRegistrableByNumeroMatricula(vm.fltSimpMat)
		}
		else if(vm.fltTipoBusqueda == 'A'){ //avanzada
			vm.searchResults = registroExamenService.findAllRegistrable(vm.fltAvNombre,vm.fltAvPrimerApellido,vm.fltAvSegundoApellido,vm.fltAvVarFigura)
		}
		else if(vm.fltTipoBusqueda == 'T'){ //mostrar los mas recientes
			vm.searchResults = registroExamenService.findAllRegistrable("","","",null)
		}

		//carga la lista de variantes de figura
		vm.varFiguraList = figuraService.listVariantes().findAll{ it.vigente == true }.sort{ it.nombre }

		return vm
	}

	def create(Integer id) {
		def viewModelInstance = this.getCreateViewModel(id)

		respond new Object(), model:[viewModelInstance:viewModelInstance]
	}

	private CreateViewModel getCreateViewModel(Integer id){
		CreateViewModel cvm = new CreateViewModel()
		if(id != null){
			def res = registroExamenService.findAllRegistrableByNumeroMatricula(id)
			if(res.size() > 0){
				cvm.registroExamenInstance = res.first()
				cvm.institutoInstance = entidadFinancieraService.obtenerInstitucion(4) //<-se obtiene del elemento "registrable"
				cvm.varianteFiguraInstance = figuraService.getVariante(cvm.registroExamenInstance.idFigura) //<-se obtiene del elemento "registrable"
			}
			else{
				cvm.registroExamenInstance = new RegistroExamenTO()
				cvm.registroExamenInstance.numeroMatricula = -1
				cvm.institutoInstance = entidadFinancieraService.obtenerInstitucion(4) //<-se obtiene del elemento "registrable"
				cvm.varianteFiguraInstance = figuraService.getVariante(195) //<-se obtiene del elemento "registrable"
			}
		}
		else{
			cvm.registroExamenInstance = new RegistroExamenTO()
			cvm.registroExamenInstance.numeroMatricula = -1
			cvm.institutoInstance = entidadFinancieraService.obtenerInstitucion(4) //<-se obtiene del elemento "registrable"
			cvm.varianteFiguraInstance = figuraService.getVariante(195) //<-se obtiene del elemento "registrable"
		}
		cvm.estadoCivilList = estadoCivilService.list()
		cvm.institucionesList = entidadFinancieraService.obtenerInstituciones()
		cvm.nacionalidadList = nacionalidadService.list()
		cvm.nivelEstudiosList = nivelEstudiosService.list()
		cvm.tipoTelefonoList = tipoTelefonoService.list()

		return cvm
	}

	def save(SustentanteTO sustentante) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		def telefonosJsonElement = JSON.parse(params.'sustentante.telefonos_json')

		//bindings manuales
		sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
		//sustentante.nacionalidad = CatalogConvertUtils.fromCatalogosToExpediente(nacionalidadService.get(Long.parseLong(params.'sustentante.nacionalidad_id')))
		//sustentante.nivelEstudios = CatalogConvertUtils.fromCatalogosToExpediente(nivelEstudiosService.get(Long.parseLong(params.'sustentante.nivelEstudios_id')))
		//sustentante.estadoCivil = CatalogConvertUtils.fromCatalogosToExpediente(estadoCivilService.get(Long.parseLong(params.'sustentante.estadoCivil_id')))
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		if(telefonosJsonElement != null && telefonosJsonElement instanceof JSONArray){
			def telefonosJsonArray = (JSONArray)telefonosJsonElement
			telefonosJsonArray.each{
				TelefonoSustentanteTO t = new TelefonoSustentanteTO()
				t.lada = it.'lada'
				t.telefono = it.'telefono'
				t.extension = it.'extension'
				t.idTipoTelefonoSustentante = Long.parseLong(it.'idTipoTelefono')
				//t.tipoTelefonoSustentante = CatalogConvertUtils.fromCatalogosToExpediente( tipoTelefonoService.get() )
				sustentante.telefonos.add(t)
			}
		}
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		sustentante.puestos = new ArrayList<PuestoTO>()
		PuestoTO p = new PuestoTO()
		p.idInstitucion = Long.parseLong(params.'registro.idInstitucion')
		p.fechaInicio = sdf.parse(params.'registro.fechaInicio_day' + '-' + params.'registro.fechaInicio_month' + '-' + params.'registro.fechaInicio_year')
		p.fechaFin = null
		p.nombrePuesto = params.'registro.nombrePuesto'
		p.esActual = true
		sustentante.puestos.add(p)
		sustentante.certificaciones = new ArrayList<CertificacionTO>()

		CertificacionTO c = new CertificacionTO()
		c.fechaInicio = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		def fechaFinCalendar = Calendar.getInstance()
		fechaFinCalendar.setTime(c.fechaInicio)
		fechaFinCalendar.add(Calendar.YEAR,3)
		c.fechaFin = fechaFinCalendar.getTime()
		c.fechaObtencion = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		c.nombreUsuarioActualizo = "USUARIO_QUE_ACTUALIZO"
		c.esLaActual = true
		c.fechaUltimoCambioStatusEsLaActual = new Date()
		c.varianteFigura = CatalogConvertUtils.fromCatalogosToExpediente( figuraService.getVariante(Long.parseLong(params.'registro.idVarianteFigura')) ) //TODO: Importar catálogo
		//c.statusAutorizacion = statusAutorizacionService.get(2)
		//c.statusCertificacion = statusCertificacionService.get(2)
		//c.metodoCertificacion = metodoCertificacionService.get(1)
		c.idStatusAutorizacion = 2 //En dictamen previo
		c.idStatusCertificacion = 2 //Certificado
		c.idMetodoCertificacion = 1 //Exámen
		c.fechaCreacion = new Date()
		c.fechaModificacion = new Date()
		sustentante.certificaciones.add(c)

		sustentante.fechaCreacion = new Date()
		sustentante.fechaModificacion = new Date()

		println "Se enviará el siguiente JSON: "
		println (sustentante as JSON)

		//se guarda el sustentante con todos los datos bindeados
		//sustentanteService.guardarNuevo(sustentante)

		respond new Object()
	}

	class IndexViewModel{
		Collection<VarianteFiguraTO> varFiguraList //listado de variantes figuras

		String fltTipoBusqueda //'S' simple -'A' avanzada - 'T' los mas recientes
		Integer fltSimpMat
		String fltAvNombre
		String fltAvPrimerApellido
		String fltAvSegundoApellido
		Long fltAvVarFigura //id de variante figura

		Collection<RegistroExamenTO> searchResults = new ArrayList<RegistroExamenTO>()
	}

	class CreateViewModel{
		RegistroExamenTO registroExamenInstance

		Collection<EstadoCivilTO> estadoCivilList
		Collection<InstitucionTO> institucionesList
		Collection<NacionalidadTO> nacionalidadList
		Collection<NivelEstudiosTO> nivelEstudiosList
		Collection<TipoTelefonoTO> tipoTelefonoList
		InstitucionTO institutoInstance
		VarianteFiguraTO varianteFiguraInstance
	}
}