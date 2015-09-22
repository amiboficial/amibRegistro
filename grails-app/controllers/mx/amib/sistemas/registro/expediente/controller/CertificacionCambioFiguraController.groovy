package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.util.Collection;
import java.util.List;

import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.EstadoCivilService;
import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO;
import mx.amib.sistemas.external.catalogos.service.FiguraService
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO;
import mx.amib.sistemas.external.catalogos.service.NacionalidadService;
import mx.amib.sistemas.external.catalogos.service.NacionalidadTO;
import mx.amib.sistemas.external.catalogos.service.NivelEstudiosService;
import mx.amib.sistemas.external.catalogos.service.NivelEstudiosTO;
import mx.amib.sistemas.external.catalogos.service.SepomexService;
import mx.amib.sistemas.external.catalogos.service.TipoTelefonoService;
import mx.amib.sistemas.external.catalogos.service.TipoTelefonoTO;
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO;
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO;
import mx.amib.sistemas.external.expediente.certificacion.service.EventoPuntosTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO;
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO;
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO
import mx.amib.sistemas.external.expediente.service.CertificacionService;
import mx.amib.sistemas.external.expediente.service.SustentanteService;
import mx.amib.sistemas.registro.expediente.controller.CertificacionReposicionAutorizacionController.CreateViewModel
import mx.amib.sistemas.registro.expediente.controller.CertificacionReposicionAutorizacionController.IndexViewModel
import mx.amib.sistemas.registro.expediente.service.CertificacionCambioFiguraService
import mx.amib.sistemas.registro.expediente.service.CertificacionReposicionAutorizacionService
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO;
import mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodosValidacionTypes
import org.codehaus.groovy.grails.web.json.JSONArray

class CertificacionCambioFiguraController {

	FiguraService figuraService
	EntidadFinancieraService entidadFinancieraService
	EstadoCivilService estadoCivilService
	NacionalidadService nacionalidadService
	NivelEstudiosService nivelEstudiosService
	TipoTelefonoService tipoTelefonoService
	SepomexService sepomexService
	
	RegistroExamenService registroExamenService
	
	SustentanteService sustentanteService
	CertificacionService certificacionService
	
	CertificacionCambioFiguraService certificacionCambioFiguraService
	
    def index() {
		render( view:'index', model:[vm:IndexViewModel.getInstance(figuraService)] )
	}
	
	static class IndexViewModel{
		int modoBusqueda = ModoBusqueda.CAMBIO_FIGURA
		List<FiguraTO> figuras
		
		private IndexViewModel(){}
		
		public static IndexViewModel getInstance(FiguraService figuraService){
			IndexViewModel vm = new IndexViewModel()
			vm.figuras = figuraService.list()
			return vm
		}
	}
	
	def create(long id){
		render( view:'create', model:[viewModelInstance:CreateViewModel.getInstance(id,certificacionService,entidadFinancieraService,
			estadoCivilService, nacionalidadService, nivelEstudiosService, tipoTelefonoService, sepomexService, registroExamenService,
			figuraService)]  )
	}
	
	static class CreateViewModel{
		//Bindeables
		SustentanteTO sustentanteInstance
		CertificacionTO certificacionInstance
		
		//No bindeables
		Collection<RegistroExamenTO> examanesList
		Collection<VarianteFiguraTO> vfigList
		Collection<InstitucionTO> institucionesList
		Collection<EstadoCivilTO> estadoCivilList
		Collection<NacionalidadTO> nacionalidadList
		Collection<NivelEstudiosTO> nivelEstudiosList
		Collection<TipoTelefonoTO> tipoTelefonoList
		String sepomexJsonList
		
		InstitucionTO institutoInstance
		VarianteFiguraTO varianteFiguraInstance
		
		String codigoPostal
		
		public static CreateViewModel getInstance(long idCertificacion, CertificacionService certificacionService, EntidadFinancieraService entidadFinancieraService,
			EstadoCivilService estadoCivilService, NacionalidadService nacionalidadService, NivelEstudiosService nivelEstudiosService, TipoTelefonoService tipoTelefonoService,
			SepomexService sepomexService, RegistroExamenService registroExamenService, FiguraService figuraService){
		
			CreateViewModel vm = new CreateViewModel()
			
			vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
			vm.estadoCivilList = estadoCivilService.list()
			vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
			vm.nacionalidadList = nacionalidadService.list()
			vm.nivelEstudiosList = nivelEstudiosService.list()
			vm.tipoTelefonoList = tipoTelefonoService.list()
			
			vm.certificacionInstance = certificacionService.get(idCertificacion)
			if(vm.certificacionInstance != null){
				vm.sustentanteInstance = vm.certificacionInstance.sustentante
				if(vm.sustentanteInstance.idSepomex != null){
					vm.codigoPostal = sepomexService.obtenerCodigoPostalDeIdSepomex(vm.sustentanteInstance.idSepomex)
					vm.sepomexJsonList = (sepomexService.obtenerDatosSepomexPorCodigoPostal(vm.codigoPostal).sort{ it.asentamiento?.nombre } as JSON)
				}
				vm.examanesList = registroExamenService.findAllRevalidableByNumeroMatricula( vm.sustentanteInstance.numeroMatricula )
				vm.vfigList = figuraService.listVariantes()
				
			}
			
			return vm
		}
	}
	
