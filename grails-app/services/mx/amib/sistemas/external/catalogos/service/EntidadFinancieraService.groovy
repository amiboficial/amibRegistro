package mx.amib.sistemas.external.catalogos.service

import grails.transaction.Transactional

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class EntidadFinancieraService {

	def grailsApplication
	
	private HashMap<Long,GrupoFinancieroTO> gruposFinancieros = new HashMap<Long,GrupoFinancieroTO>()
	private HashMap<Long,InstitucionTO> instituciones = new HashMap<Long,EntidadFinancieraTO>()
	
    def obtenerGrupoFinanciero(long id) {
		
		GrupoFinancieroTO grupoFinanciero = null
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.GrupoFinanciero.getById
		
		if(this.gruposFinancieros.containsKey( Long.valueOf(id) )) {
			grupoFinanciero = this.gruposFinancieros.get(Long.valueOf(id))
		}
		else{
			grupoFinanciero = this.descargarGrupoFinanciero(id)
		}
		return grupoFinanciero
    }
	
	def obtenerInstitucion(long id) {
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.Institucion.getById
		
		InstitucionTO institutcion = null
		
		//si la institucion ya esta almacenda
		if(this.instituciones.containsKey( Long.valueOf(id) )) {
			institutcion = this.instituciones.get(Long.valueOf(id))
		}
		else{
			
			def rest = new RestBuilder()
			def resp = rest.get(restUrl + id)
			resp.json instanceof JSONObject
			
			if(resp.json != null){
				long idgp = resp.json.'idGrupoFinanciero'
				//el descargar el grupo financiero hace que se almacene la información
				//de la respectiva institución
				def gp = this.descargarGrupoFinanciero( idgp )
				//se obtiene la información de la institución
				institutcion = this.instituciones.get( Long.valueOf(id) )
			}
			
		}			
	}
	
	private GrupoFinancieroTO descargarGrupoFinanciero(long id) {
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.GrupoFinanciero.getById
		GrupoFinancieroTO grupoFinanciero = null
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl + id)
		resp.json instanceof JSONObject
		
		if(resp.json != null){
			grupoFinanciero = new GrupoFinancieroTO()
			grupoFinanciero.id = resp.json.'id'
			grupoFinanciero.nombre = resp.json.'nombre'
			grupoFinanciero.vigente = resp.json.'vigente'.toBoolean()
			
			List<InstitucionTO> ins = new ArrayList<InstitucionTO>()
			
			resp.json.'instituciones'.each{
				InstitucionTO i = new InstitucionTO()
				i = new InstitucionTO()
				i.id = it.'id'
				i.nombre = it.'nombre'
				i.vigente = it.'vigente'.toBoolean()
				i.idTipoInstitucion = it.'idTipoInstitucion'
				i.grupoFinanciero = grupoFinanciero
				
				ins.add(i)
				if(!this.instituciones.containsKey( Long.valueOf(i.id) ))
					this.instituciones.put(Long.valueOf(i.id),i)
			}
			
			grupoFinanciero.instituciones = ins
		}
		this.gruposFinancieros.put( Long.valueOf(id) , grupoFinanciero )
		return grupoFinanciero
	}
	
}

interface EntidadFinancieraTO {
	long id
	String nombre
	boolean vigente
}

class GrupoFinancieroTO implements EntidadFinancieraTO {
	long id
	String nombre
	boolean vigente
	
	Collection<InstitucionTO> instituciones
}

class InstitucionTO implements EntidadFinancieraTO {
	long id
	String nombre
	boolean vigente
	
	long idTipoInstitucion
	
	GrupoFinancieroTO grupoFinanciero
}