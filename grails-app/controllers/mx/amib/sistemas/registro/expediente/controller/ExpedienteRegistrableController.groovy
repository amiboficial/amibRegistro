package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

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
	
}