	def save(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		//Aquí se recuperan datos enviados por la vista y se envían al servicio
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		CertificacionTO originalCert
		SustentanteTO originalSust
		ValidacionTO nuevaValidacion
		
		//Obtiene los datos
		originalCert = certificacionCambioFiguraService.obtenerParaCambioFigura(certificacion.id)
		if(originalCert != null){
			originalSust = originalCert.sustentante
		}
		
		sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
		
		def telefonosJsonElement = JSON.parse(params.'sustentante.telefonos_json')
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		if(telefonosJsonElement != null && telefonosJsonElement instanceof JSONArray){
			def telefonosJsonArray = (JSONArray)telefonosJsonElement
			telefonosJsonArray.each{
				TelefonoSustentanteTO t = new TelefonoSustentanteTO()
				t.lada = it.'lada'
				t.telefono = it.'telefono'
				t.extension = it.'extension'
				t.idTipoTelefonoSustentante = (Long)it.'idTipoTelefono'
				sustentante.telefonos.add(t)
			}
		}
		
		//sustentante.documentos = originalSust.documentos
		
		def puestosJsonElement = JSON.parse(params.'sustentante.puestos_json')
		sustentante.puestos = new ArrayList<PuestoTO>()
		if(puestosJsonElement != null && puestosJsonElement instanceof JSONArray){
			def puestosJsonArray = (JSONArray)puestosJsonElement
			puestosJsonArray.each{
				PuestoTO p = new PuestoTO()
				if(it.'id'.toString().compareToIgnoreCase("null") == 0)
					p.id = -1
				else
					p.id = Long.parseLong(it.'id'.toString())
				p.idInstitucion = Long.parseLong(it.'idInstitucion'.toString())
				p.fechaInicio = sdf.parse(it.'fechaInicio_day' + '-' + it.'fechaInicio_month' + '-' + it.'fechaInicio_year')
				if(it.'fechaFin_day'.toString() != '-1' && it.'fechaFin_month'.toString() != '-1' && it.'fechaFin_year'.toString() != '-1'){
					p.fechaFin = sdf.parse(it.'fechaFin_day' + '-' + it.'fechaFin_month' + '-' + it.'fechaFin_year')
					p.esActual = false
				}
				else{
					p.fechaFin = null
					p.esActual = true
				}
				p.nombrePuesto = it.'nombrePuesto'
				p.statusEntManifProtesta = Integer.parseInt(it.'statusEntManifProtesta'.toString())
				p.obsEntManifProtesta = it.'obsEntManifProtesta'
				p.statusEntCartaInter = Integer.parseInt(it.'statusEntCartaInter'.toString())
				p.obsEntCartaInter = it.'obsEntCartaInter'
				p.fechaModificacion = new Date()
				p.sustentante = sustentante
				sustentante.puestos.add(p)
			}
		}
		//sustentante.certificaciones = originalSust.certificaciones
		CertificacionTO certAEmitDict = originalSust.certificaciones.find{ it.id.value == certificacion.id.value }
		certAEmitDict.fechaObtencion = sdf.parse(params.'certificacion.fechaObtencion_day' + '-' + params.'certificacion.fechaObtencion_month' + '-' + params.'certificacion.fechaObtencion_year')
		certAEmitDict.fechaInicio = sdf.parse(params.'certificacion.fechaInicio_day' + '-' + params.'certificacion.fechaInicio_month' + '-' + params.'certificacion.fechaInicio_year')
		certAEmitDict.fechaFin = sdf.parse(params.'certificacion.fechaFin_day' + '-' + params.'certificacion.fechaFin_month' + '-' + params.'certificacion.fechaFin_year')
		certAEmitDict.statusEntHistorialInforme = certificacion.statusEntHistorialInforme
		certAEmitDict.obsEntHistorialInforme = certificacion.obsEntHistorialInforme
		certAEmitDict.statusEntCartaRec = certificacion.statusEntCartaRec
		certAEmitDict.obsEntCartaRec = certificacion.obsEntCartaRec
		certAEmitDict.statusConstBolVal = certificacion.statusConstBolVal
		certAEmitDict.obsConstBolVal = certificacion.obsConstBolVal
		
		nuevaValidacion = new ValidacionTO()
		//nuevaValidacion = validacion.
		nuevaValidacion.fechaInicio = certAEmitDict.fechaInicio
		nuevaValidacion.fechaFin = certAEmitDict.fechaFin
		nuevaValidacion.autorizadoPorUsuario = 'CAMBIO_FIGURA'
		
		nuevaValidacion.idMetodoValidacion = MetodosValidacionTypes.EXAMEN
		
		//Aquí introduce el id de reservación del exámen ocupado
		//idExamenReservacion -> validacion.idExamenReservacion
		nuevaValidacion.fechaAplicacion = new Date(Long.parseLong(params.'validacion.fechaAplicacionExamenUnixEpoch'.toString())*1000)
		
		try {
			certificacionCambioFiguraService.hacerCambioFigura(sustentante, certAEmitDict, nuevaValidacion)
			flash.successMessage = "El cambio de figura para el sustentante  \"" + sustentante.nombre + " " + sustentante.primerApellido + "\" ha sido guardado satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar la información, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}
		redirect (action: "index")
	}
}
