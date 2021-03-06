// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml'],
	docx:          'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails.views.gsp.encoding = 'UTF-8'
grails.views.gsp.htmlcodec = 'xml'
grails.views.gsp.codecs.expression = 'html'
grails.views.gsp.codecs.scriptlet = 'html'
grails.views.gsp.codecs.taglib = 'none'
grails.views.gsp.codecs.staticparts = 'none'

grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
grails.converters.json.default.deep = true
//resuelve problema de "misplaced key"
grails.converters.json.circular.reference.behaviour = "INSERT_NULL"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.converters.json.pretty.print = true
        grails.logging.jul.usebridge = true
		
//		//mx.amib.sistemas.expediente.resthttpURL = 'http://bimalatrop.no-ip.biz:8084/amibExpediente/'
//		//mx.amib.sistemas.expediente.resthttpURL = 'http://localhost:8084/amibExpediente/'
		
		
//		mx.amib.sistemas.catalogos.resthttpURL = 'http://10.100.128.57:8080/amibCatalogos-0.1/'
//		mx.amib.sistemas.expediente.resthttpURL = 'http://10.100.128.57:8080/amibExpediente-0.1/'
//		mx.amib.sistemas.oficios.resthttpURL = 'http://10.100.128.57:8080/amibOficios/'
//		mx.amib.sistemas.documentos.resthttpURL = 'http://10.100.128.57:8080/amibDocumentos-0.1/'
		
		
		mx.amib.sistemas.catalogos.resthttpURL = 'http://amibrevalidacion.amib.com.mx:8080/amibCatalogos-0.1/'
		mx.amib.sistemas.expediente.resthttpURL = 'http://amibrevalidacion.amib.com.mx:8080/amibExpediente-0.1/'
		mx.amib.sistemas.oficios.resthttpURL = 'http://amibrevalidacion.amib.com.mx:8080/amibOficios/'
		mx.amib.sistemas.documentos.resthttpURL = 'http://amibrevalidacion.amib.com.mx:8080/amibDocumentos-0.1/'
		
    }
	test {
		grails.logging.jul.usebridge = false
		// TODO: grails.serverURL = "http://www.changeme.com"
		mx.amib.sistemas.catalogos.resthttpURL = 'http://bimalatrop.no-ip.biz:8080/amibCatalogos-0.1/'
		//mx.amib.sistemas.expediente.resthttpURL = 'http://bimalatrop.no-ip.biz:8084/amibExpediente/'
		//mx.amib.sistemas.expediente.resthttpURL = 'http://localhost:8084/amibExpediente/'
		mx.amib.sistemas.expediente.resthttpURL = 'http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/'
		mx.amib.sistemas.oficios.resthttpURL = 'http://bimalatrop.no-ip.biz:8080/amibOficios/'
		mx.amib.sistemas.documentos.resthttpURL = 'http://bimalatrop.no-ip.biz:8080/amibDocumentos-0.1/'
	}
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
		mx.amib.sistemas.catalogos.resthttpURL = 'http://10.100.128.57:8080/amibCatalogos-0.1/'
		mx.amib.sistemas.expediente.resthttpURL = 'http://10.100.128.57:8080/amibExpediente-0.1/'
		mx.amib.sistemas.oficios.resthttpURL = 'http://10.100.128.57:8080/amibOficios/'
		mx.amib.sistemas.documentos.resthttpURL = 'http://10.100.128.57:8080/amibDocumentos-0.1/'
    }
}

// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

grails.plugin.reveng.defaultSchema='dbo'
grails.plugin.reveng.excludeTables = [
	'dbamibregistro.sys.check_constraints'
]

grails.plugins.twitterbootstrap.fixtaglib = true
grails.plugins.twitterbootstrap.defaultBundle = 'bundle_bootstrap'

mx.amib.sistemas.registro.tempDir = 'O:\\Temp\\amibRegistro\\'

mx.amib.sistemas.catalogos.general.GrupoFinanciero.classname = 'mx.amib.sistemas.catalogos.general.model.catalog.GrupoFinanciero'
mx.amib.sistemas.catalogos.general.Institucion.classname = 'mx.amib.sistemas.catalogos.general.model.catalog.Institucion'
mx.amib.sistemas.catalogos.sepomex.Asentamiento.classname = 'mx.amib.sistemas.catalogos.sepomex.model.catalog.Asentamiento'
mx.amib.sistemas.catalogos.sepomex.Ciudad.classname = 'mx.amib.sistemas.catalogos.sepomex.model.catalog.Ciudad'
mx.amib.sistemas.catalogos.sepomex.EntidadFederativa.classname = 'mx.amib.sistemas.catalogos.sepomex.model.catalog.EntidadFederativa'
mx.amib.sistemas.catalogos.sepomex.Municipio.classname = 'mx.amib.sistemas.catalogos.sepomex.model.catalog.Municipio'
mx.amib.sistemas.catalogos.sepomex.Sepomex.classname =  'mx.amib.sistemas.catalogos.sepomex.model.catalog.Sepomex'
mx.amib.sistemas.expediente.Sustentante.classname = 'mx.amib.sistemas.expediente.model.Sustentante'

