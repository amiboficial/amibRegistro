package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class ExpedienteRegistrableController {

	def entidadFinancieraService
	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def figuraService
	def tipoTelefonoService
	
    def index() { }
	
	def create() {
		def estadoCivilList = estadoCivilService.list()
		def institucionesList = entidadFinancieraService.obtenerInstituciones()
		def nacionalidadList = nacionalidadService.list()
		def nivelEstudiosList = nivelEstudiosService.list()
		def tipoTelefonoList = tipoTelefonoService.list()
		
		def institutoInstance = entidadFinancieraService.obtenerInstitucion(4) //<-se obtiene del elemento "registrable"
		def varianteFiguraInstance = figuraService.getVariante(195) //<-se obtiene del elemento "registrable"

		respond new Object(), model:[institutoInstance: institutoInstance, varianteFiguraInstance: varianteFiguraInstance, 
										estadoCivilList:estadoCivilList, institucionesList: institucionesList, nacionalidadList:nacionalidadList, 
										nivelEstudiosList:nivelEstudiosList, tipoTelefonoList: tipoTelefonoList]
	}

	def save(SustentanteTO sustentante) {
		println "Se obtuvo la siguiente información"

		println "* " + sustentante.nombre
		println "* " + sustentante.primerApellido
		println "* " + sustentante.segundoApellido
		println "* " + sustentante.genero
		println "(de params): " + params.'sustentante.fechaNacimiento_year'

		println "* " + sustentante.fechaNacimiento.toString()



		respond new Object()
	}
}