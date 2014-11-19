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
}
