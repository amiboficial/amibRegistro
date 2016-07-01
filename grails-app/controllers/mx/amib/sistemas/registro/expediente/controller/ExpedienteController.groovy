package mx.amib.sistemas.registro.expediente.controller

import java.rmi.dgc.VMID;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat
import java.util.Collection
import java.util.Date;

import org.codehaus.groovy.grails.web.json.JSONObject

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFederativaTO
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService
import mx.amib.sistemas.external.catalogos.service.EstadoCivilTO
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.external.catalogos.service.GrupoFinancieroTO
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.NacionalidadTO
import mx.amib.sistemas.external.catalogos.service.NivelEstudiosTO
import mx.amib.sistemas.external.catalogos.service.NotarioService
import mx.amib.sistemas.external.catalogos.service.NotarioTO
import mx.amib.sistemas.external.catalogos.service.SepomexService
import mx.amib.sistemas.external.catalogos.service.SepomexTO
import mx.amib.sistemas.external.catalogos.service.TipoDocumentoSustentanteService
import mx.amib.sistemas.external.catalogos.service.TipoTelefonoTO
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.documentos.service.DocumentoPoderRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.external.documentos.service.DocumentoSustentanteRepositorioTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.persona.catalog.service.TipoDocumentoTO
import mx.amib.sistemas.external.expediente.persona.service.DocumentoSustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.service.ApoderadoService
import mx.amib.sistemas.external.oficios.service.PoderService
import mx.amib.sistemas.external.oficios.service.RevocacionService
import mx.amib.sistemas.external.oficios.service.RevocadoService
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO
import mx.amib.sistemas.utils.SearchResult

import org.codehaus.groovy.grails.web.json.JSONArray

class ExpedienteController {

	def figuraService
	
	EntidadFinancieraService entidadFinancieraService
	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def tipoTelefonoService
	DocumentoRepositorioService documentoRepositorioService
	TipoDocumentoSustentanteService tipoDocumentoSustentanteService
	
	NotarioService notarioService
	
	def sustentanteService
	def documentoSustentanteService
	def statusAutorizacionService
	def statusCertificacionService
	
	SepomexService sepomexService
	
	PoderService poderService
	ApoderadoService apoderadoService
	RevocadoService revocadoService
	RevocacionService revocacionService
	def oficioCnbvService
	
    def index() {
		IndexViewModel vm = this.getIndexViewModel(params)

		if(vm.fltTB == 'T'){
			def sr = sustentanteService.findAll(vm.max, vm.offset, vm.sort, vm.order)
			vm.resultList = sr.list
			vm.count = sr.count
		}
		else if(vm.fltTB == 'M'){
			
			def result = sustentanteService.findByMatricula(vm.fltMat.value)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			vm.offset = 0
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
			
		}
		else if(vm.fltTB == 'F'){
			def result = sustentanteService.get(vm.fltFol)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
		}
		else if(vm.fltTB == 'A'){
			def sr = null
			if(vm.fltCrt == true)
				sr = sustentanteService.findAllAdvancedSearchWithCertificacion(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.fltFig, vm.fltVFig, vm.fltStCt, vm.fltStAt, vm.max?:10, vm.offset?:0, vm.sort, vm.order)
			else	
				sr = sustentanteService.findAllAdvancedSearch(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.max?:10, vm.offset?:0, vm.sort, vm.order)
			vm.resultList = sr.list
			vm.count = sr.count
		}
		
//		println (vm as JSON)
		
		render(view:'index', model: [viewModelInstance:vm])
	}
	
