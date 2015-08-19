var app = app || {};

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
		numeroOficio: "",
		fechaOficio_day: -1,
		fechaOficio_month: -1,
		fechaOficio_year: -1,
		claveDgaUniqueValidated: false,
		numeroOficioUniqueValidated: false,
		
		errorClaveDga: false,
		errorNumeroOficio: false,
		errorFechaOficio: false,
		
		errorClaveDgaUniqueNonValidated: false,
		errorNumeroOficioUniqueNonValidated: false,
		errorClaveDgaUnique: false,
		errorNumeroOficioUnique: false,
		
		checkUniqueClaveDgaUrl: '',
		checkUniqueNumeroOficioUrl: '',
		
		processing: false,
		validated: false
	},
	checkUniqueClaveDga: function(){
		var _this = this;
		
		$.ajax({
			url: _this.get('checkUniqueClaveDgaUrl') + '/' + _this.get('claveDga'),
			beforeSend: function( xhr ){
				_this.set('processing',true);
				_this.set('errorClaveDgaUnique',false);
				_this.set('claveDgaUniqueValidated',false);
				_this.set('errorClaveDga',false);
				_this.set('errorClaveDgaUniqueNonValidated',false);
			},
			type: 'GET'
		}).done( function( data ) {
			_this.set('processing',false);
			if(data.status == "OK"){
				if(data.object == true){
					_this.set('errorClaveDgaUnique',false);
					_this.set('errorClaveDga',false);
					_this.set('claveDgaUniqueValidated',true);
				}
				else{
					_this.set('errorClaveDgaUnique',true);
					_this.set('errorClaveDga',true);
					_this.set('claveDgaUniqueValidated',false);
				}
			}
			else{
				_this.set('errorClaveDgaUnique',true);
				_this.set('errorClaveDga',true);
				_this.set('claveDgaUniqueValidated',false);
			}
		});
	},
	checkUniqueNumeroOficio: function(){
		var _this = this;
		
		$.ajax({
			url: _this.get('checkUniqueNumeroOficioUrl') + '/' + _this.get('numeroOficio'),
			beforeSend: function( xhr ){
				_this.set('processing',true);
				_this.set('errorNumeroOficioUnique',false);
				_this.set('numeroOficioUniqueValidated',false);
				_this.set('errorNumeroOficio',false);
				_this.set('errorNumeroOficioUniqueNonValidated',false);
			},
			type: 'GET'
		}).done( function( data ) {
			_this.set('processing',false);
			if(data.status == "OK"){
				if(data.object == true){
					_this.set('errorNumeroOficioUnique',false);
					_this.set('errorNumeroOficio',false);
					_this.set('numeroOficioUniqueValidated',true);
				}
				else{
					_this.set('errorNumeroOficioUnique',true);
					_this.set('errorNumeroOficio',true);
					_this.set('numeroOficioUniqueValidated',false);
				}
			}
			else{
				_this.set('errorNumeroOficioUnique',true);
				_this.set('errorNumeroOficio',true);
				_this.set('numeroOficioUniqueValidated',false);
			}
		});
	}
});

