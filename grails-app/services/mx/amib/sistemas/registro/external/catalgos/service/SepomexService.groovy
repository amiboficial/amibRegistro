package mx.amib.sistemas.registro.external.catalgos.service

import grails.transaction.Transactional
import java.util.TreeMap

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class SepomexService {
	
	def grailsApplication
	
	EntidadFederativaTO obtenerEntidadFederativa(int id){
		def catef = EntidadFederativaCatalog.getInstance()
		return catef.obtenerEntidadFederativa(id)
	}
	
    Collection<EntidadFederativaTO> obtenerEntidadesFederativas() {
		def catef = EntidadFederativaCatalog.getInstance()
		return catef.obtenerCatalogo()
    }
	
	void descargarCatalogoEntidadFederativa(){
		def catef = EntidadFederativaCatalog.getInstance()
		//aqui se descarga el catálogo usando REST
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.sepomex.EntidadFederativa.list
		String className = grailsApplication.config.mx.amib.sistemas.catalogos.sepomex.EntidadFederativa.classname
		
		//prepara objetos que procesan rest
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		resp.json.each {
			EntidadFederativaTO efed = new EntidadFederativaTO()
			efed.id = it.'id'
			efed.clave = it.'clave'
			efed.nombre = it.'nombre'
			catef.agregarEntidadFederativa(efed)
		}		
	}
	
}

class EntidadFederativaCatalog {
	
	private static EntidadFederativaCatalog _instance = null
	
	private TreeMap<Integer,EntidadFederativaTO> entidadesFederativas = null
	
	private EntidadFederativaCatalog(){
		entidadesFederativas = new TreeMap<Integer,EntidadFederativaTO>()
	}
	
	public static synchronized EntidadFederativaCatalog getInstance(){
		if(_instance == null)
		{
			_instance = new EntidadFederativaCatalog()
		}
		return _instance
	}
	
	public Collection<EntidadFederativaTO> obtenerCatalogo(){
		return this.entidadesFederativas.values()
	}
	
	public void agregarEntidadFederativa(EntidadFederativaTO e){
		this.entidadesFederativas.put(Integer.valueOf(e.id), e)
	}
	
	EntidadFederativaTO obtenerEntidadFederativa(int id){
		this.entidadesFederativas.get(Integer.valueOf(id))
	}
}

class EntidadFederativaTO {
	int id
	String clave
	String nombre
}