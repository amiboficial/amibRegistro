package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.util.Collection;
import java.util.Date;
import java.util.Map;

import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO;
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
		IndexViewModel ivm = this.getIndexViewModel(params)
		
		render(view:'index', model: [viewModelInstance:ivm])
	}
	
	private IndexViewModel getIndexViewModel(Map params){
		IndexViewModel vm = new IndexViewModel();
		bindData(vm,params)
		
		//Filtra opciones de acuerdo al tipo de busqueda, descarta opciones "no viables"
		if(vm.sort == null || vm.sort == ''||
			(vm.sort != 'id' && vm.sort != 'numeroMatricula' && vm.sort != 'nombre'
			&& vm.sort != 'primerApellido' && vm.sort != 'segundoApellido') )
				vm.sort = "id"
			
		if(vm.order == null || vm.order == '')
			vm.order = "asc"
			
		if(vm.max == null || vm.max <= 0)
			vm.max = 10
			
		if(vm.offset == null || vm.offset <= 0)
			vm.offset = 0
		
		//Por default la busuqeda es del tipo "T" (todos)
		if(vm.fltTB == null || vm.fltTB == '' || (vm.fltTB != 'A' && vm.fltTB != 'M' && vm.fltTB != 'F' && vm.fltTB != 'T'))
			vm.fltTB='T'
	
		if(vm.fltTB == 'M' || vm.fltTB == 'A') vm.fltFol = null
		if(vm.fltTB == 'F' || vm.fltTB == 'A') vm.fltMat = null
			
		if(vm.fltNom == null || vm.fltTB != 'A') vm.fltNom = ""
		if(vm.fltAp1 == null || vm.fltTB != 'A') vm.fltAp1 = ""
		if(vm.fltAp2 == null || vm.fltTB != 'A') vm.fltAp2 = ""
		
		if(vm.fltFig == null || vm.fltTB != 'A') vm.fltFig = -1
		if(vm.fltVFig == null || vm.fltTB != 'A') vm.fltVFig = -1
		
		//Carga listas
		vm.figuraList = figuraService.list()

		if(vm.fltFig != null && vm.fltFig > 0)
			vm.varianteFiguraList = figuraService.get(vm.fltFig).variantes
		vm.variantesFiguraMap = new HashMap<Long,String>()
		vm.figuraList.each{
			def sb = new StringBuilder()
			sb.append("[")
			def variantesIterator = it.variantes.sort{ vf0 -> vf0.nombre }.iterator()
			while(variantesIterator.hasNext()){
				def vf = variantesIterator.next()
				sb.append('{ "id":"'+ vf.id +'" , "nombre":"'+ vf.nombre +'" }')
				if(variantesIterator.hasNext())
					sb.append(',')
			}
			sb.append("]")
			vm.variantesFiguraMap.put(it.id,sb.toString())
		}
		
		//Realiza búsquedas
		if(vm.fltTB == 'T'){
			def rs = certificacionService.findAllEnDictamenPrevio(vm.max, vm.offset, vm.sort, vm.order,
																"","","",-1,-1)
			vm.resultList = rs.list
			vm.count = rs.count
		}
		else if(vm.fltTB == 'M'){
			def rs = certificacionService.findAllEnDictamenPrevioByMatricula(vm.fltMat.value)
			
			vm.resultList = rs.list
			vm.count = rs.count
		}
		else if(vm.fltTB == 'F'){			
			def rs = certificacionService.findAllEnDictamenPrevioByFolio(vm.fltFol.value)
			
			vm.resultList = rs.list
			vm.count = rs.count
		}
		else if(vm.fltTB == 'A'){
			def rs = certificacionService.findAllEnDictamenPrevio(vm.max, vm.offset, vm.sort, vm.order,
						vm.fltNom, vm.fltAp1, vm.fltAp2,vm.fltFig, vm.fltVFig)
			vm.resultList = rs.list
			vm.count = rs.count
		}
		
		return vm
	}
	
	//Muestra datos de expediente a editar de acuerdo al proceso de dictamen
	def create(Long id) {
		CreateViewModel cvm = this.getCreateViewModel(id)
		
		render(view:'create', model: [viewModelInstance:cvm])
	}
	
	private CreateViewModel getCreateViewModel(Long id){
		CreateViewModel cvm = new CreateViewModel()
		
		cvm.institucionesList = entidadFinancieraService.obtenerInstituciones()
		
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
		CertificacionTO certAEmitDict = originalSust.certificaciones.find{ it.id.value == certificacion.id.value }
		certAEmitDict.fechaObtencion = sdf.parse(params.'certificacion.fechaObtencion_day' + '-' + params.'certificacion.fechaObtencion_month' + '-' + params.'certificacion.fechaObtencion_year')
		certAEmitDict.statusEntHistorialInforme = certificacion.statusEntHistorialInforme
		certAEmitDict.obsEntHistorialInforme = certificacion.obsEntHistorialInforme
		certAEmitDict.statusEntCartaRec = certificacion.statusEntCartaRec
		certAEmitDict.obsEntCartaRec = certificacion.obsEntCartaRec
		certAEmitDict.statusConstBolVal = certificacion.statusConstBolVal
		certAEmitDict.obsConstBolVal = certificacion.obsConstBolVal
		
		try {
			certificacionDictamenPrevioService.enviarAAutorizacion(sustentante, certAEmitDict)
			flash.successMessage = "La emisión de dictamen de sustentante de \"" + sustentante.nombre + " " + sustentante.primerApellido + "\" ha sido guardado satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar la información, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}
		redirect (action: "index")		
	}
	
	public static class IndexViewModel{
		//No bindeables
		Collection<VarianteFiguraTO> varianteFiguraList
		Map<Long,String> variantesFiguraMap
		Collection<FiguraTO> figuraList
		
		//Bindeables
		String fltTB //Tipo de Búsqueda 'A',Avanzada;'M',Matricula;'F',Folio(Id);'T',Todos
		Integer fltMat //Matrícula
		Long fltFol //Folio
		String fltNom //Nombre
		String fltAp1 //Primer apellido
		String fltAp2 //Segundo apellido
		Long fltFig //Identificador de figura
		Long fltVFig //Identificador de variante de figura
		
		//De resultado
		//Collection<SustentanteTO> resultList
		Collection<CertificacionTO> resultList
		Integer count
		String sort
		Integer max
		String order
		Integer offset
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