	def consulta() {
		IndexViewModel vm = this.getIndexViewModel(params)
		
		println ("params")
		println (params as JSON)
		if(vm.fltTB == 'T'){
			def sr = null
			vm.resultList = new ArrayList<SustentanteTO>()
			vm.count = 0
		}
		else if(vm.fltTB == 'M'){
			
			def result = sustentanteService.findByMatricula(vm.fltMat.value)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			vm.offset = 0
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
			
		}
		else if(vm.fltTB == 'F'){
			def result = sustentanteService.get(vm.fltFol)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			if(result == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
		}
		else if(vm.fltTB == 'A'){
			def sr = null
		println ("vm A")
		println "vm.finGroup-->" + vm.finGroup
		println "vm.instFin-->" + vm.instFin
			if(vm.fltCrt == true){
				if(vm.finGroup == -1 && vm.instFin == -1 ){
					println("findAllAdvancedSearchWithCertificacion")
					sr = sustentanteService.findAllAdvancedSearchWithCertificacion(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.fltFig, vm.fltVFig, vm.fltStCt, vm.fltStAt, vm.max?:10, vm.offset?:0, vm.sort, vm.order)
				}else{
					println("findAllAdvancedSearchWithCertificacionAndIns")
					sr = sustentanteService.findAllAdvancedSearchWithCertificacionAndIns(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.fltFig, vm.fltVFig, vm.fltStCt, vm.fltStAt, vm.max?:10, vm.offset?:0, vm.sort, vm.order, vm.finGroup, vm.instFin)
				}
			}else{
				if(vm.finGroup == -1 && vm.instFin == -1 ){
					println("findAllAdvancedSearch")
					sr = sustentanteService.findAllAdvancedSearch(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.max?:10, vm.offset?:0, vm.sort, vm.order)
				}else{
					println("findAllAdvancedSearchAndIns")
					sr = sustentanteService.findAllAdvancedSearchAndIns(vm.fltNom, vm.fltAp1, vm.fltAp2, vm.max?:10, vm.offset?:0, vm.sort, vm.order, vm.finGroup, vm.instFin)
				}
			}
			vm.resultList = sr.list
			vm.count = sr.count
		}
		
		println ("vm after")
		//println (vm as JSON)
		
		
		vm.gfins = entidadFinancieraService.obtenerGruposFinancierosVigentes().sort{ it.nombre }
		
		render(view:'consulta', model: [viewModelInstance:vm])
	}

	private IndexViewModel getIndexViewModel(Map params){
		IndexViewModel vm = new IndexViewModel();
		bindData(vm,params)
		
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
		
		if(vm.fltTB == null || vm.fltTB == '' || (vm.fltTB != 'A' && vm.fltTB != 'M' && vm.fltTB != 'F' && vm.fltTB != 'T'))
			vm.fltTB='T'
	
		if(vm.fltTB == 'M' || vm.fltTB == 'A') vm.fltFol = null
		if(vm.fltTB == 'F' || vm.fltTB == 'A') vm.fltMat = null
			
		if(vm.fltNom == null || vm.fltTB != 'A') vm.fltNom = ""
		if(vm.fltAp1 == null || vm.fltTB != 'A') vm.fltAp1 = "" 
		if(vm.fltAp2 == null || vm.fltTB != 'A') vm.fltAp2 = ""
		
		if(vm.fltCrt == null || vm.fltTB != 'A') vm.fltCrt = true
			
		if(vm.fltFig == null || vm.fltTB != 'A') vm.fltFig = -1 
		if(vm.fltVFig == null || vm.fltTB != 'A') vm.fltVFig = -1
		if(vm.fltStCt == null || vm.fltTB != 'A') vm.fltStCt = -1
		if(vm.fltStAt == null || vm.fltTB != 'A') vm.fltStAt = -1
		
		//Carga listas
		vm.figuraList = figuraService.list()
		vm.statusAutorizacionList = statusAutorizacionService.list()
		vm.statusCertificacionList = statusCertificacionService.list()
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
		return vm
	}
	
	def edit(Long id){
		def s = sustentanteService.get(id)
		FormViewModel vm = this.getFormViewModel(s)
		
		render(view:"edit",model:[viewModelInstance: vm])
	}
	
	def editDoc(Long id){
		EditDocViewModel vm = new EditDocViewModel()
		
		//carga de datos del viewModel
		vm.tipoDocumentoList = tipoDocumentoSustentanteService.list().findAll{ it.vigente == true }.sort{ it.descripcion }
		vm.sustentanteInstance = sustentanteService.get(id)
		vm.documentosRespositorioUuidMap = new HashMap<String,DocumentoRepositorioTO>()
		
		documentoRepositorioService.obtenerTodosPorUuids( vm.sustentanteInstance.documentos.collect{ it.uuid } ).list.each { x -> 
			vm.documentosRespositorioUuidMap.put(x.uuid, x)
		}
		
		render(view:"editDoc",model:[viewModelInstance: vm])
	}
	
	private FormViewModel getFormViewModel(SustentanteTO s){
		FormViewModel vm = new FormViewModel()
		vm.estadoCivilList = estadoCivilService.list()
		vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
		vm.nacionalidadList = nacionalidadService.list()
		vm.nivelEstudiosList = nivelEstudiosService.list()
		vm.tipoTelefonoList = tipoTelefonoService.list()
		vm.sustentanteInstance = s
		if(s.idSepomex != null){
			vm.codigoPostal = sepomexService.obtenerCodigoPostalDeIdSepomex(s.idSepomex)
			vm.sepomexJsonList = (sepomexService.obtenerDatosSepomexPorCodigoPostal(vm.codigoPostal).sort{ it.asentamiento?.nombre } as JSON)
		}
		return vm
	}
	
	def show(Long id){ 
		def s = sustentanteService.get(id)
		ShowViewModel vm = new ShowViewModel()
		
		//CARGA DE DATOS PARA ENTIDADES FEDERATIVAS
		vm.entidadesFederativasMap = new HashMap<Integer,EntidadFederativaTO>()
		sepomexService.obtenerEntidadesFederativas().each{ x ->
			vm.entidadesFederativasMap.put(x.id,x)
		}
		println (vm.entidadesFederativasMap as JSON)
		vm.institucionesPoderesMap = new HashMap<Long,InstitucionTO>()
		entidadFinancieraService.obtenerInstituciones().each { x ->
			vm.institucionesPoderesMap.put(x.id,x)
		}
		
		//se quitan las demas certificaciones para dejar solo la valida 
//		CertificacionTO ultima = s.certificaciones.find{ it.isUltima == true }
//		s.certificaciones.clear()
//		s.certificaciones.add(ultima)
		//
		SearchResult<OficioCnbvTO> servRes = null
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		if(s.certificaciones.size()>0){
			println("certifications ids")
			println(s.certificaciones.collect{it.id})
				Date mostRecent
				s.certificaciones.get(0).validaciones.each{ x ->
					if(mostRecent == null && x.fechaInicio!=null){
						mostRecent = x.fechaInicio
					}else if(x.fechaInicio!=null && x.fechaInicio > mostRecent){
						mostRecent = x.fechaInicio
					}
				}
				println("la validacion mas recienteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"+mostRecent)
				if(mostRecent!=null){
					ValidacionTO lastone =s.certificaciones.get(0).validaciones.find { vali -> vali.fechaInicio == mostRecent }
					s.certificaciones.get(0).validaciones.clear()
					s.certificaciones.get(0).validaciones.add(lastone)
				}
				//obtencion de dga si existe
				s.certificaciones.each{ x ->
					try{
						SearchResult<OficioCnbvTO> resOficios = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, x.collect{ it.id } )
						println("respuestaOFICIOS")
						println(resOficios as JSON)
						servRes = resOficios.getList()
						if(servRes!=null && resOficios.count>0 && servRes.first().claveDga != null){
							x.dga = resOficios.first().claveDga
							x.numeroOficio = resOficios.first().numeroOficio
						}
					}
					catch(Exception ex){
						ex.printStackTrace();
					}
				}
				//END obtencion de dga si existe
		}
		//end de filtro de certificaciones
		//CARGA DE DATOS DEL SUSTENTANTE
		vm.sustentanteInstance = s
		vm.nombreCompleto = s.nombre + " " + s.primerApellido + " " + s.segundoApellido
		if(s.idSepomex != null)
			vm.sepomexData = sepomexService.get(s.idSepomex)
			
			println("vm.sustentanteInstance")
			println(vm.sustentanteInstance as JSON)
		println("vm.sepomexData")
		println(vm.sepomexData as JSON)
		
		//CARGA DE DATOS DE DOCUMENTOS
		vm.documentosRespositorioUuidMap = new HashMap<String,DocumentoRepositorioTO>()
		documentoRepositorioService.obtenerTodosPorUuids( vm.sustentanteInstance.documentos.collect{ it.uuid } ).list.each { x ->
			vm.documentosRespositorioUuidMap.put(x.uuid, x)
		}
		
		//CARGA DE DATOS DE PODER
		def apoderadoResult
		def ultimaCertificacion
		List<ApoderadoTO> apoderaminetosUltimaCertificacion
		Map<Long,Boolean> apoderamientosRevocados
		def ultimoPoderValido = null
		//todos los apoderamientos de todas las certificaciones
		apoderadoResult = apoderadoService.findAllByIdCertificacionIn( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) )
		//obtiene la ultima certificacion
		ultimaCertificacion = vm.sustentanteInstance.certificaciones.find{ it.isUltima == true }
		//obtiene todos los apoderamientos correspondientes a esa ultima certificacion
		apoderaminetosUltimaCertificacion = apoderadoResult.apoderados.findAll{ it.idCertificacion.value == ultimaCertificacion.id.value }
		//obtiene los estatus de revocacion correspondiente a todas los apoderamientos de las certificaiones
		apoderamientosRevocados = revocadoService.containsRevocados( new HashSet<Long>( apoderadoResult.apoderados.collect{ it.id } ) )
		//obtiene el apoderamiento que no ha sido revocado
		apoderaminetosUltimaCertificacion.each{ x ->
			if( apoderamientosRevocados.containsKey( x.id.value ) ){
				if(apoderamientosRevocados.get( x.id.value ) == false){
					ultimoPoderValido = apoderadoResult.poderes.find{ it.id.value == x.idPoder.value }
				}
			}
		}
		if(ultimoPoderValido!=null){
			vm.poderInstance = ultimoPoderValido
			vm.documentoPoderRespaldo = documentoRepositorioService.obtenerMetadatosDocumento( vm.poderInstance.uuidDocumentoRespaldo )
			vm.notarioPoder = notarioService.get( vm.poderInstance.idNotario  )
			vm.entidadFederativaNotarioPoder = sepomexService.obtenerEntidadFederativa( (int)vm.notarioPoder.idEntidadFederativa.value )
			vm.institucionPoder = entidadFinancieraService.obtenerInstitucion( vm.poderInstance.idInstitucion )
		}
		
