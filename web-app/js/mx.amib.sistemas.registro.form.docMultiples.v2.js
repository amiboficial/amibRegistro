var app = app || {};

app.DOCMULTI2_READY = 0;
app.DOCMULTI2_VALIDATED = 1;
app.DOCMULTI2_PROC = 2;

app.DOCMULTI2_ERRMSG_NOINPUT = "DOCMULTI2_ERRMSG_NOINPUT"; //no ha introducido información del tipo ni y/o el archivo
app.DOCMULTI2_ERRMSG_ERRUPLD = "DOCMULTI2_ERRMSG_ERRUPLD"; //error al subir archivo (general)
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
		this.$el.html( this.template( this.model.toJSON() ) );
		
		//limpia mensajes
		this.$(".errorProcArc").hide();
		this.$(".procArc").hide();
		
		//de acuerdo al estatus de la vista
		if(this.state == app.DOCMULTI2_READY){
			if(this.hasErrorProcArc()){
				this.$(".errorProcArc").show();
			}
		}
		else if(this.state == app.DOCMULTI2_PROC){
			this.$(".procArc").show();
		}
		
		return this;
	},
	disableFields: function(){
		this.$('.download').prop("disabled",true);
		this.$('.setVigenciaTrue').prop("disabled",true);
		this.$('.setVigenciaFalse').prop("disabled",true);
		this.$('.delete').prop("disabled",true);
	},
	enableFields: function(){
		this.$('.download').prop("disabled",false);
		this.$('.setVigenciaTrue').prop("disabled",false);
		this.$('.setVigenciaFalse').prop("disabled",false);
		this.$('.delete').prop("disabled",false);
	},
	
	//VIEW STATUS
	//estatus y errores de vista
	state: app.DOCMULTI2_READY,
	getState: function(){
		return this.state;
	},
	setReady: function(){
		this.state = app.DOCMULTI2_READY;
		this.render();
	},
	setProcessing: function(){
		this.state = app.DOCMULTI2_PROC;
		this.render();
	},
	setValidated: function(){
		this.state = app.DOCMULTI2_VALIDATED;
		this.render();
	},
	
	//ERRORS
	errorProcArc: false,
	hasErrorProcArc: function(){
		return this.errorProcArc;
	},
	setErrorProcArc: function(){
		this.errorProcArc = true;
	},
	clearErrorProcArc: function(){
		this.errorProcArc = false;
	},
	
	//AJAX URLS
	//Urls para el procesamiento AJAX
	_downloadNewUrl: "",
	_downloadUrl: "",
	_deleteNewUrl: "",
	setDownloadNewUrl: function(downloadNewUrl){
		this._downloadNewUrl = downloadNewUrl;
	},
	setDownloadUrl: function(downloadUrl){
		this._downloadUrl = downloadUrl;
	},
	setDeleteNewUrl: function(deleteNewUrl){
		this._deleteNewUrl = deleteNewUrl;
	},
	
	//CALLBACKS
	events: {
		'click .delete':'borrarDocumento'
	},
	borrarDocumento: function(e){
		e.preventDefault();
		var view = this;
		
		if(this.model.get("grailsId") == -1){
			console.log("se debe mandar borrar al servidor");
			
			$.ajax({
				url: view._deleteNewUrl + "/" + this.model.get("uuid"), 
				beforeSend: function(xhr){
					//view.clearErrorProc();
					//view.setProcessing();
				}
			}).done( function(data){
				if(data.status == "OK"){
				
					//si lo ejecuta el borrado desde el servidor:
					//Borra el model
					view.model.destroy();
					//Destruye esta vista
					view.remove();
					
					//view.setReady();
				}
				else{
					//error alguno
					//view.setErrorProc();
					//view.setReady();
				}
			} );
			
		}
		
		
	},
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
		//rendera cada uno de los documentos 
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		return this;
	},
	renderElement: function(item){
		var elementView = new app.DocumentoView({model:item});
		elementView.setDownloadNewUrl(this._downloadNewUrl);
		elementView.setDownloadUrl(this._downloadUrl);
		elementView.setDeleteNewUrl(this._deleteNewUrl);
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
	setErrorUpload: function(msgErrorUpload){
		this.errorUpload = true;
		this.msgErrorUpload = msgErrorUpload;
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
	_downloadUrl: "",
	_deleteNewUrl: "",
	setUploadUrl: function(uploadUrl){
		this._uploadUrl = uploadUrl;
	},
	setDownloadNewUrl: function(downloadNewUrl){
		this._downloadNewUrl = downloadNewUrl;
	},
	setDownloadUrl: function(downloadUrl){
		this._downloadUrl = downloadUrl;
	},
	setDeleteNewUrl: function(deleteNewUrl){
		this._deleteNewUrl = deleteNewUrl;
	},
	
	//CALLBACKS
	events: {
		'click .add':'agregarDocumento'
	},
	agregarDocumento: function(){
		var view = this;
		var archivo = this.$(".archivo").val();
		var idTipoDocumento = this.$(".idTipoDocumento").val();
		
		if(archivo == "" || idTipoDocumento < 1){
			this.setErrorUpload(app.DOCMULTI2_ERRMSG_NOINPUT);
		}
		else{
			console.log("paso valida");
			//valida de acuerdo a los criterios de la lista de tipos documentos:
			//validar por tiposDocumento 
		
			//paso la validación
			
			//entonces recupera el archivo
			var file = this.$(".archivo")[0].files[0];
			
			var xhr = new XMLHttpRequest();
			
			if (xhr.upload) {
				//prepara el callbcack que recibira cuando se reba el archvo
				xhr.addEventListener('readystatechange', function(evnt){ 
					
					if(xhr.readyState == 4 && xhr.status != 200 )
					{
						view.setErrorUpload(app.DOCMULTI2_ERRMSG_ERRUPLD);
						view.setReady();
					}
					else if(xhr.readyState == 4 && xhr.status == 200)
					{
						var respuestaJson = JSON.parse(xhr.responseText);
						var doc = new app.Documento();
						doc.set(
							{
								grailsId: -1,
								uuid: respuestaJson.uuid, 
								nombreArchivo : respuestaJson.filename,
								mimeType: respuestaJson.mimetype,
								idTipoDocumento: idTipoDocumento,
								descripcionTipoDocumento: 'obtenerDeCollecion',
								fecha: new Date(),
								vigente: true
							}
						);
						view.collection.add(doc);
						
						//Esto debe ser limpiado en algun otro metodo, nada de dom aqui
						view.$(".archivo").val("");
						view.$(".idTipoDocumento").val('-1');
						view.setReady();
					}
						
				}, false);
				
				xhr.open('POST', this._uploadUrl, true);
				try
				{
					var formData = new FormData();
					formData.append("archivo", file);
					xhr.send(formData);
					//setea el status del componentente como "en progreso"
					this.setProcessing();
				}
				catch(err)
				{
					this.setErrorUpload(app.DOCMULTI2_ERRMSG_ERRUPLD);
					this.setReady();
				}
			}
		}
		
	},
	
	//VALIDACIONES
});