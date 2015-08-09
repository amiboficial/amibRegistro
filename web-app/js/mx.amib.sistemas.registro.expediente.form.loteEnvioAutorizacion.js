var app = app || {};

app.LoteElementVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		idSustentante: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		
		checked: false,
		showing: true
	}
});

app.LoteElementCollectionVM = Backbone.Collection.extend({
	model: app.LoteElementCollectionVM,
	count: 0,
	max: 10,
	offset: 0,
	sort: "id",
	order: "asc",
	
	/* ESTADOS DE PROCESAMIENTO */
	_processing: false,
	_startProcessing: function(){
		this._processing = true;
		this.trigger('processingStarted');
	},
	_stopProcessing: function(){
		this._processing = false;
		this.trigger('processingStopped');
	},
	_stopProcessingWithError: function(){
		this._processing = false;
		this.trigger('processingError');
	},
	isProcessing: function(){
		return this._processing;
	},
	
	/* PAGINADO */
	getCurrentPage: function(){
		return Math.floor(this.offset/this.max) + 1;
	},
	getTotalPages: function(){
		console.log("COUNT: " + this.count + ";MAX: " + this.max);
		return Math.ceil(this.count/this.max);
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
	},
	
	/* OBTENICION DE DATOS AJAX */
	fetchAll: function(){
		
	},
	
	/* ORDENAMIENTO Y SETEO DE VISIBILIDAD DE DATOS */
	setViewableElements: function(options){
		
	},
	sortAndOrderBy: function(order,sort){
		
	},
	goToPage: function(pagenum){
	
	},
	
	/* MÉTODOS "PRIVADOS" CON LOS QUE SE "COPIA" LA INFORMACIÓN DEL JSON RECIBIDO */
	
	_getResult: function(){
	
	}
});

