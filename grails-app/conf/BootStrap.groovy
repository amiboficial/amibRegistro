class BootStrap {

	def sepomexService
	
    def init = { servletContext ->
		//descarga los catálogos necesarios de AMIB Catálogos en memoria
		sepomexService.descargarCatalogoEntidadFederativa()
    }
    def destroy = {
    }
}