		//CARGA EL HISTORICO DE LOS PODERES
		vm.historicoPoderes = apoderadoResult.poderes.sort{ it.fechaApoderamiento }.reverse()
		vm.historioRevocaciones = revocacionService.getAllByIdCertficacionInSet( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) ).asList()
		
		render(view:"show",model:[viewModelInstance: vm])
	}
	
	def showless(Long id){
		println "id de showless"+id
		def s = sustentanteService.get(id)
		ShowViewModel vm = new ShowViewModel()
		
		//CARGA DE DATOS PARA ENTIDADES FEDERATIVAS
		vm.entidadesFederativasMap = new HashMap<Integer,EntidadFederativaTO>()
		sepomexService.obtenerEntidadesFederativas().each{ x ->
			vm.entidadesFederativasMap.put(x.id,x)
		}
		println (vm.entidadesFederativasMap as JSON)
		vm.institucionesPoderesMap = new HashMap<Long,InstitucionTO>()
		entidadFinancieraService.obtenerInstituciones().each { x ->
			vm.institucionesPoderesMap.put(x.id,x)
		}
		
		
		//se quitan las demas certificaciones para dejar solo la valida 
//		CertificacionTO ultima = s.certificaciones.find{ it.isUltima == true }
//		s.certificaciones.clear()
//		s.certificaciones.add(ultima)
		//
		SearchResult<OficioCnbvTO> servRes = null
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		if(s.certificaciones.size()>0){
			println("certifications ids")
			println(s.certificaciones.collect{it.id})
				Date mostRecent
				s.certificaciones.get(0).validaciones.each{ x ->
					if(mostRecent == null && x.fechaInicio!=null){
						mostRecent = x.fechaInicio
					}else if(x.fechaInicio!=null && x.fechaInicio > mostRecent){
						mostRecent = x.fechaInicio
					}
				}
				println("la validacion mas recienteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"+mostRecent)
				if(mostRecent!=null){
					ValidacionTO lastone =s.certificaciones.get(0).validaciones.find { vali -> vali.fechaInicio == mostRecent }
					s.certificaciones.get(0).validaciones.clear()
					s.certificaciones.get(0).validaciones.add(lastone)
				}
				//obtencion de dga si existe
				s.certificaciones.each{ x ->
					try{
						SearchResult<OficioCnbvTO> resOficios = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, x.collect{ it.id } )
						println("pendejadas")
						println(resOficios as JSON)
						servRes = resOficios.getList()
						if(servRes!=null&&servRes.first().claveDga != null){
							x.dga = resOficios.first().claveDga
						}
					}
					catch(Exception ex){
						ex.printStackTrace();
					}
				}
				//END obtencion de dga si existe
		}
		//end de filtro de certificaciones
		//CARGA DE DATOS DEL SUSTENTANTE
		vm.sustentanteInstance = s
		
		vm.nombreCompleto = s.nombre + " " + s.primerApellido + " " + s.segundoApellido
		if(s.idSepomex != null)
			vm.sepomexData = sepomexService.get(s.idSepomex)
			
			println("vm.sustentanteInstance")
			println(vm.sustentanteInstance as JSON)
		println("vm.sepomexData")
		println(vm.sepomexData as JSON)
		
		//CARGA DE DATOS DE DOCUMENTOS
		vm.documentosRespositorioUuidMap = new HashMap<String,DocumentoRepositorioTO>()
		documentoRepositorioService.obtenerTodosPorUuids( vm.sustentanteInstance.documentos.collect{ it.uuid } ).list.each { x ->
			vm.documentosRespositorioUuidMap.put(x.uuid, x)
		}
		
		//CARGA DE DATOS DE PODER
		def apoderadoResult
		def ultimaCertificacion
		List<ApoderadoTO> apoderaminetosUltimaCertificacion
		Map<Long,Boolean> apoderamientosRevocados
		def ultimoPoderValido = null
		//todos los apoderamientos de todas las certificaciones
		apoderadoResult = apoderadoService.findAllByIdCertificacionIn( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) )
		//obtiene la ultima certificacion
		ultimaCertificacion = vm.sustentanteInstance.certificaciones.find{ it.isUltima == true }
		//obtiene todos los apoderamientos correspondientes a esa ultima certificacion
		apoderaminetosUltimaCertificacion = apoderadoResult.apoderados.findAll{ it.idCertificacion.value == ultimaCertificacion.id.value }
		//obtiene los estatus de revocacion correspondiente a todas los apoderamientos de las certificaiones
		apoderamientosRevocados = revocadoService.containsRevocados( new HashSet<Long>( apoderadoResult.apoderados.collect{ it.id } ) )
		//obtiene el apoderamiento que no ha sido revocado
		apoderaminetosUltimaCertificacion.each{ x ->
			if( apoderamientosRevocados.containsKey( x.id.value ) ){
				if(apoderamientosRevocados.get( x.id.value ) == false){
					ultimoPoderValido = apoderadoResult.poderes.find{ it.id.value == x.idPoder.value }
				}
			}
		}
		if(ultimoPoderValido!=null){
			vm.poderInstance = ultimoPoderValido
			vm.documentoPoderRespaldo = documentoRepositorioService.obtenerMetadatosDocumento( vm.poderInstance.uuidDocumentoRespaldo )
			vm.notarioPoder = notarioService.get( vm.poderInstance.idNotario  )
			vm.entidadFederativaNotarioPoder = sepomexService.obtenerEntidadFederativa( (int)vm.notarioPoder.idEntidadFederativa.value )
			vm.institucionPoder = entidadFinancieraService.obtenerInstitucion( vm.poderInstance.idInstitucion )
		}
		
		//CARGA EL HISTORICO DE LOS PODERES
		vm.historicoPoderes = apoderadoResult.poderes.sort{ it.fechaApoderamiento }.reverse()
		vm.historioRevocaciones = revocacionService.getAllByIdCertficacionInSet( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) ).asList()
		
		vm.sustentanteInstance.puestos.each { pu ->
			if(pu.esActual && pu.idInstitucion != null){
				InstitucionTO institucionActual = entidadFinancieraService.obtenerInstitucion( pu.idInstitucion )
				if(institucionActual != null && institucionActual){
					vm.sustentanteInstance.numeroInterior = institucionActual.getNombre()
					vm.sustentanteInstance.numeroExterior = institucionActual.getGrupoFinanciero().getNombre()
				}
			}
		}
		render(view:"showless",model:[viewModelInstance: vm])
	}

	def showDemo(long id) { 
		
	}
	
	//Métodos de guardado de datos
	def updateDatosPersonales(SustentanteTO sustentante){
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		def telefonosJsonElement = JSON.parse(params.'sustentante.telefonos_json')
		
		//bindings manuales
		//sustentante.id = params.'sustentante.id'
		sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		if(telefonosJsonElement != null && telefonosJsonElement instanceof JSONArray){
			def telefonosJsonArray = (JSONArray)telefonosJsonElement
			telefonosJsonArray.each{
				TelefonoSustentanteTO t = new TelefonoSustentanteTO()
				if(JSONObject.NULL.equals(it.'grailsId') || it.'grailsId' == -1) t.id = null
				else t.id = it.'grailsId'
				t.lada = it.'lada'
				t.telefono = it.'telefono'
				t.extension = it.'extension'
				t.idTipoTelefonoSustentante = (Long)it.'idTipoTelefono'
				sustentante.telefonos.add(t)
			}
		}
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		sustentante.puestos = new ArrayList<PuestoTO>()
		sustentante.certificaciones = new ArrayList<CertificacionTO>()
		
		println "Se enviara el siguiente JSON (editar): "
		println (sustentante as JSON)

		//se guarda el sustentante con todos los datos bindeados
		try {
			sustentanteService.updateDatosPersonales(sustentante)
			flash.successMessage = "El registro de sustentante de \"" + sustentante.nombre + " " + sustentante.primerApellido + "\" ha sido guardado satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar los datos, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}

		redirect (action: "show", id:sustentante.id ) 
	}

	def updateDoc(long id){
		List<DocumentoSustentanteTO> docSustList = new ArrayList<DocumentoSustentanteTO>() //las referencias a documentos que se guardan en el expedneite
		Map<String,DocumentoSustentanteRepositorioTO> docRepSustMap = new HashMap<String,DocumentoSustentanteRepositorioTO>() //los documentos que se envíaran al repositorio
		SustentanteTO sust = sustentanteService.get(id)
		List<String> uuidsDocumentosBorrar = new ArrayList<String>()
		List<String> uuidsDocumentosAntes = new ArrayList<String>()
		
		def docsJsonStr = params.'documentos'
		def docsJson = JSON.parse(docsJsonStr)
		
		//OBTIENE LOS DOCUMENTOS
		docsJson.each{ x -> 
			DocumentoSustentanteTO dsust = new DocumentoSustentanteTO()
			DocumentoSustentanteRepositorioTO dsustrep = new DocumentoSustentanteRepositorioTO()
			
			//rellena lista de "DocumentoSustentanteTO"
			dsust.uuid = x.'uuid'
			dsust.vigente = x.'vigente'
			dsust.idTipoDocumentoSustentate = Long.parseLong(x.'idTipoDocumento'.toString())
			docSustList.add(dsust)
			
			//rellena map con los documentos a enviar a repositorio
			dsustrep.uuid = x.'uuid'
			dsustrep.clave = ''
			dsustrep.nombre = '' //asignado por lo que se encontraba en temporal
			dsustrep.mimetype = '' //asignado por lo que se encontraba en temporal
			dsustrep.fechaModificacion = new Date() //asignado por lo que se encontraba en temporal
			dsustrep.fechaCreacion = new Date() //asignado por lo que se encontraba en temporal
			dsustrep.numeroMatricula = sust.numeroMatricula
			dsustrep.tipoDocumentoSustentante = Long.parseLong(x.'idTipoDocumento'.toString())
			dsustrep.nombreCompleto = sust.nombre + sust.primerApellido + sust.segundoApellido
			docRepSustMap.put(dsustrep.uuid, dsustrep)
		}
		
		//BORRA LOS QUE YA NO ESTAN EN LA LISTA
		//-OBTIENE LOS UUID'S QUE ESTABAN ANTES
		sust.documentos.each { x -> 
			uuidsDocumentosAntes.add(x.uuid)
		}
		//-COMPARA CON LOS NUEVOS; LOS QUE NO ESTAN SE BORRAN
		uuidsDocumentosAntes.each{ x ->
			boolean inList = false;
			for(Iterator<DocumentoSustentanteTO> iterator = docSustList.iterator(); docSustList.size() > 0 && iterator.hasNext(); ){
				DocumentoSustentanteTO ds = iterator.next();
				if(ds.uuid == x){
					inList = true
					break;
				}
			}
			if(!inList){
				uuidsDocumentosBorrar.add(x) //los manda a una lista con uuids de documentos a borrar
			}
			else{
				docRepSustMap.remove(x) //si ya estaba anteriormente, no es necesario mandarlo a repositorio
			}
		}
		
		
		try {
			documentoRepositorioService.eliminarDocumentos( uuidsDocumentosBorrar ) //borra documentos que ya no se encuentran en la lista
			documentoRepositorioService.enviarDocumentosArchivoTemporal( docRepSustMap.values().asList() ) //los nuevos que se guardaron en temporal los envía a repositorio
			documentoSustentanteService.updateDocumentosDeSustentante( id, docSustList ) //guarda los registros de las referencias a documentos que se guardan en el expediente
			flash.successMessage = "La gestión de los documentos ha sido guardada satisfactoriamente"
		}
		catch (Exception e){
			flash.errorMessage = "Ha ocurrido un error al guardar los datos, los detalles son los siguientes: " + e.message.substring(0, Math.min(e.message.length(),256)  )
		}
		
		redirect (action: "show", id:id ) 
	}	
}

