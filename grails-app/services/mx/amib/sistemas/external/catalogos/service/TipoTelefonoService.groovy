package mx.amib.sistemas.external.catalogos.service

import java.util.Collection
import java.util.TreeMap
import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject
import grails.transaction.Transactional

@Transactional
class TipoTelefonoService {

    def grailsApplication
	
	def get(Long id){
		TipoTelefonoCatalog.getInstance().getElement(id)
	}
	
    def list(){
		TipoTelefonoCatalog.getInstance().getAllElements()
    }
	
	void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.personal.TipoTelefono.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			resp.json.each{ objjson ->
				def newobj = new TipoTelefonoTO()
				newobj.id = objjson.'id'
				newobj.descripcion = objjson.'descripcion'
				newobj.vigente = objjson.'vigente'.toBoolean()
				TipoTelefonoCatalog.getInstance().addElement(newobj)
			}
		}
	}
}

/**
 * Clase singleton que gestiona catálogo de tipos de telefono
 * en memoria
 *
 * @author Gabriel
 *
 */

class TipoTelefonoCatalog{
	private static TipoTelefonoCatalog _instance = null
	private TreeMap<Long,TipoTelefonoTO> _map = null
	
	private TipoTelefonoCatalog(){
		_map = new TreeMap<Long,TipoTelefonoTO>()
	}
	
	public static synchronized TipoTelefonoCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new TipoTelefonoCatalog()
		}
		return _instance
	}
	
	public void addElement(TipoTelefonoTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public TipoTelefonoTO getElement(Long id){
		return _map.get(id)
	}
	
	public Collection<TipoTelefonoTO> getAllElements(){
		return _map.values()
	}
}

class TipoTelefonoTO{
	Long id
	String descripcion
	boolean vigente
}