package mx.amib.sistemas.external.catalogos.service

import java.util.TreeMap;
import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject
import grails.transaction.Transactional

@Transactional
class EstadoCivilService {

	def grailsApplication
	
	def get(Long id){
		EstadoCivilCatalog.getInstance().getElement(id)
	}
	
    def list(){
		EstadoCivilCatalog.getInstance().getAllElements()
    }
	
	void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.personal.EstadoCivil.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			resp.json.each{ objjson ->
				def newobj = new EstadoCivilTO()
				newobj.id = objjson.'id'
				newobj.descripcion = objjson.'descripcion'
				newobj.vigente = objjson.'vigente'.toBoolean()
				EstadoCivilCatalog.getInstance().addElement(newobj)
			}
		}
	}
}

/**
 * Clase singleton que gestiona catálogo de estados civiles 
 * en memoria
 *
 * @author Gabriel
 *
 */
class EstadoCivilCatalog{
	private static EstadoCivilCatalog _instance = null
	private TreeMap<Long,EntidadFederativaTO> _map = null
	
	private EstadoCivilCatalog(){
		_map = new TreeMap<Long,EstadoCivilTO>()
	}
	
	public static synchronized EstadoCivilCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new EstadoCivilCatalog()
		}
		return _instance
	}
	
	public void addElement(EstadoCivilTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public EstadoCivilTO getElement(Long id){
		return _map.get(id)
	}
	
	public Collection<EstadoCivilTO> getAllElements(){
		return _map.values()
	}
	
}

class EstadoCivilTO{
	Long id
	String descripcion
	boolean vigente
}