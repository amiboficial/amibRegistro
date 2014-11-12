package mx.amib.sistemas.util.controller

import grails.converters.JSON
import mx.amib.sistemas.external.documentos.service.DocumentoRepositorioTO
import mx.amib.sistemas.util.service.ArchivoTO
import org.springframework.web.multipart.commons.CommonsMultipartFile

class DocumentoController {

	def archivoTemporalService
	def documentoRepositorioService
	
	def upload() {
		CommonsMultipartFile uploadFile = params.archivo
		//String uuidAnterior = params.'uuidAnterior'
		
		ArchivoTO archivo = null
		
		archivo = archivoTemporalService.guardarArchivoTemporal(session.id, uploadFile)
		//archivoTemporalService.eliminarArchivoTemporal(uuidAnterior)
		
		//se elimina el contenido de estos parametros por motivos de seguridad
		ArchivoTO archivoToRender = archivo.clone()
		archivoToRender.temploc = null
		archivoToRender.caducidad = null
		
		render archivoToRender as JSON
	}
	
	//solamente borra el archivo de TEMPORALES, no lo del repositorio
	def delete(String id) {
		HashMap<String,String> _response = new HashMap<String,String>();
		String documentoUuid = id
		archivoTemporalService.eliminarArchivoTemporal(documentoUuid)
		_response.put("status","OK")
		
		render _response as JSON
	}
	
	//String id -> uuid
	def download(String id) {
		String documentoUuid = id
		DocumentoRepositorioTO drt = documentoRepositorioService.descargarATemporal(session.id, documentoUuid)
		
		if(drt != null){
			ArchivoTO fileDocumento = archivoTemporalService.obtenerArchivoTemporal(documentoUuid)
			if(fileDocumento == null){
				response.sendError(404)
				return
			}
			else{
				File f = new File(fileDocumento.temploc)
				if (f.exists()) {
					response.setContentType(fileDocumento.mimetype)
					response.setHeader("Content-disposition", "attachment;filename=\"${fileDocumento.filename}\"")
					response.outputStream << f.bytes
					return
				}
				else {
					response.sendError(404)
					return
				}
			}
		}
		else{
			response.sendError(404)
			return
		}
	}
	
	def downloadNew(String id) {
		String documentoUuid = id
		ArchivoTO fileDocumento = archivoTemporalService.obtenerArchivoTemporal(documentoUuid)
		
		if(fileDocumento == null){
			response.sendError(404)
			return
		}
		else{
			File f = new File(fileDocumento.temploc)
			if (f.exists()) {
				response.setContentType(fileDocumento.mimetype)
				response.setHeader("Content-disposition", "attachment;filename=\"${fileDocumento.filename}\"")
				response.outputStream << f.bytes
				return
			}
			else {
				response.sendError(404)
				return
			}
		}
	}
	
}
