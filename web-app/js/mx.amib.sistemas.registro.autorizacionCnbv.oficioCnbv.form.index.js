var app = app || {};

app.EXP_OFA_DST_MATRICULA = 0;
app.EXP_OFA_DST_IDSUSTENTANTE = 1;
app.EXP_OFA_DST_NOMBRES = 2;

app.MESES = [
	{ id: 1, nombre: "enero" },
	{ id: 2, nombre: "febrero" },
	{ id: 3, nombre: "marzo" },
	{ id: 4, nombre: "abril" },
	{ id: 5, nombre: "mayo" },
	{ id: 6, nombre: "junio" },
	{ id: 7, nombre: "julio" },
	{ id: 8, nombre: "agosto" },
	{ id: 9, nombre: "septiembre" },
	{ id: 10, nombre: "octubre" },
	{ id: 11, nombre: "noviembre" },
	{ id: 12, nombre: "diciembre" }
]

app.DatosOficioTabVM = Backbone.Model.extend({
	defaults: {
		claveDga: "",
		numeroOficio: -1,
		fechaOficioAl_day: -1,
		fechaOficioAl_month: -1,
		fechaOficioAl_year: -1,
		fechaOficioDel_day: -1,
		fechaOficioDel_month: -1,
		fechaOficioDel_year: -1,
		
		errorNumeroOficio: false,
		errorFechaOficioAl: false,
		errorFechaOficioDel: false,
		
		processing: false
	}
});

app.DatosSustTabVM = Backbone.Model.extend({
	defaults: {
		
		opcionSeleccionada: app.EXP_OFA_DST_MATRICULA,
		
		numeroMatricula: -1,
		
		idSustentante: -1,
		
		nombre: "",
		primerApellido: "",
		segundoApellido: "",

		errorNumeroMatricula: false,
		errorIdSustentante: false,
		errorNombres: false,
		
		processing: false
	}
});

app.ResultVM = Backbone.Model.extend({
	defaults: { 
		grailsId: -1,
		numeroOficio: -1,
		claveDga: "",
		fechaOficio: ""
	}
});

app.ResultVMCollection = Backbone.Collection.extend({ 
	model: app.ResultVM,
	
	_count: 0,
	_max: 10,
	_offset: 0,
	_sort: "id",
	_order: "",
	
	_query: "",
	_lastAttributes: {},
	
	_fetching: false,
	
	/* CONSULTAS AJAX */
	findAllByDatosOficio: function(options){
		
	},
	findAllByNumeroMatricula: function(options){
		
	},
	findAllByIdSustentante: function(options){
		
	},
	findAllByNombreApellidos: function(options){
		
	},
	findAll: function(options){
	
	},
	sortAndOrderBy: function(order, sort){
	
	},
	goToPage: function(pagenum){
	
	},
	_getResult: function(result){
		return elemento;
	},
	
	/* METODOS PARA VISTA DE PAGINACION */
	getCurrentPage: function(){
		return Math.floor(this._offset/this._max) + 1;
	},
	getTotalPages: function(){
		return Math.ceil(this._count/this._max);
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

app.DatosOficioTabView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#oficioCnbvIndexDatosOficioTemplate').html() ),
	model: new Backbone.Model(),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.render();
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		//renderea error en caso que el numero de oficio este mal
		if( this.model.get('errorNumeroOficio') == true ){
			this.$('.div-numeroOficio').addClass('has-error');
		}
		else{
			this.$('.div-numeroOficio').removeClass('has-error');
		}
		//renderea error en caso que la fecha de inicio (al) este mal
		if( this.model.get('errorFechaOficioAl') == true ){
			this.$('.div-fechaOficioAl').addClass('has-error');
		}
		else{
			this.$('.div-fechaOficioAl').removeClass('has-error');
		}
		//renderea error en caso que la fecha de inicio (del) este mal
		if( this.model.get('errorFechaOficioDel') == true ){
			this.$('.div-fechaOficioDel').addClass('has-error');
		}
		else{
			this.$('.div-fechaOficioDel').removeClass('has-error');
		}
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
	},
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByDatosOficio',
		'change .field' : 'updateModel'
	},
	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
		
		console.log("Se actualizo modelo en el atributo: " + fieldName + ":" + fieldValue);
	},
	
	limpiar: function(e){
		e.preventDefault();
		alert('NOT YET IMPLEMENTED');
	},
	findByDatosOficio: function(e){
		e.preventDefault();
		alert('NOT YET IMPLEMENTED');
	}
	
});

app.OficioCnbvIndexView = Backbone.View.extend({
	el: '#divOficioCnbvIndexView',
	template: _.template( $('#oficioCnbvIndexTemplate').html() ),
	options: {},
	
	initialize: function(options){
		this.options = options;
		this.render();
	},
	
	//MÉTODOS DE RENDEREO
	render: function(){
		this.$el.html( this.template() );
		this.renderDatosOficioTabView();
		return this;
	},
	renderDatosOficioTabView: function(){
		var parentView = this;
		var model = new app.DatosOficioTabVM();
		var collection = this.options.resultVMCollection;
		
		this.$(".tab-pane-oficio").html("");
		var view = new app.DatosOficioTabView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-oficio").append( view.render().el );
		
		return view;
	}
});