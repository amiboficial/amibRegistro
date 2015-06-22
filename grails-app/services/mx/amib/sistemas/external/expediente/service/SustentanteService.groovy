package mx.amib.sistemas.external.expediente.service

import org.apache.http.HttpStatus

import java.util.Date
import java.util.List;
import java.text.DateFormat
import java.text.SimpleDateFormat

import org.codehaus.groovy.grails.web.json.JSONObject

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoValidacionTO;
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTO;
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTO;
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.VarianteFiguraTO;
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.EventoPuntosTO;
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO;
import mx.amib.sistemas.external.expediente.persona.catalog.service.*
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
	String updateDatosPersonalesUrl
	
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

		println "SaveUrl: " + saveUrl

		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}

		if(resp.statusCode.value() != HttpStatus.SC_CREATED )
			throw new Exception("STATUS CODE: " + resp.statusCode)
	}
	
	/**
	 * Guarda unicamente los datos personales sustentante
	 * en el sistema de expediente. Los detalles de certificación,
	 * puestos son omitidos.
	 *
	 * @param sustentante
	 *
	 */
	void updateDatosPersonales(SustentanteTO sustentante){
		println "updateDatosPersonalesUrl: " + updateDatosPersonalesUrl
		def rest = new RestBuilder()
		def resp = rest.post(updateDatosPersonalesUrl){
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
		if(!JSONObject.NULL.equals(data.'segundoApellido')) sustentante.segundoApellido = data.'segundoApellido'
		sustentante.genero = data.'genero'
		sustentante.rfc = data.'rfc'
		if(!JSONObject.NULL.equals(data.'curp')) sustentante.curp = data.'curp'
		sustentante.fechaNacimiento = df.parse(data.'fechaNacimiento'.substring(0,10))
		sustentante.correoElectronico = data.'correoElectronico'
		
		sustentante.calle = data.'calle'
		if(!JSONObject.NULL.equals(data.'numeroExterior')) sustentante.numeroExterior = data.'numeroExterior'
		if(!JSONObject.NULL.equals(data.'numeroInterior')) sustentante.numeroInterior = data.'numeroInterior'
		if(!JSONObject.NULL.equals(data.'idSepomex')) sustentante.idSepomex = data.'idSepomex'
		
		sustentante.nacionalidad = new NacionalidadTO()
		if(data.'nacionalidad' instanceof JSONObject && !JSONObject.NULL.equals(data.'nacionalidad')){
			sustentante.nacionalidad.id = data.'nacionalidad'.'id'
			sustentante.nacionalidad.descripcion = data.'nacionalidad'.'descripcion'
			sustentante.nacionalidad.vigente = data.'nacionalidad'.'vigente'
			sustentante.idNacionalidad = sustentante.nacionalidad.id
		}
		sustentante.nivelEstudios = new NivelEstudiosTO()
		if(data.'nivelEstudios' instanceof JSONObject && !JSONObject.NULL.equals(data.'nivelEstudios')){
			sustentante.nivelEstudios.id = data.'nivelEstudios'.'id'
			sustentante.nivelEstudios.descripcion = data.'nivelEstudios'.'descripcion'
			sustentante.nivelEstudios.vigente = data.'nivelEstudios'.'vigente'
			sustentante.idNivelEstudios = sustentante.nivelEstudios.id
		}
		sustentante.estadoCivil = new EstadoCivilTO()
		if(data.'estadoCivil' instanceof JSONObject && !JSONObject.NULL.equals(data.'estadoCivil')){
			sustentante.estadoCivil.id = data.'estadoCivil'.'id'
			sustentante.estadoCivil.descripcion = data.'estadoCivil'.'descripcion'
			sustentante.estadoCivil.vigente = data.'estadoCivil'.'vigente'
			sustentante.idEstadoCivil = sustentante.estadoCivil.id
		}
		
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		data.'telefonos'.each {
			TelefonoSustentanteTO ts = new TelefonoSustentanteTO()
			ts.id = it.'id'
			if(JSONObject.NULL.equals(it.'extension')) ts.extension = null
			else ts.extension = it.'extension'
			ts.telefono = it.'telefono'
			if(JSONObject.NULL.equals(it.'lada')) ts.lada = null
			else ts.lada = it.'lada'
			ts.idTipoTelefonoSustentante = it.'idTipoTelefonoSustentante'
			ts.tipoTelefonoSustentante = new TipoTelefonoTO()
			ts.tipoTelefonoSustentante.id = it.'tipoTelefonoSustentante'.'id'
			ts.tipoTelefonoSustentante.descripcion = it.'tipoTelefonoSustentante'.'descripcion'
			ts.tipoTelefonoSustentante.vigente = it.'tipoTelefonoSustentante'.'vigente'
			ts.sustentante = sustentante
			sustentante.telefonos.add(ts)
		}
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		data.'documentos'.each {
			DocumentoSustentanteTO ds = new DocumentoSustentanteTO()
			ds.uuid = it.'uuid'
			ds.vigente = it.'vigente'
			
			ds.tipoDocumentoSustentate = new TipoDocumentoTO()
			ds.tipoDocumentoSustentate.id = it.'tipoDocumentoSustentate'.'id'
			ds.tipoDocumentoSustentate.descripcion = it.'tipoDocumentoSustentate'.'descripcion'
			ds.tipoDocumentoSustentate.vigente = it.'tipoDocumentoSustentate'.'vigente'
			
			ds.sustentante = sustentante
		}
		sustentante.puestos = new ArrayList<PuestoTO>()
		data.'puestos'.each {
			PuestoTO p = new PuestoTO()
			p.id = it.'id'
			
			p.idInstitucion = it.'idInstitucion'
			if(!JSONObject.NULL.equals(it.'fechaInicio')) p.fechaInicio = df.parse(it.'fechaInicio'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaFin')) p.fechaFin = df.parse(it.'fechaFin'.substring(0,10))
			p.nombrePuesto = it.'nombrePuesto'
			p.esActual = it.'esActual'
			
			if(!JSONObject.NULL.equals(it.'fechaCreacion')) p.fechaCreacion = df.parse(it.'fechaCreacion'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaModificacion')) p.fechaModificacion = df.parse(it.'fechaModificacion'.substring(0,10))
			
			p.sustentante = sustentante
		}
		sustentante.certificaciones = new ArrayList<CertificacionTO>()
		data.'certificaciones'.each {
			CertificacionTO c = new CertificacionTO()
			c.id = it.'id'
			
			if(!JSONObject.NULL.equals(it.'fechaInicio')) c.fechaInicio = df.parse(it.'fechaInicio'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaObtencion')) c.fechaFin = df.parse(it.'fechaFin'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaCreacion')) c.fechaObtencion = df.parse(it.'fechaObtencion'.substring(0,10))
			c.isAutorizado = it.'isAutorizado'
			c.isApoderado = it.'isApoderado'
			c.isUltima = it.'isUltima'
			
			if(!JSONObject.NULL.equals(it.'fechaCreacion')) c.fechaCreacion = df.parse(it.'fechaCreacion'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaModificacion')) c.fechaModificacion = df.parse(it.'fechaModificacion'.substring(0,10))
			
			c.varianteFigura = new VarianteFiguraTO()
			c.varianteFigura.id = it.'varianteFigura'.'id'
			c.varianteFigura.nombre = it.'varianteFigura'.'nombre'
			c.varianteFigura.vigente = it.'varianteFigura'.'vigente'
			c.varianteFigura.numeroVersion = it.'varianteFigura'.'numeroVersion'
			c.varianteFigura.idFigura = it.'varianteFigura'.'idFigura'
			c.varianteFigura.nombreFigura = it.'varianteFigura'.'nombreFigura'
			c.varianteFigura.nombreAcuseFigura = it.'varianteFigura'.'nombreAcuseFigura'
			c.varianteFigura.esAutorizableFigura = it.'varianteFigura'.'esAutorizableFigura'
			c.varianteFigura.tipoAutorizacionFigura = it.'varianteFigura'.'tipoAutorizacionFigura'
			c.varianteFigura.inicialesFigura = it.'varianteFigura'.'inicialesFigura'

			c.statusAutorizacion = new StatusAutorizacionTO()
			c.statusAutorizacion.id = it.'statusAutorizacion'.'id'
			c.statusAutorizacion.descripcion = it.'statusAutorizacion'.'descripcion'
			c.statusAutorizacion.vigente = it.'statusAutorizacion'.'vigente'
			
			c.statusCertificacion = new StatusCertificacionTO()
			c.statusCertificacion.id = it.'statusCertificacion'.'id'
			c.statusCertificacion.descripcion = it.'statusCertificacion'.'descripcion'
			c.statusCertificacion.vigente = it.'statusCertificacion'.'vigente'
			
			c.idVarianteFigura = it.'idVarianteFigura'
			c.idStatusAutorizacion = it.'idStatusAutorizacion'
			c.idStatusCertificacion = it.'idStatusCertificacion'
		
			c.sustentante = sustentante
			c.validaciones = new ArrayList<ValidacionTO>()
			it.'validaciones'.each{ x ->
				ValidacionTO v = new ValidacionTO()
				if(!JSONObject.NULL.equals(it.'fechaAplicacion')) v.fechaAplicacion = df.parse(x.'fechaAplicacion'.substring(0,10))
				if(!JSONObject.NULL.equals(it.'fechaInicio')) v.fechaInicio = df.parse(x.'fechaInicio'.substring(0,10))
				if(!JSONObject.NULL.equals(it.'fechaFin')) v.fechaFin = df.parse(x.'fechaFin'.substring(0,10))
				v.autorizadoPorUsuario = x.'autorizadoPorUsuario'
				
				v.eventosPuntos = new ArrayList<EventoPuntosTO>()
				//aqui van el registro de los eventos que generaron puntos
				
				v.metodoValidacion = new MetodoValidacionTO()
				v.idMetodoValidacion = x.'idMetodoValidacion'
			
				if(!JSONObject.NULL.equals(it.'fechaCreacion'))  v.fechaCreacion = df.parse(x.'fechaCreacion'.substring(0,10))
				if(!JSONObject.NULL.equals(it.'fechaModificacion'))  v.fechaModificacion = df.parse(x.'fechaModificacion'.substring(0,10))
				
				v.certificacion = c
			}
			
		}
		return sustentante
	}
}

class SearchResult {
	List<SustentanteTO> list
	Integer count
	boolean error
	String errorDetails
}