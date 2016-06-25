package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO;
import mx.amib.sistemas.external.catalogos.service.FiguraService;
import mx.amib.sistemas.external.catalogos.service.FiguraTO;
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NacionalidadTO;
import mx.amib.sistemas.external.catalogos.service.NivelEstudiosTO;
import mx.amib.sistemas.external.catalogos.service.TipoTelefonoTO;
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.*
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.DocumentoSustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO
import mx.amib.sistemas.registro.expediente.controller.CertificacionReposicionAutorizacionController.IndexViewModel;
import mx.amib.sistemas.registro.expediente.service.CertificacionDictamenPrevioService

import org.codehaus.groovy.grails.web.json.JSONArray

class CertificacionDictamenPrevioController {

	CertificacionDictamenPrevioService certificacionDictamenPrevioService
	
	def figuraService
	def sustentanteService
	def certificacionService
	def entidadFinancieraService
	
	def sepomexService
	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def tipoTelefonoService
	
	//Muestra certificaciones en status de "en dictamen"
    def index() {
		render( view:'index', model:[vm:IndexViewModel.getInstance(figuraService)] )
	}
	
	static class IndexViewModel{
		int modoBusqueda = ModoBusqueda.DICTAMEN_PREVIO
		List<FiguraTO> figuras;
		
		private IndexViewModel(){}
		
		public static IndexViewModel getInstance(FiguraService figuraService){
			IndexViewModel vm = new IndexViewModel()
			vm.figuras = figuraService.list()
			return vm
		}
	}
	
	//Muestra datos de expediente a editar de acuerdo al proceso de dictamen
	def create(Long id) {
		CreateViewModel cvm = this.getCreateViewModel(id)
		
		render(view:'create', model: [viewModelInstance:cvm])
	}
	
	private CreateViewModel getCreateViewModel(long id){
		CreateViewModel cvm = new CreateViewModel()
		
		cvm.estadoCivilList = estadoCivilService.list()
		cvm.institucionesList = entidadFinancieraService.obtenerInstituciones()
		cvm.nacionalidadList = nacionalidadService.list()
		cvm.nivelEstudiosList = nivelEstudiosService.list()
		cvm.tipoTelefonoList = tipoTelefonoService.list()
		
		cvm.certificacionInstance = certificacionDictamenPrevioService.obtenerParaEmisionDictamen(id)
		if(cvm.certificacionInstance != null){
			cvm.sustentanteInstance = cvm.certificacionInstance.sustentante
			if(cvm.sustentanteInstance.idSepomex != null){
				cvm.codigoPostal = sepomexService.obtenerCodigoPostalDeIdSepomex(cvm.sustentanteInstance.idSepomex)
				cvm.sepomexJsonList = (sepomexService.obtenerDatosSepomexPorCodigoPostal(cvm.codigoPostal).sort{ it.asentamiento?.nombre } as JSON)
			}
			if(cvm.sustentanteInstance.fechaNacimiento == null){
				println "NULO NULO NULO!!!"
			}
		}
		else{
			println 'HUUUUUULO NULLO'
		}
		
		return cvm
	}
	
	//Envía a autorización 
	def save(SustentanteTO sustentante, CertificacionTO certificacion) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		CertificacionTO originalCert
		SustentanteTO originalSust
		
		//Obtiene los datos
		originalCert = certificacionDictamenPrevioService.obtenerParaEmisionDictamen(certificacion.id)
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
		
		//println (originalSust as JSON)
		
		CertificacionTO certAEmitDict = originalSust.certificaciones.find{ it.id.value == certificacion.id.value }
		certAEmitDict.fechaObtencion = sdf.parse(params.'certificacion.fechaObtencion_day' + '-' + params.'certificacion.fechaObtencion_month' + '-' + params.'certificacion.fechaObtencion_year')
		certAEmitDict.fechaInicio = sdf.parse(params.'certificacion.fechaInicio_day' + '-' + params.'certificacion.fechaInicio_month' + '-' + params.'certificacion.fechaInicio_year')
		certAEmitDict.fechaFin = sdf.parse(params.'certificacion.fechaFin_day' + '-' + params.'certificacion.fechaFin_month' + '-' + params.'certificacion.fechaFin_year')
		
		println(params.'certificacion.fechaEntrega_day' + '-' + params.'certificacion.fechaEntrega_month' + '-' + params.'certificacion.fechaEntrega_year')
		println(params.'certificacion.fechaEnvio_day' + '-' + params.'certificacion.fechaEnvio_month' + '-' + params.'certificacion.fechaEnvio_year')
		certAEmitDict.fechaEntregaRecepcion = sdf.parse(params.'certificacion.fechaEntrega_day' + '-' + params.'certificacion.fechaEntrega_month' + '-' + params.'certificacion.fechaEntrega_year')
		certAEmitDict.fechaEnvioComision = sdf.parse(params.'certificacion.fechaEnvio_day' + '-' + params.'certificacion.fechaEnvio_month' + '-' + params.'certificacion.fechaEnvio_year')
		
		certAEmitDict.statusEntHistorialInforme = certificacion.statusEntHistorialInforme
		certAEmitDict.obsEntHistorialInforme = certificacion.obsEntHistorialInforme
		certAEmitDict.statusEntCartaRec = certificacion.statusEntCartaRec
		certAEmitDict.obsEntCartaRec = certificacion.obsEntCartaRec
		certAEmitDict.statusConstBolVal = certificacion.statusConstBolVal
		certAEmitDict.obsConstBolVal = certificacion.obsConstBolVal
		
		try {
//			println("salvar el dictament previo preview")
//			println("IMPRIME sustentante:")
//			println(sustentante as JSON)
//			println("IMPRIME CERTIFICACION")
//			println(certAEmitDict as JSON)
			
			certificacionDictamenPrevioService.enviarAAutorizacion(sustentante, certAEmitDict)
			flash.successMessage = "La emisión de dictamen de sustentante de \"" + sustentante.nombre + " " + sustentante.primerApellido + "\" ha sido guardado satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar la información, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}
		redirect (action: "index")		
	}
	
	public static class CreateViewModel{
		//Bindeables
		SustentanteTO sustentanteInstance
		CertificacionTO certificacionInstance
		
		//No bindeables
		Collection<InstitucionTO> institucionesList
		Collection<EstadoCivilTO> estadoCivilList
		Collection<NacionalidadTO> nacionalidadList
		Collection<NivelEstudiosTO> nivelEstudiosList
		Collection<TipoTelefonoTO> tipoTelefonoList
		String sepomexJsonList
		
		InstitucionTO institutoInstance
		VarianteFiguraTO varianteFiguraInstance
		
		String codigoPostal
	}
}
