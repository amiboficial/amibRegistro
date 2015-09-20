package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

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
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO;
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO;
import mx.amib.sistemas.external.expediente.service.CertificacionService;
import mx.amib.sistemas.external.expediente.service.SustentanteService;
import mx.amib.sistemas.registro.expediente.controller.CertificacionActualizacionAutorizacionController.CreateViewModel;
import mx.amib.sistemas.registro.expediente.controller.CertificacionActualizacionAutorizacionController.IndexViewModel;
import mx.amib.sistemas.registro.expediente.service.CertificacionActualizacionAutorizacionService;
import mx.amib.sistemas.registro.expediente.service.CertificacionReposicionAutorizacionService
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO;
import mx.amib.sistemas.registro.legacy.saaec.service.RegistroExamenService;

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
			estadoCivilService, nacionalidadService, nivelEstudiosService, tipoTelefonoService, sepomexService, registroExamenService)]  )
	}
	
	static class CreateViewModel{
		//Bindeables
		SustentanteTO sustentanteInstance
		CertificacionTO certificacionInstance
		
		//No bindeables
		Collection<RegistroExamenTO> examanesList
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
			SepomexService sepomexService, RegistroExamenService registroExamenService){
		
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
			}
			
			return vm
			
		}
	}
	
	def save(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		//Aquí se recuperan datos enviados por la vista y se envían al servicio
	}
}