public class ShowViewModel{
	SustentanteTO sustentanteInstance
	SepomexTO sepomexData
	String nombreCompleto
	
	Map<String,DocumentoRepositorioTO> documentosRespositorioUuidMap
	
	//PODER VIGENTE
	PoderTO poderInstance
	NotarioTO notarioPoder
	InstitucionTO institucionPoder
	EntidadFederativaTO entidadFederativaNotarioPoder
	DocumentoPoderRepositorioTO documentoPoderRespaldo
	
	//HISTORICO DE PODERES Y REVOCACIONES
	List<PoderTO> historicoPoderes
	List<RevocacionTO> historioRevocaciones
	Map<Long,GrupoFinancieroTO> gruposFinancierosMap
	Map<Long,InstitucionTO> institucionesPoderesMap
	Map<Integer,EntidadFederativaTO> entidadesFederativasMap
}

public class FormViewModel{
	//Bindeables
	SustentanteTO sustentanteInstance
	
	//No bindeables
	Collection<EstadoCivilTO> estadoCivilList
	Collection<InstitucionTO> institucionesList
	Collection<NacionalidadTO> nacionalidadList
	Collection<NivelEstudiosTO> nivelEstudiosList
	Collection<TipoTelefonoTO> tipoTelefonoList
	String sepomexJsonList
	
