package mx.amib.sistemas.external.documentos.service

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date
import java.util.ArrayList

import mx.amib.sistemas.util.service.ArchivoTO
import mx.amib.sistemas.util.service.ArchivoTemporalService
import mx.amib.sistemas.utils.AmibFechaUtils

import org.codehaus.groovy.grails.web.json.JSONObject
import org.junit.After
import org.springframework.aop.aspectj.RuntimeTestWalker.ThisInstanceOfResidueTestVisitor

import java.io.File

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

/**
 * DocumentoRepositorioService
 *
 * Este servicio permite gestionar documentos empleado llamadas
 * HTTP/REST al sistema de amibDocumentos
 *
 * @author Gabriel
 * @version 1.2 - (Última actualización) 11/02/2015 - Se añaden métodos obtenerTodosPorMatricula,
 *			1.1 - 22/09/2014
 */
@Transactional
class DocumentoRepositorioService {

	ArchivoTemporalService archivoTemporalService
	
	String saveUrl
	String documentoPoderSaveUrl
	String documentoPoderUpdateUrl
	String documentoRevocacionSaveUrl
	String documentoRevocacionUpdateUrl
	
	String findAllByMatriculaUrl
	String findAllLikeNombreArchivoUrl
	String findAllLikeDescripcionUrl
	String findAllGenericUrl
	String findAllByTypeUrl
	
	String listDocumentoUrl
	String listCnbvDgaOficioUrl
	String listDocumentoPoderUrl
	String listFotoSustentanteUrl
	String listDocumentoSustentanteUrl
	String listRevocacionUrl
	
	String saveMultipartUrl
	String getUrl
	String downloadUrl
	String deleteUrl
	
	/**
	 * Obtiene, del repositorio amibDocumentos, 
	 * los metadatos de un documento dado su UUID
	 * 
	 * @param uuid
	 * @return Instanca de DocumentoRepositorioTO
	 */
	DocumentoRepositorioTO obtenerMetadatosDocumento(String uuid, ClaseDocumento cd = ClaseDocumento.DOCUMENTO){
		def docRep = null
		String restUrl = getUrl + uuid
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		
		def rest = new RestBuilder()
		def restMultipart = new RestBuilder()
		
		def resp = rest.get(restUrl)
		
		if(resp.json == null)
			return null
		else
		{
			switch(cd){
				case ClaseDocumento.DOCUMENTO:
					docRep = new DocumentoRepositorioTO()
				break;
				case ClaseDocumento.OFICIO_CNBV:
					docRep = new DocumentoOficioCnbvRespositorioTO()
					docRep.matriculas = resp.json.'matriculas'
					docRep.nombres = resp.json.'nombres'
					docRep.autorizaciones = resp.json.'autorizaciones'
				break;
				case ClaseDocumento.PODER:
					docRep = new DocumentoPoderRepositorioTO()
					docRep.tipoDocumentoRespaldo = resp.json.'tipoDocumentoRespaldo'
					docRep.representanteLegalNombreCompleto = resp.json.'representanteLegalNombreCompleto'
					docRep.numeroEscritura = resp.json.'numeroEscritura'
					docRep.fechaApoderamiento = df.parse(resp.json.'fechaApoderamiento'.substring(0,10))
					docRep.matriculasApoderados = resp.json.'matriculasApoderados'
					docRep.nombresApoderados = resp.json.'nombresApoderados'
					docRep.notario = resp.json.'notario'
					docRep.grupoFinanciero = resp.json.'grupoFinanciero'
					docRep.institucion = resp.json.'institucion'
				break;
				case ClaseDocumento.REVOCACION:
					docRep = new DocumentoRevocacionRepositorioTO()
					docRep.tipoDocumentoRespaldo = resp.json.'tipoDocumentoRespaldo'
					docRep.representanteLegalNombreCompleto = resp.json.'representanteLegalNombreCompleto'
					docRep.numeroEscritura = resp.json.'numeroEscritura'
					docRep.fechaRevocacion = df.parse(resp.json.'fechaRevocacion'.substring(0,10))
					docRep.matriculasRevocados = resp.json.'matriculasRevocados'
					docRep.nombresRevocados = resp.json.'nombresRevocados'
					docRep.notario = resp.json.'notario'
					docRep.grupoFinanciero = resp.json.'grupoFinanciero'
					docRep.institucion = resp.json.'institucion'
				break;
				case ClaseDocumento.FOTO_SUSTENTANTE:
					docRep = new DocumentoFotoSustentanteRepositorioTO()
					docRep.numeroMatricula = resp.json.'numeroMatricula'
					docRep.nombreCompleto = resp.json.'nombreCompleto'
				break;
				case ClaseDocumento.DOC_SUSTENTANTE:
					docRep = new DocumentoSustentanteRepositorioTO()
					docRep.numeroMatricula = resp.json.'numeroMatricula'
					docRep.tipoDocumentoSustentante = resp.json.'tipoDocumentoSustentante'
					docRep.nombreCompleto = resp.json.'nombreCompleto'
				break;
			}
			docRep.id = resp.json.'id'
			docRep.uuid = resp.json.'uuid'
			docRep.clave = resp.json.'clave'
			docRep.nombre = resp.json.'nombre'
			docRep.mimetype = resp.json.'mimetype'
			//docRep.fechaModificacion = resp.json.'fechaModificacion'
			//docRep.fechaCreacion = resp.json.'fechaCreacion'
		}
		return docRep
	}
	
