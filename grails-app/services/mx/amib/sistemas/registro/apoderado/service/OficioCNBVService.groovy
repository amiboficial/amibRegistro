package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional
import grails.converters.JSON

import mx.amib.sistemas.registro.apoderamiento.model.AutorizadoCNBV
import mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV

@Transactional
class OficioCNBVService {

	def save(OficioCNBV oficioCNBVInstance, List<String> autorizadosJson){
		
		oficioCNBVInstance.autorizadosCNBV = new HashSet<OficioCNBV>()
		autorizadosJson.each{
			def parsedJson = JSON.parse(it)
			
			AutorizadoCNBV autorizadoCNBV = new AutorizadoCNBV()
			autorizadoCNBV.numeroMatricula = parsedJson.'numeroMatricula'
			autorizadoCNBV.nombreCompleto = parsedJson.'nombreCompleto'
			
			autorizadoCNBV.oficioCNBV = oficioCNBVInstance
			oficioCNBVInstance.autorizadosCNBV.add(autorizadoCNBV)
		}
		
		oficioCNBVInstance.fechaCreacion = new Date()
		oficioCNBVInstance.fechaModificacion = new Date()
		
		oficioCNBVInstance.save(flush:true, failOnError: true)
		
		return oficioCNBVInstance
	}
	
	def update(OficioCNBV oficioCNBVInstance, List<String> autorizadosJson){
		
		List<AutorizadoCNBV> autsToDelete = new ArrayList<AutorizadoCNBV>();
		List<AutorizadoCNBV> autsToAdd = new ArrayList<AutorizadoCNBV>();
		oficioCNBVInstance.autorizadosCNBV.each{
			it.toBeDeleted = true
		}
		autorizadosJson.each{ _autorizadoJson ->
			def parsedJson = JSON.parse(_autorizadoJson)
			AutorizadoCNBV autorizadoCNBV = oficioCNBVInstance.autorizadosCNBV.find{ it.numeroMatricula == parsedJson.'numeroMatricula' }
			if(autorizadoCNBV == null){
				autorizadoCNBV = new AutorizadoCNBV()
				autorizadoCNBV.numeroMatricula = parsedJson.'numeroMatricula'
				autorizadoCNBV.nombreCompleto = parsedJson.'nombreCompleto'
				autsToAdd.add(autorizadoCNBV)
			}
			autorizadoCNBV.toBeDeleted = false
		}
		oficioCNBVInstance.autorizadosCNBV.each{
			if(it.toBeDeleted == true)
			{
				autsToDelete.add(it)
			}
		}
		autsToDelete.each{
			oficioCNBVInstance.removeFromAutorizadosCNBV(it)
			it.delete(flush:true)
		}
		autsToAdd.each{
			it.oficioCNBV = oficioCNBVInstance
			oficioCNBVInstance.autorizadosCNBV.add(it)
		}
		
		oficioCNBVInstance.fechaCreacion = new Date()
		oficioCNBVInstance.fechaModificacion = new Date()
		
		oficioCNBVInstance.save(flush:true, failOnError: true)
		
		return oficioCNBVInstance
	}
}
