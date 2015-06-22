import grails.util.Environment
// Place your Spring DSL code here
beans = {
	archivoTemporalService(mx.amib.sistemas.util.service.ArchivoTemporalService) {
		directorioTemporal = application.config.mx.amib.sistemas.registro.tempDir
		minutosCaducidadPorArchivo = 50
	}
	documentoRepositorioService(mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService) {
		saveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.save
		documentoPoderSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoPoder.save
		documentoPoderUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoPoder.update
		documentoRevocacionSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoRevocacion.save
		documentoRevocacionUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoRevocacion.update
		
		findAllByMatriculaUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllByMatricula
		findAllLikeNombreArchivoUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllLikeNombreArchivo
		findAllLikeDescripcionUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllLikeDescripcion
		findAllGenericUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllGeneric
		findAllByTypeUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllByType
		findAllUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAll
		
		listDocumentoUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.list
		listCnbvDgaOficioUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.CnbvDgaOficio.list
		listDocumentoPoderUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoPoder.list
		listFotoSustentanteUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.FotoSustentante.list
		listDocumentoSustentanteUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoSustentante.list
		listRevocacionUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoRevocacion.list

		saveMultipartUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.archivo.subirArchivoDocumentoUuid
		getUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.getByUuid
		downloadUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.archivo.descargarArchivoDocumentoUuid
		deleteUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.deleteByUuid
		archivoTemporalService = archivoTemporalService
	}
	sepomexService(mx.amib.sistemas.external.catalogos.service.SepomexService) {
		getUrl = application.config.mx.amib.sistemas.catalogos.resthttpURL + application.config.mx.amib.sistemas.catalogos.sepomex.Sepomex.get
		listEntidadFederativaUrl = application.config.mx.amib.sistemas.catalogos.resthttpURL + application.config.mx.amib.sistemas.catalogos.sepomex.EntidadFederativa.list
		findByCodigoPostalUrl = application.config.mx.amib.sistemas.catalogos.resthttpURL + application.config.mx.amib.sistemas.catalogos.sepomex.Sepomex.findByCodigoPostal
		
	}
	sustentanteService(mx.amib.sistemas.external.expediente.service.SustentanteService) {
		comprobarMatriculasUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.comprobarMatriculas
		comprobarMatriculasNotInUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.comprobarMatriculasNotIn
		findAllUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.findAll
		findAllAdvancedSearchUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.findAllAdvancedSearchUrl
		findAllAdvancedSearchWithCertificacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.findAllAdvancedSearchWithCertificacionUrl
		getByNumeroMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.obtenerSustentantePorMatricula
		getUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.get
		saveUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.save
		updateDatosPersonalesUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.updateDatosPersonales
	}
}