	DocumentoRepositorioTO obtenerMetadatosDocumentoNew(String uuid){
		def docRep = null
		String restUrl = getUrl + uuid
		
		def rest = new RestBuilder()
		def resp = rest.get(restUrl)
		
		if(resp.json != null && resp.json instanceof JSONObject)
			docRep = this.llenarMetadatosJsonDocumento(resp.json)
			
		return docRep
	}
	
	/**
	 * Obtiene, del repositorio amibDocumentos,
	 * los metadatos de todos documentos.
	 *
	 * @return Coleccion de objetos DocumentoRepositorioTO
	 *
	 */
	Collection<DocumentoRepositorioTO> obtenerTodos(Integer max = 10, Integer offset = 0, String sort = "id", String order = "desc"){
		Collection<DocumentoRepositorioTO> resultCollection = new ArrayList<DocumentoRepositorioTO>()
		String restUrl = listDocumentoUrl + "?max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		def rest = new RestBuilder()
		
		//obtiene los datos de servicio REST
		def resp = rest.get(restUrl)
		if(resp.json != null && resp.json instanceof JSONObject){
			def count = resp.json.'count'
			if(count>0) {
				def jsonArrayList = resp.json.'list'
				jsonArrayList.each{	x ->
					DocumentoRepositorioTO doc = this.llenarMetadatosJsonDocumento(x)
					if(doc != null)
						resultCollection.add(doc)
				}
			}
		}
		
		return resultCollection
	}
	
	/**
	 * Obtiene, del repositorio amibDocumentos,
	 * los metadatos de todos documentos, dado el
	 * tipo del documento solicitado
	 *
	 * @param cd
	 * @return Coleccion de objetos DocumentoRepositorioTO
	 *
	 */
	Collection<DocumentoRepositorioTO> obtenerTodos(ClaseDocumento cd, Integer max = 10, Integer offset = 0, String sort = "id", String order = "desc"){
		Collection<DocumentoRepositorioTO> resultCollection = new ArrayList<DocumentoRepositorioTO>()
		String restUrl = findAllByTypeUrl + "?idTipo=" + cd.getId() + "&max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		def rest = new RestBuilder()
		
		println "URL -> " + restUrl
		
		//obtiene los datos de servicio REST
		def resp = rest.get(restUrl)
		if(resp.json != null && resp.json instanceof JSONObject){
			def count = resp.json.'count'
			if(count>0) {
				def jsonArrayList = resp.json.'list'
				jsonArrayList.each{	x ->
					DocumentoRepositorioTO doc = this.llenarMetadatosJsonDocumento(x)
					if(doc != null)
						resultCollection.add(doc)
				}
			}
		}
		
		return resultCollection
	}
	
