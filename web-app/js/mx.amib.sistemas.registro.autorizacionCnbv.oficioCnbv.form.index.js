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
		
		//binding del modelo a la vista
		this.listenTo( this.model, 'change', this.change );
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
	change: function(item){
		if(item.changed.hasOwnProperty('claveDga')){
			this.$('.claveDga').val( this.model.get("claveDga") );
		}
		else if(item.changed.hasOwnProperty('numeroOficio')){
			this.$('.numeroOficio').val( this.model.get("numeroOficio") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioAl_day')){
			this.$('.fechaOficioAl_day').val( this.model.get("fechaOficioAl_day") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioAl_month')){
			this.$('.fechaOficioAl_month').val( this.model.get("fechaOficioAl_month") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioAl_year')){
			this.$('.fechaOficioAl_year').val( this.model.get("fechaOficioAl_year") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioDel_day')){
			this.$('.fechaOficioDel_day').val( this.model.get("fechaOficioDel_day") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioDel_month')){
			this.$('.fechaOficioDel_month').val( this.model.get("fechaOficioDel_month") );
		}
		else if(item.changed.hasOwnProperty('fechaOficioDel_year')){
			this.$('.fechaOficioDel_year').val( this.model.get("fechaOficioDel_year") );
		}
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
		this.model.set('claveDga','');
		this.model.set('numeroOficio','');
		this.model.set('fechaOficioAl_day',-1);
		this.model.set('fechaOficioAl_month',-1);
		this.model.set('fechaOficioAl_year',-1);
		this.model.set('fechaOficioDel_day',-1);
		this.model.set('fechaOficioDel_month',-1);
		this.model.set('fechaOficioDel_year',-1);
	},
	findByDatosOficio: function(e){
		e.preventDefault();
		alert('NOT YET IMPLEMENTED');
	}
	
});

app.DatosSustTabView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#oficioCnbvIndexDatosSustTemplate').html() ),
	model: new Backbone.Model(),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.render();
		
		//binding del modelo a la vista
		this.listenTo( this.model, 'change', this.onChangeModel );
	},
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderOpcionSeleccionada();
		this.renderError();
		return this;
	},
	renderError: function(){
	
		if( this.model.get('errorNumeroMatricula') == true ){
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
		if( this.model.get('errorIdSustentante') == true ){
			this.$('.div-idSustentante').addClass('has-error');
		}
		else{
			this.$('.div-idSustentante').removeClass('has-error');
		}
		if( this.model.get('errorNombres') == true ){
			this.$('.div-primerApellido').addClass('has-error');
			this.$('.div-segundoApellido').addClass('has-error');
			this.$('.div-nombre').addClass('has-error');
		}
		else{
			this.$('.div-primerApellido').removeClass('has-error');
			this.$('.div-segundoApellido').removeClass('has-error');
			this.$('.div-nombre').removeClass('has-error');
		}
		
	},
	renderOpcionSeleccionada: function(){
		console.log('paso por renderOpcionSeleccionada');
		var valOpcion = this.model.get("opcionSeleccionada");
		this.$('.opcionSeleccionada[value="' + valOpcion + '"]').prop('checked',true);
		if(valOpcion == app.EXP_OFA_DST_MATRICULA){
			this.$('.numeroMatricula').prop('disabled',false);
			this.$('.idSustentante').prop('disabled',true);
			this.$('.nombre').prop('disabled',true);
			this.$('.primerApellido').prop('disabled',true);
			this.$('.segundoApellido').prop('disabled',true);
		}
		else if(valOpcion == app.EXP_OFA_DST_IDSUSTENTANTE){
			this.$('.numeroMatricula').prop('disabled',true);
			this.$('.idSustentante').prop('disabled',false);
			this.$('.nombre').prop('disabled',true);
			this.$('.primerApellido').prop('disabled',true);
			this.$('.segundoApellido').prop('disabled',true);
		}
		else if(valOpcion == app.EXP_OFA_DST_NOMBRES){
			this.$('.numeroMatricula').prop('disabled',true);
			this.$('.idSustentante').prop('disabled',true);
			this.$('.nombre').prop('disabled',false);
			this.$('.primerApellido').prop('disabled',false);
			this.$('.segundoApellido').prop('disabled',false);
		}
	},
	enableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
		this.$("select").prop('disabled',true);
		this.renderOpcionSeleccionada();
	},
	disableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
		this.$("select").prop('disabled',false);
		this.renderOpcionSeleccionada();
	},
	onChangeModel: function(item){
		if(item.changed.hasOwnProperty('opcionSeleccionada')){
			this.renderOpcionSeleccionada();
		}
		if(item.changed.hasOwnProperty('numeroMatricula')){
			this.$('.numeroMatricula').val( this.model.get("numeroMatricula") );
		}
		else if(item.changed.hasOwnProperty('idSustentante')){
			this.$('.idSustentante').val( this.model.get("idSustentante") );
		}
		else if(item.changed.hasOwnProperty('nombre')){
			this.$('.nombre').val( this.model.get("nombre") );
		}
		else if(item.changed.hasOwnProperty('primerApellido')){
			this.$('.primerApellido').val( this.model.get("primerApellido") );
		}
		else if(item.changed.hasOwnProperty('segundoApellido')){
			this.$('.segundoApellido').val( this.model.get("segundoApellido") );
		}
	},
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByDatosSust',
		'change .field' : 'updateModel'
	},
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		if(fieldName == 'opcionSeleccionada'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		
		
		console.log("Se actualizo modelo en el atributo: " + fieldName + ":" + fieldValue);
	},
	limpiar: function(e){
		e.preventDefault();
		
		//this.model.set('opcionSeleccionada',app.EXP_OFA_DST_MATRICULA);
		this.model.set('numeroMatricula',"");
		this.model.set('idSustentante',"");
		this.model.set('nombre',"");
		this.model.set('primerApellido',"");
		this.model.set('segundoApellido',"");
		
		this.model.set('errorNumeroMatricula',false);
		this.model.set('errorIdSustentante',false);
		this.model.set('errorNombres',false);
		
	},
	findByDatosSust: function(e){
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
		this.renderDatosSustTabView();
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
	},
	renderDatosSustTabView: function(){
		var parentView = this;
		var model = new app.DatosSustTabVM();
		var collection = this.options.resultVMCollection;
		
		this.$(".tab-pane-sustentante").html("");
		var view = new app.DatosSustTabView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-sustentante").append( view.render().el );
		
		return view;
	}
});