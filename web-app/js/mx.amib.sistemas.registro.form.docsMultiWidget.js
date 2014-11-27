var app = app || {};

app.ST_DOC_PRELOADED = 0; //Precargado
app.ST_DOC_UPLOADED = 1; //Archivo cargado
app.ST_DOC_DELETED = 2; //Borrado

app.ST_VM_DOC_READY = 0; //Listo
app.ST_VM_DOC_UPLOADING = 1; //Subiendo
app.ST_VM_DOC_READY_ERRORS = 2; //Listo con errores

app.ST_VM_DOC_UPLD_NE = 0; //No error
app.ST_VM_DOC_UPLD_ERR = 1; //Error genérico
app.ST_VM_DOC_UPLD_NSEL = 2; //No hay tipo seleccionado
app.ST_VM_DOC_UPLD_NARC = 3; //No hay archivo
app.ST_VM_DOC_UPLD_EXT = 4; //Mensajes de validador externo

app.Doc = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		uuid: '',
		idTipo: -1,
		dsTipo: '',
		nombre: '',
		status: app.ST_VM_DOC_READY,
		_urlDown: '',
		_urlDelete: ''
	}
});

app.Docs = Backbone.Collection.extend({
	model: app.Revocado
});

app.DocsViewModel = Backbone.Model.extend({
	defaults: {
		status: app.ST_VM_DOC_READY,
		urlUpload: '/amibRegistro/documento/upload',
		urlDownloadNew: '/amibRegistro/documento/downloadNew',
		urlDeleteNew: '/amibRegistro/documento/delete',
		errors: []
	}
});

app.DocView = Backbone.View.extend({
	tagName: 'div',
	className: 'list-group-item',

	template: _.template( $('#documentoMultiTemplate').html() ),
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .download':'descargarDocumento',
		'click .delete':'eliminarDocumento'
	},
	
	descargarDocumento: function(e){		
		window.open(this.model.get('_urlDown'));
	},
	
	eliminarDocumento: function(e){
		e.preventDefault();

		if(this.model.get('status') == app.ST_DOC_UPLOADED )
		{
			//manda borrar el documento de los temporales del servidor
			$.ajax({
				url: this.model.get('_urlDelete'),
				context: document.body
			});
		}
		
		//si lo ejecuta debidamente:
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	},
	
});

