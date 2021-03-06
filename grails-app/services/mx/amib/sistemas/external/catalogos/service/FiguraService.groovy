package mx.amib.sistemas.external.catalogos.service

import java.util.Collection
import java.util.TreeMap
import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject
import grails.transaction.Transactional

@Transactional
class FiguraService {

	def grailsApplication
	
	def get(Long id){
		return FiguraCatalog.getInstance().getElement(id)
	}
	
	def list(){
		return FiguraCatalog.getInstance().getAllElements()
	}
	
	def getVariante(Long id){
		return VarianteFiguraCatalog.getInstance().getElement(id)
	}
	
	def listVariantes(){
		return VarianteFiguraCatalog.getInstance().getAllElements()
	}
	
    void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.Figura.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		
		if(resp.json != null){
			
			FiguraCatalog.getInstance().clearAll()
			VarianteFiguraCatalog.getInstance().clearAll()
			
			resp.json.each{ objjson ->
				def newobj = new FiguraTO()
				newobj.id = objjson.'id'
				newobj.nombre = objjson.'nombre'
				newobj.nombreAcuse = objjson.'nombreAcuse'
				newobj.esAutorizable = objjson.'esAutorizable'
				newobj.tipoAutorizacion = objjson.'tipoAutorizacion'
				newobj.iniciales = objjson.'iniciales'
				newobj.vigente = objjson.'vigente'.toBoolean()
				newobj.variantes = new ArrayList<VarianteFiguraTO>()
				objjson.'variantes'.each{ sobjjson ->
					def snewobj = new VarianteFiguraTO()
					snewobj.id = sobjjson.'id'
					snewobj.nombre = sobjjson.'nombre'
					snewobj.vigente = sobjjson.'vigente'.toBoolean()
					snewobj.figura = newobj
					newobj.variantes.add(snewobj)
					VarianteFiguraCatalog.getInstance().addElement(snewobj)
				}
				FiguraCatalog.getInstance().addElement(newobj)
			}
		}
	}
}

/**
 * Clase singleton que gestiona catálogo de figuras
 * en memoria
 *
 * @author Gabriel
 *
 */

class FiguraCatalog{
	private static FiguraCatalog _instance = null
	private TreeMap<Long,FiguraTO> _map = null
	
	private FiguraCatalog(){
		_map = new TreeMap<Long,FiguraTO>()
	}
	
	public static synchronized FiguraCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new FiguraCatalog()
		}
		return _instance
	}
	
	public void addElement(FiguraTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public FiguraTO getElement(Long id){
		return _map.get(id)
	}
	
	public List<FiguraTO> getAllElements(){
		return _map.values().toList()
	}
	
	public void clearAll(){
		_map.clear()
	}
}

class VarianteFiguraCatalog{
	private static VarianteFiguraCatalog _instance = null
	private TreeMap<Long,VarianteFiguraTO> _map = null
	
	private VarianteFiguraCatalog(){
		_map = new TreeMap<Long,VarianteFiguraTO>()
	}
	
	public static synchronized VarianteFiguraCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new VarianteFiguraCatalog()
		}
		return _instance
	}
	
	public void addElement(VarianteFiguraTO obj){
		if(!_map.containsKey(obj.id))
			_map.put(obj.id, obj)
	}
	
	public VarianteFiguraTO getElement(Long id){
		return _map.get(id)
	}
	
	public List<VarianteFiguraTO> getAllElements(){
		return _map.values().toList()
	}
	
	public void clearAll(){
		_map.clear()
	}
}

class FiguraTO{
	Long id
	String nombre
	String nombreAcuse
	Boolean esAutorizable
	String tipoAutorizacion
	String iniciales
	Boolean vigente
	List<VarianteFiguraTO> variantes
}

class VarianteFiguraTO{
	Long id
	String nombre
	Boolean vigente
	
	FiguraTO figura
}