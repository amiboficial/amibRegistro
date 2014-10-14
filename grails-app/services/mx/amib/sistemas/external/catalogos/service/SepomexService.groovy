package mx.amib.sistemas.external.catalogos.service

import grails.transaction.Transactional
import java.util.TreeMap

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

//NOTA: Este servicio esta presente en:
//amibRegistro, amibCursosEventos
/**
 * Este servicio permite gestionar los catálogos SEPOMEX
 * (Código Postal, Asentamientos, Ciudad, Municipio,
 * Entidad Federativa)
 * 
 * @author Gabriel
 * @version 1.0 - (Última actualización) 13/09/2014
 *
 */
@Transactional
class SepomexService {
		
	String listEntidadFederativaUrl
	String findByCodigoPostalUrl
	
	/**
	 * Obtiene una instancia de EntidadFederativaTO de acuerdo
	 * al identificador proporcionado
	 * 
	 * @param id
	 * @return Instancia de EntidadFederativaTO
	 */
	EntidadFederativaTO obtenerEntidadFederativa(int id){
		def catef = EntidadFederativaCatalog.getInstance()
		return catef.obtenerEntidadFederativa(id)
	}
	
	/**
	 * Obtiene una lista con todas las instancias de EntidadFederativaTO
	 * correspondientes a cada una de las Entidades Federativas
	 * de México deacuerdo a SEPOMEX
	 * 
	 * @return Colección con todas la entidades federativas
	 */
    Collection<EntidadFederativaTO> obtenerEntidadesFederativas() {
		def catef = EntidadFederativaCatalog.getInstance()
		return catef.obtenerCatalogo()
    }
	
	/**
	 * Descarga el catálogo completo de Entidades Federativas
	 * del sistema amibCatalogos. Solo puede ser llamado una vez,
	 * de lo contrario, resultará en comportamiento inesperado.
	 * 
	 * Es recomendable que este método sea llamado al 
	 * inicio de la aplicación.
	 */
	void descargarCatalogoEntidadFederativa(){
		def catef = EntidadFederativaCatalog.getInstance()
		//aqui se descarga el catálogo usando REST
		String restUrl = listEntidadFederativaUrl
		
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
	
	/**
	 * Obtiene los datos obtenidos de Sepomex dado un código postal.
	 * Se obtiene una colección y no una simple instancia dado que 
	 * un código postal puede corresponder a mas de un asentamiento.
	 * 
	 * @param codigoPostal
	 * @return Colección de instancia de SepomexTO
	 */
	Collection<SepomexTO> obtenerDatosSepomexPorCodigoPostal(String codigoPostal){
		List<SepomexTO> listaSepomex = new ArrayList<SepomexTO>()
		def catef = EntidadFederativaCatalog.getInstance()
		
		String restUrl = findByCodigoPostalUrl + codigoPostal
		//prepara objetos que procesan rest
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		resp.json.each {
			SepomexTO spmx = new SepomexTO()
			spmx.id = it.'id'
			spmx.codigoPostal = it.'codigoPostal'
			spmx.vigente = true
			
			spmx.asentamiento = new AsentamientoTO()
			spmx.asentamiento.id = it.'asentamiento'.'id'
			spmx.asentamiento.clave = it.'asentamiento'.'clave'
			spmx.asentamiento.nombre = it.'asentamiento'.'nombre'
			spmx.asentamiento.vigente = it.'asentamiento'.'vigente'
			
			spmx.ciudad = new CiudadTO()
			spmx.ciudad.id = it.'ciudad'.'id'
			spmx.ciudad.clave = it.'ciudad'.'clave'
			spmx.ciudad.nombre = it.'ciudad'.'nombre'
			spmx.ciudad.vigente = it.'ciudad'.'vigente'
		
			//rellena datos de municipio
			MunicipioTO mun = new MunicipioTO()
			mun.id = it.'asentamiento'.'municipio'.'id'
			mun.clave = it.'asentamiento'.'municipio'.'clave'
			mun.nombre = it.'asentamiento'.'municipio'.'nombre'
			mun.vigente = it.'asentamiento'.'municipio'.'vigente'
			mun.entidadFederativa = catef.obtenerEntidadFederativa( (it.'asentamiento'.'municipio'.'idEntidadFederativa').toInteger() )
			
			spmx.asentamiento.municipio = mun
			spmx.ciudad.municipio = mun
			
			listaSepomex.add(spmx)
		}
		
		if(listaSepomex.size() == 0)
			listaSepomex = null
			
		return listaSepomex
	}
}

/**
 * Clase singleton que gestiona catálogo de entidades 
 * federativas en memoria
 * 
 * @author Gabriel
 *
 */
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

class MunicipioTO {
	long id
	String clave 
	String nombre
	boolean vigente
	
	EntidadFederativaTO entidadFederativa
}

class AsentamientoTO {
	long id
	String clave 
	String nombre
	boolean vigente
	
	MunicipioTO municipio
}

class CiudadTO {
	long id
	String clave
	String nombre
	boolean vigente
	
	MunicipioTO municipio
}

class SepomexTO {
	long id
	String codigoPostal
	boolean vigente
	
	AsentamientoTO asentamiento
	CiudadTO ciudad
}