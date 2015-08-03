var app = app || {};

/*
app.EXP_CEA_SELECTED_TAB_MAT = 0;
app.EXP_CEA_SELECTED_TAB_FOL = 1;
app.EXP_CEA_SELECTED_TAB_BAV = 2;
*/
app.EXP_CEA_RSLTS_ST_READY = 0;
app.EXP_CEA_RSLTS_ST_PROC = 0;

app.EXP_CEA_RSLT_ST_NO_ENVIADO = 0;
app.EXP_CEA_RSLT_ST_ENVIADO = 1;

app.EXP_CEA_RSLT_NOSEL_COLOR = "#FFFFFF"; //blanco
app.EXP_CEA_RSLT_SEL_COLOR = "#D9EDF7"; //azul claro
app.EXP_CEA_RSLT_ENLOTE_COLOR = "#DEF7D9"; //verde claro
app.EXP_CEA_RSLT_SELENLOTE_COLOR = "#F2D9F7"; //morado claro


app.Figura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.variantesFigura = new Array();
}

app.VarianteFigura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.figura = {};
}
/*
app.CertPendAutMainVM = Backbone.Model.extend({
	defaults: {
		selectedTab: app.EXP_CEA_SELECTED_TAB_MAT
	}
});
*/
app.MatriculaTabVM = Backbone.Model.extend({
	defaults: {
		numeroMatricula: -1
	}
});

app.FolioTabVM = Backbone.Model.extend({
	defaults: {
		idSustentante: -1
	}
});

app.BusqAvVM = Backbone.Model.extend({
	defaults: {
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		idVarianteFigura: -1,
		
		viewFiguras: [],
		viewVariantesFigura: []
	}
});

app.ResultVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		dsFigura: "",
		idVarianteFigura: -1,
		dsVarianteFigura: "",
		
		yaEnLote: false,
		
		viewChecked: false
	},
	getViewSelectionColor: function(){
		var colorHexStr = app.EXP_CEA_RSLT_NOSEL_COLOR;
		if(this.get('yaEnLote') == true && this.get('viewChecked') == true){
			colorHexStr = app.EXP_CEA_RSLT_SELENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == true && this.get('viewChecked') == false){
			colorHexStr = app.EXP_CEA_RSLT_ENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == false && this.get('viewChecked') == true){
			colorHexStr = app.EXP_CEA_RSLT_SEL_COLOR;
		}
		else if(this.get('yaEnLote') == false && this.get('viewChecked') == false){
			colorHexStr = app.EXP_CEA_RSLT_NOSEL_COLOR;
		}
		return colorHexStr;
	}
});

app.ResultVMCollection = Backbone.Collection.extend({
	model: app.ResultVM
});

app.ResultsVM = Backbone.Model.extend({
	defaults: {
		showYaEnLote: true,
		totalEnLote: 0,
		
		state: app.EXP_CEA_RSLTS_ST_READY,
		error: false,
		
		max: 10,
		offset: 0,
		sort: "id",
		order: "asc",
	},
	getCurrentPage: function(){
		return -1;
	},
	getTotalPages: function(){
		return -1;
	},
	getNextPage: function(){
		return -1;
	},
	getBackPage: function(){
		return -1;
	}
});

app.CertPendAutMainView = Backbone.View.extend({
	el: '#divCertPendAut',
	template: _.template( $('#certPendAutMainTemplate').html() ),
	options: {},
	
	initialize: function(options){
		//this.collection = new app.PuestoViewModelCollection(initialData);
		this.options = options;
		this.render();
		//this.listenTo( this.collection, 'add', this.renderList );
		//this.listenTo( this.collection, 'sort', this.renderList );
	},
	
	//MÉTODOS DE RENDEREO
	render: function(){
		this.$el.html( this.template() );
		//this.renderMatriculaTabView();
		//this.renderFolioTabView();
		//this.renderBusqAvView();
		this.renderResultView();
		return this;
	},
	renderMatriculaTabView: function(){
		this.$(".tab-pane-matricula").html("");
		var view = new app.MatriculaTabView(this.options);
		return view.render();
	},
	renderFolioTabView: function(){
		this.$(".tab-pane-folio").html("");
		var view = new app.FolioTabView(this.options);
		return view.render();
	},
	renderBusqAvView: function(){
		this.$(".tab-pane-busqav").html("");
		var view = new app.BusqAvView(this.options);
		return view.render();
	},
	renderResultView: function(){
	
		var parentView = this;
		var model = this.options.resultsVM;
		var collection = this.options.resultVMCollection;
		
		var view = new app.ResultsView({ model:model, collection:collection, parentView:parentView });

		this.$(".div-resultados").html("");
		this.$(".div-resultados").append( view.render().el );
		
		return view;
	}
	
});

app.MatriculaTabView = Backbone.View.extend({
	parentView: {},
	el: "",
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByNumeroMatricula'
	},
	limpiar : function(e){
		
	},
	findByNumeroMatricula : function(e){
		
	}
});

app.FolioTabView = Backbone.View.extend({
	parentView: {},
	el: "",
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByIdSustentante'
	},
});

app.BusqAvView = Backbone.View.extend({
	parentView: {},
	el: "",
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findAll'
	},
});

app.ResultView = Backbone.View.extend({
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#resultTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		
		this.render();
		
		this.listenTo( this.model, 'change:viewChecked', this.render );
		this.listenTo( this.model, 'change:yaEnLote', this.render );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.css( "background-color" , this.model.getViewSelectionColor() );
		return this;
	},
	
	events: {
		'click .sent' : 'enviarALote',
		'click .check' : 'seleccionar'
	},
	
	enviarALote: function(e){
		e.preventDefault();
		
		if( this.model.get('yaEnLote') == false ){
			this.model.set('yaEnLote',true);
		}
		else{
			this.model.set('yaEnLote',false);
		}
	},
	
	seleccionar: function(e){
		e.preventDefault();
		
		if( this.model.get('viewChecked') == false ){
			this.model.set('viewChecked',true);
		}
		else{
			this.model.set('viewChecked',false);
		}
	}
});

app.ResultsView = Backbone.View.extend({
	parentView: {},
	tagname: 'div',
	template: _.template( $('#resultsTemplate').html() ),
	
	model: new Backbone.Model(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.render();
		
		//this.listenTo( this.collection, 'add', this.renderList );
		//this.listenTo( this.collection, 'sort', this.renderList );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderList();
		return this;
	},
	renderList: function(){
		this.$(".list-items").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.ResultView({model:item,parentView:view});
		elementView.viewModel = this.viewModel;
		this.$(".list-items").append( elementView.render().el );
		return this;
	},
	
	events: {
		'click .hideSent' : 'ocultarElementoEnviados',
		'click .selectAll' : 'seleccionarTodos',
		'click .selectNone' : 'quitarSeleccionTodos',
		'click .sentSelected' : 'enviarSeleccionadosLote',
		'click .viewLote' : 'verLote'
	},
	
	ocultarElementoEnviados: function(e){
		e.preventDefault();
	},
	seleccionarTodos: function(e){
		e.preventDefault();
	},
	quitarSeleccionTodos: function(e){
		e.preventDefault();
	},
	enviarSeleccionadosLote: function(e){
		e.preventDefault();
	},
	verLote: function(e){
		e.preventDefault();
	}
});