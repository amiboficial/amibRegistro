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

app.DOCMULTI2_ERRMSG_SUBMITVAL = "DOCMULTI2_ERRMSG_SUBMITVAL"; //mensaje de validación al hacer submit
app.DOCMULTI2_ERRMSG_CANT_REQ = "DOCMULTI2_ERRMSG_CANT_REQ"; //no se cumplió con la cantidad de documentos requeridos

/*app.TipoDocumento = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		descripcion: "",
		vigente: false,
		cantidadRequerida: 0,
		cantidadMaxima: 0,
		manejaVigencia: true
	}
});*/

app.Documento = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		uuid: "00000000-0000-0000-0000-000000000000",
		vigente: false,
		nombreArchivo: "",
		mimeType: "",
		idTipoDocumento: -1,
		descripcionTipoDocumento: "",
		manejaVigenciaTipoDocumento: true,
		fecha: new Date()
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
		'click .delete':'borrarDocumento',
		'click .setVigenciaFalse':'hacerNoVigente',
		'click .setVigenciaTrue':'hacerVigente',
		'click .download':'descargarDocumento'
	},
	borrarDocumento: function(e){
		e.preventDefault();
		var view = this;
		
		if(this.model.get("grailsId") == -1){
			console.log("se debe mandar borrar al servidor");
			
			$.ajax({
				url: view._deleteNewUrl + "/" + this.model.get("uuid"), 
				beforeSend: function(xhr){
					view.clearErrorProcArc();
					view.setProcessing();
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
					view.setErrorProc();
					view.setReady();
				}
			} );
			
		}
		else{
			//Borra el model
			view.model.destroy();
			//Destruye esta vista
			view.remove();
		}

	},
	hacerVigente: function(e){
		e.preventDefault();
		var view = this;
		
		this.model.set("vigente", true);
		this.setReady();
		console.log("se supone se hizo vigente");
	},
	hacerNoVigente: function(e){
		e.preventDefault();
		var view = this;
		
		this.model.set("vigente", false);
		this.setReady();
		console.log("se supone se hizo no vigente");
	},
	descargarDocumento: function(e){
		e.preventDefault();
		if(this.model.get("grailsId") > 0){
			window.open(this._downloadUrl + "/" + this.model.get("uuid"));
		}
		else{
			window.open(this._downloadNewUrl + "/" + this.model.get("uuid"));
		}
	}
});

