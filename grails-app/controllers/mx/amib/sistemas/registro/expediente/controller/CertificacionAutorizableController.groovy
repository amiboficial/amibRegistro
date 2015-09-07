package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import java.util.List;

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.registro.autorizacionCnbv.controller.OficioCnbvController.ShowVM;

class CertificacionAutorizableController {

	CertificacionService certificacionService
	
	//El id es el modo de búsqueda
	def findAllByMatricula(int id){
		int numeroMatricula
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		
		numeroMatricula = this.getNumeroMatriculaParam(params)
		
		responseModel = new HashMap<String,Object>()
		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevioByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllEnDictamenPrevioByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllEnDictamenPrevioByMatricula(numeroMatricula)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllEnDictamenPrevioByMatricula(numeroMatricula)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(certServRes.getList()) )
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
	def findAllByIdSustentante(int id){
		int idSustentante
		//Referencias de objetos a utilizar
		Map<String,Object> responseModel
		def certServRes
		
		idSustentante = this.getNumeroMatriculaParam(params)
		
		responseModel = new HashMap<String,Object>()
		try{
			if(id == ModoBusqueda.DICTAMEN_PREVIO){
				certServRes = certificacionService.findAllEnDictamenPrevioByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.ACTUALIZACION_AUTORIZACION){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllEnDictamenPrevioByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllEnDictamenPrevioByFolio(idSustentante)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllEnDictamenPrevioByFolio(idSustentante)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(certServRes.getList()) )
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
				certServRes = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else if(id == ModoBusqueda.REPOSICION_AUTORIZACION){
				//aplican para todos aquellos cuya autorización en la última certificación se encuentra vencia
				certServRes = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else if(id == ModoBusqueda.CAMBIO_FIGURA){
				//aplican todos aquellos que estan autorizados con poderes, pasados 18 meses de su fecha de inicio
				//esta condición se aplica en la búsqueda de expediente
				certServRes = certificacionService.findAllEnDictamenPrevio(max, offset, sort, order, nombre, primerApellido, segundoApellido, idFigura, idVarianteFigura)
			}
			else{
				certServRes = null
			}
			
			if(certServRes != null){
				responseModel.put('status','OK')
				responseModel.put('list', ResultVM.copyFromServicesResults(certServRes.getList()) )
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
		
		public static List<ResultVM> copyFromServicesResults(List<CertificacionTO> certList){
			List<ResultVM> listRes = new ArrayList<ResultVM>()
			certList.each { x ->
				ResultVM vm = new ResultVM()
				vm.grailsId = x.id
				vm.idSustentante = x.sustentante.id
				vm.numeroMatricula = x.sustentante.numeroMatricula
				vm.nombre = x.sustentante.nombre
				vm.primerApellido = x.sustentante.primerApellido
				vm.segundoApellido = x.sustentante.segundoApellido
				vm.nombreFigura = x.varianteFigura.nombreFigura
				vm.nombreVarianteFigura = x.varianteFigura.nombre
				vm.dsStatusCertificacion = x.statusCertificacion.descripcion
				vm.dsStatusAutorizacion = x.statusAutorizacion.descripcion
				vm.dsFechaRangoVigencia = x.fechaInicio.toString() + ' - ' + x.fechaFin.toString()
				listRes.add(vm)
			}
			return listRes
		}
		
	}
}

public class ModoBusqueda{
	public static final int DICTAMEN_PREVIO = 0; 
	public static final int ACTUALIZACION_AUTORIZACION = 1;
	public static final int REPOSICION_AUTORIZACION = 2;
	public static final int CAMBIO_FIGURA = 3;
}