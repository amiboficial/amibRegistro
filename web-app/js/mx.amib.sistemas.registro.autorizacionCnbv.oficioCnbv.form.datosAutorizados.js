var app = app || {};

app.DatosAutorizadosTabVM = Backbone.Model.extend({
	defaults: {
		idCertificacion: '',
		idSustentante: -1,
		numeroMatricula: '',
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		dsFigura: '',
		dsVarianteFigura: '',
		dsTipoAutorizacion: '',
	
		numeroMatriculaFoundValidated: false,
		errorNumeroMatricula: false,
		errorNumeroMatriculaNotFound: false,
		errorNumeroMatriculaInvalidDataType: false,
		
		processing: false,

		findAutorizableByNumeroMatriculaUrl: ''
	},
	findAutorizableByNumeroMatricula: function(){
		alert('findAutorizableByNumeroMatricula - NOT YET IMPLEMENTED');
	},
	_getResult: function(result){
		//todo: hacer eso
	}
});

app.AutorizadoVM = Backbone.Model.extend({
	defaults: {
		idCertificacion: -1,
		idSustentante: -1,
		numeroMatricula: '',
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		dsFigura: '',
		dsVarianteFigura: '',
		dsTipoAutorizacion: '',
		
		expanded: false
	}
});

app.AutorizadoVMCollection = Backbone.Collection.extend({ 
	model: app.AutorizadoVM,
	
	_sort: "idCertificacion",
	_order: "asc",
	
	sortAndOrderBy: function(order, sort){
		alert("sortAndOrderBy(" + order + "," + sort + ") - NOT YET IMPLEMENTED");
	}
});

app.AutorizadoResultView = Backbone.View.extend({
	parentView: {},
});

app.AutorizadoResultsView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#oficioCnbvFormAutorizadosListTemplate').html() ),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.listenTo( this.collection, 'reset', this.renderList );
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		return this;
	},
	renderList: function(){
		this.$(".list-items").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		}, this );
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.AutorizadoResultView({model:item,parentView:view});
		this.$(".list-items").append( elementView.render().el );
		return elementView;
	}
});

app.DatosAutorizadosTabView = Backbone.View.extend({
	checkId: -1,
	el: '#divAutorizados',
	template: _.template( $('#oficioCnbvFormAutorizadosTemplate').html() ),
	model: new Backbone.Model(),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.render();
		//aqui colocar los listeners
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderAutorizadoResultsView();
		return this;
	},
	renderAutorizadoResultsView: function(){
		var parentView = this;
		var collection = this.collection; //AutorizadoVMCollection
		var view;
		
		this.$('.div-autorizados').html("");
		view = new app.AutorizadoResultsView( { parentView:parentView, collection:collection } );
		this.$('.div-autorizados').append( view.render().el );
	},
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	}
});