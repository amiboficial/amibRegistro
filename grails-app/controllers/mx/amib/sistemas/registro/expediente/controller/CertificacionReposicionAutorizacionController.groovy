package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.util.Collection;
import java.util.List;

import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.EstadoCivilService;
import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO;
import mx.amib.sistemas.external.catalogos.service.FiguraService;
import mx.amib.sistemas.external.catalogos.service.FiguraTO;
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
import mx.amib.sistemas.registro.expediente.controller.CertificacionActualizacionAutorizacionController.CreateViewModel;
import mx.amib.sistemas.registro.expediente.controller.CertificacionActualizacionAutorizacionController.IndexViewModel;
import mx.amib.sistemas.registro.expediente.service.CertificacionActualizacionAutorizacionService;
import mx.amib.sistemas.registro.expediente.service.CertificacionReposicionAutorizacionService
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO;
import mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService;

import org.codehaus.groovy.grails.web.json.JSONArray

import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodosValidacionTypes

class CertificacionReposicionAutorizacionController {

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
	
	CertificacionReposicionAutorizacionService certificacionReposicionAutorizacionService
	
	CertificacionActualizacionAutorizacionService certificacionActualizacionAutorizacionService
	
    def index() {
		render( view:'index', model:[vm:IndexViewModel.getInstance(figuraService)] )
	}
	
