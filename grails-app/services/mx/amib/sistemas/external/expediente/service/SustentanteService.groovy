package mx.amib.sistemas.external.expediente.service

import org.apache.http.HttpStatus

import java.util.Date
import java.text.DateFormat
import java.text.SimpleDateFormat
import org.codehaus.groovy.grails.web.json.JSONObject
import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.catalog.service.NacionalidadTO
import mx.amib.sistemas.external.expediente.persona.catalog.service.NivelEstudiosTO
import mx.amib.sistemas.external.expediente.persona.service.*

//NOTA: Este servicio esta presente en:
//amibRegistro, amibCursosEventos

/**
 * Este servicio nos permite gestionar datos del expediente de un sustentante,
 * haciendo uso de llamados a servicios REST a amibExpediente.
 * 
 * @author Gabriel
 * @version 1.0 - (Última actualización) 13/09/2014
 *			1.1 - TODO: Se tiene que cambiar de paquete
 *			1.2 - Se agrega metodo save
 *			1.3 - Se agrega metodo para comprobar matriculas
 */
@Transactional
class SustentanteService {

	String comprobarMatriculasUrl
	String comprobarMatriculasNotInUrl
	String findAllUrl
	String findAllAdvancedSearchUrl
	String findAllAdvancedSearchWithCertificacionUrl
	String getUrl
	String getByNumeroMatriculaUrl
	String saveUrl

	Collection<Integer> comprobarMatriculas(Collection<Integer> matriculasComprobar){
		Collection<Integer> result = new ArrayList<Integer>()
		def rest = new RestBuilder()
		def resp = rest.post(comprobarMatriculasUrl){
			json {
				matriculas = matriculasComprobar
			}
		}
		if(resp.json != null) {
			result = new ArrayList<Integer>( resp.json )
		}
		return result
	}

	Collection<Integer> comprobarMatriculasNotIn(Collection<Integer> matriculasComprobar){
		Collection<Integer> result = new ArrayList<Integer>()
		def rest = new RestBuilder()
		def resp = rest.post(comprobarMatriculasNotInUrl){
			json {
				matriculas = matriculasComprobar
			}
		}
		if(resp.json != null) {
			result = new ArrayList<Integer>( resp.json )
		}
		return result
	}

	/**
	 * Obtiene los datos de un sustentante dado su 
	 * número de matrícula
	 * 
	 * @param numeroMatricula
	 * @return Instancia de sustentanteTO con datos del 
	 * 			sustentante. Si no se encontró, entonces
	 * 			regresa nulo.
	 */
    SustentanteTO obtenerPorMatricula(int numeroMatricula) {
		SustentanteTO sustentante = null
		def rest = new RestBuilder()
		def resp = rest.get(getByNumeroMatriculaUrl + numeroMatricula)
		
		if(resp.json != null && resp.json instanceof JSONObject){
			sustentante = this.obtenerSustentanteFromJSON(resp.json)
		}
		return sustentante
    }



	/**
	 * Guarda los datos de un nuevo sustentante
	 * en el sistema de expediente. Los detalles de certificación,
	 * puestos, certificaciones y puestos también son incluidos.
	 *
	 * @param sustentante
	 *
	 */
	void guardarNuevo(SustentanteTO sustentante){
		sustentante.id = null

		println saveUrl

		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}

