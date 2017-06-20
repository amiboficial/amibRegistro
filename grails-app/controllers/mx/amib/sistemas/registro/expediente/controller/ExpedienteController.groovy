package mx.amib.sistemas.registro.expediente.controller

import java.rmi.dgc.VMID;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat
import java.util.Collection
import java.util.Date;

import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument
import org.apache.poi.xwpf.usermodel.XWPFParagraph
import org.apache.poi.xwpf.usermodel.XWPFRun
import org.apache.poi.xwpf.usermodel.XWPFTable
import org.apache.poi.xwpf.usermodel.XWPFTableRow
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
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
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
import mx.amib.sistemas.registro.comprobante.model.ComprobantePuntos
import mx.amib.sistemas.registro.expediente.service.CertificacionActualizacionAutorizacionService;
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO
import mx.amib.sistemas.registro.legacy.saaec.service.SolicitudesOnlineDataService
import mx.amib.sistemas.solicitud.SolicitudesOnlineTO
import mx.amib.sistemas.utils.SearchResult

import org.codehaus.groovy.grails.web.json.JSONArray


import org.apache.poi.xwpf.usermodel.ParagraphAlignment;

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
	
	def certificacionService
	
	StatusAutorizacionTypes statusAutorizacion
	
	CertificacionActualizacionAutorizacionService certificacionActualizacionAutorizacionService
	
	Collection<EntidadFederativaTO> entidadFederativaList
	
	SolicitudesOnlineDataService solicitudesOnlineDataService
	
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
	
	def poderes() {
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
				Boolean havePowers=false
				result.certificaciones.each{ x ->
					if(x.statusAutorizacion.id.value == 5L){
						havePowers = true
					}
				}
				if(havePowers){
					vm.count = 1
					vm.resultList.add(result)
				}else{
					vm.count = 0
				}
			}
			
		}
		else if(vm.fltTB == 'F'){
			def result = sustentanteService.get(vm.fltFol)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			if(result == null){
				vm.count = 0
			}
			else{
				Boolean havePowers=false
				result.certificaciones.each{ x ->
					if(x.statusAutorizacion.id.value == 5L){
						havePowers = true
					}
				}
				if(havePowers){
					vm.count = 1
					vm.resultList.add(result)
				}else{
					vm.count = 0
				}	
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
		
		render(view:'withPower', model: [viewModelInstance:vm])
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
		vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
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
		List<Map<String,String>> servRes = null
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		if(s.certificaciones.size()>0){
			println("certifications ids")
			println(s.certificaciones.collect{it.id})
			Date mostMostRecent
				s.certificaciones.each{w -> 
					Date mostRecent
					w.validaciones.each{ x ->
						println("validaciones x.fechaInicio:::::;;;;;;;;")
						println(x.fechaInicio)
						if(mostRecent == null && x.fechaInicio!=null){
							mostRecent = x.fechaInicio
						}else if(x.fechaInicio!=null && x.fechaInicio > mostRecent){
							mostRecent = x.fechaInicio
						}
					}
					if(mostMostRecent == null && w.fechaAutorizacionInicio!=null){
						mostMostRecent = w.fechaAutorizacionInicio
					}else if(w.fechaAutorizacionInicio!=null && w.fechaAutorizacionInicio > mostMostRecent){
						mostMostRecent = w.fechaAutorizacionInicio
					}
					println("la validacion mas recienteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"+mostRecent)
					if(mostRecent!=null){
						ValidacionTO lastone =w.validaciones.find { vali -> vali.fechaInicio == mostRecent }
						w.validaciones.clear()
						w.validaciones.add(lastone)
						//ultima autorizacion
					}
				}
				//obtencion de dga si existe
				String degea = ""
				String numeroficio = ""
				s.certificaciones.each{ x ->
					try{
						SearchResult<OficioCnbvTO> resOficios = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, x.collect{ it.id } )
						println("respuestaOFICIOS")
						println(resOficios as JSON)
						servRes = resOficios.list
						if(resOficios.list!=null && resOficios.count>0 && servRes.first().get("claveDga") != null){
							SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy")
							Date masReciente
							servRes.each{ y ->
								Date parseo = (Date)y.get("fechaOficio")
								if(masReciente == null && y.get("fechaOficio")!=null){
									masReciente = parseo
								}else if(masReciente!=null && parseo > masReciente){
									masReciente = parseo
								}
							}
							println("cual es el dga mas reciente ---------<<>>"+masReciente)
							def actual = servRes.find{ valit -> valit.get("fechaOficio") == masReciente }
							degea = actual.get("claveDga")
							numeroficio = actual.get("numeroOficio")
						}
					}
					catch(Exception ex){
						ex.printStackTrace();
					}
				}
				if(degea!=""){
					println("degea____>>>"+degea)
					println("numeroficio>>>"+numeroficio)
					println("mostMostRecent>>>"+mostMostRecent)
					
					s.certificaciones.each{ x ->
						
						if(mostMostRecent!= null && x.fechaAutorizacionInicio == mostMostRecent){
							x.dga = degea
							x.numeroOficio = Long.parseLong(numeroficio, 10)
						}
					}
				}
				//END obtencion de dga si existe
		}
		//end de filtro de certificaciones
		//CARGA DE DATOS DEL SUSTENTANTE
		s.certificaciones.sort{ a,b-> b.fechaFin<=>a.fechaFin }
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
		apoderaminetosUltimaCertificacion = apoderadoResult.apoderados.findAll{ it?.idCertificacion?.value == ultimaCertificacion?.id?.value }
		//obtiene los estatus de revocacion correspondiente a todas los apoderamientos de las certificaiones
		apoderamientosRevocados = revocadoService.containsRevocados( new HashSet<Long>( apoderadoResult.apoderados.collect{ it.id } ) )
		//obtiene los apoderamientos que no han sido revocados
		List<PoderTO> sinRevocar = new ArrayList<PoderTO>()
		apoderaminetosUltimaCertificacion.each{ x ->
			if( apoderamientosRevocados.containsKey( x.id.value ) ){
				if(apoderamientosRevocados.get( x.id.value ) == false){
					ultimoPoderValido = apoderadoResult.poderes.find{ it.id.value == x.idPoder.value }
					sinRevocar.add(ultimoPoderValido)
				}
			}
		}
		//se obtiene la fecha de apoderamiento mas reciente
		def recentApoderamientodate = null
		sinRevocar.each{y -> 
			if(recentApoderamientodate == null){
				recentApoderamientodate = y.fechaApoderamiento
			}else if(recentApoderamientodate<y.fechaApoderamiento){
				recentApoderamientodate = y.fechaApoderamiento
			}
		}
		//se limpia el campo para obtener el ultimo poder con base en la fecha de apoderamiento
		ultimoPoderValido = null
		ultimoPoderValido = sinRevocar.find{ it.fechaApoderamiento == recentApoderamientodate }
		if(ultimoPoderValido!=null){
			vm.poderInstance = ultimoPoderValido
			vm.documentoPoderRespaldo = documentoRepositorioService.obtenerMetadatosDocumento( vm.poderInstance.uuidDocumentoRespaldo )
			vm.notarioPoder = notarioService.get( vm.poderInstance.idNotario  )
			if(vm.notarioPoder.idEntidadFederativa != null && vm.notarioPoder.idEntidadFederativa.value != null)
			vm.entidadFederativaNotarioPoder = sepomexService.obtenerEntidadFederativa( (int)vm.notarioPoder.idEntidadFederativa.value )
			vm.institucionPoder = entidadFinancieraService.obtenerInstitucion( vm.poderInstance.idInstitucion )
		}
		
		//CARGA EL HISTORICO DE LOS PODERES
		vm.historicoPoderes = apoderadoResult.poderes.sort{ it.fechaApoderamiento }.reverse()
		vm.historioRevocaciones = revocacionService.getAllByIdCertficacionInSet( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) ).asList()
		
		vm.PFIResult = certificacionActualizacionAutorizacionService.getPFIExamns(s.numeroMatricula)	
		
		//listado de solicitudes aceptadas asociadas a la matricula		
		//aqui se obtiene la informacion de las solicitudes online si es que existe