//INICIA: ESPECIFICACIONES DE RUTAS PARA CONSUMO DE SERVICIOS REST
//especificaciones de rutas para servicios REST de amibCatalogos
mx.amib.sistemas.catalogos.general.GrupoFinanciero.list = 'grupoFinancieroRestful/index?max=100'
mx.amib.sistemas.catalogos.general.GrupoFinanciero.getById = 'grupoFinancieroRestful/show/'
mx.amib.sistemas.catalogos.general.Institucion.getById = 'institucionRestful/show/'
mx.amib.sistemas.catalogos.general.Figura.list = 'figuraRestful/list'
mx.amib.sistemas.catalogos.general.Figura.getById = 'figuraRestful/show/'
mx.amib.sistemas.catalogos.personal.EstadoCivil.list = 'estadoCivilRestful/index?max=100'
mx.amib.sistemas.catalogos.personal.EstadoCivil.getById = 'estadoCivilRestful/index/show/'
mx.amib.sistemas.catalogos.personal.NivelEstudios.list = 'nivelEstudiosRestful/index?max=100'
mx.amib.sistemas.catalogos.personal.Nacionalidad.list = 'nacionalidadRestful/list'
mx.amib.sistemas.catalogos.personal.TipoTelefono.list = 'tipoTelefonoRestful/list'
mx.amib.sistemas.catalogos.personal.TipoDocumentoSustentante.list = 'tipoDocumentoSustentanteRestful/list'
mx.amib.sistemas.catalogos.sepomex.EntidadFederativa.list = 'entidadFederativaRestful/index?max=32'
mx.amib.sistemas.catalogos.sepomex.Sepomex.findByCodigoPostal = 'sepomexRestful/findByCodigoPostal?cp='
mx.amib.sistemas.catalogos.sepomex.Sepomex.get = 'sepomexRestful/show/'

//especificaciones de rutas para servicios REST de amibExpediente
mx.amib.sistemas.expediente.Sustentante.comprobarMatriculas = 'sustentanteRestful/comprobarMatriculas/'
mx.amib.sistemas.expediente.Sustentante.comprobarMatriculasNotIn = 'sustentanteRestful/comprobarMatriculasNotIn/'
mx.amib.sistemas.expediente.Sustentante.findAll = 'sustentanteRestful/findAll'
mx.amib.sistemas.expediente.Sustentante.findAllAdvancedSearchUrl = 'sustentanteRestful/findAllAdvancedSearch'
mx.amib.sistemas.expediente.Sustentante.findAllAdvancedSearchWithCertificacionUrl = 'sustentanteRestful/findAllAdvancedSearchWithCertificacion'
mx.amib.sistemas.expediente.Sustentante.obtenerSustentantePorMatricula = 'sustentanteRestful/obtenerSustentantePorMatricula/'
mx.amib.sistemas.expediente.Sustentante.findAllByIdCertificacionIn = 'sustentanteRestful/findAllByIdCertificacionIn/'
mx.amib.sistemas.expediente.Sustentante.get = 'sustentanteRestful/show/'
mx.amib.sistemas.expediente.Sustentante.save = 'sustentanteRestful/save'
mx.amib.sistemas.expediente.Sustentante.updateDatosPersonales = 'sustentanteRestful/updateDatosPersonales'
mx.amib.sistemas.expediente.Sustentante.updatePuestos = 'sustentanteRestful/updatePuestos'
mx.amib.sistemas.expediente.DocumentoSustentante.updateDocumentosDeSustentante = 'documentoSustentanteRestful/updateDocumentosDeSustentante'
mx.amib.sistemas.expediente.certificacion.MetodoValidacion.list = 'metodoValidacionRestful/index?max=100'
mx.amib.sistemas.expediente.certificacion.StatusAutorizacion.list = 'statusAutorizacionRestful/index?max=100'
mx.amib.sistemas.expediente.certificacion.StatusCertificacion.list = 'statusCertificacionRestful/index?max=100'
mx.amib.sistemas.expediente.certificacion.Certificacion.getAll = 'certificacionRestful/getAll'
mx.amib.sistemas.expediente.certificacion.Certificacion.getWithSustentante = 'certificacionRestful/getWithSustentante/'
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevio = 'certificacionRestful/findAllEnDictamenPrevio/'
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevioByMatricula = 'certificacionRestful/findAllEnDictamenPrevioByMatricula/'
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnDictamenPrevioByFolio = 'certificacionRestful/findAllEnDictamenPrevioByFolio/'
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacion = 'certificacionRestful/findAllEnAutorizacion'
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacionByMatricula = "certificacionRestful/findAllEnAutorizacionByMatricula/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllEnAutorizacionByFolio = "certificacionRestful/findAllEnAutorizacionByFolio/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacion = "certificacionRestful/findAllCandidatoActualizacionAutorizacion"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacionByMatricula = "certificacionRestful/findAllCandidatoActualizacionAutorizacionByMatricula/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoActualizacionAutorizacionByFolio = "certificacionRestful/findAllCandidatoActualizacionAutorizacionByFolio/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacion = "certificacionRestful/findAllCandidatoReposicionAutorizacion/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacionByMatricula = "certificacionRestful/findAllCandidatoReposicionAutorizacionByMatricula/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoReposicionAutorizacionByFolio = "certificacionRestful/findAllCandidatoReposicionAutorizacionByFolio/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFigura = "certificacionRestful/findAllCandidatoCambioFigura"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFiguraByMatricula = "certificacionRestful/findAllCandidatoCambioFiguraByMatricula/"
mx.amib.sistemas.expediente.certificacion.Certificacion.findAllCandidatoCambioFiguraByFolio = "certificacionRestful/findAllCandidatoCambioFiguraByFolio/"
mx.amib.sistemas.expediente.certificacion.Certificacion.updateDatosParaAprobarDictamen = 'certificacionRestful/updateDatosParaAprobarDictamen'
mx.amib.sistemas.expediente.certificacion.Certificacion.updateDatosParaActualizarAutorizacion = 'certificacionRestful/updateDatosParaActualizarAutorizacion'
mx.amib.sistemas.expediente.certificacion.Certificacion.createReponerAutorizacion = 'certificacionRestful/createReponerAutorizacion'
mx.amib.sistemas.expediente.certificacion.Certificacion.createCambioFigura = 'certificacionRestful/createCambioFigura'

