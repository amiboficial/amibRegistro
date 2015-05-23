class BootStrap {

	def sepomexService
	def entidadFinancieraService
	def estadoCivilService
	def figuraService
	def nacionalidadService
	def nivelEstudiosService
	def tipoTelefonoService

	//CATALOGOS PROPIOS DE EXPEDIENTE
	def metodoCertificacionService
	def statusAutorizacionService
	def statusCertificacionService

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

		//Descarga catálogos propios del sistema de expediente
		metodoCertificacionService.descargarCatalogo()
		statusAutorizacionService.descargarCatalogo()
		statusCertificacionService.descargarCatalogo()
    }
    def destroy = {
		
    }
}
