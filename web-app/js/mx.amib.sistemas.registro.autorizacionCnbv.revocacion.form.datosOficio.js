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

app.RevocacionDatosOficioTabVM = Backbone.Model.extend({
	defaults:{
		idGrupoFinanciero: -1,
		gruposFinancieros: [ {id:'-1',text:'-Seleccione-',instituciones:[]} ] ,
		idInstitucion:-1,
		instituciones: [ {id:'-1',text:'-Seleccione-'} ],
		numeroEscritura:'',
		representanteLegalNombre:'',
		representanteLegalApellido1:'',
		representanteLegalApellido2:'',
		fechaRevocacion_day:-1,
		fechaRevocacion_month:-1,
		fechaRevocacion_year:-1,
		
		errorNoGrupoFinanciero: false,
		errorNoRepresentanteLegalNombre: false,
		errorNoRepresentanteLegalApellido1: false,
		errorNoNumeroEscritura: false,
		errorNumeroEscrituraNoNumerico: false,
		errorNumeroEscrituraNonCheckedYet: false,
		errorNumeroEscrituraNonUnique: false,
		errorNoFechaRevocacion: false,
		
		numeroEscrituraUniqueChecked: false,
		isNumeroEscrituraUnique: false,
		
		processing: false,
		validated: false,
		
		checkNumeroEscrituraUniqueUrl: '',
	},
	
	initialize: function(){
		this.listenTo( this, 'change:numeroEscritura', this.checkNumeroEscrituraUnique );
		this.listenTo( this, 'change:idGrupoFinanciero', this.cargarInstitucionesDeGrupoFinanciero );
		
		
		Backbone.Model.prototype.initialize.call(this);
	},
	
	cargarInstitucionesDeGrupoFinanciero: function(){
		var grupoFinancieroSeleccionado;
		var institucionesGrupoFinanciero;
		
		//si se escoge el "-1" en grupo financiero
		if(this.get('idGrupoFinanciero') == -1){
			this.set({
				idInstitucion: -1,
				instituciones: [ {id:'-1',text:'-Seleccione-'} ],
			});
		}
		else{
			//busca el grupo financiero con la id correspondiente
			_.each(this.get('gruposFinancieros'), function(item){
				if(item.id == this.get('idGrupoFinanciero')){
					grupoFinancieroSeleccionado = item;
				}
			}, this);
			//setea el correspondiente array de instituciones
			this.set('instituciones',grupoFinancieroSeleccionado.instituciones);
		}
		
		//manda una notificacion de que se acualizaron las instituciones
		this.trigger('institucionesCargadas',{});
	},
	validate: function(){
		var valid = true;
		var num10CarExp = /^[0-9]{1,10}$/;
		
		var grupoFinancieroSeleccionado = (this.get('idGrupoFinanciero') != -1);
		var noRepLegalNombre = (this.get('representanteLegalNombre') == '');
		var noRepLegalAp1 = (this.get('representanteLegalApellido1') == '');
		var noNumeroEscritura = (this.get('numeroEscritura') == '');
		var numeroEscrituraNoNumerico = (!num10CarExp.test(this.get('numeroEscritura')));
		var numeroEscrituraUniqueChecked = this.get('numeroEscrituraUniqueChecked');
		var numeroEscrituraUnique = this.get('isNumeroEscrituraUnique');
		var noFechaRevocacion = ( this.get('fechaRevocacion_day') == -1 || this.get('fechaRevocacion_month') == -1 || this.get('fechaRevocacion_year') == -1)
	
		this.set({
			errorNoGrupoFinanciero: false,
			errorNoRepresentanteLegalNombre: false,
			errorNoRepresentanteLegalApellido1: false,
			errorNoNumeroEscritura: false,
			errorNumeroEscrituraNoNumerico: false,
			errorNumeroEscrituraNonCheckedYet: false,
			errorNumeroEscrituraNonUnique: false,
			errorNoFechaRevocacion: false,
			validated: false
		},false);
		
		if(!grupoFinancieroSeleccionado){
			valid = false;
			this.set('errorNoGrupoFinanciero',true);
		}
		if(noRepLegalNombre){
			valid = false;
			this.set('errorNoRepresentanteLegalNombre',true);
		}
		if(noRepLegalAp1){
			valid = false;
			this.set('errorNoRepresentanteLegalApellido1',true);
		}
		if(noNumeroEscritura){
			valid = false;
			this.set('errorNoNumeroEscritura',true);
		}
		if(numeroEscrituraNoNumerico){
			valid = false;
			this.set('errorNumeroEscrituraNoNumerico',true);
		}
		if(!numeroEscrituraUniqueChecked){
			valid = false;
			this.set('errorNumeroEscrituraNonCheckedYet',true);
		}
		else if(!numeroEscrituraUnique){
			valid = false;
			this.set('errorNumeroEscrituraNonUnique',true);
		}
		
		if(noFechaRevocacion){
			valid = false;
			this.set('errorNoFechaRevocacion',true);
		}
		
		this.set('validated',valid);
		this.trigger('validated',valid);
		return valid;
	},
	invalidate: function(){
		this.set('validated',false);
		this.trigger('validated',false);
	},
	checkNumeroEscrituraUnique: function(){
		var _this = this;
		
		console.log('checkNumeroEscrituraUniqueUrl -> ' + _this.get('checkNumeroEscrituraUniqueUrl'))
		
		this.invalidateCheckNumeroEscrituraUnique();
		if(this.validateNumeroEscritura()){
			
			_this.set('processing',true);
			$.ajax({
				url: _this.get('checkNumeroEscrituraUniqueUrl') + "?numeroEscritura=" + _this.get("numeroEscritura") ,
				async: true,
				success: function(result){
					_this.set('processing',false);
					_this.set('numeroEscrituraUniqueChecked',true);
					if(result.status == "OK" && result.object.isNumeroEscrituraAvailable == true){
						_this.set('isNumeroEscrituraUnique',true);
					}
					else{
						_this.set('isNumeroEscrituraUnique',false);
					}
					_this.trigger('numeroEscrituraUniqueChecked',{});
				}
			});
			
		}
		
	},
	validateNumeroEscritura: function(){
		var valid = true;
		var num10CarExp = /^[0-9]{1,10}$/;
		
		var noNumeroEscritura = (this.get('numeroEscritura') == '');
		var numeroEscrituraNoNumerico = (!num10CarExp.test(this.get('numeroEscritura')));
		
		this.set('errorNoNumeroEscritura',false);
		this.set('errorNumeroEscrituraNoNumerico',false);
		
		if(noNumeroEscritura){
			valid = false;
			//this.set('errorNoNumeroEscritura',true); simplemente se muestra como borrado
		}
		else if(numeroEscrituraNoNumerico){
			valid = false;
			this.set('errorNumeroEscrituraNoNumerico',true);
		}
		
		this.trigger('numeroEscrituraValidated',{});
		
		return valid;
	},
	invalidateCheckNumeroEscrituraUnique: function(){
		this.set({
			errorNumeroEscrituraNonCheckedYet: false,
			errorNumeroEscrituraNonUnique: false,
			numeroEscrituraUniqueChecked: false,
			isNumeroEscrituraUnique: false
		});
		this.trigger('numeroEscrituraUniqueCheckInvalidated',{});
	}
	
});