	InstitucionTO institutoInstance
	VarianteFiguraTO varianteFiguraInstance
	
	String codigoPostal
}

public class EditDocViewModel{

	Collection<TipoDocumentoTO> tipoDocumentoList
	
	Map<String,DocumentoRepositorioTO> documentosRespositorioUuidMap
	SustentanteTO sustentanteInstance
	
}

public class IndexViewModel{
	
	//No bindeables
	Collection<VarianteFiguraTO> varianteFiguraList
	Map<Long,String> variantesFiguraMap
	Collection<FiguraTO> figuraList
	Collection<StatusCertificacionTO> statusCertificacionList
	Collection<StatusAutorizacionTO> statusAutorizacionList
	Collection<GrupoFinancieroTO> gfins
	
	Collection<SustentanteTO> resultList
	Integer count
	
	//Bindeables
	String fltTB //Tipo de Búsqueda 'A',Avanzada;'M',Matricula;'F',Folio(Id);'T',Todos
	Integer fltMat //Matrícula
	Long fltFol //Folio
	String fltNom //Nombre
	String fltAp1 //Primer apellido
	String fltAp2 //Segundo apellido
	Boolean fltCrt //Certificado?
	Long fltFig //Identificador de figura
	Long fltVFig //Identificador de variante de figura
	Long fltStCt //Identificador de estatus de certificacion
	Long fltStAt //Identificador de estatus de autorizacion
	
	Long finGroup
	Long instFin

	String sort
	Integer max
	String order
	Integer offset
}
