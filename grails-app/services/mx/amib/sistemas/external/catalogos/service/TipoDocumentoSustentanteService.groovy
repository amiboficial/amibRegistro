package mx.amib.sistemas.external.catalogos.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

@Transactional
class TipoDocumentoSustentanteService {

	def grailsApplication
	Map<Long, TipoDocumentoSustentanteTO> _catalogo = null
	
    def get(Long id){
		return _catalogo.get(id)
	}
	
    def list(){
		return _catalogo.values().asList()
    }
	
	void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.personal.TipoDocumentoSustentante.list
		
		println restUrl
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		
		if(resp.json != null){
			_catalogo = new HashMap<Long, TipoDocumentoSustentanteTO>()
			resp.json.each{ objjson ->
				def newobj = new TipoDocumentoSustentanteTO()
				newobj.id = objjson.'id'
				newobj.descripcion = objjson.'descripcion'
				newobj.vigente = objjson.'vigente'.toBoolean()
				_catalogo.put(newobj.id, newobj)
			}
		}
	}
}

class TipoDocumentoSustentanteTO{
	long id
	String descripcion
	boolean vigente
}