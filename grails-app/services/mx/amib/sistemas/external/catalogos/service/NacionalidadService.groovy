package mx.amib.sistemas.external.catalogos.service

import java.util.Collection;
import java.util.TreeMap

import grails.plugins.rest.client.RestBuilder

import org.codehaus.groovy.grails.web.json.JSONObject

import grails.transaction.Transactional

@Transactional
class NacionalidadService {

	def grailsApplication
	
	def get(Long id){
		return NacionalidadCatalog.getInstance().getElement(id)
	}
	
	def list(){
		return NacionalidadCatalog.getInstance().getAllElements()
	}
	
	void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.personal.Nacionalidad.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			resp.json.each{ objjson ->
				def newobj = new NacionalidadTO()
				newobj.id = objjson.'id'
				newobj.descripcion = objjson.'descripcion'
				newobj.vigente = objjson.'vigente'.toBoolean()
				NacionalidadCatalog.getInstance().addElement(newobj)
			}
		}
	}
}

/**
 * Clase singleton que gestiona catálogo de nacionalidades
 * en memoria
 *
 * @author Gabriel
 *
 */

class NacionalidadCatalog{
	private static NacionalidadCatalog _instance = null
	private TreeMap<Long,NacionalidadTO> _map = null
	
	private NacionalidadCatalog(){
		_map = new TreeMap<Long,NacionalidadTO>()
	}
	
	public static synchronized NacionalidadCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new NacionalidadCatalog()
		}
		return _instance
	}
	
	public void addElement(NacionalidadTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public NacionalidadTO getElement(Long id){
		return _map.get(id)
	}
	
	public Collection<NacionalidadTO> getAllElements(){
		return _map.values()
	}
	
}

class NacionalidadTO{
	Long id
	String descripcion
	Boolean vigente
}
