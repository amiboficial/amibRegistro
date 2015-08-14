var app = app || {};

app.EXP_OFA_DST_MATRICULA = 0;
app.EXP_OFA_DST_IDSUSTENTANTE = 1;
app.EXP_OFA_DST_NOMBRES = 2;

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