//		vm.solicitudes = solicitudesOnlineDataService.findAllRegistrableByNumeroMatricula(s.numeroMatricula)
//		println("vm.solicitudes")
//		println(vm.solicitudes)
		
		
		
		render(view:"show",model:[viewModelInstance: vm])
	}
	
	def showless(Long id){
		println "id de showless"+id
		def s = sustentanteService.get(id)
		ShowViewModel vm = new ShowViewModel()
		vm.institucionesList = entidadFinancieraService.obtenerInstituciones()
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
		List<Map<String,String>> servRes = null
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		if(s.certificaciones.size()>0){
			println("certifications ids")
			println(s.certificaciones.collect{it.id})
			Date mostMostRecent
				s.certificaciones.each{w -> 
					Date mostRecent
					w.validaciones.each{ x ->
						println("validaciones x.fechaInicio:::::;;;;;;;;")
						println(x.fechaInicio)
						if(mostRecent == null && x.fechaInicio!=null){
							mostRecent = x.fechaInicio
						}else if(x.fechaInicio!=null && x.fechaInicio > mostRecent){
							mostRecent = x.fechaInicio
						}
					}
					if(mostMostRecent == null && w.fechaAutorizacionInicio!=null){
						mostMostRecent = w.fechaAutorizacionInicio
					}else if(w.fechaAutorizacionInicio!=null && w.fechaAutorizacionInicio > mostMostRecent){
						mostMostRecent = w.fechaAutorizacionInicio
					}
					println("la validacion mas recienteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"+mostRecent)
					if(mostRecent!=null){
						ValidacionTO lastone =w.validaciones.find { vali -> vali.fechaInicio == mostRecent }
						w.validaciones.clear()
						w.validaciones.add(lastone)
						//ultima autorizacion
					}
				}
				//obtencion de dga si existe
				String degea = ""
				String numeroficio = ""
				s.certificaciones.each{ x ->
					try{
						SearchResult<OficioCnbvTO> resOficios = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, x.collect{ it.id } )
						println("respuestaOFICIOS")
						println(resOficios as JSON)
						servRes = resOficios.list
						if(resOficios.list!=null && resOficios.count>0 && servRes.first().get("claveDga") != null){
							SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy")
							Date masReciente
							servRes.each{ y ->
								Date parseo = (Date)y.get("fechaOficio")
								if(masReciente == null && y.get("fechaOficio")!=null){
									masReciente = parseo
								}else if(masReciente!=null && parseo > masReciente){
									masReciente = parseo
								}
							}
							println("cual es el dga mas reciente ---------<<>>"+masReciente)
							def actual = servRes.find{ valit -> valit.get("fechaOficio") == masReciente }
							degea = actual.get("claveDga")
							numeroficio = actual.get("numeroOficio")
						}
					}
					catch(Exception ex){
						ex.printStackTrace();
					}
				}
				if(degea!=""){
					println("degea____>>>"+degea)
					println("numeroficio>>>"+numeroficio)
					println("mostMostRecent>>>"+mostMostRecent)
					
					s.certificaciones.each{ x ->
						
						if(mostMostRecent!= null && x.fechaAutorizacionInicio == mostMostRecent){
							x.dga = degea
							x.numeroOficio = Long.parseLong(numeroficio, 10)
						}
					}
				}
				//END obtencion de dga si existe
		}
		//end de filtro de certificaciones
		//CARGA DE DATOS DEL SUSTENTANTE
		s.certificaciones.sort{ a,b-> b.fechaFin<=>a.fechaFin }
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
		//obtiene los apoderamientos que no han sido revocados
		List<PoderTO> sinRevocar = new ArrayList<PoderTO>()
		apoderaminetosUltimaCertificacion.each{ x ->
			if( apoderamientosRevocados.containsKey( x.id.value ) ){
				if(apoderamientosRevocados.get( x.id.value ) == false){
					ultimoPoderValido = apoderadoResult.poderes.find{ it.id.value == x.idPoder.value }
					sinRevocar.add(ultimoPoderValido)
				}
			}
		}
		//se obtiene la fecha de apoderamiento mas reciente
		def recentApoderamientodate = null
		sinRevocar.each{y -> 
			if(recentApoderamientodate == null){
				recentApoderamientodate = y.fechaApoderamiento
			}else if(recentApoderamientodate<y.fechaApoderamiento){
				recentApoderamientodate = y.fechaApoderamiento
			}
		}
		//se limpia el campo para obtener el ultimo poder con base en la fecha de apoderamiento
		ultimoPoderValido = null
		ultimoPoderValido = sinRevocar.find{ it.fechaApoderamiento == recentApoderamientodate }
		if(ultimoPoderValido!=null){
			vm.poderInstance = ultimoPoderValido
			vm.documentoPoderRespaldo = documentoRepositorioService.obtenerMetadatosDocumento( vm.poderInstance.uuidDocumentoRespaldo )
			vm.notarioPoder = notarioService.get( vm.poderInstance.idNotario  )
			if(vm.notarioPoder.idEntidadFederativa != null && vm.notarioPoder.idEntidadFederativa.value != null)
			vm.entidadFederativaNotarioPoder = sepomexService.obtenerEntidadFederativa( (int)vm.notarioPoder.idEntidadFederativa.value )
			vm.institucionPoder = entidadFinancieraService.obtenerInstitucion( vm.poderInstance.idInstitucion )
		}
		
		//CARGA EL HISTORICO DE LOS PODERES
		vm.historicoPoderes = apoderadoResult.poderes.sort{ it.fechaApoderamiento }.reverse()
		vm.historioRevocaciones = revocacionService.getAllByIdCertficacionInSet( new HashSet<Long>(vm.sustentanteInstance.certificaciones.collect{ it.id.value }.asList()) ).asList()
		
		vm.PFIResult = certificacionActualizacionAutorizacionService.getPFIExamns(s.numeroMatricula)
		
		render(view:"showless",model:[viewModelInstance: vm])
	}

	def powerShow(Long id){
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
		List<Map<String,String>> servRes = null
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		if(s.certificaciones.size()>0){
			println("certifications ids")
			println(s.certificaciones.collect{it.id})
			Date mostMostRecent
				s.certificaciones.each{w ->
					Date mostRecent
					w.validaciones.each{ x ->
						println("validaciones x.fechaInicio:::::;;;;;;;;")
						println(x.fechaInicio)
						if(mostRecent == null && x.fechaInicio!=null){
							mostRecent = x.fechaInicio
						}else if(x.fechaInicio!=null && x.fechaInicio > mostRecent){
							mostRecent = x.fechaInicio
						}
					}
					if(mostMostRecent == null && w.fechaAutorizacionInicio!=null){
						mostMostRecent = w.fechaAutorizacionInicio
					}else if(w.fechaAutorizacionInicio!=null && w.fechaAutorizacionInicio > mostMostRecent){
						mostMostRecent = w.fechaAutorizacionInicio
					}
					println("la validacion mas recienteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"+mostRecent)
					if(mostRecent!=null){
						ValidacionTO lastone =w.validaciones.find { vali -> vali.fechaInicio == mostRecent }
						w.validaciones.clear()
						w.validaciones.add(lastone)
						//ultima autorizacion
					}
				}
				//obtencion de dga si existe
				String degea = ""
				String numeroficio = ""
				s.certificaciones.each{ x ->
					try{
						SearchResult<OficioCnbvTO> resOficios = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max, offset, sort, order, x.collect{ it.id } )
						println("respuestaOFICIOS")
						println(resOficios as JSON)
						servRes = resOficios.list
						if(resOficios.list!=null && resOficios.count>0 && servRes.first().get("claveDga") != null){
							SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy")
							Date masReciente
							servRes.each{ y ->
								Date parseo = (Date)y.get("fechaOficio")
								if(masReciente == null && y.get("fechaOficio")!=null){
									masReciente = parseo
								}else if(masReciente!=null && parseo > masReciente){
									masReciente = parseo
								}
							}
							println("cual es el dga mas reciente ---------<<>>"+masReciente)
							def actual = servRes.find{ valit -> valit.get("fechaOficio") == masReciente }
							degea = actual.get("claveDga")
							numeroficio = actual.get("numeroOficio")
						}
					}
					catch(Exception ex){
						ex.printStackTrace();
					}
				}
				if(degea!=""){
					println("degea____>>>"+degea)
					println("numeroficio>>>"+numeroficio)
					println("mostMostRecent>>>"+mostMostRecent)
					
					s.certificaciones.each{ x ->
						
						if(mostMostRecent!= null && x.fechaAutorizacionInicio == mostMostRecent){
							x.dga = degea
							x.numeroOficio = Long.parseLong(numeroficio, 10)
						}
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
		//obtiene los apoderamientos que no han sido revocados
		List<PoderTO> sinRevocar = new ArrayList<PoderTO>()
		apoderaminetosUltimaCertificacion.each{ x ->
			if( apoderamientosRevocados.containsKey( x.id.value ) ){
				if(apoderamientosRevocados.get( x.id.value ) == false){
					ultimoPoderValido = apoderadoResult.poderes.find{ it.id.value == x.idPoder.value }
					sinRevocar.add(ultimoPoderValido)
				}
			}
		}
		//se obtiene la fecha de apoderamiento mas reciente
		def recentApoderamientodate = null
		sinRevocar.each{y -> 
			if(recentApoderamientodate == null){
				recentApoderamientodate = y.fechaApoderamiento
			}else if(recentApoderamientodate<y.fechaApoderamiento){
				recentApoderamientodate = y.fechaApoderamiento
			}
		}
		//se limpia el campo para obtener el ultimo poder con base en la fecha de apoderamiento
		ultimoPoderValido = null
		ultimoPoderValido = sinRevocar.find{ it.fechaApoderamiento == recentApoderamientodate }
		if(ultimoPoderValido!=null){
			vm.poderInstance = ultimoPoderValido
			vm.documentoPoderRespaldo = documentoRepositorioService.obtenerMetadatosDocumento( vm.poderInstance.uuidDocumentoRespaldo )
			vm.notarioPoder = notarioService.get( vm.poderInstance.idNotario  )
			if(vm.notarioPoder.idEntidadFederativa != null && vm.notarioPoder.idEntidadFederativa.value != null)
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
		
		vm.PFIResult = certificacionActualizacionAutorizacionService.getPFIExamns(s.numeroMatricula)
		
		render(view:"powerShow",model:[viewModelInstance: vm])
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
	
	def updateDatesCertificationExpedient(){
		Long idCert = 1L
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		Map<String,Object> respuesta = new HashMap<String,Object>()
		idCert = Long.parseLong( params.idCertificacion)
		CertificacionTO cert = certificacionService.get(idCert)
		cert.fechaInicio = sdf.parse(params.'dayFhIniCert' + '-' + params.'monthFhIniCert' + '-' + params.'yearFhIniCert')
		cert.fechaFin = sdf.parse(params.'dayFhFinCert' + '-' + params.'monthFhFinCert' + '-' + params.'yearFhFinCert')
		println(cert as JSON)
		cert = certificacionService.updateDatosParaAprobarDictamen(cert)
		if(cert!=null){
			respuesta = [ 'status' : 'OK' ]
		}else{
			respuesta = [ 'status' : 'ERROR' ]
		}
		render(respuesta as JSON)
	}
	
	def changeEditNotarioShow(){
		if(entidadFederativaList==null){
			entidadFederativaList = sepomexService.obtenerEntidadesFederativas()
		}
		def ult = null
		def res = new SearchResult<NotarioTO>()
		res.list = new ArrayList<NotarioTO>()
		int numeroNotaria = -1
		def auxList = null
		try{
			for(EntidadFederativaTO eft: entidadFederativaList){
				numeroNotaria = Integer.parseInt(params.nuNotario?:"-1")
				auxList = notarioService.findAllBy(100,0,"desc","nombreCompleto",eft.id,numeroNotaria,"")
				if(auxList!=null && auxList.error!= null && !auxList.error && auxList.count!= null && auxList.count > 0
					&& auxList.list!= null ){
					auxList.list.each{
							def auxRow = it;
							auxRow.nombreCompleto = auxRow.nombreCompleto +" - "+ eft.nombre
							res.list.add(auxRow)
					}
				}//end if not null or error rasultset
			}//end iteration federal entyties
			ult = [ 'status': 'OK', 'object': res.list ]
		}
		catch(Exception ex) {
			ex.printStackTrace()
			ult = [ 'status': 'ERROR', 'object': ex.message ]
		}
		render ult as JSON
	}
	
	def updateEditNotarioShow(){
		def respuesta = null
		try{
			def poderToUpdate = Long.parseLong( params.idPoder)
			def nuevoNotarioId = Long.parseLong( params.notid)
			def poderActual = poderService.get(poderToUpdate)
			println("poderActual get")
			println(poderActual as JSON)
			poderActual.idNotario = nuevoNotarioId
			poderActual = poderService.update(poderActual)
			println("poderActual after")
			println(poderActual as JSON)
		}catch(Exception ex) {
			ex.printStackTrace()
			respuesta = [ 'status' : 'ERROR' ]
		}
			respuesta = [ 'status' : 'OK' ]
		render(respuesta as JSON)
	}
	
	
	
	/***
	 * metodo para hacer el export de word just example
	 *
	 * @param listaOperadoras
	 * @param idPeriodoMensual
	 * @param httpServletResponse
	 */
	def descargarTabFormatDocx(){
	//OutputStream os = httpServletResponse.getOutputStream();
	// TODO: DESCARGA DE ARCHIVO DE CARGA
	
	//Seteo de cabeceras
//	httpServletResponse.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
//	httpServletResponse.setHeader("Content-Disposition", "attachment; filename=testxls.xlsx");
//	httpServletResponse.setContentType("application/zip");
//	httpServletResponse.setHeader("Content-Disposition", "attachment; filename=carteras.docx");
//	httpServletResponse.setStatus(HttpStatus.OK.value());
	
	//en este bloque obtiene todos las filas ordenadas por fondo
//	String[] operadoras = listaOperadoras.split(",");
	
	//max list size for fondos
//	int MaxArrayLength = 0;
//	String currentFondeu = "";
//	if(list != null && !list.isEmpty() && list.size()>0){
//		   MaxArrayLength = list.size() ;
//		   currentFondeu = list.get(0).getFondo();
//	}
		
	//se INICIA el outputstream que regresara todos los archivos
//	InputStream is = null;
//	OutputStream os = null;
//	int data = 0;
	
	//Blank Document
	XWPFDocument document= new XWPFDocument();
	  
	//create paragraph
	XWPFParagraph paragraph = document.createParagraph();
	
	//crea el titulo del documento
	XWPFRun paragraphOneRunOne = paragraph.createRun();
	paragraphOneRunOne.setBold(true);
//	paragraphOneRunOne.setItalic(true);
	paragraph.setAlignment(ParagraphAlignment.CENTER);
    paragraphOneRunOne.setFontSize(18);
    paragraphOneRunOne.setFontFamily("Times New Roman");
	paragraphOneRunOne.setText("Sistema de Revalidación por Puntos AMIB");
	paragraphOneRunOne.addBreak();
	
	//create table
	XWPFTable table = document.createTable();
	  
	//create first row
	XWPFTableRow tableRowOne = table.getRow(0);
	XWPFRun column1 = tableRowOne.getCell(0).addParagraph().createRun();
    column1.setFontSize(8);
    column1.setFontFamily("Times New Roman");
	column1.setText("Número de Matrícula: "+"7850");
	
	XWPFRun column2 = tableRowOne.addNewTableCell().addParagraph().createRun();
    column2.setFontSize(8);
    column2.setFontFamily("Times New Roman");
	column2.setText("Nombre del sustentante:  "+"Mónica Marisela Hernández Ibarra");
	tableRowOne.addNewTableCell();
	tableRowOne.addNewTableCell();
	
	//create space
	XWPFTableRow tableSeparator = table.createRow();
	tableSeparator.getCell(0).setText(" ");
	
	//create segundo parrafo
	XWPFTableRow tableRowTwo = table.createRow();
	tableRowTwo.getCell(0).setText("Figura Certificada:  "+" Asesor de Estrategias de Inversión");
	
	//create space2
	XWPFTableRow tableSeparator2 = table.createRow();
	tableSeparator2.getCell(0).setText(" ");
	  
	//create tercer parrafo
	XWPFTableRow tableRowTres = table.createRow();
	tableRowTres.getCell(0).setText("Vigencia de la Certificación Anterior:");
	tableRowTres.getCell(1).setText("Inicio 24/04/2014");
	tableRowTres.getCell(2).setText("Fin 24/04/2017");
	
	//create space3
	XWPFTableRow tableSeparator3 = table.createRow();
	tableSeparator3.getCell(0).setText(" ");
	  
	//create cuarto parrafo
	XWPFTableRow tableRowCuatro = table.createRow();
	tableRowCuatro.getCell(0).setText("Vigencia de la Certificación:");
	tableRowCuatro.getCell(1).setText("Inicio 24/04/2017");
	tableRowCuatro.getCell(2).setText("Fin 24/04/2020");
	
	//create space4
	XWPFTableRow tableSeparator4 = table.createRow();
	tableSeparator4.getCell(0).setText(" ");
	  
	//create cinco
	XWPFTableRow tableRowCinco = table.createRow();
	tableRowCinco.getCell(0).setText("Fecha de Emisión del Dictamen: 28/02/2017");
	
	//create space5
	XWPFTableRow tableSeparator5 = table.createRow();
	tableSeparator5.getCell(0).setText(" ");
	  
	//create cinco
	XWPFTableRow tableRowSeis = table.createRow();
	tableRowSeis.getCell(0).setText("Institución en la que labora:   Banco Santander (México) S.A., Institución de Banca Múltiple, Grupo Financiero Santander México");
	
	//create space5
	XWPFTableRow tableSeparator6 = table.createRow();
	tableSeparator6.getCell(0).setText(" ");
	  
	//create tercer parrafo
	XWPFTableRow tableRowSiete = table.createRow();
	tableRowSiete.getCell(0).setText("Vigencia de la Certificación Anterior:");
	tableRowSiete.getCell(1).setText("Inicio 24/04/2014");
	tableRowSiete.getCell(2).setText("Fin 24/04/2017");
	
	  
	//Set alignment paragraph to RIGHT
	XWPFRun run=paragraph.createRun();
	run.setText("At tutorialspoint.com, we strive hard to " +
	   "provide quality tutorials for self-learning " +
	   "purpose in the domains of Academics, Information " +
	   "Technology, Management and Computer Programming " +
	   "Languages.");
	  
	//Create Another paragraph
	paragraph=document.createParagraph();
	  
	//Set alignment paragraph to CENTER
	run=paragraph.createRun();
	run.setText("The endeavour started by Mohtashim, an AMU " +
	   "alumni, who is the founder and the managing director " +
	   "of Tutorials Point (I) Pvt. Ltd. He came up with the " +
	   "website tutorialspoint.com in year 2006 with the help" +
	   "of handpicked freelancers, with an array of tutorials" +
	   " for computer programming languages. ");
			
		
	//end Phase este exporta el ultimo sea cual sea
//	try {
//		os = httpServletResponse.getOutputStream();
//		document.write(os);
//		System.out.println("alignparagraph.docx written successfully");
//		os.flush();
//		os.close();
//	} catch (IOException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
	//end Phase este exporta el ultimo se acual sea
		
   response.contentType  = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' // or whatever content type your resources are
   response.setHeader("Content-disposition", "filename=test.docx")
   document.write(response.outputStream)
//   response.outputStream << document.getBytes()
   response.outputStream.flush()
   
	}
	
	
	
	/***
	 * metodo para hacer el export de word just example
	 *
	 * @param listaOperadoras
	 * @param idPeriodoMensual
	 * @param httpServletResponse
	 */
	def descargarCocaFullDocx(){
	
	List<ComprobantePuntos> comprobantes = solicitudesOnlineDataService.findAllComprobantesPuntos(Integer.parseInt(params.numeroMatricula))
	
	if(comprobantes == null || comprobantes.empty){
		flash.message = "Matricula no encontrada	"
		render(view:"wordExport",model:[])
		return
	}
	
	ComprobantePuntos auxiliar = comprobantes.get(0);
		
		
	//Blank Document
	File file = grailsApplication.mainContext.getResource("comprobanteSource.docx").file
	String pat = file.path
	FileInputStream fi = new FileInputStream(file.path);
	XWPFDocument document = new XWPFDocument(fi);
	  
	//create paragraph
	XWPFParagraph paragraphone = document.createParagraph();
	
	//crea el titulo del documento
	XWPFRun paragraphOneRunOne = paragraphone.createRun();
	paragraphOneRunOne.setBold(true);
//	paragraphOneRunOne.setItalic(true);
	paragraphone.setAlignment(ParagraphAlignment.CENTER);
	paragraphOneRunOne.setFontSize(18);
	paragraphOneRunOne.setFontFamily("Times New Roman");
	paragraphOneRunOne.setText("Sistema de Revalidación por Puntos AMIB");
	paragraphOneRunOne.addCarriageReturn();
	paragraphOneRunOne.addBreak();
	
	
	//create paragraph
	XWPFParagraph paragraph = document.createParagraph();
	
	//crea el titulo del documento
	XWPFRun secondp = paragraph.createRun();
	secondp.setFontSize(7);
	paragraph.setAlignment(ParagraphAlignment.LEFT);
	secondp.setFontFamily("Times New Roman");
	secondp.setText("Número de Matrícula: "+auxiliar.Matricula.replace(".0", "")+"\t\t"+"Nombre del sustentante:  "+auxiliar.Nombre);
	secondp.addCarriageReturn();
	secondp.addBreak();
	
	//crea el titulo del documento
	XWPFRun tercerp = paragraph.createRun();
	tercerp.setFontSize(7);
	tercerp.setFontFamily("Times New Roman");
	tercerp.setText("Figura Certificada:  "+auxiliar.Figura_Certificada);
	tercerp.addCarriageReturn();
	tercerp.addBreak();
	
	
	//crea el titulo del documento
	XWPFRun cuartop = paragraph.createRun();
	cuartop.setFontSize(7);
	cuartop.setFontFamily("Times New Roman");
	cuartop.setText("Vigencia de la Certificación Anterior:"+"\t\t"+" Inicio: "+auxiliar.Inicio_de_Vigencia_Anterior+"\t\t"+" Fin: "+auxiliar.Fin_de_Vigencia_Anterior);
	cuartop.addCarriageReturn();
	cuartop.addBreak();
	
	//crea el titulo del documento
	XWPFRun quintop = paragraph.createRun();
	quintop.setFontSize(7);
	quintop.setFontFamily("Times New Roman");
	quintop.setText("Vigencia de la Certificación:"+"\t\t"+" Inicio: "+auxiliar.Inicio_Nueva_Vigencia+"\t\t"+" Fin: "+auxiliar.Fin_Nueva_Vigencia);
	quintop.addCarriageReturn();
	quintop.addBreak();
	
	//crea el titulo del documento
	XWPFRun sextop = paragraph.createRun();
	sextop.setFontSize(7);
	sextop.setFontFamily("Times New Roman");
	sextop.setText("Fecha de Emisión del Dictamen: "+auxiliar.Fecha_de_Emisión);
	sextop.addCarriageReturn();
	sextop.addBreak();
	
	//crea el titulo del documento
	XWPFRun septimop = paragraph.createRun();
	septimop.setFontSize(7);
	septimop.setFontFamily("Times New Roman");
	septimop.setText("Institución en la que labora: "+auxiliar.INSTITUCIÓN_EN_LA_QUE_LABORA);
	septimop.addBreak();
	
	//////////////////7INICIO DE TABLA DE OPCIONES 
	
	//create table
	XWPFTable table = document.createTable();
	table.getCTTbl().getTblPr().unsetTblBorders();
	  
	//create first row
	XWPFTableRow tableRowOne = table.getRow(0);
	XWPFRun column1 = tableRowOne.getCell(0).getParagraphArray(0).createRun();
	column1.setFontSize(7);
	column1.setFontFamily("Times New Roman");
	column1.setText("OPCIÓN");
	
	tableRowOne.addNewTableCell();
	
	//create first row
	XWPFRun column2 = tableRowOne.addNewTableCell().getParagraphArray(0).createRun();
	column2.setFontSize(7);
	column2.setFontFamily("Times New Roman");
	column2.setText("INSTITUTO");
	
	tableRowOne.addNewTableCell();
	
	//create first row
	XWPFRun column3 = tableRowOne.addNewTableCell().getParagraphArray(0).createRun();
	column3.setFontSize(7);
	column3.setFontFamily("Times New Roman");
	column3.setText("PUNTOS");
	
	tableRowOne.addNewTableCell();
	
	
	
	//create space
	XWPFTableRow tableSeparator = table.createRow();
	
	//Total Calculado
	Integer totalcalc = 0;
	
	if(auxiliar.Opción_1 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_1);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_1);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	if(auxiliar.Opción_2 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_2);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_2);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos2.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos2.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	if(auxiliar.Opción_3 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_3);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_3);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos3.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos3.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	
	if(auxiliar.Opción_4 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_4);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_4);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos4.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos4.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	if(auxiliar.Opción_5 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_5);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_5);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos5.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos5.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	if(auxiliar.Opción_6 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_6);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_6);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos6.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos6.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	if(auxiliar.Opción_7 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_7);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_7);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos7.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos7.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	if(auxiliar.Opción_8 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_8);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_8);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos_8.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos_8.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	
	
	
	if(auxiliar.Opción_9 != null){
		//create cuarto parrafo
		XWPFTableRow tableRowCuatro = table.createRow();
		
		XWPFRun opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
		opcionCol.setFontSize(7);
		opcionCol.setFontFamily("Times New Roman");
		opcionCol.setText(auxiliar.Opción_9);
		
		XWPFRun opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
		opcionCol2.setFontSize(7);
		opcionCol2.setFontFamily("Times New Roman");
		opcionCol2.setText("        ");
		
		XWPFRun opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
		opcionCol3.setFontSize(7);
		opcionCol3.setFontFamily("Times New Roman");
		opcionCol3.setText(auxiliar.Instituto_9);
		
		XWPFRun opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
		opcionCol4.setFontSize(7);
		opcionCol4.setFontFamily("Times New Roman");
		opcionCol4.setText("        ");
		
		XWPFRun opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
		opcionCol5.setFontSize(7);
		opcionCol5.setFontFamily("Times New Roman");
		opcionCol5.setText(auxiliar.Puntos_9.replace(".0", ""));
		
		totalcalc += Integer.valueOf(auxiliar.Puntos_9.replace(".0", ""))
		
		XWPFRun opcionCol6 = tableRowCuatro.getCell(5).addParagraph().createRun();
		opcionCol6.setFontSize(7);
		opcionCol6.setFontFamily("Times New Roman");
		opcionCol6.setText("        ");
	}
	
	
	////ESTE ERA UN MOCK UP CON DATOS ESTATICOS
