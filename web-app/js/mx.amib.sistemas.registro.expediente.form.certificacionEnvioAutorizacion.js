var app = app || {};

/*
app.EXP_CEA_SELECTED_TAB_MAT = 0;
app.EXP_CEA_SELECTED_TAB_FOL = 1;
app.EXP_CEA_SELECTED_TAB_BAV = 2;
*/
app.EXP_CEA_RSLTS_ST_READY = 0;
app.EXP_CEA_RSLTS_ST_PROC = 0;

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
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		dsFigura: "",
		idVarianteFigura: -1,
		dsVarianteFigura: "",
		
		yaEnLote: false,
		
		viewChecked: false
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
	template: _.template( $('#certPendAutMainView').html() ),
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
		this.renderMatriculaTabView();
		this.renderFolioTabView();
		this.renderBusqAvView();
		this.renderResultView();
		return this;
	},
	renderMatriculaTabView: function(){
		this.$(".matricula-tab-pane").html("");
		var view = new app.MatriculaTabView(this.options);
		return view.render();
	},
	renderFolioTabView: function(){
		this.$(".folio-tab-pane").html("");
		var view = new app.FolioTabView(this.options);
		return view.render();
	},
	renderBusqAvView: function(){
		this.$(".busqav-tab-pane").html("");
		var view = new app.BusqAvView(this.options);
		return view.render();
	},
	renderResultView: function(){
		this.$(".div-resultados").html("");
		var view = new app.ResultsView(this.options);
		return view.render();
	}
	
});

app.MatriculaTabView = Backbone.View.extend({
	parentView: {},
	el: "",
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByNumeroMatricula'
	},
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
	el: "",
	events: {
		//aqui va el evento de la "seleccion"
	},
});

app.ResultsView = Backbone.View.extend({
	parentView: {},
	el: "",
	events: {
		//aqui van los eventos de los botones
	},
});