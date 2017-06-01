package mx.amib.sistemas.external.expediente.service

import org.springframework.http.HttpStatus
import org.springframework.http.converter.StringHttpMessageConverter

import java.util.Date
import java.util.List;
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.nio.charset.Charset
import java.text.Normalizer
import java.text.Normalizer.Form

import org.codehaus.groovy.grails.web.json.JSONElement
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
import mx.amib.sistemas.utils.StringUtils

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
	String findAllByIdCertificacionInUrl
	String getUrl
	String getByNumeroMatriculaUrl
	String saveUrl
	String updateDatosPersonalesUrl
	String updatePuestosUrl
	
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
	SustentanteTO guardarNuevo(SustentanteTO sustentante){
		sustentante.id = null

		println "SaveUrl: " + saveUrl

		def rest = new RestBuilder()
		def resp = rest.post(saveUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}

		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				sustentante = this.obtenerSustentanteFromJSON(resp.json)
			}
		
		return sustentante
	}
	
	/**
	 * Guarda unicamente los datos personales sustentante
	 * en el sistema de expediente. Los detalles de certificación,
	 * puestos son omitidos.
	 *
	 * @param sustentante
	 *
	 */
	SustentanteTO updateDatosPersonales(SustentanteTO sustentante){
				
		def rest = new RestBuilder()
		def resp = rest.post(updateDatosPersonalesUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}

		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				sustentante = this.obtenerSustentanteFromJSON(resp.json)
			}
		
		return sustentante
	}
	
	/**
	 * Guarda unicamente los datos laborales sustentante
	 * en el sistema de expediente. Los detalles de certificación,
	 * personales son omitidos.
	 *
	 * @param sustentante
	 *
	 */
	SustentanteTO updatePuestos(SustentanteTO sustentante){
		
		def rest = new RestBuilder()
		def resp = rest.post(updatePuestosUrl){
			contentType "application/json;charset=UTF-8"
			json (sustentante as JSON)
		}

		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				sustentante = this.obtenerSustentanteFromJSON(resp.json)
			}
		
		return sustentante
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
		rest.restTemplate.setMessageConverters([new StringHttpMessageConverter(Charset.forName("UTF-8"))])
		def resp = rest.get(url)
		
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			sr.list = lista
				if(resp.json != null && resp.json.'count' != null && resp.json.'error' != null ){ //previene fallos cuando falla la peticion a expediente
					sr.count = resp.json.'count'
					sr.error = resp.json.'error'
					sr.errorDetails = resp.json.'errorDetails'
				}else{
					sr.count = 0
					sr.error = false
					sr.errorDetails = ""
				}
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
		String url = findAllAdvancedSearchUrl
		Map<String,String> qsparams = new HashMap<String,String>()
		RestBuilder rest = new RestBuilder() 
		def resp = null
		
		qsparams.put('max', max)
		qsparams.put('offset', offset)
		qsparams.put('sort', sort)
		qsparams.put('order', order)
		qsparams.put('nom', nom)
		qsparams.put('ap1', ap1)
		qsparams.put('ap2', ap2)
		url += '?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}'
		println "La url es: " + url

		resp = rest.get(url,qsparams)
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			sr.list = lista
				if(resp.json != null && resp.json.'count' != null && resp.json.'error' != null ){ //previene fallos cuando falla la peticion a expediente
					sr.count = resp.json.'count'
					sr.error = resp.json.'error'
					sr.errorDetails = resp.json.'errorDetails'
				}else{
					sr.count = 0
					sr.error = false
					sr.errorDetails = ""
				}
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
		String url = findAllAdvancedSearchWithCertificacionUrl
		Map<String,String> qsparams = new HashMap<String,String>()
		RestBuilder rest = new RestBuilder()
		def resp = null
		
		qsparams.put('max', max)
		qsparams.put('offset', offset)
		qsparams.put('sort', sort)
		qsparams.put('order', order)
		qsparams.put('nom', nom)
		qsparams.put('ap1', ap1)
		qsparams.put('ap2', ap2)
		qsparams.put('idfig', idfig)
		qsparams.put('idvarfig', idvarfig)
		qsparams.put('stcert', stcert)
		qsparams.put('staut', staut)
		
		url +=	"?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}&idfig={idfig}&idvarfig={idvarfig}&stcert={stcert}&staut={staut}"
		println "La url es: " + url
		
		resp = rest.get(url,qsparams)
		if(resp.json != null && resp.json instanceof JSONObject) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.'list'.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			println("enates del error AXXXXXXXXXXXXXXXXXXXXXXX")
			println(resp.json as JSON)
			sr.list = lista
			if(resp.json != null && resp.json.'count' != null && resp.json.'error' != null ){ //previene fallos cuando falla la peticion a expediente
				sr.count = resp.json.'count'
				sr.error = resp.json.'error'
				sr.errorDetails = resp.json.'errorDetails'
			}else{
				sr.count = 0
				sr.error = false
				sr.errorDetails = ""
			}
		}
		else{
			sr.error = true
			sr.errorDetails = "NON_JSON_RESPONSE"
		}
		return sr
	}
		
		//metodos de busqueda avanzada que incluyen la institucion financiera
		SearchResult findAllAdvancedSearchAndIns(String nom, String ap1, String ap2,
			Integer max, Integer offset, String sort, String order, Long idgrup, Long idfina){
			
			SearchResult sr = new SearchResult()
			String url = findAllAdvancedSearchUrl
			Map<String,String> qsparams = new HashMap<String,String>()
			RestBuilder rest = new RestBuilder()
			def resp = null
			
			qsparams.put('max', max)
			qsparams.put('offset', offset)
			qsparams.put('sort', sort)
			qsparams.put('order', order)
			qsparams.put('nom', nom)
			qsparams.put('ap1', ap1)
			qsparams.put('ap2', ap2)
			qsparams.put('idgrup', idgrup)
			qsparams.put('idfina', idfina)
			
//			String uri2 = "http://localhost:8084/amibExpediente/sustentanteRestful/findAllAdvancedSearch"
//			uri2 += 'AndIns?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}&idgrup={idgrup}&idfina={idfina}'
//			println "La url es: " + uri2
			
			url += 'AndIns?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}&idgrup={idgrup}&idfina={idfina}'
			println "La url es: " + url
			
//			url = uri2
	
			resp = rest.get(url,qsparams)
			println("resp.headers")
			println(resp.headers)
			if(resp.json != null && resp.json instanceof JSONObject) {
				def lista = new ArrayList<SustentanteTO>()
				resp.json.'list'.each{
					SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
					lista.add(sustentante)
				}
				sr.list = lista
				if(resp.json != null && resp.json.'count' != null && resp.json.'error' != null ){ //previene fallos cuando falla la peticion a expediente
					sr.count = resp.json.'count'
					sr.error = resp.json.'error'
					sr.errorDetails = resp.json.'errorDetails'
				}else{
					sr.count = 0
					sr.error = false
					sr.errorDetails = ""
				}
			}
			else{
				sr.error = true
				sr.errorDetails = "NON_JSON_RESPONSE"
			}
			return sr
		}
			
		SearchResult findAllAdvancedSearchWithCertificacionAndIns(String nom, String ap1, String ap2,
			Long idfig, Long idvarfig, Long stcert, Long staut,
			Integer max, Integer offset, String sort, String order, Long idgrup, Long idfina){
			
			SearchResult sr = new SearchResult()
			String url = findAllAdvancedSearchWithCertificacionUrl
			Map<String,String> qsparams = new HashMap<String,String>()
			RestBuilder rest = new RestBuilder()
			def resp = null
			
			qsparams.put('max', max)
			qsparams.put('offset', offset)
			qsparams.put('sort', sort)
			qsparams.put('order', order)
			qsparams.put('nom', nom)
			qsparams.put('ap1', ap1)
			qsparams.put('ap2', ap2)
			qsparams.put('idfig', idfig)
			qsparams.put('idvarfig', idvarfig)
			qsparams.put('stcert', stcert)
			qsparams.put('staut', staut)
			qsparams.put('idgrup', idgrup)
			qsparams.put('idfina', idfina)
			
//			String uri2 = "http://localhost:8084/amibExpediente/sustentanteRestful/findAllAdvancedSearchWithCertificacion"
//			uri2 += 'AndIns?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}&idfig={idfig}&idvarfig={idvarfig}&stcert={stcert}&staut={staut}&idgrup={idgrup}&idfina={idfina}'
//			println "La url es: " + uri2
			
			url +=	'AndIns?max={max}&offset={offset}&sort={sort}&order={order}&nom={nom}&ap1={ap1}&ap2={ap2}&idfig={idfig}&idvarfig={idvarfig}&stcert={stcert}&staut={staut}&idgrup={idgrup}&idfina={idfina}'
			println "La url es: " + url
			
//			url = uri2
			
			resp = rest.get(url,qsparams)
			println("resp.headers")
			if(resp.json != null && resp.json instanceof JSONObject) {
				def lista = new ArrayList<SustentanteTO>()
				resp.json.'list'.each{
					SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
					lista.add(sustentante)
				}
				sr.list = lista
				if(resp.json != null && resp.json.'count' != null && resp.json.'error' != null ){ //previene fallos cuando falla la peticion a expediente
					sr.count = resp.json.'count'
					sr.error = resp.json.'error'
					sr.errorDetails = resp.json.'errorDetails'
				}else{
					sr.count = 0
					sr.error = false
					sr.errorDetails = ""
				}
			}
			else{
				sr.error = true
				sr.errorDetails = "NON_JSON_RESPONSE"
			}
			return sr
		}
		//END metodos de busqueda avanzada que incluyen la institucion financiera
	
	Collection<SustentanteTO> findAllByIdCertificacionIn(Collection<Long> idsCertificacion){		
		Collection<Integer> result = new ArrayList<Integer>()
		def rest = new RestBuilder()
		def resp = rest.post(findAllByIdCertificacionInUrl){
			json (idsCertificacion as JSON)
		}
		if(resp.json != null && resp.json instanceof JSONElement) {
			def lista = new ArrayList<SustentanteTO>()
			resp.json.each{
				SustentanteTO sustentante = this.obtenerSustentanteFromJSON(it)
				lista.add(sustentante)
			}
			result = lista
		}
		return result
	}
		
	public static SustentanteTO obtenerSustentanteFromJSON(JSONObject data){
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
		if(!JSONObject.NULL.equals(data.'fechaNacimiento')) sustentante.fechaNacimiento = df.parse(data.'fechaNacimiento'.substring(0,10))
		sustentante.correoElectronico = data.'correoElectronico'
		
		sustentante.calle = data.'calle'
		if(!JSONObject.NULL.equals(data.'numeroExterior')) sustentante.numeroExterior = data.'numeroExterior'
		if(!JSONObject.NULL.equals(data.'numeroInterior')) sustentante.numeroInterior = data.'numeroInterior'
		if(!JSONObject.NULL.equals(data.'idSepomex')) sustentante.idSepomex = data.'idSepomex'
		if(!JSONObject.NULL.equals(data.'asentamientoOtro')) sustentante.asentamientoOtro = data.'asentamientoOtro'
		
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
			
			ds.idTipoDocumentoSustentate = it.'tipoDocumentoSustentate'.'id'
			ds.tipoDocumentoSustentate = new TipoDocumentoTO()
			ds.tipoDocumentoSustentate.id = it.'tipoDocumentoSustentate'.'id'
			ds.tipoDocumentoSustentate.descripcion = it.'tipoDocumentoSustentate'.'descripcion'
			ds.tipoDocumentoSustentate.vigente = it.'tipoDocumentoSustentate'.'vigente'
			
			ds.sustentante = sustentante
			sustentante.documentos.add(ds)
		}
		sustentante.puestos = new ArrayList<PuestoTO>()
		data.'puestos'.each {
			PuestoTO p = new PuestoTO()
			if(!JSONObject.NULL.equals(it.'id')){p.id = Long.parseLong(it.'id'.toString())}
			else{
				p.id = -1
			}
			
			p.idInstitucion = it.'idInstitucion'
			if(!JSONObject.NULL.equals(it.'fechaInicio')) p.fechaInicio = df.parse(it.'fechaInicio'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaFin')) p.fechaFin = df.parse(it.'fechaFin'.substring(0,10))
			p.nombrePuesto = it.'nombrePuesto'
			p.esActual = it.'esActual'
			
			p.statusEntManifProtesta = it.'statusEntManifProtesta'
			if(!JSONObject.NULL.equals(it.'obsEntManifProtesta')) p.obsEntManifProtesta = it.'obsEntManifProtesta'
			p.statusEntCartaInter = it.'statusEntCartaInter'
			if(!JSONObject.NULL.equals(it.'obsEntCartaInter')) p.obsEntCartaInter = it.'obsEntCartaInter'
			
			if(!JSONObject.NULL.equals(it.'fechaCreacion')) p.fechaCreacion = df.parse(it.'fechaCreacion'.substring(0,10))
			if(!JSONObject.NULL.equals(it.'fechaModificacion')) p.fechaModificacion = df.parse(it.'fechaModificacion'.substring(0,10))
			
			p.sustentante = sustentante
			sustentante.puestos.add(p)
		}
		sustentante.certificaciones = new ArrayList<CertificacionTO>()
		data.'certificaciones'.each {
			CertificacionTO c = CertificacionService.obtenerCertificacionFromJSON(it);
			c.sustentante = sustentante
			sustentante.certificaciones.add(c)
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