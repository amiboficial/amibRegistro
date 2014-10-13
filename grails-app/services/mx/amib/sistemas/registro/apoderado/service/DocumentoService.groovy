package mx.amib.sistemas.registro.apoderado.service

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

import javax.servlet.http.HttpSession
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.RestoreAction;

import java.util.Date;
import java.util.UUID
import java.io.FileOutputStream
import java.io.File

import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.commons.CommonsMultipartFile

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion

@Transactional
class DocumentoService {

	def grailsApplication
	
	private static TreeMap<String,DocumentoTO> documentosTemporales = new TreeMap<String,DocumentoTO>()
	
	//Obtiene un "Archivo" del listado en memoria de documetos temporales
	ArchivoTO obtenerArchivoDocumentoTemp(String uuid){

		ArchivoTO archivo = new ArchivoTO()
		DocumentoTO doc = null
		
		if(!this.documentosTemporales.containsKey(uuid)){
			archivo = null
		}
		else{
			archivo.file = new File(grailsApplication.config.mx.amib.sistemas.registro.tempDir + uuid)
			archivo.mimeType = this.documentosTemporales.get(uuid).mimeType
			archivo.nombre = this.documentosTemporales.get(uuid).nombreDocumento
		}
		
		return archivo
	}
	
	//Guarda documento temporal
    DocumentoTO guardarDocumentoTemp(String sessionId, CommonsMultipartFile documentoArchivo, String uuidAnterior) {
		DocumentoTO documento = new DocumentoTO()
		String strTipoDocumento = null
		
		documento.uuid = UUID.randomUUID() as String
		documento.sessionId = sessionId
		
		documento.nombreDocumento = documentoArchivo.getOriginalFilename()
		documento.mimeType = documentoArchivo.getContentType() 
		
		FileOutputStream fos = new FileOutputStream(grailsApplication.config.mx.amib.sistemas.registro.tempDir + documento.uuid)
		fos.write(documentoArchivo.getBytes())
		fos.close()
		
		//this.limpiaDocumentoTempTipo(sessionId, claseDocumento, idTipoDocumento)
		this.eliminarDocumentoTemp(uuidAnterior)
		documentosTemporales.put(documento.uuid, documento)
		
		return documento
    }
	
	//Borra documento temporal dado su uuid
	void eliminarDocumentoTemp(String uuid){
		if(documentosTemporales.containsKey(uuid))
		{
			documentosTemporales.remove(uuid)
			try{
			   File file = new File(grailsApplication.config.mx.amib.sistemas.registro.tempDir + uuid);
			   if(file.delete()){
				   System.out.println(file.getName() + " is deleted!");
			   }else{
				   System.out.println("Delete operation is failed.");
			   }
		
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	//Borra documento temporal de la misma clase, tipo y session
	/*void limpiaDocumentoTempTipo(String sessionId, ClaseDocumento claseDocumento, int idTipoDocumento){
		List<DocumentoTO> docsBorrar = new ArrayList<DocumentoTO>()
		
		for( DocumentoTO d : documentosTemporales.values() ){
			if( d.sessionId == sessionId && d.claseDocumento == claseDocumento && d.idTipoDocumento == idTipoDocumento ){
				docsBorrar.add(d)
			}
		}
		
		for( DocumentoTO db : docsBorrar ){
			this.eliminarDocumentoTemp(db.uuid);
		}
	}*/
	
	//Borra documentos temporal dado un sessionId
	//(util cuando ya no existe dicha session y hay que limpiar)
	void limpiaDocumentoTemp(String sessionId){
		List<DocumentoTO> docsBorrar = new ArrayList<DocumentoTO>()
		
		for( DocumentoTO d : documentosTemporales.values() ){
			if( d.sessionId == sessionId ){
				docsBorrar.add(docsBorrar)
			}
		}
		
		for( DocumentoTO db : docsBorrar ){
			this.eliminarDocumentoTemp(db.uuid);
		}
	}
	
	//Envía los documentos temporales al repositorio
	void enviaDocumentosTemp(List<DocumentoPoderRepositorioTO> docs, boolean flush = true){
		docs.each{
			//Obtiene los datos requeridos de nombre y mimetype, así como establece fechas
			it.nombre = this.documentosTemporales.get(it.uuid).nombreDocumento
			it.mimetype = this.documentosTemporales.get(it.uuid).mimeType
			it.fechaModificacion = new Date()
			it.fechaCreacion = new Date()
			
			//Prepara al llamada REST
			String restUrl = grailsApplication.config.mx.amib.sistemas.documentos.resthttpURL + grailsApplication.config.mx.amib.sistemas.documentos.DocumentoPoder.save
			def rest = new RestBuilder()
			def restMultipart = new RestBuilder()
			String _uuid = it.uuid
			String _json = (it as JSON)
			
			println restUrl
			println _json
			//Envía acorde al metadato
			def resp = rest.post(restUrl){
				contentType "application/json;charset=UTF-8"
				json _json
			}
			println (resp.json instanceof JSONObject) as JSON
			
			//Si envía error de "ya existente" entonces ignora
			//Envía el archivo
			String restMulitpartUrl = grailsApplication.config.mx.amib.sistemas.documentos.resthttpURL + grailsApplication.config.mx.amib.sistemas.documentos.archivo.subirArchivoDocumentoUuid  + _uuid
			println restMulitpartUrl
			def respMultipart = restMultipart.post(restMulitpartUrl) {
		        contentType "multipart/form-data"
				archivo = new File(grailsApplication.config.mx.amib.sistemas.registro.tempDir + _uuid)
		    }
			println (respMultipart.json instanceof JSONObject) as JSON
			
			//Si todo sale bien, lo elimina de los temporales
			this.eliminarDocumentoTemp(it.uuid)
		}
	}
}

class DocumentoPoderRepositorioTO {
	Long id
	String uuid
	String clave
	String nombre
	String mimetype
	Date fechaModificacion
	Date fechaCreacion
	
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

class DocumentoTO{
	String uuid
	String sessionId

	int id
	String nombreDocumento
	String claveDocumento
	String mimeType
	
	int idTipoDocumento
	String tipoDocumento
}

class ArchivoTO{
	String mimeType
	String nombre
	File file
}

enum ErrorGuardarDocumentoTemp{
	ERROR, ERROR_TAM_MAYOR, ERROR_TIPO
}