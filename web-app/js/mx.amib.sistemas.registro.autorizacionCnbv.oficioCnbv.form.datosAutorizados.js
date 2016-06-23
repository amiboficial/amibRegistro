var app = app || {};

app.DatosAutorizadosTabVM = Backbone.Model.extend({
	defaults: {
		idCertificacion: '',
		idSustentante: -1,
		numeroMatricula: '',
		nombreCompleto: '',
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
		errorNumeroMatriculaInList: false,
		errorNumeroMatriculaAtLeastOne: false,
		
		processing: false,

		findAutorizableByNumeroMatriculaUrl: ''
		, institucion: ''
	},
	findAutorizableByNumeroMatricula: function(){
		var _this = this;
	
		$.ajax({
			url: _this.get('findAutorizableByNumeroMatriculaUrl') + '/' + _this.get('numeroMatricula'),
			beforeSend: function( xhr ){
				_this.set('processing',true);
				_this.set('errorNumeroMatricula',false);
				_this.set('errorNumeroMatriculaNotFound',false);
				_this.set('errorNumeroMatriculaInvalidDataType',false);
				_this.set('errorNumeroMatriculaInList',false);
				_this.set('errorNumeroMatriculaAtLeastOne',false);
				_this.set('numeroMatriculaFoundValidated',false);
			},
			type: 'GET'
		}).done( function( data ) {
			_this.set('processing',false);
			if(data.status == "OK"){
				_this.set(data.object);
				_this.set('errorNumeroMatriculaNotFound',false);
				_this.set('numeroMatriculaFoundValidated',true);
			}
			else{
				_this.set('errorNumeroMatriculaNotFound',true);
				_this.set('numeroMatriculaFoundValidated',false);
			}
		});
	
		//alert('findAutorizableByNumeroMatricula - NOT YET IMPLEMENTED');
	},
	//_getResult: function(result){
		//todo: hacer eso
	//}
});

app.AutorizadoResultView = Backbone.View.extend({
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#oficioCnbvFormAutorizadosElementTemplate').html() ),
	model: new Backbone.Model(),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .remove': 'borrar'
	},
	
	borrar: function(e){
		e.preventDefault();
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	}
});

app.AutorizadoResultsView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#oficioCnbvFormAutorizadosListTemplate').html() ),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.listenTo( this.collection, 'reset', this.renderList );
		this.listenTo( this.collection, 'sort', this.renderList );
		this.listenTo( this.collection, 'add', this.renderList );
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
	},
	
	events: {
		'click .sort': 'mandarOrdenar'
	},
	
	mandarOrdenar: function(e){
		var order = this.$(e.currentTarget).data("order");
		var sort = this.$(e.currentTarget).data("sort");
		
		e.preventDefault();
			this.collection.sortAndOrderBy(order,sort);
	}
});

