package mx.amib.sistemas.external.catalogos.service

import grails.transaction.Transactional

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class EntidadFinancieraService {

	def grailsApplication
	
	private HashMap<Long,GrupoFinancieroTO> gruposFinancieros = new HashMap<Long,GrupoFinancieroTO>()
	private HashMap<Long,InstitucionTO> instituciones = new HashMap<Long,EntidadFinancieraTO>()

	//Propiedades
	Date ultimaActualizacionGruposFinancieros = new Date()
	Date ultimaActualizacionInstituciones = new Date()
	
    GrupoFinancieroTO obtenerGrupoFinanciero(long id) {
		GrupoFinancieroTO grupoFinanciero = null
		if(this.gruposFinancieros.containsKey( Long.valueOf(id) )) {
			grupoFinanciero = this.gruposFinancieros.get(Long.valueOf(id))
		}
		return grupoFinanciero
    }
	
	Collection<GrupoFinancieroTO> obtenerGruposFinancierosVigentes(){
		List<GrupoFinancieroTO> gpvig = new ArrayList<GrupoFinancieroTO>()
		
		gruposFinancieros.values().sort{it.nombre}.each{
			if(it.vigente == true){
				gpvig.add(it)
			}
				
		}
		
		return gpvig
	}
	
	InstitucionTO obtenerInstitucion(Long id) {
		InstitucionTO institutcion = null
		
		if(id != null && this.instituciones.containsKey( id ) ) {
			institutcion = this.instituciones.get(id)
		}
		return institutcion
	}

	Collection<InstitucionTO> obtenerInstituciones() {
		return this.instituciones.values().sort{it.nombre}.findAll{it.vigente == true};
	}
	
	void descargarCatalogo(){
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.GrupoFinanciero.list
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			resp.json.each{ gfjson -> 
				def grupoFinanciero = new GrupoFinancieroTO()
				grupoFinanciero.id = gfjson.'id'
				grupoFinanciero.nombre = gfjson.'nombre'
				grupoFinanciero.vigente = gfjson.'vigente'.toBoolean()
				
				List<InstitucionTO> ins = new ArrayList<InstitucionTO>()
				gfjson.'instituciones'.each{ ijson ->
					def i = new InstitucionTO()
					i.id = ijson.'id'
					i.nombre = ijson.'nombre'
					i.vigente = ijson.'vigente'.toBoolean()
					i.idTipoInstitucion = ijson.'idTipoInstitucion'
					i.grupoFinanciero = grupoFinanciero
					
					ins.add(i)
					if(!this.instituciones.containsKey( Long.valueOf(i.id) ))
						this.instituciones.put(Long.valueOf(i.id),i)
				}
				grupoFinanciero.instituciones = new InstitucionTO[ ins.size() ]
				ins.toArray(grupoFinanciero.instituciones)
				
				if(!this.gruposFinancieros.containsKey( Long.valueOf(grupoFinanciero.id) ))
					this.gruposFinancieros.put( Long.valueOf(grupoFinanciero.id) , grupoFinanciero )
			}
		}
	}
	
	void limpiarCatalogo(){
		this.gruposFinancieros.clear()
		this.instituciones.clear()
	}
	
}

interface EntidadFinancieraTO {
	long id
	String nombre
	Boolean vigente
}

class GrupoFinancieroTO implements EntidadFinancieraTO {
	long id
	String nombre
	Boolean vigente
	
	InstitucionTO[] instituciones
}

class InstitucionTO implements EntidadFinancieraTO {
	long id
	String nombre
	Boolean vigente
	
	long idTipoInstitucion
	
	GrupoFinancieroTO grupoFinanciero
}