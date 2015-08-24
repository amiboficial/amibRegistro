var app = app || {};

app.NotarioVM = Backbone.Model.extend ({
	defaults: {
		numeroNotaria: '',
		idEntidadFederativa: -1,
		entidadesFederativas: [ { id:'-1',text:'-Seleccione-' } ] ,
		
		notariosEncontrados: [ { id:'-1',text:'-Seleccione-' } ],
		idNotarioSeleccionado: -1,
		
		//flags de estado
		processing: false,
		hayNotariosEncontrados: false,
		
		//errores de "valdidación" al momento de buscar el notario
		errorNumeroNotariaInvalidType: false,
		errorNumeroNotariaBlank: false,
		errorEntidadFederativaNonSelected: false,
		
		//errores al no encontrar notario
		errorNotarioNotFound: false,
		
		//error al no seleccionar ningun notario
		errorNotarioNotSelected: false,
		
		//url para obtener al notario
		findNotarioByNumeroNotariaAndIdEntidadFederativaUrl: ''
	},
	
	initialize: function(){
		this.listenTo( this, 'change:numeroNotaria', this.invalidarResultadosBusqueda );
		this.listenTo( this, 'change:idEntidadFederativa', this.invalidarResultadosBusqueda );
	},
	
	setBlankNotarioEncontrados: function(){
		this.set('notariosEncontrados',[ { id:'-1',text:'-Seleccione-' } ]);
	},
	findNotarioByNumeroNotariaAndIdEntidadFederativa: function(numeroNotaria,idEntidadFederativa){
		var _this = this;
		
		//llamada ajax para actualizar a los notarios
		$.ajax({
			url: _this.get('findNotarioByNumeroNotariaAndIdEntidadFederativaUrl'),
			beforeSend: function( xhr ){
				_this.set('processing',true);
				_this.set('hayNotariosEncontrados',false);
				_this.set('errorNumeroNotariaInvalidType',false);
				_this.set('errorNumeroNotariaBlank',false);
				_this.set('errorEntidadFederativaNonSelected',false);
				_this.set('errorNotarioNotFound',false);
				_this.set('errorNotarioNotSelected',false);
			},
			type: 'GET',
			data: { numeroNotaria:numeroNotaria, idEntidadFederativa:idEntidadFederativa },
		}).done( function( data ) {
			_this.set('processing',false);
			if(data.status == "OK" && data.object.length > 1){ //es mayor a 1 porque ya incluy el dato del "nulo"
				_this.set('hayNotariosEncontrados',true);
				//console.log("notariosEncontrados ->");
				//console.dir(data.object);
				_this.set('notariosEncontrados',data.object);
			}
			else{
				_this.set('errorNotarioNotFound',true);
			}
		});
	},
	invalidarResultadosBusqueda: function(){
		console.log('invalidarResultadosBusqueda');
		this.set({
			hayNotariosEncontrados: false,
			idNotarioSeleccionado: -1,
			errorNumeroNotariaInvalidType: false,
			errorNumeroNotariaBlank: false,
			errorEntidadFederativaNonSelected: false,
			errorNotarioNotFound: false,
			errorNotarioNotSelected: false,
		});
		this.setBlankNotarioEncontrados();
	},
});

