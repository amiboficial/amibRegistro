var app = app || {};


app.EXP_CEA_SELECTED_TAB_MAT = 0;
app.EXP_CEA_SELECTED_TAB_FOL = 1;
app.EXP_CEA_SELECTED_TAB_BAV = 2;

app.EXP_CEA_RSLTS_ST_READY = 0;
app.EXP_CEA_RSLTS_ST_PROC = 1;

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
		procesando: false,
		
		viewChecked: false,
		
		sendToLoteUrl: "",
	},
	getViewSelectionColor: function(){	
		var colorHexStr = app.EXP_CEA_RSLT_NOSEL_COLOR;
		if(this.get('yaEnLote') == true && this.get('viewChecked') == true && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_SELENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == true && this.get('viewChecked') == false && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_ENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == false && this.get('viewChecked') == true && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_SEL_COLOR;
		}
		return colorHexStr;
	},
	
	//Async
	sendToLote: function(){
		
	}
	
});

app.ResultVMCollection = Backbone.Collection.extend({
	model: app.ResultVM, 
	
	findAllByMatriculaUrl: "",
	findAllByIdSustentanteUrl: "",
	findAllUrl: "",
	sendAllToLoteUrl: "",
	
	
	findAllByMatricula: function(options){ //Async
		
	},
	findAllByIdSustentante: function(options){ //Async
		
	},
	findAll: function(options){ //Async
		
	},
	sendAllToLote: function(options){ //Async
		
	}
	
});

app.ResultsVM = Backbone.Model.extend({
	defaults: {
		showYaEnLote: true,
		totalEnLote: 0,
		
		state: app.EXP_CEA_RSLTS_ST_READY,
		error: false,
		
		count: 95,
		max: 10,
		offset: 0,
		sort: "id",
		order: "asc",
		tab: app.EXP_CEA_SELECTED_TAB_MAT
	},
	getCurrentPage: function(){
		return Math.ceil(offset/max);
	},
	getTotalPages: function(){
		return Math.ceil(count/max);
	},
	getNextPage: function(){
		var nextPage = 0;
		nextPage = this.getCurrentPage() + 1;
		return nextPage;
	},
	getBackPage: function(){
		var backPage = 0;
		backPage = this.getCurrentPage() - 1;
		return backPage;
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
		this.listenTo( this.model, 'change:procesando', this.render );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.css( "background-color" , this.model.getViewSelectionColor() );
		return this;
	},
	
	events: {
		'click .send' : 'enviarALote',
		'click .check' : 'seleccionar'
	},
	
	enviarALote: function(e){
		e.preventDefault();
		
		var view = this;
		
		//se debe ejecutar una llamada al servidor donde
		//se envie el elemento al lote
		//y en caso de que el eleemto se actualiza, cambie su estatus
		if( view.model.get('yaEnLote') == false ){
			view.model.set('procesando',true);
			setTimeout(function(){
				view.model.set({'procesando':false},{silent:true});
				view.model.set('yaEnLote',true);
			}, 1200);
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
		
		this.listenTo( this.model, 'change:state', this.renderStateChange );
		//this.listenTo( this.collection, 'sort', this.renderList );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderList();
		this.renderStateChange();
		
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
	renderStateChange: function(){
		if(this.model.get('state') == app.EXP_CEA_RSLTS_ST_READY){
			this.$('.procMessage').hide();
		}
		else{
			this.$('.procMessage').show();
		}
		if(this.model.get('error') == false){
			this.$('.errorMessage').hide();
		}
		else{
			this.$('.errorMessage').show();
		}
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
		
		this.collection.each( function(item){
			item.set('viewChecked',true);
		},this );
		
	},
	quitarSeleccionTodos: function(e){
		e.preventDefault();
		
		this.collection.each( function(item){
			item.set('viewChecked',false);
		},this );
		
	},
	enviarSeleccionadosLote: function(e){
		e.preventDefault();
		
		var view = this;
		
		//envía una peticion AJAX "con todos los datos"
		//rendera los que hayan sido satisfactorios
		view.model.set('state',app.EXP_CEA_RSLTS_ST_PROC);
		view.collection.each( function(item){
			if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
				item.set({'procesando':true});
			}
		},view );
		
		setTimeout(function(){
			view.collection.each( function(item){
				if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
					item.set({'procesando':false},{silent:true});
					item.set('yaEnLote',true);
				}
				view.model.set('state',app.EXP_CEA_RSLTS_ST_READY);
			},view );
		}, 3000);

	},
	verLote: function(e){
		e.preventDefault();
	}
});