package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.service.CertificacionService
import mx.amib.sistemas.registro.expediente.service.LoteEnvioAutorizacionService

class LoteEnvioAutorizacionController {

	LoteEnvioAutorizacionService loteEnvioAutorizacionService
	CertificacionService certificacionService
	
    def index() { 
		
	}

	def getAllCertificados(){
		Map<String,String> result = new HashMap<String,String>()
		Set<Long> qresult = null
		List<CertificacionTO> certs = null 
		
		String sort = params.'sort'?:"id"
		String order = params.'order'?:"asc"
		
		try{
			qresult = loteEnvioAutorizacionService.getSet(this.session.id)
			certs = certificacionService.getAll(qresult.toList())
						
			//Sorting & ordering
			if(sort == "id"){
				if(order == "desc"){
					certs = certs.sort{ it.sustentante.id }.reverse()
				}
				else{
					certs = certs.sort{ it.sustentante.id }
				}
			}
			if(sort == "numeroMatricula"){
				if(order == "desc"){
					certs = certs.sort{ it.sustentante.numeroMatricula }.reverse()
				}
				else{
					certs = certs.sort{ it.sustentante.numeroMatricula }
				}
			}
			else if(sort == "nombre"){
				if(order == "desc"){
					certs = certs.sort{ it.sustentante.nombre }.reverse()
				}
				else{
					certs = certs.sort{ it.sustentante.nombre }
				}
			}
			else if(sort == "primerApellido"){
				if(order == "desc"){
					certs = certs.sort{ it.sustentante.primerApellido }.reverse()
				}
				else{
					certs = certs.sort{ it.sustentante.primerApellido }
				}
			}
			else if(sort == "segundoApellido"){
				if(order == "desc"){
					certs = certs.sort{ it.sustentante.segundoApellido }.reverse()
				}
				else{
					certs = certs.sort{ it.sustentante.segundoApellido }
				}
			}
			
			result.put("status","OK")
			result.put("object", certs )
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
		
}