app.NotarioView =  Backbone.View.extend({
	el: '#divNotario',
	template: _.template( $('#notarioTemplate').html() ),
	model: new app.NotarioVM(),
	
	initialize: function(options){
		this.model = options.model;
		
		this.render();
		
		this.listenTo(this.model, 'change:notariosEncontrados', this.renderNotariosEncontrados );
		this.listenTo(this.model, 'change:hayNotariosEncontrados', this.renderHayNotariosEncontrados );
		
		this.listenTo(this.model, 'change:errorNumeroNotariaInvalidType', this.renderError );
		this.listenTo(this.model, 'change:errorNumeroNotariaBlank', this.renderError );
		this.listenTo(this.model, 'change:errorEntidadFederativaNonSelected', this.renderError );
		this.listenTo(this.model, 'change:errorNotarioNotFound', this.renderError );
		this.listenTo(this.model, 'change:errorNotarioNotSelected', this.renderError );
		
		this.listenTo( this.model, 'change:validated', this.renderValidated );
		this.listenTo( this.model, 'change:validated', this.notifyValidated );
		
		this.listenTo(this.model, 'change:processing', this.renderProcessing );
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
	notifyValidated: function(){
		if(this.model.get('validated') == true){
			this.trigger("stateChange","VALIDATED",this.checkId);
		}
		else{
			this.trigger("stateChange","READY",this.checkId);
		}
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderNotariosEncontrados();
		this.renderHayNotariosEncontrados();
		this.renderProcessing();
		this.renderError();
		this.renderValidated();
	},
	renderHayNotariosEncontrados: function(){
		//console.log('paso por renderHayNotariosEncontrados...');
		if(this.model.get('hayNotariosEncontrados') == true){
			//console.log('hayNotariosEncontrados -> true');
			this.$('.idNotarioSeleccionado').prop('disabled',false);
			this.$('.buscarNotario').prop('disabled',true);
		}
		else{
			//console.log('hayNotariosEncontrados -> false');
			this.$('.idNotarioSeleccionado').prop('disabled',true);
			this.$('.buscarNotario').prop('disabled',false);
		}
	},
	renderNotariosEncontrados: function(){
		//console.log('paso por -> renderNotariosEncontrados');
		//console.dir(this.model.get('notariosEncontrados'));
		var optionsStr = '';
		var notariosArr;
		var idNotarioSel;
		
		notariosArr = this.model.get('notariosEncontrados');
		idNotarioSel = this.model.get('idNotarioSeleccionado');
		_.each(notariosArr,function(item){
			if(idNotarioSel == item.id){
				optionsStr += '<option value="'+item.id+'" selected>' + item.text + '</option>';
			}
			else{
				optionsStr += '<option value="'+item.id+'">' + item.text + '</option>';
			}
		},this);
		
		this.$('.idNotarioSeleccionado').html(optionsStr);
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
			this.disableSubmit();
		}
		else{
			this.enableInput();
			this.enableSubmit();
			this.renderHayNotariosEncontrados();
		}
	},
	renderError: function(){
		if(this.model.get('errorNumeroNotariaInvalidType')){
			this.$('.div-numeroNotaria').addClass('has-error');
			this.$('.alert-errorNumeroNotariaInvalidType').show();
		}
		else{
			this.$('.alert-errorNumeroNotariaInvalidType').hide();
			this.$('.div-numeroNotaria').removeClass('has-error');
		}
		if(this.model.get('errorNumeroNotariaBlank')){
			this.$('.div-numeroNotaria').addClass('has-error');
			this.$('.alert-errorNumeroNotariaBlank').show();
		}
		else{
			this.$('.div-numeroNotaria').removeClass('has-error');
			this.$('.alert-errorNumeroNotariaBlank').hide();
		}
		if(this.model.get('errorEntidadFederativaNonSelected')){
			this.$('.div-idEntidadFederativa').removeClass('has-error');
			this.$('.alert-errorEntidadFederativaNonSelected').show();
		}
		else{
			this.$('.div-idEntidadFederativa').removeClass('has-error');
			this.$('.alert-errorEntidadFederativaNonSelected').hide();
		}
		if(this.model.get('errorNotarioNotFound')){
			this.$('.alert-errorNotarioNotFound').show();
		}
		else{
			this.$('.alert-errorNotarioNotFound').hide();
		}
		if(this.model.get('errorNotarioNotSelected')){
			this.$('.div-idNotarioSeleccionado').removeClass('has-error');
			this.$('.alert-errorNotarioNotSelected').show();
		}
		else{
			this.$('.div-idNotarioSeleccionado').removeClass('has-error');
			this.$('.alert-errorNotarioNotSelected').hide();
		}
	},
	disableInput: function(){
		this.$(".numeroNotaria").prop('disabled',true);
		this.$(".idEntidadFederativa").prop('disabled',true);
		this.$(".notariosEncontrados").prop('disabled',true);
		this.$(".idNotarioSeleccionado").prop('disabled',true);
		this.$(".buscarNotario").prop('disabled',true);
	},
	enableInput: function(){
		this.$(".numeroNotaria").prop('disabled',false);
		this.$(".idEntidadFederativa").prop('disabled',false);
		this.$(".notariosEncontrados").prop('disabled',false);
		this.$(".idNotarioSeleccionado").prop('disabled',false);
		this.$(".buscarNotario").prop('disabled',false);
	},
	enableSubmit: function(){
		this.$(".edit").prop('disabled',true);
		this.$(".submit").prop('disabled',false);
	},
	disableSubmit: function(){
		this.$(".submit").prop('disabled',true);
		this.$(".edit").prop('disabled',false);
	},
	
	events: {
		'click .buscarNotario' : 'buscarNotario',
		'click .submit':'submit',
		'click .edit':'edit',
		'change .field' : 'updateModel'
	},
	
	updateModel: function(e){
		e.preventDefault();
		
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = this.$(e.currentTarget).val().trim();
		
		if(fieldName == 'numeroNotaria' ||fieldName == 'idEntidadFederativa'){
			
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		
	},
	
	buscarNotario: function(e){
		e.preventDefault();
		
		var numeroNotaria = this.model.get('numeroNotaria');
		var idEntidadFederativa = this.model.get('idEntidadFederativa');
		
		if(this._validateBuscarNotario()){
			this.model.findNotarioByNumeroNotariaAndIdEntidadFederativa(numeroNotaria,idEntidadFederativa);
		}
	},
	_validateBuscarNotario: function(){
		var valid = true;
		var num10CarExp = /^[0-9]{1,10}$/;
		
		var numeroNotariaBlank = (this.model.get('numeroNotaria').trim() == '');
		var numeroNotariaInvalidType = num10CarExp.test(!this.model.get('numeroNotaria').trim())
		var entidadFederativaNonSelected = (this.model.get('idEntidadFederativa') == -1)
		
		this.model.set({
			errorNumeroNotariaInvalidType: false,
			errorNumeroNotariaBlank: false,
			errorEntidadFederativaNonSelected: false
		});
		
		if(numeroNotariaBlank){
			this.model.set('errorNumeroNotariaInvalidType',true);
			valid = false;
		}
		else if(numeroNotariaInvalidType){
			this.model.set('errorNumeroNotariaBlank',true);
			valid = false;
		}
		
		if(entidadFederativaNonSelected){
			this.model.set('errorEntidadFederativaNonSelected',true);
			valid = false;
		}
		
		return valid;
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
		var valid = true;
		var notarioSeleted = (this.model.get('idNotarioSeleccionado') != -1);
		
		//limpia errores
		this.model.set('errorNotarioNotSelected',false);
		
		if(!notarioSeleted){
			this.model.set('errorNotarioNotSelected',true);
			valid = false;
		}
		
		return valid; //TODO: validancion que hay seleccionado un notario valido
	}
});