	/**
	 * Obtiene, del repositorio amibDocumentos, 
	 * los metadatos de todos documentos que 
	 * coincidan con el número de matrícula
	 * proporcionado
	 *
	 * @param numeroMatricula
	 * @return Coleccion de objetos DocumentoRepositorioTO
	 *
	 */
	Collection<DocumentoRepositorioTO> obtenerTodosPorMatricula(Integer numeroMatricula, Integer max = 10, Integer offset = 0, String sort = "id", String order = "desc"){
		Collection<DocumentoRepositorioTO> resultCollection = new ArrayList<DocumentoRepositorioTO>()
		String restUrl = findAllByMatriculaUrl + "?matricula=" + numeroMatricula + "&max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		def rest = new RestBuilder()
		
		//obtiene los datos de servicio REST
		def resp = rest.get(restUrl)
		if(resp.json != null && resp.json instanceof JSONObject){
			def count = resp.json.'count'
			if(count>0) {
				def jsonArrayList = resp.json.'list'
				jsonArrayList.each{	x ->
					DocumentoRepositorioTO doc = this.llenarMetadatosJsonDocumento(x)
					if(doc != null)
						resultCollection.add(doc)
				}
			}
		}
		
		return resultCollection
	}
	
	/**
	 * Obtiene, del repositorio amibDocumentos,
	 * los metadatos de todos documentos que
	 * coincidan con alguna porción del nombre de archivo
	 * proporcionado, sin considerar mayus/minus
	 *
	 * @param nombreArchivo
	 * @return Coleccion de objetos DocumentoRepositorioTO
	 *
	 */
	Collection<DocumentoRepositorioTO> obtenerTodosPorNombreArchivoILike(String nombreArchivo, Integer max = 10, Integer offset = 0, String sort = "id", String order = "desc"){
		Collection<DocumentoRepositorioTO> resultCollection = new ArrayList<DocumentoRepositorioTO>()
		String restUrl = findAllLikeNombreArchivoUrl + "?nombreArchivo=" + nombreArchivo + "&max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		def rest = new RestBuilder()
		
		//obtiene los datos de servicio REST
		def resp = rest.get(restUrl)
		if(resp.json != null && resp.json instanceof JSONObject){
			def count = resp.json.'count'
			if(count>0) {
				def jsonArrayList = resp.json.'list'
				jsonArrayList.each{	x ->
					DocumentoRepositorioTO doc = this.llenarMetadatosJsonDocumento(x)
					if(doc != null)
						resultCollection.add(doc)
				}
			}
		}
		
		return resultCollection
	}
	
	/**
	 * Obtiene, del repositorio amibDocumentos,
	 * los metadatos de todos documentos que
	 * coincidan con alguna porción de alguna descripción
	 * proporcionada, sin considerar mayus/minus
	 *
	 * @param descripcion
	 * @return Coleccion de objetos DocumentoRepositorioTO
	 *
	 */
	Collection<DocumentoRepositorioTO> obtenerTodosPorDescripcionILike(String descripcion, Integer max = 10, Integer offset = 0, String sort = "id", String order = "desc"){
		Collection<DocumentoRepositorioTO> resultCollection = new ArrayList<DocumentoRepositorioTO>()
		String restUrl = findAllLikeDescripcionUrl + "?descripcion=" + descripcion + "&max=" + max + "&offset=" + offset + "&sort=" + sort + "&order=" + order
		def rest = new RestBuilder()
		
		//obtiene los datos de servicio REST
		def resp = rest.get(restUrl)
		if(resp.json != null && resp.json instanceof JSONObject){
			def count = resp.json.'count'
			if(count>0) {
				def jsonArrayList = resp.json.'list'
				jsonArrayList.each{	x ->
					DocumentoRepositorioTO doc = this.llenarMetadatosJsonDocumento(x)
					if(doc != null)
						resultCollection.add(doc)
				}
			}
		}
		
		return resultCollection
	}
	