app.DatosAutorizadosTabView = Backbone.View.extend({
	checkId: -1,
	el: '#divAutorizados',
	template: _.template( $('#oficioCnbvFormAutorizadosTemplate').html() ),
	templateResult: _.template( $('#oficioCnbvFormAutorizadosResultTemplate').html() ),
	model: new Backbone.Model(),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.render();
		//aqui colocar los listeners
		this.listenTo( this.model, 'change:numeroMatricula', this.invalidateResult );
		this.listenTo( this.model, 'change:numeroMatriculaFoundValidated', this.renderResult );
		
		this.listenTo( this.model, 'change:errorNumeroMatricula', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroMatriculaNotFound', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroMatriculaInvalidDataType', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroMatriculaInList', this.renderError );
		this.listenTo( this.model, 'change:errorNumeroMatriculaAtLeastOne', this.renderError );
		
		this.listenTo( this.model, 'change:validated', this.renderValidated );
		this.listenTo( this.model, 'change:processing', this.renderProcessing );
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderResult();
		this.renderAutorizadoResultsView();
		this.renderError();
		this.renderProcessing();
		this.renderValidated();
		return this;
	},
	renderResult: function(){
		this.$('.div-result').html( this.templateResult( this.model.toJSON() ) );
	},
	renderAutorizadoResultsView: function(){
		var parentView = this;
		var collection = this.collection; //AutorizadoVMCollection
		var view;
		
		this.$('.div-autorizados').html("");
		view = new app.AutorizadoResultsView( { parentView:parentView, collection:collection } );
		this.$('.div-autorizados').append( view.render().el );
	},
	renderError: function(){
		var errorNumeroMatricula = this.model.get('errorNumeroMatricula');
		var errorNumeroMatriculaNotFound = this.model.get('errorNumeroMatriculaNotFound');
		var errorNumeroMatriculaInvalidDataType = this.model.get('errorNumeroMatriculaInvalidDataType');
		var errorNumeroMatriculaInList =  this.model.get('errorNumeroMatriculaInList');
		var errorNumeroMatriculaAtLeastOne = this.model.get('errorNumeroMatriculaAtLeastOne');
		
		if(errorNumeroMatricula){
			this.$('.alert-errorNumeroMatricula').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.alert-errorNumeroMatricula').hide();
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
		
		if(errorNumeroMatriculaNotFound){
			this.$('.alert-errorNumeroMatriculaNotFound').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.alert-errorNumeroMatriculaNotFound').hide();
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
		
		if(errorNumeroMatriculaInvalidDataType){
			this.$('.alert-errorNumeroMatriculaInvalidDataType').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.alert-errorNumeroMatriculaInvalidDataType').hide();
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
		
		if(errorNumeroMatriculaInList){
			this.$('.alert-errorNumeroMatriculaInList').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.alert-errorNumeroMatriculaInList').hide();
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
		
		if(errorNumeroMatriculaAtLeastOne){
			this.$('.alert-errorNumeroMatriculaAtLeastOne').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.alert-errorNumeroMatriculaAtLeastOne').hide();
			this.$('.div-numeroMatricula').removeClass('has-error');
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
	disableInput: function(){
		this.$(".numeroMatricula").prop('disabled',true);
		this.$(".verifyNumeroMatricula").prop('disabled',true);
		this.$(".add").prop('disabled',true);
		
		this.$(".sort").prop('disabled',true);
		this.$(".remove ").prop('disabled',true); 
	},
	enableInput: function(){
		this.$(".numeroMatricula").prop('disabled',false);
		this.$(".verifyNumeroMatricula").prop('disabled',false);
		if(this.model.get('numeroMatriculaFoundValidated')){
			this.$(".add").prop('disabled',false);
		}
		else{
			this.$(".add").prop('disabled',true);
		}
		this.$(".sort").prop('disabled',false);
		this.$(".remove ").prop('disabled',false); 
	},
	enableSubmitDisableEdit: function(){
		this.$(".edit").prop('disabled',true);
		this.$(".submit").prop('disabled',false);
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop('disabled',true);
		this.$(".edit").prop('disabled',false);
	},
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	clearNumeroMatricula: function(){
		this.model.set('numeroMatricula','');
		this.$('.numeroMatricula').val('');
	},
	invalidateResult: function(){
		this.model.set({
			idCertificacion: '',
			idSustentante: -1,
			nombreCompleto: '',
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
			errorNumeroMatriculaInList: false,
			errorNumeroMatriculaAtLeastOne: false

			, institucion: ''
		});
	},
	
	events: {
		'click .verifyNumeroMatricula':'verifyNumeroMatricula',
		'click .add': 'addApoderadable',
		'click .submit':'submit',
		'click .edit':'edit',
		'change .field': 'updateModel'
	},
	
	updateModel: function(e){
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = this.$(e.currentTarget).val().trim();
		this.model.set(fieldName,fieldValue);
	},
	
	addApoderadable: function(e){
		e.preventDefault();
		
		var _this = this;
		var apoderable;
		var obj;
		
		obj = {
			idCertificacion: _this.model.get('idCertificacion'),
			idSustentante: _this.model.get('idSustentante'),
			numeroMatricula: _this.model.get('numeroMatricula'),
			nombreCompleto: _this.model.get('nombreCompleto'),
			nombre: _this.model.get('nombre'),
			primerApellido: _this.model.get('primerApellido'),
			segundoApellido: _this.model.get('segundoApellido'),
			dsFigura: _this.model.get('dsFigura'),
			dsVarianteFigura: _this.model.get('dsVarianteFigura'),
			dsTipoAutorizacion: _this.model.get('dsTipoAutorizacion')
		}
		apoderable = new app.AutorizadoVM(obj);
		
		this.collection.add(apoderable);
		
		//this.model.set('numeroMatricula','');
		this.clearNumeroMatricula();
	},
	
	verifyNumeroMatricula: function(e){
		e.preventDefault();
		if(this._validateNumeroMatricula()){
			this.model.findAutorizableByNumeroMatricula();
		}
	},
	_validateNumeroMatricula: function(){
		var num10CarExp = /^[0-9]{1,10}$/;
		var containedInCollection = false;
		var valid = true;
		
		this.model.set('errorNumeroMatriculaInvalidDataType',false);
		
		if(this.model.get('numeroMatricula') == ''){
			this.model.set('errorNumeroMatriculaInvalidDataType',true);
			valid = false;
		}
		else if(!num10CarExp.test(this.model.get('numeroMatricula'))){
			this.model.set('errorNumeroMatriculaInvalidDataType',true);
			valid = false;
		}
		else{
			this.collection.forEach( function(item){
				if(this.model.get('numeroMatricula') == item.get('numeroMatricula'))
					containedInCollection = true;
			}, this );
			if(containedInCollection){
				this.model.set('errorNumeroMatriculaInList',true);
				valid = false;
			}
		}
		
		return valid;
	},
	
	submit: function(e){
		e.preventDefault();
		if(this._validate()){
			this.model.set('validated',true);
			this.invalidateResult();
			this.clearNumeroMatricula();
			this.trigger("stateChange","VALIDATED",this.checkId);
		}
	},
	edit: function(e){
		e.preventDefault();
		this.model.set('validated',false);
		this.trigger("stateChange","READY",this.checkId);
	},
	
	_validate: function(){
		var valid = true;
		//valida que haya al menos un autorizable
		this.model.set('errorNumeroMatriculaAtLeastOne',false);
		
		if(this.collection.size() == 0){
			this.model.set('errorNumeroMatriculaAtLeastOne',true);
			valid = false;
		}
		
		return valid;
	}
	
});