package mx.amib.sistemas.registro.expediente.controller

import grails.converters.JSON

class ExpedienteRegistrableController {

	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def figuraService
	
    def index() { }
	
	def create() {
		def estadoCivilList = estadoCivilService.list()
		def nacionalidadList = nacionalidadService.list()
		def nivelEstudiosList = nivelEstudiosService.list()
		
		def varianteFiguraInstance = figuraService.getVariante(195)
		
		println (varianteFiguraInstance as JSON)
		
		respond new Object(), model:[varianteFiguraInstance: varianteFiguraInstance, estadoCivilList:estadoCivilList, nacionalidadList:nacionalidadList, nivelEstudiosList:nivelEstudiosList]
	}
	
}