	/**
	 * Envía los documentos indicados al repositorio amibDocumentos,
	 * siempre y cuando su archivo correspondiente se encuentre
	 * almacenado en temporal (usando el servicio ArchivoTemporalService)
	 * 
	 * @param docs
	 */
    void enviarDocumentosArchivoTemporal(Collection<DocumentoRepositorioTO> docs) {

		docs.each{
			String restUrl = null
			
			it.id = null //este siempre se debe setear nulo para que pueda guardar el nuevo documento
			it.nombre = archivoTemporalService.obtenerArchivoTemporal(it.uuid).filename
			it.mimetype = archivoTemporalService.obtenerArchivoTemporal(it.uuid).mimetype
			it.fechaModificacion = AmibFechaUtils.obtenerFechaZ()
			it.fechaCreacion = AmibFechaUtils.obtenerFechaZ()
			
			def rest = new RestBuilder()
			def restMultipart = new RestBuilder()
			String _uuid = it.uuid
			String _json = (it as JSON)
			
			if( DocumentoPoderRepositorioTO.class.isInstance(it) ){
				restUrl = this.documentoPoderSaveUrl
			}
			else if ( DocumentoRevocacionRepositorioTO.class.isInstance(it) ){
				restUrl = this.documentoRevocacionSaveUrl
			}
			else{
				restUrl = this.saveUrl
			}
			
			//Envía acorde al metadato
			def resp = rest.post(restUrl){
				contentType "application/json;charset=UTF-8"
				json _json
			}

			ArchivoTO arcTemp = archivoTemporalService.obtenerArchivoTemporal(_uuid)
			if(arcTemp == null){
				println "ESTA COSA ES NULL!"
			}
			else{
				println "PUES NO ES NULL Y EL OBJETO ES: " + (arcTemp as JSON)
			}
			
			def respMultipart = restMultipart.post(this.saveMultipartUrl + _uuid) {
				contentType "multipart/form-data"
				archivo = new File( (arcTemp.temploc) )
			}

			archivoTemporalService.eliminarArchivoTemporal(_uuid)
		}
    }
	
	void actualizaMetadatosDocumentos(Collection<DocumentoRepositorioTO> docs){
		docs.each{
			this.actualizaMetadatosDocumento(it)
		}
	}
	
	/**
	 * Actualiza UNICAMENTE los metadatos relativos al documento,
	 * por lo que no actualizara datos como nombre, mimetype ni clave
	 * 
	 * @param doc
	 */
	void actualizaMetadatosDocumento(DocumentoRepositorioTO doc){
		String restUrl = null
		
		doc.id = null
		doc.fechaModificacion = new Date()
		
		def rest = new RestBuilder()
		def restMultipart = new RestBuilder()
		String _uuid = doc.uuid
		String _json = (doc as JSON)
		
		if( DocumentoPoderRepositorioTO.class.isInstance(doc) ){
			restUrl = this.documentoPoderUpdateUrl
		}
		else if ( DocumentoRevocacionRepositorioTO.class.isInstance(doc) ){
			restUrl = this.documentoRevocacionUpdateUrl
		}
		//Envía acorde al metadato
		def resp = rest.post(restUrl){
			contentType "application/json;charset=UTF-8"
			json _json
		}
	}
	
	/**
	 * Elimina un documento del repositorio amibDocumentos 
	 * dado su UUID
	 * 
	 * @param uuid
	 */
	void eliminarDocumento(String uuid){
		String restUrl = deleteUrl + uuid
		
		def rest = new RestBuilder()
		def restMultipart = new RestBuilder()
		
		println restUrl
		def resp = rest.get(restUrl)
		
		resp.json instanceof JSONObject
		
		if(resp.json.'status' == 'OK'){
			println uuid + ',Archivo borrado - OK'
		}
		else if(resp.json.'status' == 'ERROR'){
			println resp.json.'status'
			println resp.json.'details'
		}
	}
	
	/**
	 * Elimina multiples documentos del repositorio amibDocumentos 
	 * dado un listado de UUIDs
	 * 
	 * @param uuids
	 */
	void eliminarDocumentos(Collection<String> uuids){
		uuids.each { uuid ->
			this.eliminarDocumento(uuid)
		}
	}
	
