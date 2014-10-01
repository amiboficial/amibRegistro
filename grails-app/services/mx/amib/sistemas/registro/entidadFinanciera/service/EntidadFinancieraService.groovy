package mx.amib.sistemas.registro.entidadFinanciera.service

import grails.transaction.Transactional

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class EntidadFinancieraService {

	def grailsApplication
	
    def obtenerGrupoFinanciero(long id, boolean cargaAsociados = false) {
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.GrupoFinanciero.getById
		String className = grailsApplication.config.mx.amib.sistemas.catalogos.general.GrupoFinanciero.classname
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl + id)
		resp.json instanceof JSONObject

		GrupoFinancieroTO grupoFinanciero = null
		
		if(resp.json.'class' == className){
			grupoFinanciero = new GrupoFinancieroTO()
			grupoFinanciero.id = resp.json.'id'
			grupoFinanciero.nombre = resp.json.'nombre'
			grupoFinanciero.vigente = resp.json.'vigente'.toBoolean()
		}
		
		return grupoFinanciero
    }
	
	def obtenerInstitucion(long id, boolean cargaAsociados = false) {
		String restUrl = grailsApplication.config.mx.amib.sistemas.catalogos.resthttpURL + grailsApplication.config.mx.amib.sistemas.catalogos.general.Institucion.getById
		String className = grailsApplication.config.mx.amib.sistemas.catalogos.general.Institucion.classname
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl + id)
		resp.json instanceof JSONObject
		
		InstitucionTO institutcion = null 
		
		if(resp.json.'class' == className){
			institutcion = new InstitucionTO()
			institutcion.id = resp.json.'id'
			institutcion.nombre = resp.json.'nombre'
			institutcion.vigente = resp.json.'vigente'.toBoolean()
			institutcion.idTipoInstitucion = resp.json.'tipoInstitucion'.'id'
			institutcion.grupoFinanciero = null
		}
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
	
	InstitucionTO[] instituciones
}

class InstitucionTO implements EntidadFinancieraTO {
	long id
	String nombre
	boolean vigente
	
	long idTipoInstitucion
	
	GrupoFinancieroTO grupoFinanciero
}