package mx.amib.sistemas.external.catalogos.service

import java.util.Collection
import java.util.TreeMap
import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject
import grails.transaction.Transactional

@Transactional
class NivelEstudiosService {

	def grailsApplication
	
	def get(Long id){
		return NivelEstudiosCatalog.getInstance().getElement(id)
	}
	
	def list(){
		return NivelEstudiosCatalog.getInstance().getAllElements()
	}
	
    void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.personal.NivelEstudios.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			resp.json.each{ objjson ->
				def newobj = new NivelEstudiosTO()
				newobj.id = objjson.'id'
				newobj.descripcion = objjson.'descripcion'
				newobj.vigente = objjson.'vigente'.toBoolean()
				NivelEstudiosCatalog.getInstance().addElement(newobj)
			}
		}
	}
}

class NivelEstudiosCatalog{
	private static NivelEstudiosCatalog _instance = null
	private TreeMap<Long,NivelEstudiosTO> _map = null
	
	private NivelEstudiosCatalog(){
		_map = new TreeMap<Long,NivelEstudiosTO>()
	}
	
	public static synchronized NivelEstudiosCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new NivelEstudiosCatalog()
		}
		return _instance
	}
	
	public void addElement(NivelEstudiosTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public NivelEstudiosTO getElement(Long id){
		return _map.get(id)
	}
	
	public Collection<NivelEstudiosTO> getAllElements(){
		return _map.values()
	}
	
}

class NivelEstudiosTO{
	Long id
	String descripcion
	Boolean vigente
}