//	//create cuarto parrafo
//	tableRowCuatro = table.createRow();
//	
//	opcionCol = tableRowCuatro.getCell(0).getParagraphArray(0).createRun();
//	opcionCol.setFontSize(7);
//	opcionCol.setFontFamily("Times New Roman");
//	opcionCol.setText("Especialista en Estrategias de Inversión E- Learning (Versión 2014)");
//	
//	opcionCol2 = tableRowCuatro.getCell(1).addParagraph().createRun();
//	opcionCol2.setFontSize(7);
//	opcionCol2.setFontFamily("Times New Roman");
//	opcionCol2.setText("        ");
//	
//	opcionCol3 = tableRowCuatro.getCell(2).getParagraphArray(0).createRun();
//	opcionCol3.setFontSize(7);
//	opcionCol3.setFontFamily("Times New Roman");
//	opcionCol3.setText("Laura Garza & Asociados.");
//	
//	opcionCol4 = tableRowCuatro.getCell(3).addParagraph().createRun();
//	opcionCol4.setFontSize(7);
//	opcionCol4.setFontFamily("Times New Roman");
//	opcionCol4.setText("        ");
//	
//	opcionCol5 = tableRowCuatro.getCell(4).getParagraphArray(0).createRun();
//	opcionCol5.setFontSize(7);
//	opcionCol5.setFontFamily("Times New Roman");
//	opcionCol5.setText("350");
//	
//	opcionCol6 = tableRowCuatro.getCell(5).getParagraphArray(0).createRun();
//	opcionCol6.setFontSize(7);
//	opcionCol6.setFontFamily("Times New Roman");
//	opcionCol6.setText("        ");
	
	//ESPACIO ENTRE OPCIONES Y TOTAL
	XWPFTableRow tableSeparator2 = table.createRow();
	
	//create cuarto parrafo
	XWPFTableRow tableRowCuatro = table.createRow();
	
	XWPFRun opcionCol = tableRowCuatro.getCell(3).getParagraphArray(0).createRun();
	opcionCol.setFontSize(7);
	opcionCol.setFontFamily("Times New Roman");
	opcionCol.setText("TOTAL DE PUNTOS");
	
	XWPFRun opcionCol3 = tableRowCuatro.getCell(5).getParagraphArray(0).createRun();
	opcionCol3.setFontSize(7);
	opcionCol3.setFontFamily("Times New Roman");
	opcionCol3.setText(totalcalc.toString());
	
	//create resutlado de la evaluacion
	tableRowCuatro = table.createRow();
	
	opcionCol = tableRowCuatro.getCell(3).getParagraphArray(0).createRun();
	opcionCol.setFontSize(7);
	opcionCol.setFontFamily("Times New Roman");
	opcionCol.setText("RESULTADO DE LA REVALIDACIÓN:");
	
	opcionCol3 = tableRowCuatro.getCell(5).getParagraphArray(0).createRun();
	opcionCol3.setFontSize(7);
	opcionCol3.setFontFamily("Times New Roman");
	opcionCol3.setText(auxiliar.Estatus);
	
	//create paragraph
	XWPFParagraph paragraphPie = document.createParagraph();
	
	//crea el titulo del documento
	XWPFRun parrafoFinal = paragraphPie.createRun();
	parrafoFinal.setFontSize(12);
	parrafoFinal.setUnderline(UnderlinePatterns.DASHED_HEAVY);
	parrafoFinal.setBold(true);
	paragraphPie.setAlignment(ParagraphAlignment.CENTER);
	parrafoFinal.setFontFamily("Times New Roman");
	parrafoFinal.setText("Fernando Muñoz Nolasco");
	
	//create paragraph
	XWPFParagraph paragraphNF = document.createParagraph();
	
	//crea el titulo del documento
	XWPFRun parrafoNF = paragraphNF.createRun();
	parrafoNF.setFontSize(8);
	paragraphNF.setAlignment(ParagraphAlignment.CENTER);
	parrafoNF.setFontFamily("Times New Roman");
	parrafoNF.setText("NOMBRE Y FIRMA DEL DICTAMINADOR");
	parrafoNF.addCarriageReturn();
	
	//create paragraph pie de pagina
	XWPFParagraph paragraphNota = document.createParagraph();
	
	//crea el pie de pagina
	XWPFRun parrafoNota = paragraphNota.createRun();
	parrafoNota.setFontSize(7);
	parrafoNota.setBold(true);
	paragraphNota.setAlignment(ParagraphAlignment.LEFT);
	parrafoNota.setFontFamily("Times New Roman");
	parrafoNota.setText("Esta constancia sólo acredita que se ha obtenido la Revalidación de la Certificación, pero de ninguna forma revalida la \n Autorización otorgada por la CNBV, dado que para tales efectos se requiere la entrega de documentación adicional. \n Para corroborar ésta información consulte la página de la AMIB: www.amib.com.mx ");
		
   response.contentType  = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' // or whatever content type your resources are
   response.setHeader("Content-disposition", "filename=test.docx")
   document.write(response.outputStream)
//   response.outputStream << document.getBytes()
   response.outputStream.flush()
   
	}
	
	def wordExport() {
		render(view:"wordExport",model:[])
	}
	
	
}

public class ShowViewModel{
	SustentanteTO sustentanteInstance
	SepomexTO sepomexData
	String nombreCompleto
	String PFIResult
	
	Collection<InstitucionTO> institucionesList
	
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
	
	//Datos de solicitudes Online
	List<SolicitudesOnlineTO> solicitudes
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
