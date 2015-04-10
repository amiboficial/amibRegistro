package mx.amib.sistemas.external.expediente.service

import java.util.Date
import java.text.DateFormat
import java.text.SimpleDateFormat
import org.codehaus.groovy.grails.web.json.JSONObject
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
 */
@Transactional
class SustentanteService {

	String getByNumeroMatriculaUrl
	
	/**
	 * Obtiene los datos de un sustentante dado su 
	 * número de matrícula
	 * 
	 * @param numeroMatricula
	 * @return Instancia de SustentanteTO con datos del 
	 * 			sustentante. Si no se encontró, entonces
	 * 			regresa nulo.
	 */
    SustentanteTO obtenerPorMatricula(int numeroMatricula) {
		SustentanteTO sustenante = null
		def rest = new RestBuilder()
		def resp = rest.get(getByNumeroMatriculaUrl + numeroMatricula)
		resp.json instanceof JSONObject
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		
		if(resp.json != null){
			sustenante = new SustentanteTO()
			sustenante.id = resp.json.'id'
			sustenante.numeroMatricula = resp.json.'numeroMatricula'
			sustenante.nombre = resp.json.'nombre'
			sustenante.primerApellido = resp.json.'primerApellido'
			sustenante.segundoApellido = resp.json.'segundoApellido'
			sustenante.genero = resp.json.'genero'
			sustenante.rfc = resp.json.'rfc'
			sustenante.curp = resp.json.'curp'
			sustenante.fechaNacimiento = df.parse(resp.json.'fechaNacimiento'.substring(0,10))
			sustenante.correoElectronico = resp.json.'correoElectronico'
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
		return sustenante
    }
}
