import grails.util.Environment
// Place your Spring DSL code here
beans = {
	membershipServiceScopedProxy(org.springframework.aop.scope.ScopedProxyFactoryBean)
	{
		targetBeanName = 'membershipService'
		proxyTargetClass = true
	}
	archivoTemporalService(mx.amib.sistemas.utils.service.ArchivoTemporalService) {
		directorioTemporal = application.config.mx.amib.sistemas.registro.tempDir
		minutosCaducidadPorArchivo = 50
	}
	documentoRepositorioService(mx.amib.sistemas.external.documentos.service.DocumentoRepositorioService) {
		saveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.save
		documentoPoderSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoPoder.save
		documentoPoderUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoPoder.update
		documentoRevocacionSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoRevocacion.save
		documentoRevocacionUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoRevocacion.update
		documentoOficioCnbvSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.CnbvDgaOficio.save
		documentoOficioCnbvUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.CnbvDgaOficio.update
		documentoFotoSustentanteSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.FotoSustentante.save
		documentoFotoSustentanteUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.FotoSustentante.update
		documentoSustentanteRepositorioSaveUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoSustentante.save
		documentoSustentanteRepositorioUpdateUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.DocumentoSustentante.update
		
		findAllByUuidListUrl = application.config.mx.amib.sistemas.documentos.resthttpURL + application.config.mx.amib.sistemas.documentos.Documento.findAllByUuidList
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
		findAllByIdCertificacionInUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.findAllByIdCertificacionIn
		getByNumeroMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.obtenerSustentantePorMatricula
		getUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.get
		saveUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.save
		updateDatosPersonalesUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.updateDatosPersonales
		updatePuestosUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.Sustentante.updatePuestos 
		
	}
	documentoSustentanteService(mx.amib.sistemas.external.expediente.service.DocumentoSustentanteService) {
		updateDocumentosDeSustentanteUrl =  application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.DocumentoSustentante.updateDocumentosDeSustentante 
	}
	certificacionService(mx.amib.sistemas.external.expediente.service.CertificacionService){
		getAllUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.getAll
		getWithSustentante = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.getWithSustentante
		findAllEnDictamenPrevioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevio
		findAllEnDictamenPrevioByMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevioByMatricula
		findAllEnDictamenPrevioByFolioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevioByFolio
		findAllEnAutorizacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacion
		findAllEnAutorizacionByMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacionByMatricula
		findAllEnAutorizacionByFolioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacionByFolio
		
		findAllCandidatoActualizacionAutorizacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacion
		findAllCandidatoActualizacionAutorizacionByMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacionByMatricula
		findAllCandidatoActualizacionAutorizacionByFolioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacionByFolio
		findAllCandidatoReposicionAutorizacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacion
		findAllCandidatoReposicionAutorizacionByMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacionByMatricula
		findAllCandidatoReposicionAutorizacionByFolioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacionByFolio
		findAllCandidatoCambioFiguraUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFigura
		findAllCandidatoCambioFiguraByMatriculaUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFiguraByMatricula
		findAllCandidatoCambioFiguraByFolioUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFiguraByFolio
		
		updateDatosParaAprobarDictamenUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.updateDatosParaAprobarDictamen
		updateDatosParaActualizarAutorizacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.updateDatosParaActualizarAutorizacion
		createReponerAutorizacionUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.createReponerAutorizacion
		createCambioFiguraUrl = application.config.mx.amib.sistemas.expediente.resthttpURL + application.config.mx.amib.sistemas.expediente.certificacion.Certificacion.createCambioFigura
	}
	poderService(mx.amib.sistemas.external.oficios.service.PoderService){
		listUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.list
		findAllByUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.findAllBy
		getUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.get
		saveUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.save
		updateUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.update
		isNumeroEscrituraAvailableUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.isNumeroEscrituraAvailable
	}
	apoderadoService(mx.amib.sistemas.external.oficios.service.ApoderadoService){
		findAllByIdCertificacionInUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.apoderado.findAllByIdCertificacionIn
		getAllUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.poder.apoderado.getAll
	}
	revocacionService(mx.amib.sistemas.external.oficios.service.RevocacionService){
		listUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.list
		findAllByUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.findAllBy
		getUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.get
		
		findAllByNumeroEscrituraUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.findAllByNumeroEscritura
		findAllByFechaRevocacionUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.findAllByFechaRevocacion
		findAllByGrupoFinancieroUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.findAllByGrupoFinanciero
		findAllByInstitucionUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.findAllByInstitucion
		
		getAllByIdCertficacionInSetUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.getAllByIdCertficacionInSet
		
		saveUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.save
		updateUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.update
		isNumeroEscrituraAvailableUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.isNumeroEscrituraAvailable
	}
	revocadoService(mx.amib.sistemas.external.oficios.service.RevocadoService){
		getIdsCertificacionUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.revocado.getIdsCertificacion
		containsRevocadosUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.revocacion.revocado.containsRevocados
	}
	oficioCnbvService(mx.amib.sistemas.external.oficios.service.OficioCnbvService){
		listUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.list
		findAllByUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllBy
		findAllByIdCertificacionInAutorizadosUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllByIdCertificacionInAutorizados
		findAllByMultipleIdCertificacionInAutorizadosUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllByMultipleIdCertificacionInAutorizados
		findAllByNumeroOficioUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllByNumeroOficio
		findAllByClaveDgaUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllByClaveDga
		findAllByFechaOficioUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.findAllByFechaOficio
		
		checkUniqueClaveDgaUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.checkUniqueClaveDga
		checkUniqueNumeroOficioUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.checkUniqueNumeroOficio
		
		getUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.get
		saveUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.save
		updateUrl = application.config.mx.amib.sistemas.oficios.resthttpURL + application.config.mx.amib.sistemas.oficios.oficioCnbv.update
	}
}