	static class IndexViewModel{
		int modoBusqueda = ModoBusqueda.REPOSICION_AUTORIZACION
		List<FiguraTO> figuras;
		
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
			figuraService
			, certificacionActualizacionAutorizacionService)]  )
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
		String PFIResult
		
		public static CreateViewModel getInstance(long idCertificacion, CertificacionService certificacionService, EntidadFinancieraService entidadFinancieraService,
			EstadoCivilService estadoCivilService, NacionalidadService nacionalidadService, NivelEstudiosService nivelEstudiosService, TipoTelefonoService tipoTelefonoService,
			SepomexService sepomexService, RegistroExamenService registroExamenService, FiguraService figuraService
			, CertificacionActualizacionAutorizacionService certificacionActualizacionAutorizacionService){
		
			CreateViewModel vm = new CreateViewModel()
			
			vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
			vm.estadoCivilList = estadoCivilService.list()
			vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
			vm.nacionalidadList = nacionalidadService.list()
			vm.nivelEstudiosList = nivelEstudiosService.list()
			vm.tipoTelefonoList = tipoTelefonoService.list()
			vm.PFIResult = ""
			
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
			
			try{
				vm.PFIResult = certificacionActualizacionAutorizacionService.getPFIExamns(vm.sustentanteInstance.numeroMatricula)
				}catch(Exception e){
					e.printStackTrace();
				}
			
			return vm
			
		}
	}
	
	def save(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		//Aquí se recuperan datos enviados por la vista y se envían al servicio
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy")
		CertificacionTO originalCert
		SustentanteTO originalSust
		ValidacionTO nuevaValidacion
		EventoPuntosTO nuevoEventoPuntos
		
		//Obtiene los datos
		originalCert = certificacionReposicionAutorizacionService.obtenerParaReposicion(certificacion.id)
		if(originalCert != null){
			originalSust = originalCert.sustentante
		}
		
		if(params.'sustentante.fechaNacimiento_month'!=null && params.'sustentante.fechaNacimiento_month'!="-1"
		&& params.'sustentante.fechaNacimiento_day'!=null && params.'sustentante.fechaNacimiento_day'!="-1"	
		&& params.'sustentante.fechaNacimiento_year'!=null && params.'sustentante.fechaNacimiento_year'!="-1"	){
			if(params.'sustentante.fechaNacimiento_month'!=null && params.'sustentante.fechaNacimiento_month'.toString().length()<2){
				sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-0' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
			}else{
				sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-0' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
			}
		}
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
				if(it.'fechaInicio_month'!=null && it.'fechaInicio_month'!="-1"
					&& it.'fechaInicio_day'!=null && it.'fechaInicio_day'!="-1"
					&& it.'fechaInicio_year'!=null && it.'fechaInicio_year'!="-1"	){
						if(it.'fechaInicio_month'!=null && it.'fechaInicio_month'.toString().length()<2){
							p.fechaInicio = sdf.parse(it.'fechaInicio_day' + '-0' + it.'fechaInicio_month' + '-' + it.'fechaInicio_year')
						}
						else{
							p.fechaInicio = sdf.parse(it.'fechaInicio_day' + '-' + it.'fechaInicio_month' + '-' + it.'fechaInicio_year')
						}
				}
					
				if(	it.'fechaFin_day'!=null && it.'fechaFin_month'!=null && it.'fechaFin_year'!=null &&
					it.'fechaFin_day'.toString() != '-1' && it.'fechaFin_month'.toString() != '-1' && it.'fechaFin_year'.toString() != '-1'){
					if(it.'fechaFin_month'!=null && it.'fechaFin_month'.toString().length()<2){
						p.fechaFin = sdf.parse(it.'fechaFin_day' + '-0' + it.'fechaFin_month' + '-' + it.'fechaFin_year')
					}
					else{
						p.fechaFin = sdf.parse(it.'fechaFin_day' + '-' + it.'fechaFin_month' + '-' + it.'fechaFin_year')
					}
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
		
		println("obtencion fechas")
		println(params.'certificacion.fechaFin_day' + '-' + params.'certificacion.fechaFin_month' + '-' + params.'certificacion.fechaFin_year')
		println(params.'certificacion.fechaInicio_day' + '-' + params.'certificacion.fechaInicio_month' + '-' + params.'certificacion.fechaInicio_year')
		
		
		if(	params.'certificacion.fechaInicio_day'!=null && params.'certificacion.fechaInicio_month'!=null && params.'certificacion.fechaInicio_year'!=null &&
			params.'certificacion.fechaInicio_day'!= '-1' && params.'certificacion.fechaInicio_month'!= '-1' && params.'certificacion.fechaInicio_year'!= '-1'){
				if(params.'certificacion.fechaInicio_month'!=null && params.'certificacion.fechaInicio_month'.toString().length()<2){
					certAEmitDict.fechaInicio = sdf.parse(params.'certificacion.fechaInicio_day' + '-0' + params.'certificacion.fechaInicio_month' + '-' + params.'certificacion.fechaInicio_year')
				}else{
					certAEmitDict.fechaInicio = sdf.parse(params.'certificacion.fechaInicio_day' + '-' + params.'certificacion.fechaInicio_month' + '-' + params.'certificacion.fechaInicio_year')
				}
		}
		if(	params.'certificacion.fechaFin_day'!=null && params.'certificacion.fechaFin_month'!=null && params.'certificacion.fechaFin_year'!=null &&
			params.'certificacion.fechaFin_day'!= '-1' && params.'certificacion.fechaFin_month'!= '-1' && params.'certificacion.fechaFin_year'!= '-1'){
				if(params.'certificacion.fechaFin_month'!=null && params.'certificacion.fechaFin_month'.toString().length()<2){
					certAEmitDict.fechaFin = sdf.parse(params.'certificacion.fechaFin_day' + '-0' + params.'certificacion.fechaFin_month' + '-' + params.'certificacion.fechaFin_year')
				}else{
					certAEmitDict.fechaFin = sdf.parse(params.'certificacion.fechaFin_day' + '-' + params.'certificacion.fechaFin_month' + '-' + params.'certificacion.fechaFin_year')
				}
		}
		certAEmitDict.statusEntHistorialInforme = certificacion.statusEntHistorialInforme
		certAEmitDict.obsEntHistorialInforme = certificacion.obsEntHistorialInforme
		certAEmitDict.statusEntCartaRec = certificacion.statusEntCartaRec
		certAEmitDict.obsEntCartaRec = certificacion.obsEntCartaRec
		certAEmitDict.statusConstBolVal = certificacion.statusConstBolVal
		certAEmitDict.obsConstBolVal = certificacion.obsConstBolVal
		
		nuevaValidacion = new ValidacionTO()
		//nuevaValidacion = validacion.
		if(certAEmitDict!= null && certAEmitDict.fechaInicio!= null &&  certAEmitDict.fechaFin!= null ){
			nuevaValidacion.fechaInicio = certAEmitDict.fechaInicio
			nuevaValidacion.fechaFin = certAEmitDict.fechaFin
		}else{
			nuevaValidacion.fechaInicio = new Date()
			nuevaValidacion.fechaFin = new Date()
		}
		nuevaValidacion.autorizadoPorUsuario = validacion.autorizadoPorUsuario
		
		nuevaValidacion.idMetodoValidacion = validacion.idMetodoValidacion
		
		if(nuevaValidacion.idMetodoValidacion == MetodosValidacionTypes.EXAMEN){
			//Aquí introduce el id de reservación del exámen ocupado 
			//idExamenReservacion -> validacion.idExamenReservacion
			nuevaValidacion.fechaAplicacion = new Date(Long.parseLong(params.'validacion.fechaAplicacionExamenUnixEpoch'.toString())*1000)
			
			//asigna la figura asociada al examen
			Collection<RegistroExamenTO> examents = registroExamenService.findAllRevalidableByNumeroMatricula( sustentante.numeroMatricula )
			RegistroExamenTO exacto = examents.find{it.idExamenReservacion.value.toString() == params.'validacion.idExamenReservacion'}
			certAEmitDict.idVarianteFigura = exacto.idFigura
			
		}
		else if(nuevaValidacion.idMetodoValidacion == MetodosValidacionTypes.PUNTOS){
			//Aquí añadirá los puntos de acuerdo a los eventos enviados
			nuevoEventoPuntos = new EventoPuntosTO()
			nuevoEventoPuntos.puntaje = Integer.parseInt(params.'validacion.puntaje'.toString())
			
			validacion = nuevaValidacion
			
			nuevaValidacion.eventosPuntos = new ArrayList<EventoPuntosTO>()
			nuevaValidacion.eventosPuntos.add(nuevoEventoPuntos)
			
			nuevaValidacion.fechaAplicacion = new Date()
		}else{
			nuevaValidacion.fechaAplicacion = new Date()
		}
		
		try {
			certificacionReposicionAutorizacionService.reponerAutorizacion(sustentante, certAEmitDict, nuevaValidacion)
			flash.successMessage = "La reposición de la autorización para el sustentante  \"" + sustentante.nombre + " " + sustentante.primerApellido + "\" ha sido guardado satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar la información, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}
		redirect (action: "index")
	}
}
