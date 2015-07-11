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
		descripcionTipoDocumento: "",
		fecha: new Date(1436480714000)
	}
});

app.ArchivoCargado = Backbone.Model.extend ({
	defaults: {
		fileLoaded: false,
		idTipoDocumento: -1
	}
});

app.Documentos = Backbone.Collection.extend({
	model: app.Documento
});

app.DocumentoView = Backbone.View.extend({
	//BACKBONE VIEW RENDERING
	tagName: 'div',
	className: 'list-group-item',
	template: _.template( $('#documento').html() ),
	render: function(){
		//this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.html( this.template() );
		return this;
	}
});

app.DocumentosView = Backbone.View.extend({

	//INITIALIZE
	initialize: function( options ){
		this.tiposDocumento = options.tiposDocumento;
		this.collection = options.initialDocumentos;
		this.render();
		
		//callbacks a realizar en cambios al modelo
		this.listenTo( this.collection, 'add', this.renderElement );
	},

	//CHECKLIST ID ATTRIBUTES
	//métodos y atributo para implementar complemento 
	//en un checklist
	checkId: -1,
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	//BACKBONE VIEW RENDERING
	//atributos básicos de vista
	el: '#divDocumentos',
	tagName: 'div',
	className: 'list-group-item',
	template: _.template( $('#documentos').html() ),
	render: function(){
		//this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.html( this.template() );
		return this;
	},
	renderElement: function(item){
		var elementView = new app.ApoderadoView({model:item});
		this.$(".listaDocumentos").append( elementView.render().el );
	},
	clearErrorsOnFields: function(){
		//TODO: LIMPIA LA MARCA CON "ROJITO" DE LOS CAMPOS CON ERROR
	},
	showErrorsOnFields: function(){
		//TODO: MARCA CON "ROJITO" LOS CAMPOS CON ERROR
	},
	disableFields: function(){
		
	},
	enableFields: function(){

	},
	enableSubmitDisableEdit: function() {
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", true );
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", false );
	},
	
	//VIEW STATUS
	//estatus y errores de vista
	state: app.DOCMULTI2_READY,
	getState: function(){
		return this.state;
	},
	setReady: function(){
		this.state = app.DOCMULTI2_READY;
		this.trigger("stateChange","READY",this.checkId);
		this.render();
	},
	setProcessing: function(){
		this.state = app.DOCMULTI2_PROC;
		this.render();
	},
	setValidated: function(){
		this.state = app.DOCMULTI2_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
		this.render();
	},
	
	//VALIDATION ELEMENTS
	tiposDocumento: new Array(), //Se setea al inicializar con un arreglo de TipoDocumento
	//ERRORS
	errorUpload: false,
	msgErrorUpload: "",
	errorValidacion: false,
	msgErrorValidacion: "",
	hasErrorUpload: function(){
		return this.errorUpload;
	},
	setErrorUpload: function(){
		this.errorUpload = true;
	},
	clearErrorUpload: function(){
		this.errorUpload = false;
	},
	hasErrorValidacion: function(){
		return this.errorValidacion;
	},
	setErrorValidacion: function(){
		this.errorValidacion = true;
	},
	clearErrorValidacion: function(){
		this.errorValidacion = false;
	},
	
	//AJAX URLS
	//Urls para el procesamiento AJAX
	_uploadUrl: "",
	_downloadNewUrl: "",
	_download: "",
	_deleteNew: "",
	setUploadUrl: function(uploadUrl){
		this._uploadUrl = uploadUrl;
	},
	setDownloadNewUrl: function(downloadNewUrl){
		this._downloadNewUrl = downloadNewUrl;
	},
	setDownload: function(download){
		this._download = download;
	},
	setDeleteNew: function(deleteNew){
		this._deleteNew = deleteNew;
	},
	
	//CALLBACKS
	events: {
		'click .add':'agregarDocumento'
	},
	agregarDocumento: function(){
		alert("VALIDA EL ARCHIVO Y SUBE EL ARCHIVO AL SERVER");
	},
	
	//VALIDACIONES
});