	/**
	 * Descarga un documento del repostorio, dado su UUID,
	 * al almacenamiento temporal.
	 * 
	 * @param sessionId
	 * @param uuid
	 */
	DocumentoRepositorioTO descargarATemporal(String sessionId, String uuid){
		//paso 1: obtiene metadatos
		DocumentoRepositorioTO dr = this.obtenerMetadatosDocumento(uuid)
		//paso 2: descarga a temporal
		if(dr != null){
			//comprueba si ya esta en temporal, si ya esta, solo actualiza caducidad
			//if(archivoTemporalService.comprobarArchivoTemporal(uuid))
				//archivoTemporalService.renuevaCaducidadArchivoTemporal(uuid)
			//else
				archivoTemporalService.descargarArchivoTemporal(sessionId, uuid, dr.nombre, dr.mimetype, new URL(downloadUrl+uuid))
		}
		return dr
	}
	
	private DocumentoRepositorioTO llenarMetadatosJsonDocumento(def jsonObjectDoc){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		DateFormat dftm = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
		DocumentoRepositorioTO doc = null	
		def claseDocumento = ClaseDocumento.fromInteger(jsonObjectDoc.'idTipo')
		switch(claseDocumento){
			case ClaseDocumento.DOC_SUSTENTANTE:
				doc = new DocumentoSustentanteRepositorioTO()
				def docIns = (DocumentoSustentanteRepositorioTO)doc
				docIns.numeroMatricula = jsonObjectDoc.'numeroMatricula'
				docIns.tipoDocumentoSustentante = jsonObjectDoc.'tipoDocumentoSustentante'
				docIns.nombreCompleto = jsonObjectDoc.'nombreCompleto'
			break;
			case ClaseDocumento.DOCUMENTO:
				doc = new DocumentoRepositorioTO()
			break;
			case ClaseDocumento.FOTO_SUSTENTANTE:
				doc = new DocumentoFotoSustentanteRepositorioTO()
				def docIns = (DocumentoFotoSustentanteRepositorioTO)doc
				docIns.numeroMatricula = jsonObjectDoc.'numeroMatricula'
				docIns.nombreCompleto = jsonObjectDoc.'nombreCompleto'
			break;
			case ClaseDocumento.OFICIO_CNBV:
				doc = new DocumentoOficioCnbvRespositorioTO()
				def docIns = (DocumentoOficioCnbvRespositorioTO)doc
				docIns.matriculas = jsonObjectDoc.'matriculas'
				docIns.nombres = jsonObjectDoc.'nombres'
				docIns.autorizaciones = jsonObjectDoc.'autorizaciones'
			break;
			case ClaseDocumento.PODER:
				doc = new DocumentoPoderRepositorioTO()
				def docIns = (DocumentoPoderRepositorioTO)doc
				docIns.tipoDocumentoRespaldo = jsonObjectDoc.'tipoDocumentoRespaldo'
				docIns.representanteLegalNombreCompleto = jsonObjectDoc.'representanteLegalNombreCompleto'
				docIns.numeroEscritura = jsonObjectDoc.'numeroEscritura'
				docIns.fechaApoderamiento = df.parse(jsonObjectDoc.'fechaApoderamiento'.substring(0,10))
				docIns.matriculasApoderados = jsonObjectDoc.'matriculasApoderados'
				docIns.nombresApoderados = jsonObjectDoc.'nombresApoderados'
				docIns.notario = jsonObjectDoc.'notario'
				docIns.grupoFinanciero = jsonObjectDoc.'grupoFinanciero'
				docIns.institucion = jsonObjectDoc.'institucion'
			break;
			case ClaseDocumento.REVOCACION:
				doc = new DocumentoRevocacionRepositorioTO()
				def docIns = (DocumentoRevocacionRepositorioTO)doc
				docIns.tipoDocumentoRespaldo = jsonObjectDoc.'tipoDocumentoRespaldo'
				docIns.representanteLegalNombreCompleto = jsonObjectDoc.'representanteLegalNombreCompleto'
				docIns.numeroEscritura = jsonObjectDoc.'numeroEscritura'
				docIns.fechaRevocacion = df.parse(jsonObjectDoc.'fechaRevocacion'.substring(0,10))
				docIns.matriculasRevocados = jsonObjectDoc.'matriculasRevocados'
				docIns.nombresRevocados = jsonObjectDoc.'nombresRevocados'
				docIns.notario = jsonObjectDoc.'notario'
				docIns.grupoFinanciero = jsonObjectDoc.'grupoFinanciero'
				docIns.institucion = jsonObjectDoc.'institucion'
			break;
		}
		if(doc!=null) {
			doc.id = jsonObjectDoc.'id'
			doc.uuid = jsonObjectDoc.'uuid'
			doc.clave = jsonObjectDoc.'clave'
			doc.nombre = jsonObjectDoc.'nombre'
			doc.mimetype = jsonObjectDoc.'mimetype'
			doc.fechaCreacion = dftm.parse(jsonObjectDoc.'fechaCreacion'.substring(0,19) + "-0000")
			doc.fechaModificacion = dftm.parse(jsonObjectDoc.'fechaModificacion'.substring(0,19) + "-0000")
		}
		return doc
	}
}

