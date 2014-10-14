package mx.amib.sistemas.external.documentos.service

import java.util.Date

import mx.amib.sistemas.util.service.ArchivoTO
import mx.amib.sistemas.util.service.ArchivoTemporalService

import org.codehaus.groovy.grails.web.json.JSONObject

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
 * @version 1.0 - (Última actualización) 12/09/2014
 *
 */
@Transactional
class DocumentoRepositorioService {

	ArchivoTemporalService archivoTemporalService
	
	String saveUrl
	String documentoPoderSaveUrl
	String saveMultipartUrl
	String getUrl
	String downloadUrl
	String deleteUrl
	
    void enviarDocumentosArchivoTemporal(Collection<DocumentoRepositorioTO> docs) {
		docs.each{
			String restUrl = null
			
			it.id = null //este siempre se debe setear nulo para que pueda guardar el nuevo documento
			it.nombre = archivoTemporalService.obtenerArchivoTemporal(it.uuid).filename
			it.mimetype = archivoTemporalService.obtenerArchivoTemporal(it.uuid).mimetype
			it.fechaModificacion = new Date()
			it.fechaCreacion = new Date()
			
			def rest = new RestBuilder()
			def restMultipart = new RestBuilder()
			String _uuid = it.uuid
			String _json = (it as JSON)
			
			if( DocumentoPoderRepositorioTO.class.isInstance(it) ){
				restUrl = this.documentoPoderSaveUrl
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
	
	void eliminarDocumento(String uuid){
		
	}
	
	void eliminarDocumentos(Collection<String> uuids){
		
	}
	
	void descargarATemporal(String uuid){
		
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
	String datosAdicionales
}

class DocumentoPoderRepositorioTO extends DocumentoRepositorioTO{
	String tipoDocumentoRespaldo
	String representanteLegalNombre
	String representanteLegalApellido1
	String representanteLegalApellido2
	Boolean esRegistradoPorGrupoFinanciero
	Integer numeroEscritura
	Date fechaApoderamiento
	String jsonApoderados
	String jsonNotario
	String jsonGrupoFinanciero
	String jsonInstitucion
}

class DocumentoFotoSustentanteRepositorioTO extends DocumentoRepositorioTO{
	String datosAdicionales
}

class DocumentoSustentanteRepositorioTO extends DocumentoRepositorioTO{
	String datosAdicionales
}