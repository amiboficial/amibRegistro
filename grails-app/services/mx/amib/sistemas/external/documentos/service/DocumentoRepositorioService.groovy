package mx.amib.sistemas.external.documentos.service

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date

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
 * @version 1.2 - (Última actualización) 03/02/2015
 *			1.1 - (Última actualización) 22/09/2014
 */
@Transactional
class DocumentoRepositorioService {

	ArchivoTemporalService archivoTemporalService
	
	String saveUrl
	String documentoPoderSaveUrl
	String documentoPoderUpdateUrl
	String documentoRevocacionSaveUrl
	String documentoRevocacionUpdateUrl
	
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
		resp.json instanceof JSONObject
		
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
					docRep.fechaApoderamiento = df.parse(resp.json.'fechaApoderamiento'.substring(0,10))
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

enum ClaseDocumento{
	DOCUMENTO, OFICIO_CNBV, PODER, REVOCACION, FOTO_SUSTENTANTE, DOC_SUSTENTANTE
}