class DocumentoRepositorioTO{
	Long id
	String uuid
	String clave
	String nombre
	String mimetype
	Date fechaModificacion
	Date fechaCreacion
}

class DocumentoOficioCnbvRespositorioTO extends DocumentoRepositorioTO{
	String matriculas
	String nombres
	String autorizaciones
}

class DocumentoPoderRepositorioTO extends DocumentoRepositorioTO{
	String tipoDocumentoRespaldo
	String representanteLegalNombreCompleto
	Integer numeroEscritura
	Date fechaApoderamiento
	String matriculasApoderados
	String nombresApoderados
	String notario
	String grupoFinanciero
	String institucion
}

class DocumentoRevocacionRepositorioTO extends DocumentoRepositorioTO{
	String tipoDocumentoRespaldo
	String representanteLegalNombreCompleto
	Integer numeroEscritura
	Date fechaRevocacion
	String matriculasRevocados
	String nombresRevocados
	String notario
	String grupoFinanciero
	String institucion
}

class DocumentoFotoSustentanteRepositorioTO extends DocumentoRepositorioTO{
	Integer numeroMatricula
	String nombreCompleto
}

class DocumentoSustentanteRepositorioTO extends DocumentoRepositorioTO{
	Integer numeroMatricula
	String tipoDocumentoSustentante
	String nombreCompleto
}

public enum ClaseDocumento{
	DOCUMENTO(1,"DOCUMENTO"), OFICIO_CNBV(2,"OFICIO_CNBV"), PODER(3,"PODER"), 
	FOTO_SUSTENTANTE(4,"FOTO_SUSTENTANTE"), DOC_SUSTENTANTE(5,"DOC_SUSTENTANTE"), REVOCACION(6,"REVOCACION")
	
	private Integer id
	private String name
	private static Map<Integer,ClaseDocumento> _map = null
	
	public ClaseDocumento(Integer id, String name){
		this.id = id
		this.name = name
	}
	
	public Integer getId()
	{
		return this.id
	}
	
	private static synchronized Map<Integer,ClaseDocumento> getInstanceMap(){
		if(_map == null)
		{
			_map = new HashMap<Integer,ClaseDocumento>()
			_map.put(ClaseDocumento.DOCUMENTO.id, ClaseDocumento.DOCUMENTO)
			_map.put(ClaseDocumento.OFICIO_CNBV.id, ClaseDocumento.OFICIO_CNBV)
			_map.put(ClaseDocumento.PODER.id, ClaseDocumento.PODER)
			_map.put(ClaseDocumento.FOTO_SUSTENTANTE.id, ClaseDocumento.FOTO_SUSTENTANTE)
			_map.put(ClaseDocumento.DOC_SUSTENTANTE.id, ClaseDocumento.DOC_SUSTENTANTE)
			_map.put(ClaseDocumento.REVOCACION.id, ClaseDocumento.REVOCACION)
		}
		return _map
	}
	
	public static ClaseDocumento fromInteger(Integer x){
		return ClaseDocumento.getInstanceMap().get(x)
	}
}