app.DatosOficioTabView =  Backbone.View.extend({
	
	el: '#divOficioCnbv',
	template: _.template( $('#oficioCnbvFormDatosOficioTemplate').html() ),
	templateNumeroOficioUniqueValidated: _.template( $('#_NumeroOficioUniqueValidated').html() ),
	templateNumeroOficioUniqueNonValidated: _.template( $('#_NumeroOficioUniqueNonValidated').html() ),
	templateClaveDgaUniqueValidated: _.template( $('#_ClaveDgaUniqueValidated').html() ),
	templateClaveDgaUniqueNonValidated: _.template( $('#_ClaveDgaUniqueNonValidated').html() ),
	
	model: new Backbone.Model(),
	
	initialize: function(options){
		this.model = options.model;
		this.render();
		
		this.listenTo( this.model, 'change:numeroOficio', this.numeroOficioChanged );
		this.listenTo( this.model, 'change:claveDga', this.claveDgaChanged );
		
		this.listenTo( this.model, 'change:numeroOficioUniqueValidated', this.renderUniqueValidated );
		this.listenTo( this.model, 'change:claveDgaUniqueValidated', this.renderUniqueValidated );
		
		this.listenTo( this.model, 'change:errorClaveDga', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroOficio', this.renderError );
		this.listenTo( this.model, 'change:errorFechaOficio', this.renderError );
		this.listenTo( this.model, 'change:errorClaveDgaUnique', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroOficioUnique', this.renderError );
		this.listenTo( this.model, 'change:errorClaveDgaUniqueNonValidated', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroOficioUniqueNonValidated', this.renderError );
		
		this.listenTo( this.model, 'change:validated', this.renderValidated );
		this.listenTo( this.model, 'change:validated', this.notifyValidated );
		
		this.listenTo( this.model, 'change:processing', this.renderProcessing );
	},
	
	//CHECKLIST ID ATTRIBUTES
	//métodos y atributo para implementar complemento 
	//en un checklist
	checkId: -1,
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	//MÉTODOS DE RENDEREO
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderUniqueValidated();
		this.renderError();
		this.renderProcessing();
		this.renderValidated();
		return this;
	},
	renderUniqueValidated: function(){
		if(this.model.get('numeroOficioUniqueValidated')){
			this.$('.div-wrapper-numeroOficio').html( this.templateNumeroOficioUniqueValidated( this.model.toJSON() ) );
		}
		else{
			this.$('.div-wrapper-numeroOficio').html( this.templateNumeroOficioUniqueNonValidated( this.model.toJSON() ) );
		}
		
		if(this.model.get('claveDgaUniqueValidated')){
			this.$('.div-wrapper-claveDga').html( this.templateClaveDgaUniqueValidated( this.model.toJSON() ) );
		}
		else{
			this.$('.div-wrapper-claveDga').html( this.templateClaveDgaUniqueNonValidated( this.model.toJSON() ) );
		}
	},
	renderValidated: function(){
		if(this.model.get('validated') == true){
			this.disableInput();
			this.disableSubmitEnableEdit();
		}
		else{
			this.enableInput();
			this.enableSubmitDisableEdit();
		}
	},
	renderError: function(){
		if(this.model.get('errorClaveDga')){
			this.$('.div-claveDga').addClass('has-error');
		}
		else{
			this.$('.div-claveDga').removeClass('has-error');
		}
		if(this.model.get('errorNumeroOficio')){
			this.$('.div-numeroOficio').addClass('has-error');
		}
		else{
			this.$('.div-numeroOficio').removeClass('has-error');
		}
		if(this.model.get('errorFechaOficio')){
			this.$('.div-fechaOficio').addClass('has-error');
		}
		else{
			this.$('.div-fechaOficio').removeClass('has-error');
		}
		if(this.model.get('errorClaveDgaUnique')){
			this.$('.alert-errorClaveDgaUnique').show();
		}
		else{
			this.$('.alert-errorClaveDgaUnique').hide();
		}
		if(this.model.get('errorNumeroOficioUnique')){
			this.$('.alert-errorNumeroOficioUnique').show();
		}
		else{
			this.$('.alert-errorNumeroOficioUnique').hide();
		}
		if(this.model.get('errorClaveDgaUniqueNonValidated')){
			this.$('.alert-errorClaveDgaUniqueNonValidated').show();
		}
		else{
			this.$('.alert-errorClaveDgaUniqueNonValidated').hide();
		}
		if(this.model.get('errorNumeroOficioUniqueNonValidated')){
			this.$('.alert-errorNumeroOficioUniqueNonValidated').show();
		}
		else{
			this.$('.alert-errorNumeroOficioUniqueNonValidated').hide();
		}
	},
	renderProcessing: function(){
		if(this.model.get('processing')){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.enableInput();
		}
		//this.renderValidated();
	},
	disableInput: function(){
		this.$(".numeroOficio").prop('disabled',true);
		this.$(".claveDga").prop('disabled',true);
		this.$(".fechaOficio_day").prop('disabled',true);
		this.$(".fechaOficio_month").prop('disabled',true);
		this.$(".fechaOficio_year").prop('disabled',true);
		this.$(".verifyClaveDga").prop('disabled',true);
		this.$(".verifyNumeroOficio").prop('disabled',true);
	},
	enableInput: function(){
		this.$(".numeroOficio").prop('disabled',false);
		this.$(".claveDga").prop('disabled',false);
		this.$(".fechaOficio_day").prop('disabled',false);
		this.$(".fechaOficio_month").prop('disabled',false);
		this.$(".fechaOficio_year").prop('disabled',false);
		this.$(".verifyClaveDga").prop('disabled',false);
		this.$(".verifyNumeroOficio").prop('disabled',false);
	},
	enableSubmitDisableEdit: function(){
		this.$(".edit").prop('disabled',true);
		this.$(".submit").prop('disabled',false);
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop('disabled',true);
		this.$(".edit").prop('disabled',false);
	},
	
	
	//listenTo events
	numeroOficioChanged: function(){
		this.model.set('numeroOficioUniqueValidated',false);
	},
	claveDgaChanged: function(){
		this.model.set('claveDgaUniqueValidated',false);
	},
	notifyValidated: function(){
		if(this.model.get('validated') == true){
			this.trigger("stateChange","VALIDATED",this.checkId);
		}
		else{
			this.trigger("stateChange","READY",this.checkId);
		}
	},
	
	events: {
		'click .verifyClaveDga':'verifyClaveDga',
		'click .verifyNumeroOficio':'verifyNumeroOficio',
		'click .submit':'submit',
		'click .edit':'edit',
		'change .field':'updateModel'
	},
	updateModel: function(e){
		e.preventDefault();
		
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = this.$(e.currentTarget).val().trim();
		
		if(fieldName == 'claveDga' ||fieldName == 'numeroOficio'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
	},
	
	verifyClaveDga: function(e){
		e.preventDefault();
		this.model.checkUniqueClaveDga();
	},
	verifyNumeroOficio: function(e){
		var num10CarExp = /^[0-9]{1,10}$/;
	
		e.preventDefault();
		
		this.model.set('errorNumeroOficio',false);
		if( !num10CarExp.test( this.model.get('numeroOficio') ) ){
			this.model.set('errorNumeroOficio',true);
		}
		else{
			this.model.checkUniqueNumeroOficio();
		}
		
	},
	
	submit: function(e){
		e.preventDefault();
		if(this._validate()){
			this.model.set('validated',true);
			this.trigger("stateChange","VALIDATED",this.checkId);
		}
	},
	edit: function(e){
		e.preventDefault();
		this.model.set('validated',false);
		this.trigger("stateChange","READY",this.checkId);
	},
	
	_validate: function(){
		var num10CarExp = /^[0-9]{1,10}$/;
		var valid = true;
		var validFecha = (this.model.get('fechaOficio_day') != -1 && this.model.get('fechaOficio_month') != -1 && this.model.get('fechaOficio_year') != -1)
		
		this.model.set('errorClaveDga',false);
		this.model.set('errorNumeroOficio',false);
		this.model.set('errorFechaOficio',false);
		this.model.set('errorClaveDgaUnique',false);
		this.model.set('errorNumeroOficioUnique',false);
		this.model.set('errorClaveDgaUniqueNonValidated',false);
		this.model.set('errorNumeroOficioUniqueNonValidated',false);
		
		if( this.model.get('numeroOficio') == '' ){
			this.model.set('errorNumeroOficio',true);
			valid = false;
		}
		else if( !num10CarExp.test( this.model.get('numeroOficio') ) ){
			this.model.set('errorNumeroOficio',true);
			valid = false;
		}
		
		if( this.model.get('claveDga') == '' ){
			this.model.set('errorClaveDga',true);
			valid = false;
		}
		
		if(!validFecha){
			this.model.set('errorFechaOficio',true);
			valid = false;
		}
		
		if(!this.model.get('numeroOficioUniqueValidated')){
			this.model.set('errorNumeroOficio',true);
			this.model.set('errorNumeroOficioUniqueNonValidated',true);
			valid = false;
		}
		
		if(!this.model.get('claveDgaUniqueValidated')){
			this.model.set('errorClaveDga',true);
			this.model.set('errorClaveDgaUniqueNonValidated',true);
			valid = false;
		}
		
		return valid;
	}
	
});