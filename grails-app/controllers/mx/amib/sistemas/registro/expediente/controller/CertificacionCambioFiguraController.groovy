package mx.amib.sistemas.registro.expediente.controller

import java.util.List;

import mx.amib.sistemas.external.catalogos.service.FiguraService
import mx.amib.sistemas.external.catalogos.service.FiguraTO
import mx.amib.sistemas.registro.expediente.controller.CertificacionReposicionAutorizacionController.IndexViewModel

class CertificacionCambioFiguraController {

	FiguraService figuraService
	
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
}
