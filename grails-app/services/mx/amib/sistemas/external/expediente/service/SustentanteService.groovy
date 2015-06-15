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

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		
		if(resp.json != null && resp.json instanceof JSONObject){
			sustentante = new SustentanteTO()
			sustentante.id = resp.json.'id'
			sustentante.numeroMatricula = resp.json.'numeroMatricula'
			sustentante.nombre = resp.json.'nombre'
			sustentante.primerApellido = resp.json.'primerApellido'
			sustentante.segundoApellido = resp.json.'segundoApellido'
			sustentante.genero = resp.json.'genero'
			sustentante.rfc = resp.json.'rfc'
			sustentante.curp = resp.json.'curp'
			sustentante.fechaNacimiento = df.parse(resp.json.'fechaNacimiento'.substring(0,10))
			sustentante.correoElectronico = resp.json.'correoElectronico'
			sustentante.nacionalidad = new NacionalidadTO()
			if(resp.json.'nacionalidad' instanceof JSONObject && JSONObject.NULL.equals(resp.json.'nacionalidad')){
				sustentante.nacionalidad.id = resp.json.'nacionalidad'.'id'
				sustentante.nacionalidad.descripcion = resp.json.'nacionalidad'.'descripcion'
				sustentante.nacionalidad.vigente = resp.json.'nacionalidad'.'vigente'
			}
			sustentante.nivelEstudios = new NivelEstudiosTO()
			if(resp.json.'nivelEstudios' instanceof JSONObject && JSONObject.NULL.equals(resp.json.'nivelEstudios')){
				sustentante.nivelEstudios.id = resp.json.'nivelEstudios'.'id'
				sustentante.nivelEstudios.descripcion = resp.json.'nivelEstudios'.'descripcion'
				sustentante.nivelEstudios.vigente = resp.json.'nivelEstudios'.'vigente'
			}
			sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
			sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
			sustentante.puestos = new ArrayList<PuestoTO>()
			sustentante.certificaciones = new ArrayList<CertificacionTO>()
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
		
	}
	
	SustentanteTO findByMatricula(int numeroMatricula){
		return this.obtenerPorMatricula(numeroMatricula)
	}
	
	SearchResult findAll(Integer max, Integer offset, String sort, String order){
		SearchResult sr = new SearchResult()
		def rest = new RestBuilder()
		def resp = rest.post(findAllUrl){
			order = order
			sort = sort
			offset = offset
			max = max
		}
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO s = new SustentanteTO()
				
				//Solo añade datos relevantes a una búsqueda de resultados
				s.id = it.'id'
				s.numeroMatricula = it.'numeroMatricula'
				s.nombre = it.'nombre'
				s.primerApellido = it.'primerApellido'
				s.segundoApellido = it.'segundoApellido'
				
				lista.add(s)
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
}

class SearchResult {
	List<SustentanteTO> list
	Integer count
	boolean error
	String errorDetails
}