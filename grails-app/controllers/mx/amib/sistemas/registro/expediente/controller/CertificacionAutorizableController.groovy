package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.List;

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.registro.autorizacionCnbv.controller.OficioCnbvController.ShowVM
import org.codehaus.groovy.grails.web.mapping.LinkGenerator

class CertificacionAutorizableController {

	CertificacionService certificacionService
	LinkGenerator grailsLinkGenerator
	
	//El id es el modo de búsqueda
	def getAll(int id){
		//Parámetros de ordenamiento y paginación
		int max, offset
		String sort, order
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		
		max = this.getMaxParam(params)
		offset = this.getOffsetParam(params)
		sort = this.getSortParam(params)
		order = this.getOrderParam(params)
		
		responseModel = new HashMap<String,Object>()
//		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, '', '', '', -1, -1)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoActualizacionAutorizacion(max, offset, sort, order, '', '', '', -1, -1)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllCandidatoReposicionAutorizacion(max, offset, sort, order, '', '', '', -1, -1)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoCambioFigura(max, offset, sort, order, '', '', '', -1, -1)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(grailsLinkGenerator,certServRes.getList(),id) )
				responseModel.put('count', certServRes.count)
			}
			else{
				responseModel.put('status','ERROR')
				responseModel.put('errorMessage','ID_MODO_BUSQUEDA_NOT_SPECIFIED')
			}
//		}
//		catch(Exception e){
//			responseModel.put('status','ERROR')
//			responseModel.put('errorMessage',e.message)
//		}
		
