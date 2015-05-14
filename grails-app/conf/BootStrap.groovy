class BootStrap {

	def sepomexService
	def entidadFinancieraService
	def estadoCivilService
	def figuraService
	def nacionalidadService
	def nivelEstudiosService
	def tipoTelefonoService
	
    def init = { servletContext ->
		groovyx.net.http.ParserRegistry.setDefaultCharset("UTF-8");
		//descarga los catálogos necesarios de AMIB Catálogos en memoria
		//descarga catálogo de estado civil
		estadoCivilService.descargarCatalogo()
		//descarga catálogos de grupos financieros e instituciones
		entidadFinancieraService.descargarCatalogo()
		//descarga catalogo de figuras y sus variantes
		figuraService.descargarCatalogo()
		nacionalidadService.descargarCatalogo()
		nivelEstudiosService.descargarCatalogo()
		tipoTelefonoService.descargarCatalogo()
		//descarga catálogo de sepomex
		sepomexService.descargarCatalogoEntidadFederativa()
    }
    def destroy = {
		
    }
}