app.DocumentosView = Backbone.View.extend({

	//INITIALIZE
	initialize: function( options ){
		this.tiposDocumento = options.tiposDocumento;
		this.collection = options.initialDocumentos;
		this.render();
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
		this.$el.html( this.template( { tiposDocumento:this.tiposDocumento } ) );
		//rendera cada uno de los documentos 
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		//renderea errores
		this.renderErrors();
		
		this.$(".procUpload").hide();
		
		if(this.getState() == app.DOCMULTI2_READY){
			this.enableFields();
			this.enableSubmitDisableEdit();
		}
		else if(this.getState() == app.DOCMULTI2_PROC){
			this.$(".procUpload").show();
			this.disableFields();
		}
		else if(this.getState() == app.DOCMULTI2_VALIDATED){
			//deshabilitar todos los campos
			this.disableFields();
			//solo dejar "editar" habilidado
			this.disableSubmitEnableEdit();
		}
		
		return this;
	},
	renderElement: function(item){
		var elementView = new app.DocumentoView({model:item});
		elementView.setDownloadNewUrl(this._downloadNewUrl);
		elementView.setDownloadUrl(this._downloadUrl);
		elementView.setDeleteNewUrl(this._deleteNewUrl);
		
		this.$(".listaDocumentos").append( elementView.render().el );
	},
	renderErrors: function(){
		var view = this
	
		this.$(".errorValidacion").hide();
		this.$(".errorUpload").hide();
		this.$(".successUpload").hide();
		
		if(this.hasErrorUpload()){
			this.$(".errorUpload").show(100);
			this.$(".msgErrorUpload").text(this.msgErrorUpload);
			//window.setTimeout( function(){ view.$(".errorUpload").hide(100); }, 3000 );
		}
		if(this.hasErrorValidacion()){
			var msg = "";
			_.each(this.msgsErrorValidacion,function(item){
				msg += "<li>" + item + "</li>";
			},this);
			this.$('.validationErrorMsgs').html(msg);
			this.$('.msgErrorValidacion').text(this.msgErrorValidacion);
			this.$(".errorValidacion").show(100);
			//window.setTimeout( function(){ view.$(".errorValidacion").hide(100); }, 3000 );
		}
	},
	renderSuccessAddElement: function(){
		var view = this;
		this.$(".successUpload").show(100);
		window.setTimeout( function(){ view.$(".successUpload").hide(100); }, 2500 );
	},
	
	clearErrorsOnFields: function(){
		//TODO: LIMPIA LA MARCA CON "ROJITO" DE LOS CAMPOS CON ERROR
	},
	showErrorsOnFields: function(){
		//TODO: MARCA CON "ROJITO" LOS CAMPOS CON ERROR
	},
	disableFields: function(){
		this.$(".archivo").prop( "disabled", true );
		this.$(".idTipoDocumento").prop( "disabled", true );
		this.$(".add").prop( "disabled", true );
		this.$(".download").prop( "disabled", true );
		this.$(".delete").prop( "disabled", true );
		this.$(".setVigenciaFalse").prop( "disabled", true );
		this.$(".setVigenciaTrue").prop( "disabled", true );
		this.$(".orderByNombreArchivo").prop( "disabled", true );
		this.$(".orderByIdTipoDocumento").prop( "disabled", true );
		this.$(".orderByFecha").prop( "disabled", true );
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", true );
	},
	enableFields: function(){
		this.$(".archivo").prop( "disabled", false );
		this.$(".idTipoDocumento").prop( "disabled", false );
		this.$(".add").prop( "disabled", false );
		this.$(".download").prop( "disabled", false );
		this.$(".delete").prop( "disabled", false );
		this.$(".setVigenciaFalse").prop( "disabled", false );
		this.$(".setVigenciaTrue").prop( "disabled", false );
		this.$(".orderByNombreArchivo").prop( "disabled", false );
		this.$(".orderByIdTipoDocumento").prop( "disabled", false );
		this.$(".orderByFecha").prop( "disabled", false );
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", false );
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
	msgErrorValidacion: app.DOCMULTI2_ERRMSG_SUBMITVAL,
	msgsErrorValidacion: [],
	hasErrorUpload: function(){
		return this.errorUpload;
	},
	setErrorUpload: function(msgErrorUpload){
		this.errorUpload = true;
		this.msgErrorUpload = msgErrorUpload;
		this.renderErrors();
	},
	clearErrorUpload: function(){
		this.errorUpload = false;
		this.renderErrors();
	},
	hasErrorValidacion: function(){
		return this.errorValidacion;
	},
	setErrorValidacion: function(msgError){
		this.errorValidacion = true;
		this.msgsErrorValidacion.push(msgError);
		this.renderErrors();
	},
	clearErrorValidacion: function(){
		this.errorValidacion = false;
		this.msgsErrorValidacion = new Array();
		this.renderErrors();
	},
	clearAllErrors: function(){
		this.clearErrorUpload();
		this.clearErrorValidacion();
	},
	setSuccessUpload: function(){
		this.renderSuccessAddElement();
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
		'click .add':'addDocumento',
		'click .orderByNombreArchivo':'orderByNombreArchivo',
		'click .orderByIdTipoDocumento':'orderByIdTipoDocumento',
		'click .orderByFecha':'orderByFecha',
		'click .submit':'submit',
		'click .edit':'edit',
	},
	addDocumento: function(){
		var view = this;
		var archivo = this.$(".archivo").val();
		var idTipoDocumento = this.$(".idTipoDocumento").val();
		var tipoDocumento = {};
		
		//Se obtiene la instancia del tipo de documento a agregar
		for(var i=0;i<this.tiposDocumento.length;i++){
			if(this.tiposDocumento[i].grailsId == idTipoDocumento){
				tipoDocumento = this.tiposDocumento[i];
				break;
			}
		}
		
		//limpiea cualquier error
		this.clearAllErrors();
		//valida que ninguno de los campos este "vacio"
		if(archivo == "" || idTipoDocumento < 1){
			this.setErrorUpload(app.DOCMULTI2_ERRMSG_NOINPUT);
		}
		else{
			//valida de acuerdo a los criterios de la lista de tipos documentos
			//cuenta el tipoDocumento en la coleccion actual
			var countTD = 0;
			this.collection.each(function(item){
				if(item.get("idTipoDocumento") == idTipoDocumento){
					countTD++;
				}
			},this);
			//comprueba que esa cantidad no se haya pasado
			if(countTD >= tipoDocumento.cantidadMaxima){
				this.setErrorUpload(app.DOCMULTI2_ERRMSG_CANT_MAX);
			}
			else{
			
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
									descripcionTipoDocumento: tipoDocumento.descripcion,
									manejaVigenciaTipoDocumento: tipoDocumento.manejaVigencia,
									fecha: new Date(),
									vigente: true
								}
							);
							view.collection.add(doc);
							
							//Esto debe ser limpiado en algun otro metodo, nada de dom aqui
							view.$(".archivo").val("");
							view.$(".idTipoDocumento").val('-1');
							view.setReady();
							view.setSuccessUpload();
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
		}
		
	},
	orderByNombreArchivo: function(e){
		e.preventDefault();
		this.collection.comparator = 'nombreArchivo';
		this.collection.sort();
		this.setReady();
		//console.log("NO HACE NADA EN ORDER POR ARCHIVO!!");
	},
	orderByIdTipoDocumento: function(e){
		e.preventDefault();
		this.collection.comparator = 'descripcionTipoDocumento';
		this.collection.sort();
		this.setReady();
	},
	orderByFecha: function(e){
		e.preventDefault();
		this.collection.comparator = 'fecha';
		this.collection.sort();
		this.setReady();
	},
	submit: function(e){
		e.preventDefault();
		//El modelo ya se encuentra en objeto, solo procedera a validar la información
		//console.log("HACIENDO SUBMIT");
		if( this.validate() ){
			//console.log("LOS DATOS FUERON VALIDOS");
			this.setValidated();
		}
		else{
			this.setReady();
		}
	},
	
	edit: function(e){
		e.preventDefault();
	
		this.setReady();
	},
	
	//VALIDACIONES
	//En caso de requerirse, aquí se agregan expresiones regulares
	validate: function(){
		var valid = true;
		//validar las cantidades requeridas por cada tipo de documento
		var currCantReq = 0;
		var colInArray = this.collection.toJSON();
		this.clearAllErrors();
		
		for(var i=0; i<this.tiposDocumento.length; i++){
			currCantReq = 0;
			for(var j=0; j<colInArray.length; j++){
				if(colInArray[j].idTipoDocumento == this.tiposDocumento[i].grailsId){
					currCantReq++;
				}
			}
			if(currCantReq < this.tiposDocumento[i].cantidadRequerida){
				valid = false;
				this.setErrorValidacion(app.DOCMULTI2_ERRMSG_CANT_REQ + ":" + this.tiposDocumento[i].descripcion);
			}
		}
		return valid;
	}
});