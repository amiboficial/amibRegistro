var app = app || {};

app.ST_DOC_PRELOADED = 0;
app.ST_DOC_UPLOADED = 1;
app.ST_DOC_DELETED = 2;

app.ST_VM_DOC_READY = 0;
app.ST_VM_DOC_UPLOADING = 1;
app.ST_VM_DOC_READY_ERRORS = 2;

app.Doc = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		uuid: '',
		idTipo: -1,
		dsTipo: '',
		nombre: '',
		status: app.ST_DOC_PRELOADED,
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
		urlDownload: '/amibRegistro/documento/download',
		urlDownloadNew: '/amibRegistro/documento/downloadNew',
		urlDelete: '/amibRegistro/documento/delete'
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
		e.preventDefault();
		alert("descargarDocumento");
	},
	
	eliminarDocumento: function(e){
		e.preventDefault();

		//manda borrar el documento de los temporales del servidor
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
		
		this.listenTo( this.viewModel, 'change:status', this.renderBusy );
	},
	
	render: function(){
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		
		//limpiar mensajes
		this.$(".msgProcesando").hide();
		this.$(".msgErrorPeticion").hide();
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
		if( !jQuery.isEmptyObject(this.validator) ){
			validatedByExternal = this.validator.validateModel(this.collection);
		}
		
		// esta ocupado?
		// fue validado correctamente por "validator"? (si es que hay uno referenciado)
		// mensajes adicionales de "validator"
	},
	
	renderBusy: function(item){
		if(item.get('status') == app.ST_VM_DOC_UPLOADING){
			this.$(".msgProcesando").show();
			this.$(".msgErrorPeticion").hide();
			this.$(".newFileRow").hide();
		}
		else if(item.get('status') == app.ST_VM_DOC_READY_ERRORS){
			this.$(".msgProcesando").hide();
			this.$(".msgErrorPeticion").show();
			this.$(".newFileRow").show();
		}
		else{
			this.$(".msgProcesando").hide();
			this.$(".msgErrorPeticion").hide();
			this.$(".newFileRow").show();
		}
	},
	
	events: {
		'click .add':'agregarNuevoDocumento'
	},
	
	agregarNuevoDocumento: function(e){
		e.preventDefault();
		
		this.viewModel.set('status',app.ST_VM_DOC_UPLOADING);
		
		var contexto = this;
		setTimeout(function(){
			contexto.viewModel.set('status',app.ST_VM_DOC_READY);
			
			var doc = new app.Doc();
			contexto.collection.add(doc);
			
		}, 200);
		
		//var doc = new app.Doc();
		//this.collection.add(doc);
	}
});