app.RevocacionDatosOficioTabView = Backbone.View.extend({
	checkId: -1,
	el: '#divRevocacion',
	template: _.template( $('#formRevocacionTemplate').html() ),
	model: new app.RevocacionDatosOficioTabVM(),
	
	initialize: function(options){
		this.model = options.model;
		this.render();
		
		this.listenTo( this.model, 'change:processing', this.renderProcessing );
		this.listenTo( this.model, 'institucionesCargadas', this.renderInstitucionesCargadas );
		this.listenTo( this.model, 'numeroEscrituraUniqueChecked', this.renderNumeroEscrituraUniqueChecked );
		this.listenTo( this.model, 'numeroEscrituraUniqueCheckInvalidated', this.renderInvalidateCheckNumeroEscrituraUnique );
		this.listenTo( this.model, 'numeroEscrituraValidated', this.renderError );
		this.listenTo( this.model, 'validated', this.renderError );
		this.listenTo( this.model, 'validated', this.renderValidated );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderInstitucionesCargadas();
		this.renderError();
		this.renderProcessing();
		return this;
	},
	
	renderInstitucionesCargadas: function(){
		var innerHtml = '';
		_.each( this.model.get('instituciones'), function(item){
			if(item.id == this.model.get('idInstitucion')){
				innerHtml += '<option value="'+item.id+'" selected>'+item.text+'</option>';
			}
			else{
				innerHtml += '<option value="'+item.id+'">'+item.text+'</option>';
			}
		}, this );
		this.$('.idInstitucion').html( innerHtml );
	},
	renderError: function(){
		console.log('paso por aqui!!!');
		var valid = true;
		//primero limpia cualquier mensaje de error
		this.$('.alert-errorNoGrupoFinanciero').hide();
		this.$('.alert-errorNoRepresentanteLegalNombre').hide();
		this.$('.alert-errorNoRepresentanteLegalApellido1').hide();
		this.$('.alert-errorNoNumeroEscritura').hide();
		this.$('.alert-errorNumeroEscrituraNoNumerico').hide();
		this.$('.alert-errorNumeroEscrituraNonCheckedYet').hide();
		this.$('.alert-errorNumeroEscrituraNonUnique').hide();
		this.$('.alert-errorNoFechaRevocacion').hide();
		this.$('.div-idGrupoFinanciero').removeClass( 'has-error' );
		this.$('.div-representanteLegalNombre').removeClass( 'has-error' );
		this.$('.div-representanteLegalApellido1').removeClass( 'has-error' );
		this.$('.div-numeroEscritura').removeClass( 'has-error' );
		this.$('.div-fechaRevocacion').removeClass( 'has-error' );
		
		if( this.model.get('errorNoGrupoFinanciero') == true ){
			this.$('.alert-errorNoGrupoFinanciero').show();
			this.$('.div-idGrupoFinanciero').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNoRepresentanteLegalNombre') == true ){
			this.$('.alert-errorNoRepresentanteLegalNombre').show();
			this.$('.div-representanteLegalNombre').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNoRepresentanteLegalApellido1') == true ){
			this.$('.alert-errorNoRepresentanteLegalApellido1').show();
			this.$('.div-representanteLegalApellido1').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNoNumeroEscritura') == true ){
			this.$('.alert-errorNoNumeroEscritura').show();
			this.$('.div-numeroEscritura').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNumeroEscrituraNoNumerico') == true ){
			this.$('.alert-errorNumeroEscrituraNoNumerico').show();
			this.$('.div-numeroEscritura').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNumeroEscrituraNonCheckedYet') == true ){
			this.$('.alert-errorNumeroEscrituraNonCheckedYet').show();
			this.$('.div-numeroEscritura').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNumeroEscrituraNonUnique') == true ){
			this.$('.alert-errorNumeroEscrituraNonUnique').show();
			this.$('.div-numeroEscritura').addClass( 'has-error' );
		}
		
		if( this.model.get('errorNoFechaRevocacion') == true ){
			this.$('.alert-errorNoFechaRevocacion').show();
			this.$('.div-fechaRevocacion').addClass( 'has-error' );
		}
	},
	renderProcessing: function(){
		if( this.model.get('processing') == true ){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.renderValidated();
		}
	},
	renderValidated: function(){
		console.log('paso por el renderValidated');
		
		if(this.model.get('validated')){
			this.disableInput();
			this.$('.submit').prop('disabled',true);
			this.$('.edit').prop('disabled',false);
		}
		else{
			this.enableInput();
			this.$('.submit').prop('disabled',false);
			this.$('.edit').prop('disabled',true);
		}
	},
	renderNumeroEscrituraUniqueChecked: function(){
		this.$('.alert-errorNumeroEscrituraNonUnique').hide();
		this.$('.div-numeroEscritura').removeClass( 'has-success' );
		this.$('.div-numeroEscritura').removeClass( 'has-error' );
		
		if(this.model.get('isNumeroEscrituraUnique')){
			this.$('.div-numeroEscritura').addClass( 'has-success' );
		}
		else{
			this.$('.alert-errorNumeroEscrituraNonUnique').show();
			this.$('.div-numeroEscritura').addClass( 'has-error' );
		}
	},
	renderInvalidateCheckNumeroEscrituraUnique: function(){
		this.$('.alert-errorNumeroEscrituraNonUnique').hide();
		this.$('.div-numeroEscritura').removeClass( 'has-success' );
		this.$('.div-numeroEscritura').removeClass( 'has-error' );
	},
	enableInput: function(){
		this.$('input').prop('disabled',false);
		this.$('button').prop('disabled',false);
		this.$('select').prop('disabled',false);
	},
	disableInput: function(){
		this.$('input').prop('disabled',true);
		this.$('button').prop('disabled',true);
		this.$('select').prop('disabled',true);
	},
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	events: {
		'change .field':'updateModel',
		'click .submit':'submit',
		'click .edit':'edit'
	},
	
	updateModel: function(e){
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = $.trim(this.$(e.currentTarget).val());
		
		console.log('updateModel:'+fieldName+':'+fieldValue);
		if(fieldName == 'numeroEscritura' || fieldName == 'idGrupoFinanciero'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
	},
	
	submit: function(){
		if(this.model.validate(true)){
			this.trigger("stateChange","VALIDATED",this.checkId);
		}
	},	
	edit: function(){
		this.trigger("stateChange","READY",this.checkId);
		this.model.invalidate();
	}
	
});