//especificaciones de rutas para servicios REST de amibOficios
mx.amib.sistemas.oficios.poder.list = 'poder/index'
mx.amib.sistemas.oficios.poder.findAllBy = 'poder/findAllBy'
mx.amib.sistemas.oficios.poder.get = 'poder/show/'
mx.amib.sistemas.oficios.poder.save = 'poder/save'
mx.amib.sistemas.oficios.poder.update = 'poder/update/'
mx.amib.sistemas.oficios.poder.isNumeroEscrituraAvailable = 'poder/isNumeroEscrituraAvailable/'
mx.amib.sistemas.oficios.poder.apoderado.findAllByIdCertificacionIn = 'apoderado/findAllByIdCertificacionIn'
mx.amib.sistemas.oficios.poder.apoderado.getAll = 'apoderado/getAll'
mx.amib.sistemas.oficios.revocacion.list = 'revocacion/index'
mx.amib.sistemas.oficios.revocacion.findAllBy = 'revocacion/findAllBy'
mx.amib.sistemas.oficios.revocacion.findAllByNumeroEscritura = 'revocacion/findAllByNumeroEscritura'
mx.amib.sistemas.oficios.revocacion.findAllByFechaRevocacion = 'revocacion/findAllByFechaRevocacion'
mx.amib.sistemas.oficios.revocacion.findAllByGrupoFinanciero = 'revocacion/findAllByGrupoFinanciero'
mx.amib.sistemas.oficios.revocacion.findAllByInstitucion = 'revocacion/findAllByInstitucion'
mx.amib.sistemas.oficios.revocacion.getAllByIdCertficacionInSet = 'revocacion/getAllByIdCertficacionInSet'
mx.amib.sistemas.oficios.revocacion.get = 'revocacion/show/'
mx.amib.sistemas.oficios.revocacion.save = 'revocacion/save'
mx.amib.sistemas.oficios.revocacion.update = 'revocacion/update/'
mx.amib.sistemas.oficios.revocacion.isNumeroEscrituraAvailable = 'revocacion/isNumeroEscrituraAvailable/'
mx.amib.sistemas.oficios.revocacion.revocado.getIdsCertificacion = 'revocado/getIdsCertificacionFromIdsRevocados'
mx.amib.sistemas.oficios.revocacion.revocado.containsRevocados = 'revocado/containsRevocados'
mx.amib.sistemas.oficios.oficioCnbv.list = 'oficioCnbv/index'
mx.amib.sistemas.oficios.oficioCnbv.findAllBy = 'oficioCnbv/findAllBy'
mx.amib.sistemas.oficios.oficioCnbv.findAllByIdCertificacionInAutorizados = 'oficioCnbv/findAllByIdCertificacionInAutorizados'
mx.amib.sistemas.oficios.oficioCnbv.findAllByMultipleIdCertificacionInAutorizados = 'oficioCnbv/findAllByMultipleIdCertificacionInAutorizados'
mx.amib.sistemas.oficios.oficioCnbv.findAllByNumeroOficio = 'oficioCnbv/findAllByNumeroOficio'
mx.amib.sistemas.oficios.oficioCnbv.findAllByClaveDga = 'oficioCnbv/findAllByClaveDga'
mx.amib.sistemas.oficios.oficioCnbv.findAllByFechaOficio = 'oficioCnbv/findAllByFechaOficio'
mx.amib.sistemas.oficios.oficioCnbv.checkUniqueClaveDga = 'oficioCnbv/checkUniqueClaveDga'
mx.amib.sistemas.oficios.oficioCnbv.checkUniqueNumeroOficio = 'oficioCnbv/checkUniqueNumeroOficio'
mx.amib.sistemas.oficios.oficioCnbv.get = 'oficioCnbv/show/'
mx.amib.sistemas.oficios.oficioCnbv.save = 'oficioCnbv/save'
mx.amib.sistemas.oficios.oficioCnbv.update = 'oficioCnbv/update/'