app.DocsView = Backbone.View.extend({
	el:'#divMultiplesDocumentos',
	viewModel: new app.DocsViewModel(),
	validator: {},
	
	initialize: function(initialData){
		this.collection = new app.Docs(initialData);
		this.render();
		
		this.listenTo( this.collection, 'add', this.renderElement );
		
		this.listenTo( this.collection, 'add', this.renderHiddenData );
		this.listenTo( this.collection, 'change', this.renderHiddenData );
		this.listenTo( this.collection, 'remove', this.renderHiddenData );
		this.listenTo( this.collection, "reset", this.renderHiddenData );
		
		this.listenTo( this.collection, 'remove', this.renderDeletedInHidden );
		
		this.listenTo( this.viewModel, 'change:status', this.renderBusy );
	},
	
	render: function(){
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		
		//limpiar mensajes
		this.$(".msgProcesando").hide();
		this.$(".msgErrorPeticion").hide();
		this.$(".msgErrorTipoNoSel").hide();
		this.$(".msgErrorTipoNoArc").hide();
		this.$(".msgErrorValidadorExt").hide();
		return this;
	},
	
	renderElement: function(item){
		var elementView =  new app.DocView({model:item});
		elementView.viewModel = this.viewModel;
		this.$(".listaDocs").append( elementView.render().el );
	},
	
	renderHiddenData: function(){
		var busy = false;
		if(this.viewModel.get('status') == app.ST_VM_DOC_UPLOADING){
			busy = true;
		}
		var validatedByExternal = true;
		var validatedByExternalMessage = "";
		if( !jQuery.isEmptyObject(this.validator) ){
			validatedByExternal = this.validator.submitValidation(this.collection);
		}
		if(validatedByExternal){
			validatedByExternalMessage = this.validator.renderLastSubmitValidationMsg();
		}
		// esta ocupado?
		$("#hdnDocsIsBusy").val(busy);
		// fue validado correctamente por "validator"? (si es que hay uno referenciado)
		$("#hdnDocsModelValidated").val(validatedByExternal);
		// mensajes adicionales de "validator"
		$("#hdnDocsModelValidatedMsg").val(busy);
	},
	
	renderDeletedInHidden: function(item){
		if(item.get('grailsId') > 0){
			console.log("Se borrará un documento en el server, su id fué: " + item.get('grailsId'));
			var pipeString = $.trim($("#hdnDocsDeleted").val());
			if(pipeString == ""){
				pipeString = item.get('grailsId')
			}
			else{
				pipeString = pipeString + '|' + item.get('grailsId')
			}
			$("#hdnDocsDeleted").val(pipeString)
		}
		else{
			console.log("Fue un documento que aún no está en repositorio, su id fué: " + item.get('grailsId'));
		}
	},
	
	renderBusy: function(item){
		if(item.get('status') == app.ST_VM_DOC_UPLOADING){
			this.$(".msgProcesando").show();
			this.$(".msgErrorPeticion").hide();
			this.$(".msgErrorTipoNoSel").hide();
			this.$(".msgErrorTipoNoArc").hide();
			this.$(".newFileRow").hide();
			this.$(".msgErrorValidadorExt").hide();
		}
		else if(item.get('status') == app.ST_VM_DOC_READY_ERRORS){
	
			this.$(".msgProcesando").hide();
			this.$('.tipoDiv').removeClass('has-error');
			this.$(".msgErrorTipoNoSel").hide();
			this.$(".archivoInputDiv").removeClass('has-error');
			this.$(".msgErrorTipoNoArc").hide();
			this.$(".msgErrorPeticion").hide();
			this.$(".msgErrorValidadorExt").hide();
			
			for(var i=0; i < this.viewModel.get('errors').length; i++){
				var item = this.viewModel.get('errors')[i];
				console.log("elemento de error: " + item);
				if(item == app.ST_VM_DOC_UPLD_ERR){
					this.$(".msgErrorPeticion").show();
				}
				else if(item == app.ST_VM_DOC_UPLD_NSEL){
					this.$(".tipoDiv").addClass('has-error');
					this.$(".msgErrorTipoNoSel").show();
				}
				else if(item == app.ST_VM_DOC_UPLD_NARC){
					this.$(".archivoInputDiv").addClass('has-error');
					this.$(".msgErrorTipoNoArc").show();
				}
				else if(item == app.ST_VM_DOC_UPLD_EXT){
					this.$(".msgErrorValidadorExt").html( this.validator.renderLastBeforeUploadErrorsHtml() );
					this.$(".msgErrorValidadorExt").show();
				}
			}

			this.$(".newFileRow").show();
		}
		else{
			this.$(".msgProcesando").hide();
			
			this.$('.tipoDiv').removeClass('has-error');
			this.$(".msgErrorTipoNoSel").hide();
			this.$(".archivoInputDiv").removeClass('has-error');
			this.$(".msgErrorTipoNoArc").hide();
			this.$(".msgErrorPeticion").hide();
			this.$(".msgErrorValidadorExt").hide();
			
			this.$(".newFileRow").show();
		}
	},
	
	events: {
		'click .add':'agregarNuevoDocumento'
	},
	
	agregarNuevoDocumento: function(e){
		e.preventDefault();
		var contexto = this;
		
		this.viewModel.set('status',app.ST_VM_DOC_UPLOADING);
		
		var file = document.getElementById("ZmlsZURvY3VtZW50bw").files[0];//ZmlsZURvY3VtZW50bw== -> fileDocumento
		
		var fileString = document.getElementById("ZmlsZURvY3VtZW50bw").value;
		var idTipo = this.$(".tipoDocumento").val();
		var dsTipo = this.$(".tipoDocumento option:selected").text();
		
		
		console.log(idTipo + ',' + dsTipo + ',' + document.getElementById("ZmlsZURvY3VtZW50bw").value );
		
		this.viewModel.set('errors',new Array());
		if(fileString == ""){
			this.viewModel.get('errors').push(app.ST_VM_DOC_UPLD_NARC);	
		}
		if(idTipo == "null") {
			this.viewModel.get('errors').push(app.ST_VM_DOC_UPLD_NSEL);
		}
		
		console.log("el tamaño es " + this.viewModel.get('errors').length)
		 
		if(this.viewModel.get('errors').length > 0){
			this.viewModel.set('status',app.ST_VM_DOC_READY_ERRORS);
			return;
		}
		else{
			var validatedByExternal = true;
			if( !jQuery.isEmptyObject(this.validator) ){
				validatedByExternal = this.validator.validateBeforeUpload(this.collection,file,idTipo);
			}
			if(validatedByExternal==false){
				this.viewModel.get('errors').push(app.ST_VM_DOC_UPLD_EXT);
				this.viewModel.set('status',app.ST_VM_DOC_READY_ERRORS);
				return;
			}
		}
		
		var xhr = new XMLHttpRequest();
		if (xhr.upload) {
		
			xhr.addEventListener('readystatechange', function(evnt){ 
				if(xhr.readyState == 4 && xhr.status != 200 )
				{
					contexto.viewModel.set('errors',new Array());
					contexto.viewModel.get('errors').push(app.ST_VM_DOC_UPLD_ERR);
					contexto.viewModel.set('status',app.ST_VM_DOC_READY_ERRORS);
				}
				else if(xhr.readyState == 4 && xhr.status == 200)
				{
					var respuestaJson = JSON.parse(xhr.responseText);
					var doc = new app.Doc();
					doc.set(
						{uuid: respuestaJson.uuid, 
						 nombre: respuestaJson.filename,
						 status: app.ST_DOC_UPLOADED,
						 idTipo: idTipo,
						 dsTipo: dsTipo,
						 _urlDown: contexto.viewModel.get('urlDownloadNew') + '/' + respuestaJson.uuid,
						 _urlDelete: contexto.viewModel.get('urlDeleteNew') + '/' + respuestaJson.uuid}
					);
					contexto.collection.add(doc);
					$("#ZmlsZURvY3VtZW50bw").val("");
					$(".tipoDocumento").val('null');
					contexto.viewModel.set('status',app.ST_VM_DOC_READY);
				}
					
			}, false);
			
			
			xhr.open('POST', this.viewModel.get('urlUpload'), true);
			try
			{
				var formData = new FormData();
				formData.append("archivo", file);
				xhr.send(formData);
			}
			catch(err)
			{
				this.viewModel.set('errors',new Array());
				this.viewModel.get('errors').push(app.ST_VM_DOC_UPLD_ERR);
				this.viewModel.set('status',app.ST_VM_DOC_READY_ERRORS);
			}
		}
		
		/*
		setTimeout(function(){
			contexto.viewModel.set('status',app.ST_VM_DOC_READY);
			
			var doc = new app.Doc();
			contexto.collection.add(doc);
			
		}, 200);
		*/
		//var doc = new app.Doc();
		//this.collection.add(doc);
	}
});