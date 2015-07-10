var app = app || {};

app.DOCMULTI2_READY = 0;
app.DOCMULTI2_VALIDATED = 1;
app.DOCMULTI2_PROC = 2;

app.DOCMULTI2_ERRMSG_MAXSIZE = "DOCMULTI2_ERRMSG_MAXSIZE"; //tamaño máximo de archivo superado
app.DOCMULTI2_ERRMSG_TYPE_NOT_ALLOWED = "DOCMULTI2_ERRMSG_TYPE_NOT_ALLOWED"; //tipo de archivo no permitido
app.DOCMULTI2_ERRMSG_CANT_MAX = "DOCMULTI2_ERRMSG_CANT_MAX"; //se ha sobrepasado la cantidad máxima de documentos del mismo tipo permitidos
app.DOCMULTI2_ERRMSG_ERRMSG_EPROC = "DOCMULTI2_ERRMSG_ERRMSG_EPROC"; //error al procesar la peticion

app.TipoDocumento = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		descripcion: "",
		vigente: false,
		cantidadRequeridaVigente: 0,
		cantidadMaximaVigente: 0,
		cantidadMaximaNoVigente: 0,
		manejaVigencia: false
	}
});

app.Documento = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		uuid: "00000000-0000-0000-0000-000000000000",
		vigente: false,
		nombreArchivo: "",
		mimeType: "",
		idTipoDocumento: -1,
		tipoDocumento: new app.TipoDocumento(),
		fecha: new Date(1436480714000)
	}
});

app.Documentos = Backbone.Collection.extend({
	model: app.Documento
});

app.DocumentoView = Backbone.View.extend({
	
});