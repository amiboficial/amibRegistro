package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.FiguraService
import mx.amib.sistemas.external.catalogos.service.FiguraTO

class CertificacionActualizacionAutorizacionController {

	FiguraService figuraService
	
    def index() {
		render( view:'index', model:[vm:IndexViewModel.getInstance(figuraService)] )
	}
	
	static class IndexViewModel{
		List<FiguraTO> figuras;
		
		private IndexViewModel(){}
		
		public static IndexViewModel getInstance(FiguraService figuraService){
			IndexViewModel vm = new IndexViewModel()
			
			vm.figuras = figuraService.list()
			
			println (vm.figuras as JSON)
			
			return vm
		}
	}
}