//especificaciones de rutas para servicios REST de amibDocumentos
mx.amib.sistemas.documentos.Documento.save = 'documentoRestful/save'
mx.amib.sistemas.documentos.Documento.getByUuid = 'documentoRestful/getByUuid?uuid='
mx.amib.sistemas.documentos.Documento.deleteByUuid = 'documentoRestful/deleteByUuid?uuid='

mx.amib.sistemas.documentos.Documento.findAllByUuidList = 'documentoRestful/findAllByUuidList'
mx.amib.sistemas.documentos.Documento.findAllByMatricula = 'documentoRestful/findAllByMatricula'
mx.amib.sistemas.documentos.Documento.findAllLikeNombreArchivo = 'documentoRestful/findAllLikeNombreArchivo'
mx.amib.sistemas.documentos.Documento.findAllLikeDescripcion = 'documentoRestful/findAllLikeDescripcion'
mx.amib.sistemas.documentos.Documento.findAllGeneric = 'documentoRestful/findAllGeneric'
mx.amib.sistemas.documentos.Documento.findAllByType = 'documentoRestful/findAllByType'
mx.amib.sistemas.documentos.Documento.findAll = 'documentoRestful/findAll'

mx.amib.sistemas.documentos.Documento.list = 'documentoRestful/index'
mx.amib.sistemas.documentos.CnbvDgaOficio.list = 'cnbvDgaOficioRestful/index'
mx.amib.sistemas.documentos.DocumentoPoder.list = 'documentoPoderRestful/index'
mx.amib.sistemas.documentos.FotoSustentante.list = 'fotoSustenanteRestful/index'
mx.amib.sistemas.documentos.DocumentoSustentante.list = 'documentoSustentanteRestful/index'
mx.amib.sistemas.documentos.DocumentoRevocacion.list = 'documentoRevocacionRestful/index'

mx.amib.sistemas.documentos.DocumentoPoder.save = 'documentoPoderRestful/save'
mx.amib.sistemas.documentos.DocumentoPoder.update = 'documentoPoderRestful/updateByUuid'
mx.amib.sistemas.documentos.DocumentoRevocacion.save = 'documentoRevocacionRestful/save'
mx.amib.sistemas.documentos.DocumentoRevocacion.update = 'documentoRevocacionRestful/updateByUuid'
mx.amib.sistemas.documentos.CnbvDgaOficio.save = 'cnbvDgaOficioRestful/save'
mx.amib.sistemas.documentos.CnbvDgaOficio.update = 'cnbvDgaOficioRestful/updateByUuid'
mx.amib.sistemas.documentos.FotoSustentante.save = 'fotoSustenanteRestful/save'
mx.amib.sistemas.documentos.FotoSustentante.update = 'fotoSustenanteRestful/updateByUuid'
mx.amib.sistemas.documentos.DocumentoSustentante.save = 'documentoSustentanteRestful/save'
mx.amib.sistemas.documentos.DocumentoSustentante.update = 'documentoSustentanteRestful/updateByUuid'
mx.amib.sistemas.documentos.archivo.subirArchivoDocumentoUuid = 'archivoDocumento/subirArchivoDocumentoUuid?uuid='
mx.amib.sistemas.documentos.archivo.descargarArchivoDocumentoUuid = 'archivoDocumento/descargarArchivoDocumentoUuid?uuid='
