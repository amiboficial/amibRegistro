var app = app || {};

app.EXP_OFA_DST_MATRICULA = 0;
app.EXP_OFA_DST_IDSUSTENTANTE = 1;
app.EXP_OFA_DST_NOMBRES = 2;

app.EXP_OFA_DST_NUMOFICIO = 0;
app.EXP_OFA_DST_CLAVEDGA = 1;
app.EXP_OFA_DST_FCOFICIO = 2;

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
	
		opcionSeleccionada: app.EXP_OFA_DST_NUMOFICIO,
	
		claveDga: "",
		numeroOficio: "",
		fechaOficioAl_day: -1,
		fechaOficioAl_month: -1,
		fechaOficioAl_year: -1,
		fechaOficioDel_day: -1,
		fechaOficioDel_month: -1,
		fechaOficioDel_year: -1,
		
		errorNumeroOficio: false,
		errorClaveDga: false,
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

app.OficioCnbvResultVM = Backbone.Model.extend({
	defaults: { 
		grailsId: -1,
		numeroOficio: -1,
		claveDga: "",
		fechaOficio: ""
	}
});

app.OficioCnbvResultVMCollection = Backbone.Collection.extend({ 
	model: app.OficioCnbvResultVM,
	
	_count: 0,
	_max: 10,
	_offset: 0,
	_sort: "id",
	_order: "",
	
	_query: "",
	_lastAttributes: {},
	
	_fetching: false,
	_error: false,
	
	findAllByNumeroOficioUrl: '',
	findAllByClaveDgaUrl: '',
	findAllByFechaOficioUrl: '',
	findAllByNumeroMatriculaUrl: '',
	findAllByIdSustentanteUrl: '',
	findAllByNombreApellidosUrl: '',
	
	/* OBTIENE EL STATUS SI ES QUE ESTA "TRAYENDO DATOS" */
	_startProcessing: function(){
		this._fetching = true;
		this.trigger('processingStarted');
	},
	_stopProcessing: function(){
		this._fetching = false;
		this.trigger('processingStopped');
	},
	_stopProcessingWithError: function(){
		this._fetching = false;
		this.trigger('processingError');
	},
	isFetching: function(){
		return this._fetching;
	},
	hasError: function(){
		return this._error;
	},
	
	/* CONSULTAS AJAX */
	/*findAllByDatosOficio: function(options){
		alert('NOT YET IMPLEMENTED - findAllByDatosOficio');
	},*/
	
	findAllByNumeroOficio: function(options){
		var _this = this;
	
		this._count = 0;
		this._max = 10;
		this._offset = 0;
		this._sort = "id";
		this._order = "";
	
		this._query = 'findAllByNumeroOficio';
		this._lastAttributes = { numeroOficio: options.numeroOficio }
	
		$.ajax({
			url: _this.findAllByNumeroOficioUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			data: {
				numeroOficio: options.numeroOficio
			},
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
				var listE = data.object.list
				_this.reset( null );
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				_this.trigger('reset', this, {});
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
	},
	findAllByClaveDga: function(options){
		var _this = this;
	
		this._count = 0;
		this._max = 10;
		this._offset = 0;
		this._sort = "id";
		this._order = "";
	
		this._query = 'findAllByClaveDga';
		this._lastAttributes = { claveDga:options.claveDga }
	
		$.ajax({
			url: _this.findAllByClaveDgaUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			data: {
				claveDga: options.claveDga
			},
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
				var listE = data.object.list
				_this.reset( null );
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				_this.trigger('reset', this, {});
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
	},
	findAllByFechaOficio: function(){
		alert('NOT YET IMPLEMENTED - findAllByFechaOficio');
	},
	findAllByNumeroMatricula: function(options){
		alert('NOT YET IMPLEMENTED - findAllByNumeroMatricula');
	},
	findAllByIdSustentante: function(options){
		alert('NOT YET IMPLEMENTED - findAllByIdSustentante');
	},
	findAllByNombreApellidos: function(options){
		alert('NOT YET IMPLEMENTED - findAllByNombreApellidos');
	},
	findAll: function(options){
		alert('NOT YET IMPLEMENTED - findAll');
	},
	sortAndOrderBy: function(order, sort){
		alert('NOT YET IMPLEMENTED - sortAndOrderBy');
	},
	goToPage: function(pagenum){
		alert('NOT YET IMPLEMENTED - goToPage');
	},
	_getResult: function(result){
	
		var elemento = new app.OficioCnbvResultVM();
		var _this = this;
	
		elemento.set('grailsId',result.id);
		elemento.set('numeroOficio',result.numeroOficio);
		elemento.set('claveDga',result.claveDga);
		elemento.set('fechaOficio',result.fechaOficio);
		
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
		this.listenTo( this.model, 'change', this.onChangeModel );
		this.listenTo( this.model, 'change:errorNumeroOficio', this.renderError );
		this.listenTo( this.model, 'change:errorClaveDga', this.renderError );
		this.listenTo( this.model, 'change:errorFechaOficioAl', this.renderError );
		this.listenTo( this.model, 'change:errorFechaOficioDel', this.renderError );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderOpcionSeleccionada();
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
		if( this.model.get('errorClaveDga') == true ){
			this.$('.div-claveDga').addClass('has-error');
		}
		else{
			this.$('.div-claveDga').removeClass('has-error');
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
	renderOpcionSeleccionada: function(){
		console.log('paso por renderOpcionSeleccionada');
		var valOpcion = this.model.get("opcionSeleccionada");
				
		this.$('.opcionSeleccionada[value="' + valOpcion + '"]').prop('checked',true);
		if(valOpcion == app.EXP_OFA_DST_NUMOFICIO){
			this.$('.numeroOficio').prop('disabled',false);
			
			this.$('.claveDga').prop('disabled',true);
			
			this.$('.fechaOficioAl_day').prop('disabled',true);
			this.$('.fechaOficioAl_month').prop('disabled',true);
			this.$('.fechaOficioAl_year').prop('disabled',true);
			this.$('.fechaOficioDel_day').prop('disabled',true);
			this.$('.fechaOficioDel_month').prop('disabled',true);
			this.$('.fechaOficioDel_year').prop('disabled',true);
			
		}
		else if(valOpcion == app.EXP_OFA_DST_CLAVEDGA){
			this.$('.numeroOficio').prop('disabled',true);
			
			this.$('.claveDga').prop('disabled',false);
			
			this.$('.fechaOficioAl_day').prop('disabled',true);
			this.$('.fechaOficioAl_month').prop('disabled',true);
			this.$('.fechaOficioAl_year').prop('disabled',true);
			this.$('.fechaOficioDel_day').prop('disabled',true);
			this.$('.fechaOficioDel_month').prop('disabled',true);
			this.$('.fechaOficioDel_year').prop('disabled',true);
		}
		else if(valOpcion == app.EXP_OFA_DST_FCOFICIO){
			this.$('.numeroOficio').prop('disabled',true);
			
			this.$('.claveDga').prop('disabled',true);
			
			this.$('.fechaOficioAl_day').prop('disabled',false);
			this.$('.fechaOficioAl_month').prop('disabled',false);
			this.$('.fechaOficioAl_year').prop('disabled',false);
			this.$('.fechaOficioDel_day').prop('disabled',false);
			this.$('.fechaOficioDel_month').prop('disabled',false);
			this.$('.fechaOficioDel_year').prop('disabled',false);
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
	onChangeModel: function(item){
		if(item.changed.hasOwnProperty('opcionSeleccionada')){
			this.renderOpcionSeleccionada();
		}
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
		
		if(fieldName == 'opcionSeleccionada'){
			this.model.set(fieldName,fieldValue);
			this._clearModel();
			this._clearError();
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		
		console.log("Se actualizo modelo en el atributo: " + fieldName + ":" + fieldValue);
	},
	
	limpiar: function(e){
		e.preventDefault();
		this._clearModel();
		this._clearError();
	},
	findByDatosOficio: function(e){
		e.preventDefault();
		
		if(this._validate()){
		
			var valOpcion = this.model.get("opcionSeleccionada");
		
			if(valOpcion == app.EXP_OFA_DST_NUMOFICIO){
				this.collection.findAllByNumeroOficio( { numeroOficio : this.model.get("numeroOficio") } );
			}
			else if(valOpcion == app.EXP_OFA_DST_CLAVEDGA){
				this.collection.findAllByClaveDga( { claveDga : this.model.get("claveDga") } );
			}
			else if(valOpcion == app.EXP_OFA_DST_FCOFICIO){
				this.collection.findAllByFechaOficio();
			}
		
		}
	},
	
	_clearModel: function(){
		this.model.set('claveDga','');
		this.model.set('numeroOficio','');
		this.model.set('fechaOficioAl_day',-1);
		this.model.set('fechaOficioAl_month',-1);
		this.model.set('fechaOficioAl_year',-1);
		this.model.set('fechaOficioDel_day',-1);
		this.model.set('fechaOficioDel_month',-1);
		this.model.set('fechaOficioDel_year',-1);
	},
	_clearError: function(){
		this.model.set('errorNumeroOficio',false);
		this.model.set('errorClaveDga',false);
		this.model.set('errorFechaOficioAl',false);
		this.model.set('errorFechaOficioDel',false);
	},
	_validate: function(){
		var numericRegEx = /^[0-9]{1,10}$/;
		var valOpcion = this.model.get("opcionSeleccionada");
		var valid = true;
		
		this._clearError();
		
		var claveDgaVacio = (this.model.get('claveDga') == '')
		var numeroOficioVacio = (this.model.get('numeroOficio') == '')
		var fechaDelVacia = (this.model.get('fechaOficioDel_day') == -1 && this.model.get('fechaOficioDel_month') == -1 && this.model.get('fechaOficioDel_year') == -1);
		var fechaAlVacia = (this.model.get('fechaOficioAl_day') == -1 && this.model.get('fechaOficioAl_month') == -1 && this.model.get('fechaOficioAl_year') == -1);
		var fechaDelOk = (this.model.get('fechaOficioDel_day') != -1 && this.model.get('fechaOficioDel_month') != -1 && this.model.get('fechaOficioDel_year') != -1);
		var fechaAlOk = (this.model.get('fechaOficioAl_day') != -1 && this.model.get('fechaOficioAl_month') != -1 && this.model.get('fechaOficioAl_year') != -1);
		var todoVacio = (claveDgaVacio && numeroOficioVacio && fechaDelVacia && fechaAlVacia)
		
		if(valOpcion == app.EXP_OFA_DST_NUMOFICIO){
			if( numericRegEx.test( this.model.get('numeroOficio') ) != true ){
				this.model.set('errorNumeroOficio',true);
				valid = false;
			}
		}
		else if(valOpcion == app.EXP_OFA_DST_CLAVEDGA){
			if( claveDgaVacio ){
				this.model.set('errorClaveDga',true);
				valid = false;
			}
		}
		else if(valOpcion == app.EXP_OFA_DST_FCOFICIO){
			//valida que al menos uno de los 3 este completado
			if(fechaAlVacia || !fechaAlOk){
				this.model.set('errorFechaOficioAl',true);
				valid = false;
			}
			
			if(fechaDelVacia || !fechaDelOk){
				this.model.set('errorFechaOficioDel',true);
				valid = false;
			}
		}
		
		return valid;
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
		
		this.listenTo( this.model, 'change:errorNumeroMatricula', this.renderError );
		this.listenTo( this.model, 'change:errorIdSustentante', this.renderError );
		this.listenTo( this.model, 'change:errorNombres', this.renderError );
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
			this._clearModel();
			this._clearError();
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
	},
	limpiar: function(e){
		e.preventDefault();
		
		this._clearModel();
		this._clearError();
	},
	findByDatosSust: function(e){
		e.preventDefault();
		
		if(this._validate()){
			var valOpcion = this.model.get("opcionSeleccionada");
			if(valOpcion == app.EXP_OFA_DST_MATRICULA){
				this.collection.findAllByNumeroMatricula();
			}
			else if(valOpcion == app.EXP_OFA_DST_IDSUSTENTANTE){
				this.collection.findAllByIdSustentante();
			}
			else if(valOpcion == app.EXP_OFA_DST_NOMBRES){
				this.collection.findAllByNombreApellidos();
			}
		}
		
	},
	
	_clearModel: function(){
		this.model.set('numeroMatricula',"");
		this.model.set('idSustentante',"");
		this.model.set('nombre',"");
		this.model.set('primerApellido',"");
		this.model.set('segundoApellido',"");
	},
	
	_clearError: function(){
		this.model.set('errorNumeroMatricula',false);
		this.model.set('errorIdSustentante',false);
		this.model.set('errorNombres',false);
	},
	
	_validate: function(){
		var numericRegEx = /^[0-9]{1,10}$/;
		
		var valOpcion = this.model.get("opcionSeleccionada");
		var valid = true;
		
		this._clearError();
		
		if(valOpcion == app.EXP_OFA_DST_MATRICULA){
			if( numericRegEx.test( this.model.get('numeroMatricula') ) != true ){
				this.model.set('errorNumeroMatricula',true);
				valid = false;
			}
		}
		else if(valOpcion == app.EXP_OFA_DST_IDSUSTENTANTE){
			if( numericRegEx.test( this.model.get('idSustentante') ) != true ){
				this.model.set('errorIdSustentante',true);
				valid = false;
			}
		}
		else if(valOpcion == app.EXP_OFA_DST_NOMBRES){
			//valida que al menos uno de los 3 este completado
			if( this.model.get('nombre') == '' && 
				this.model.get('primerApellido') == '' && 
				this.model.get('segundoApellido') == ''){
				
				this.model.set('errorNombres',true);
				valid = false;
			}
		}
		
		return valid;
	}
	
});

app.OficioCnbvResultView = Backbone.View.extend({
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#oficioCnbvResultTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		this.render();
	},
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	events: {
		'click .show' : 'show'
	},
	show: function(e){
		e.preventDefault();
		alert("not implemented yet - show");
	}
});

app.OficioCnbvResultsView = Backbone.View.extend({
	parentView: {},
	tagname: 'div',
	template: _.template( $('#oficioCnbvResultsTemplate').html() ),
	
	initialize: function(options){
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.listenTo( this.collection, 'reset', this.renderList );
		
		this.listenTo( this.collection, 'processingStarted', this.renderStateChange );
		this.listenTo( this.collection, 'processingError', this.renderStateChange );
		this.listenTo( this.collection, 'processingStopped', this.renderStateChange );
	},
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		this.renderStateChange();
		return this;
	},
	renderList: function(){
		console.log("paso el renderList");
		this.$(".list-items").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		this.renderPagination();
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.OficioCnbvResultView({model:item,parentView:view});
		elementView.viewModel = this.viewModel;
		this.$(".list-items").append( elementView.render().el );
		return this;
	},
	renderStateChange: function(){
		if(this.collection.isFetching() == false){
			this.$('.procMessage').hide();
			this.enableInput();
		}
		else{
			this.$('.procMessage').show();
			this.disableInput();
		}
		if(this.collection.hasError() == false){
			this.$('.errorMessage').hide();
		}
		else{
			this.$('.errorMessage').show();
		}
	},
	renderPagination: function(){
		var paginationStr = "";
		var totalPages = this.collection.getTotalPages();
		var currentPage = this.collection.getCurrentPage();
		
		if(currentPage == 1){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&lt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage-1) + '"><a href="javascript:void(0);">&lt;</a></li>'
		}
		
		for(var i=1; i<=totalPages; i++){
			if(i == currentPage){
				paginationStr += '<li class="active"><a href="javascript:void(0);">' + i + '</a></li>';
			}
			else{
				paginationStr += '<li class="page handCursor" data-page="' + i + '"><a href="javascript:void(0);">' + i + '</a></li>';
			}
		}
		
		if(currentPage == totalPages || totalPages == 0){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&gt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage+1) + '"><a href="javascript:void(0);">&gt;</a></li>'
		}
		
		
		this.$(".pagination").html("");
		this.$(".pagination").html(paginationStr);
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
		this.$("select").prop('disabled',false);
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
		this.$("select").prop('disabled',true);
	},
	
	events: {
		'click .sort': 'mandarOrdenar',
		'click .page': 'mandarAPagina'
	},
	
	mandarOrdenar: function(e){
		var order = this.$(e.currentTarget).data("order");
		var sort = this.$(e.currentTarget).data("sort");
		
		e.preventDefault();
		//si no se esta procesando nada en la colección
		if(!this.collection.isFetching()){
			this.collection.sortAndOrderBy(order,sort);
		}
	},
	mandarAPagina: function(e){
		var pagina = this.$(e.currentTarget).data("page");

		e.preventDefault();
		//si no se esta procesando nada en la colección
		if(!this.collection.isFetching()){
			this.collection.goToPage(pagina);
		}
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
		this.renderResultView();
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
	},
	renderResultView: function(){
		var parentView = this;
		var collection = this.options.resultVMCollection;
		
		var view = new app.OficioCnbvResultsView({ collection:collection, parentView:parentView });

		this.$(".div-resultados").html("");
		this.$(".div-resultados").append( view.render().el );
		
		return view;
	}
});

