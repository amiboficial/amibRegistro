package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import javax.servlet.ServletOutputStream
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.registro.expediente.service.FormatoSolicitudAutorizacionService
import mx.amib.sistemas.registro.expediente.service.LoteEnvioAutorizacionService

class LoteEnvioAutorizacionController {

	LoteEnvioAutorizacionService loteEnvioAutorizacionService
	CertificacionService certificacionService
	FormatoSolicitudAutorizacionService formatoSolicitudAutorizacionService
	
    def index() { 
		
	}

	def downloadAsExcel(){
		Set<Long> qresult = null
		List<CertificacionTO> certs = null
		//ServletOutputStream sos = 
		
		qresult = loteEnvioAutorizacionService.getSet(this.session.id)
		certs = certificacionService.getAll(qresult.toList())
		
		formatoSolicitudAutorizacionService.fill(certs)
		if(certs.size() > 0){
			
			response.setContentType('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
			response.setHeader('Content-disposition', 'attachment;filename=\"envioAutorizacion' + (int)(System.currentTimeMillis()/1000) + '.xlsx\"')
			try{
				formatoSolicitudAutorizacionService.renderAsXLSX(response.outputStream)
				response.outputStream.flush()
			}
			catch(IOException e){
				response.sendError(404)
			}
			finally{
				response.outputStream.close()
			}
			
			return
		}
		else {
			response.sendError(404)
			return
		}
	}
	
	def getAllCompleteResult(){
		Map<String,String> result = new HashMap<String,String>()
		Set<Long> qresult = null
		List<CertificacionTO> certs = null 
		
		String sort = params.'sort'?:"id"
		String order = params.'order'?:"asc"
		
		try{
			qresult = loteEnvioAutorizacionService.getSet(this.session.id)
			certs = certificacionService.getAll(qresult.toList())
			
			result.put("status","OK")
			result.put("object", ResultElement.copyFromServicesResults(certs, sort, order) )
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def getAll(){
		Map<String,String> result = new HashMap<String,String>()
		Set<Long> qresult = null
		
		try{
			qresult = loteEnvioAutorizacionService.getSet(this.session.id)
			result.put("status","OK")
			result.put("object",qresult)
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def add(long id){
		Map<String,String> result = new HashMap<String,String>()
		long idCert = id
		
		try{
			loteEnvioAutorizacionService.add(this.session.id, idCert)
			result.put("status","OK")
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def addAll(){
		Map<String,String> result = new HashMap<String,String>()
		List<Long> idsCertList = new ArrayList<Long>()
		
		try{
			request.JSON.'ids'.each{ x -> 
				idsCertList.add( new Long(x) )
			}
			loteEnvioAutorizacionService.addAll(this.session.id, idsCertList)
			result.put("status","OK")
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def remove(long id){
		Map<String,String> result = new HashMap<String,String>()
		long idCert = id
		
		try{
			loteEnvioAutorizacionService.remove(this.session.id, idCert)
			result.put("status","OK")
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def removeAll(){
		Map<String,String> result = new HashMap<String,String>()
		List<Long> idsCertList = new ArrayList<Long>()
		
		try{
			request.JSON.'ids'.each{ x ->
				idsCertList.add( new Long(x) )
			}
			loteEnvioAutorizacionService.removeAll(this.session.id, idsCertList)
			result.put("status","OK")
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def clear(){
		Map<String,String> result = new HashMap<String,String>()
		
		try{
			loteEnvioAutorizacionService.clear(this.session.id)
			result.put("status","OK")
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	def count(){
		Map<String,String> result = new HashMap<String,String>()
		try{
			//qresult = loteEnvioAutorizacionService.getSet(this.session.id)
			result.put("status","OK")
			result.put("object",loteEnvioAutorizacionService.count(this.session.id))
		}
		catch(Exception e){
			result.put("status","ERROR")
			result.put("errorDetail",e.message)
		}
		
		render (result as JSON)
	}
	
	public static class ResultElement{
		long grailsId
		long idSustentante
		int numeroMatricula
		String nombre
		String primerApellido
		String segundoApellido
		String fechaEntrega
		String fechaEnvio
		String tipoSolicitud
		
		public static List<ResultElement> copyFromServicesResults(List<CertificacionTO> certs, String sort, String order){
			List<ResultElement> rel = new ArrayList<ResultElement>()
			ResultElement re = null
			
			certs.each{ x ->
				re = new ResultElement()
				re.grailsId = x.id
				re.idSustentante = x.sustentante.id
				re.numeroMatricula = x.sustentante.numeroMatricula
				re.nombre = x.sustentante.nombre
				re.primerApellido = x.sustentante.primerApellido
				re.segundoApellido = x.sustentante.segundoApellido
				
				if(x.fechaEntregaRecepcion != null){
					re.fechaEntrega = x.fechaEntregaRecepcion.format( 'yyyy-MM-dd' )
				}
				else{
					re.fechaEntrega = ""
				}
				if(x.fechaEnvioComision != null){
					re.fechaEnvio = x.fechaEnvioComision.format( 'yyyy-MM-dd' )
				}
				else{
					re.fechaEnvio = ""
				}
				if(x.validaciones!= null && !x.validaciones.isEmpty()){
					Date lastone;
					for(ValidacionTO va: x.validaciones){
						if(lastone==null){
							lastone = va.fechaModificacion;
						}else if(lastone != null && lastone<va.fechaModificacion){
							lastone = va.fechaModificacion;
						}
					}
					def lastVali = x.validaciones.find{it.fechaModificacion == lastone}
					re.tipoSolicitud = lastVali.metodoValidacion.descripcion
				}
				
				rel.add(re)
			}
			
			//Sorting & ordering
			if(sort == "id"){
				if(order == "desc"){
					rel = rel.sort{ it.idSustentante }.reverse()
				}
				else{
					rel = rel.sort{ it.idSustentante }
				}
			}
			if(sort == "numeroMatricula"){
				if(order == "desc"){
					rel = rel.sort{ it.numeroMatricula }.reverse()
				}
				else{
					rel = rel.sort{ it.numeroMatricula }
				}
			}
			else if(sort == "nombre"){
				if(order == "desc"){
					rel = rel.sort{ it.nombre }.reverse()
				}
				else{
					rel = rel.sort{ it.nombre }
				}
			}
			else if(sort == "primerApellido"){
				if(order == "desc"){
					rel = rel.sort{ it.primerApellido }.reverse()
				}
				else{
					rel = rel.sort{ it.primerApellido }
				}
			}
			else if(sort == "segundoApellido"){
				if(order == "desc"){
					rel = rel.sort{ it.segundoApellido }.reverse()
				}
				else{
					rel = rel.sort{ it.segundoApellido }
				}
			}
			
			return rel
		}
	}
	
}
