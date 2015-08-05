package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.expediente.service.CertificacionService

class CertificacionEnvioAutorizacionController {

	CertificacionService certificacionService
	
    def index() { 
		
	}
		
	def indexOld(){
		
	}
	
	def findAllByMatricula(Integer id){
		def res = null
				
		try{
			res = [ 'status' : 'OK' , 'object' : certificacionService.findAllEnAutorizacionByMatricula(id.value) ]
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def findAllByIdSustentante(Long id){
		def res = null
						
		try{
			res = [ 'status' : 'OK' , 'object' : certificacionService.findAllByIdSustentante(id.value) ]
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
	def findAll(){
		def res = null
		
		int max = Integer.parseInt(params.max?:"10")
		int offset = Integer.parseInt(params.offset?:"0")
		String sort = params.sort?:"id"
		String order = params.order?:"asc"
		
		String nom = params.nom?:""
		String ap1 = params.ap1?:""
		String ap2 = params.ap2?:""
		long idfig = Long.parseLong(params.idfig?:"-1")
		long idvarfig = Long.parseLong(params.idvarfig?:"-1")
		
		
		try{
			res = [ 'status' : 'OK' , 'object' : certificacionService.findAllEnAutorizacion(max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig) ] 
		}
		catch(Exception ex){
			res = [ 'status': 'ERROR', 'object': ex.message ]
		}
		
		render (res as JSON)
	}
	
}