		if(resp.statusCode.value() != HttpStatus.SC_CREATED )
			throw new Exception("STATUS CODE: " + resp.statusCode)
	}
	
	SustentanteTO get(long id){
		SustentanteTO sustentante = null 
		
		def rest = new RestBuilder()
		def resp = rest.post(getUrl + "/" + id){
		}
		
		if(resp.json != null && resp.json instanceof JSONObject) {
			sustentante = this.obtenerSustentanteFromJSON(resp.json)
		}
		
		return sustentante
	}
	
	SustentanteTO findByMatricula(int numeroMatricula){
		return this.obtenerPorMatricula(numeroMatricula)
	}
	
	SearchResult findAll(Integer max, Integer offset, String sort, String order){
		SearchResult sr = new SearchResult()
		String url = findAllUrl + "?max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		
		println "La url es: " + url
		
		def rest = new RestBuilder() 
		def resp = rest.get(url)
		
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			sr.list = lista
			sr.count = resp.json.'count'
			sr.error = resp.json.'error'
			sr.errorDetails = resp.json.'errorDetails'
		}
		else{
			sr.error = true
			sr.errorDetails = "NON_JSON_RESPONSE"
		}
		return sr
	}
	
	SearchResult findAllAdvancedSearch(String nom, String ap1, String ap2, 
		Integer max, Integer offset, String sort, String order){
		
		SearchResult sr = new SearchResult()
		String url = findAllAdvancedSearchUrl + "?max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order +
		"&nom=" + nom + "&ap1=" + ap1 + "&ap2=" + ap2
		println "La url es: " + url
		
		def rest = new RestBuilder()
		def resp = rest.get(url)
		
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			sr.list = lista
			sr.count = resp.json.'count'
			sr.error = resp.json.'error'
			sr.errorDetails = resp.json.'errorDetails'
		}
		else{
			sr.error = true
			sr.errorDetails = "NON_JSON_RESPONSE"
		}
		return sr
	}
		
	SearchResult findAllAdvancedSearchWithCertificacion(String nom, String ap1, String ap2, 
		Long idfig, Long idvarfig, Long stcert, Long staut, 
		Integer max, Integer offset, String sort, String order){
		
		SearchResult sr = new SearchResult()
		String url = findAllAdvancedSearchWithCertificacionUrl + "?max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order + 
						"&nom=" + nom + "&ap1=" + ap1 + "&ap2=" + ap2 + "&idfig=" + idfig + "&idvarfig=" + idvarfig + 
						"&stcert=" + stcert + "&staut=" + staut
		println "La url es: " + url
		
		def rest = new RestBuilder()
		def resp = rest.get(url)
		
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			sr.list = lista
			sr.count = resp.json.'count'
			sr.error = resp.json.'error'
			sr.errorDetails = resp.json.'errorDetails'
		}
		else{
			sr.error = true
			sr.errorDetails = "NON_JSON_RESPONSE"
		}
		return sr
	}
	
	private SustentanteTO obtenerSustentanteFromJSON(JSONObject data){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		SustentanteTO sustentante = new SustentanteTO()
		sustentante.id = data.'id'
		sustentante.numeroMatricula = data.'numeroMatricula'
		sustentante.nombre = data.'nombre'
		sustentante.primerApellido = data.'primerApellido'
		sustentante.segundoApellido = data.'segundoApellido'
		sustentante.genero = data.'genero'
		sustentante.rfc = data.'rfc'
		sustentante.curp = data.'curp'
		sustentante.fechaNacimiento = df.parse(data.'fechaNacimiento'.substring(0,10))
		sustentante.correoElectronico = data.'correoElectronico'
		sustentante.nacionalidad = new NacionalidadTO()
		if(data.'nacionalidad' instanceof JSONObject && JSONObject.NULL.equals(data.'nacionalidad')){
			sustentante.nacionalidad.id = data.'nacionalidad'.'id'
			sustentante.nacionalidad.descripcion = data.'nacionalidad'.'descripcion'
			sustentante.nacionalidad.vigente = data.'nacionalidad'.'vigente'
		}
		sustentante.nivelEstudios = new NivelEstudiosTO()
		if(data.'nivelEstudios' instanceof JSONObject && JSONObject.NULL.equals(data.'nivelEstudios')){
			sustentante.nivelEstudios.id = data.'nivelEstudios'.'id'
			sustentante.nivelEstudios.descripcion = data.'nivelEstudios'.'descripcion'
			sustentante.nivelEstudios.vigente = data.'nivelEstudios'.'vigente'
		}
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		sustentante.puestos = new ArrayList<PuestoTO>()
		sustentante.certificaciones = new ArrayList<CertificacionTO>()
		return sustentante
	}
}

class SearchResult {
	List<SustentanteTO> list
	Integer count
	boolean error
	String errorDetails
}