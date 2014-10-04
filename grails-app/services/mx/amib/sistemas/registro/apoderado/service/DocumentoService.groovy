package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import java.util.UUID
import java.io.FileOutputStream
import org.springframework.web.multipart.commons.CommonsMultipartFile

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion

@Transactional
class DocumentoService {

	def grailsApplication
	
	private static TreeMap<String,DocumentoTO> documentosTemporales = new TreeMap<String,DocumentoTO>()
	
    DocumentoTO guardarDocumentoTemp(String sessionId, CommonsMultipartFile documentoArchivo, int idTipoDocumento, ClaseDocumento claseDocumento) {
		DocumentoTO documento = new DocumentoTO()
		String strTipoDocumento = null
		
		switch(claseDocumento){
			case ClaseDocumento.PODER:
				strTipoDocumento = TipoDocumentoRespaldoPoder.get(idTipoDocumento).descripcion
			break;
			case ClaseDocumento.REVOCACION:
				strTipoDocumento = TipoDocumentoRespaldoRevocacion.get(idTipoDocumento).descripcion
			break;
		}
		
		documento.uuidTemp = UUID.randomUUID() as String
		documento.sessionId = sessionId
		
		documento.idTipoDocumento = idTipoDocumento
		documento.tipoDocumento = strTipoDocumento
		documento.claseDocumento = claseDocumento
		
		documento.nombreDocumento = documentoArchivo.getOriginalFilename()
		documento.mimeType = documentoArchivo.getContentType() 
		
		FileOutputStream fos = new FileOutputStream(grailsApplication.config.mx.amib.sistemas.registro.tempDir + documento.uuidTemp)
		fos.write(documentoArchivo.getBytes())
		fos.close()
		
		this.limpiaDocumentoTempTipo(documento.claseDocumento, documento.idTipoDocumento)
		documentosTemporales.put(documento.uuidTemp, documento)
		
		return documento
    }
	
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
	
	void limpiaDocumentoTempTipo(ClaseDocumento claseDocumento, int idTipoDocumento){
		List<DocumentoTO> docsBorrar = new ArrayList<DocumentoTO>()
		
		for( DocumentoTO d : documentosTemporales.values() ){
			if( d.claseDocumento == claseDocumento && d.idTipoDocumento == idTipoDocumento ){
				docsBorrar.add(d)
			}
		}
		
		for( DocumentoTO db : docsBorrar ){
			this.eliminarDocumentoTemp(db.uuidTemp);
		}
	}
	
	void limpiaDocumentoTemp(String sessionId){
		List<DocumentoTO> docsBorrar = new ArrayList<DocumentoTO>()
		
		for( DocumentoTO d : documentosTemporales.values() ){
			if( d.sessionId == sessionId ){
				docsBorrar.add(docsBorrar)
			}
		}
		
		for( DocumentoTO db : docsBorrar ){
			this.eliminarDocumentoTemp(db.uuidTemp);
		}
	}
	
}

class DocumentoTO{
	String uuidTemp
	String sessionId
	
	ClaseDocumento claseDocumento
	int idTipoDocumento
	String tipoDocumento
	
	String nombreDocumento
	String claveDocumento
	String mimeType
}

enum ClaseDocumento{
	PODER, REVOCACION
}

enum ErrorGuardarDocumentoTemp{
	ERROR, ERROR_TAM_MAYOR, ERROR_TIPO
}