		render (responseModel as JSON)
	}
	
	//El id es el modo de búsqueda
	def findAllByMatricula(int id){
		String sort, order
		int numeroMatricula
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		//List<CertificacionTO> certServResList
		
		numeroMatricula = this.getNumeroMatriculaParam(params)
		
		responseModel = new HashMap<String,Object>()
		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevioByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoActualizacionAutorizacionByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllCandidatoReposicionAutorizacionByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoCambioFiguraByMatricula(numeroMatricula)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(grailsLinkGenerator,certServRes.getList(),id) )
				responseModel.put('count', certServRes.count)
			}
			else{
				responseModel.put('status','ERROR')
				responseModel.put('errorMessage','ID_MODO_BUSQUEDA_NOT_SPECIFIED')
			}
		}
		catch(Exception e){
			e.printStackTrace()
			responseModel.put('status','ERROR')
			responseModel.put('errorMessage',e.message)
		}
		
		render (responseModel as JSON)
	}
	
	//El id es el modo de búsqueda
	def findAllByIdSustentante(int id){
		String sort, order
		int idSustentante
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		
		idSustentante = this.getIdSustentanteParam(params)
		
		responseModel = new HashMap<String,Object>()
		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevioByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoActualizacionAutorizacionByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllCandidatoReposicionAutorizacionByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoCambioFiguraByFolio(idSustentante)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(grailsLinkGenerator,certServRes.getList(),id) )
				responseModel.put('count', certServRes.count)
			}
			else{
				responseModel.put('status','ERROR')
				responseModel.put('errorMessage','ID_MODO_BUSQUEDA_NOT_SPECIFIED')
			}
		}
		catch(Exception e){
			responseModel.put('status','ERROR')
			responseModel.put('errorMessage',e.message)
		}
		
		render (responseModel as JSON)
	}
	
	//El id es el modo de búsqueda
	def findAllByNombresAndCertificacion(int id){
		//Parámetros de ordenamiento y paginación
		int max, offset
		String sort, order
		//Parámetros para búsqueda avanzada
		String nombre, primerApellido, segundoApellido
		long idFigura, idVarianteFigura
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		
		max = this.getMaxParam(params)
		offset = this.getOffsetParam(params)
		sort = this.getSortParam(params)
		order = this.getOrderParam(params)
		
		nombre = params.'nombre'?:''
		primerApellido = params.'primerApellido'?:''
		segundoApellido = params.'segundoApellido'?:''
		idFigura = this.getIdFiguraParam(params)
		if(idFigura == -1)
			idVarianteFigura = -1
		else
			idVarianteFigura = this.getIdVarianteFiguraParam(params)
			
		responseModel = new HashMap<String,Object>()
		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoActualizacionAutorizacion(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllCandidatoReposicionAutorizacion(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllCandidatoCambioFigura(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(grailsLinkGenerator,certServRes.getList(),id) )
				responseModel.put('count', certServRes.count)
			}
			else{
				responseModel.put('status','ERROR')
				responseModel.put('errorMessage','ID_MODO_BUSQUEDA_NOT_SPECIFIED')
			}
		}
		catch(Exception e){
			responseModel.put('status','ERROR')
			responseModel.put('errorMessage',e.message)
		}
		
		render (responseModel as JSON)
	}
	
	private int getMaxParam(def params){
		int max
		try{
			max = Integer.parseInt(params.'max'?:'10')
		}
		catch(NumberFormatException nfe){
			max = 10;
		}
		return max
	}
	
	private int getOffsetParam(def params){
		int offset
		try{
			offset = Integer.parseInt(params.'offset'?:'0')
		}
		catch(NumberFormatException nfe){
			offset = 0;
		}
		return offset
	}
	
	private String getSortParam(def params){
		String sort
		sort = params.'sort'?:'id'
		switch(sort){
			case 'id':
			case 'idSustentante':
			case 'numeroMatricula':
			case 'nombre':
			case 'primerApellido':
			case 'segundoApellido':
			break;
			default:
			sort = 'id'
		}
		return sort
	}
	
	private String getOrderParam(def params){
		String order
		order = params.'order'?:'asc'
		if( order.compareToIgnoreCase('asc') != 0 && order.compareToIgnoreCase('desc') != 0 ){
			order = 'asc'
		}
		return order
	}
	
	private int getNumeroMatriculaParam(def params){
		int numeroMatricula
		try{
			numeroMatricula = Integer.parseInt(params.'numeroMatricula'?:'-1')
		}
		catch(NumberFormatException nfe){
			numeroMatricula = -1;
		}
		return numeroMatricula
	}
	
	private int getIdSustentanteParam(def params){
		int idSustentante
		try{
			idSustentante = Integer.parseInt(params.'idSustentante'?:'-1')
		}
		catch(NumberFormatException nfe){
			idSustentante = -1;
		}
		return idSustentante
	}
	
	private int getIdFiguraParam(def params){
		int idFigura
		try{
			idFigura = Integer.parseInt(params.'idFigura'?:'-1')
		}
		catch(NumberFormatException nfe){
			idFigura = -1;
		}
		return idFigura
	}
	
	private int getIdVarianteFiguraParam(def params){
		int idVarianteFigura
		try{
			idVarianteFigura = Integer.parseInt(params.'idVarianteFigura'?:'-1')
		}
		catch(NumberFormatException nfe){
			idVarianteFigura = -1;
		}
		return idVarianteFigura
	}
	
	public static class ResultVM{
		
		private static DateFormat df = new SimpleDateFormat('dd/MM/YYY')
		
		long grailsId = -1
		long idSustentante = -1
		int numeroMatricula = -1
		String nombre = ''
		String primerApellido = ''
		String segundoApellido = ''
		
		String nombreFigura = ''
		String nombreVarianteFigura = ''
		String dsStatusCertificacion = ''
		String dsStatusAutorizacion = ''
		String dsFechaRangoVigencia = ''
		
		String iconoBotonAccion = 'asterisk'
		String mensajeBotonAccion = 'Ir a proceso'
		String accionUrl = '' //url a la que se dirigirá
		
		boolean expanded = false
		
		public static List<ResultVM> copyFromServicesResults(LinkGenerator glg, List<CertificacionTO> certList, int modoBusqueda){
			List<ResultVM> listRes = new ArrayList<ResultVM>()
			certList.each { x ->
				listRes.add(ResultVM.copyFromCertificacionTO(glg, x, modoBusqueda))
			}
			return listRes
		}
		
		private static ResultVM copyFromCertificacionTO(LinkGenerator glg, CertificacionTO cert, int modoBusqueda){
			ResultVM vm = new ResultVM()
			vm.grailsId = cert.id
			vm.idSustentante = cert.sustentante.id
			vm.numeroMatricula = cert.sustentante.numeroMatricula
			vm.nombre = cert.sustentante.nombre
			vm.primerApellido = cert.sustentante.primerApellido
			vm.segundoApellido = cert.sustentante.segundoApellido
			vm.nombreFigura = cert.varianteFigura.nombreFigura
			vm.nombreVarianteFigura = cert.varianteFigura.nombre
			vm.dsStatusCertificacion = cert.statusCertificacion.descripcion
			vm.dsStatusAutorizacion = cert.statusAutorizacion.descripcion
			vm.dsFechaRangoVigencia = ""
			if(cert.fechaInicio != null){
				vm.dsFechaRangoVigencia += cert.fechaInicio.format( 'dd/MM/yyyy' )
			}
			vm.dsFechaRangoVigencia += ' - '
			if(cert.fechaFin != null){
				vm.dsFechaRangoVigencia += cert.fechaFin.format( 'dd/MM/yyyy' )
			}
			
			
			if(modoBusqueda == ModoBusqueda.DICTAMEN_PREVIO){
				vm.iconoBotonAccion = 'edit'
				vm.mensajeBotonAccion = 'Emitir dictamen'
				vm.accionUrl = glg.link(controller: 'certificacionDictamenPrevio', action: 'create', id: cert.id)
			}
			else if(modoBusqueda == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				vm.iconoBotonAccion = 'refresh'
				vm.mensajeBotonAccion = 'Actualizar'
				vm.accionUrl = glg.link(controller: 'certificacionActualizacionAutorizacion', action: 'create', id: cert.id)
			}
			else if(modoBusqueda == ModoBusqueda.REPOSICION_AUTORIZACION){
				vm.iconoBotonAccion = 'retweet'
				vm.mensajeBotonAccion = 'Reponer'
				vm.accionUrl = glg.link(controller: 'certificacionReposicionAutorizacion', action: 'create', id: cert.id)
			}
			else if(modoBusqueda == ModoBusqueda.CAMBIO_FIGURA){
				vm.iconoBotonAccion = 'transfer'
				vm.mensajeBotonAccion = 'Cambiar figura'
				vm.accionUrl = glg.link(controller: 'certificacionCambioFigura', action: 'create', id: cert.id)
			}
			return vm
		}
	}
}

public class ModoBusqueda{
	public static final int DICTAMEN_PREVIO = 0; 
	public static final int ACTUALIZACION_AUTORIZACION = 1;
	public static final int REPOSICION_AUTORIZACION = 2;
	public static final int CAMBIO_FIGURA = 3;
}