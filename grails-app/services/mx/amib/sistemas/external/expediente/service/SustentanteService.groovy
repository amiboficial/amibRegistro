package mx.amib.sistemas.external.expediente.service

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
 */
@Transactional
class SustentanteService {

	String getByNumeroMatriculaUrl
	String saveUrl

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
		
		if(resp.json != null){
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
		sustentante.id = -1

		println saveUrl

		def rest = new RestBuilder()
		def resp = rest.put(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}
	}
}
