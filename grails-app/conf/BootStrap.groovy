class BootStrap {

	def sepomexService
	def entidadFinancieraService
	
    def init = { servletContext ->
		//descarga los catálogos necesarios de AMIB Catálogos en memoria
		sepomexService.descargarCatalogoEntidadFederativa()
		//descarga catálogos de grupos financieros e instituciones
		entidadFinancieraService.descargarCatalogo()
    }
    def destroy = {
		
    }
}
