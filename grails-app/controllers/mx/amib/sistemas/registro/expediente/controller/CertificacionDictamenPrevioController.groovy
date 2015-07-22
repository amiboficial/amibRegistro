package mx.amib.sistemas.registro.expediente.controller

import java.util.Collection;
import java.util.Map;

import mx.amib.sistemas.external.catalogos.service.FiguraTO;
import mx.amib.sistemas.external.catalogos.service.VarianteFiguraTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.*
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class CertificacionDictamenPrevioController {

	def figuraService
	def sustentanteService
	
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
			def sr = null

			sr = sustentanteService.findAllAdvancedSearchWithCertificacion("", "", "", -1, -1, 
																			StatusCertificacionTypes.CERTIFICADO, 
																			StatusAutorizacionTypes.DICTAMEN_PREVIO, 
																			vm.max, vm.offset, vm.sort, vm.order)
			vm.resultList = sr.list
			vm.count = sr.count
		}
		else if(vm.fltTB == 'M'){
			def result = sustentanteService.findByMatricula(vm.fltMat.value)
			vm.resultList = new ArrayList<SustentanteTO>()
			
			//checa si la última certificación es candidata a un dictamen
			SustentanteTO s = result
			CertificacionTO c = s.certificaciones.find{ x ->
				x.isUltima == true && x.statusAutorizacion.id == StatusAutorizacionTypes.DICTAMEN_PREVIO && x.statusCertificacion.id == StatusCertificacionTypes.CERTIFICADO
			}

			vm.offset = 0
			if(c == null){
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
			
			//checa si la última certificación es candidata a un dictamen
			SustentanteTO s = result
			CertificacionTO c = s.certificaciones.find{ x ->
				x.isUltima == true && x.statusAutorizacion.id == StatusAutorizacionTypes.DICTAMEN_PREVIO && x.statusCertificacion.id == StatusCertificacionTypes.CERTIFICADO
			}
			
			if(c == null){
				vm.count = 0
			}
			else{
				vm.count = 1
				vm.resultList.add(result)
			}
		}
		else if(vm.fltTB == 'A'){
			def sr = null

			sr = sustentanteService.findAllAdvancedSearchWithCertificacion(vm.fltNom, vm.fltAp1, vm.fltAp2, 
																			vm.fltFig, vm.fltVFig, 
																			StatusCertificacionTypes.CERTIFICADO, 
																			StatusAutorizacionTypes.DICTAMEN_PREVIO, 
																			vm.max, vm.offset, vm.sort, vm.order)

			vm.resultList = sr.list
			vm.count = sr.count
		}
		
		return vm
	}
	
	//Muestra datos de expediente a editar de acuerdo al proceso de dictamen
	def create() { }
	
	//Envía a autorización 
	def save() { }
	
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
		Collection<SustentanteTO> resultList
		Integer count
		String sort
		Integer max
		String order
		Integer offset
	}
	
	public static class CreateViewModel{
		
	}
}