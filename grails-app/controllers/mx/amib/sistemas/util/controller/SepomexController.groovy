package mx.amib.sistemas.util.controller

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.SepomexTO

class SepomexController {

	def sepomexService
	
    def obtenerDatosSepomex(String id) 
	{
		Collection<SepomexTO> sepomexData = null
		def res = null
		try
		{
			sepomexData = sepomexService.obtenerDatosSepomexPorCodigoPostal(id)
			if(sepomexData != null && sepomexData.size() > 0)
				res = [ status: 'OK', object: sepomexData ]
			else
			res = [ status: 'NO_DATA' ]
		}
		catch(Exception ex){
			res = [ status: 'ERROR', object: ex.message ]
		}
		render res as JSON
	}
	
}
