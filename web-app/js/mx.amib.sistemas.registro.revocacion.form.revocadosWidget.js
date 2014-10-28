var app = app || {};

app.RVC_SHOW = 1;
app.RVC_NEW = 2;
app.RVC_EDIT = 3;

app.RVC_ERR_NO = 0;
app.RVC_ERR_EMPTY = 1;
app.RVC_ERR_FORMAT = 2;
app.RVC_ERR_DATE = 3;
app.RVC_ERR_VALID = 4;

app.RVC_ERR_MAT_NO = 0
app.RVC_ERR_MAT_EN_LISTA = 1;
app.RVC_ERR_MAT_NOT_FOUND = 2;
app.RVC_ERR_MAT_REQUEST = 3;

app.RVCS_EDIT = 1;
app.RVCS_READY = 2;

app.Revocado = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: 0,
		nombreCompleto: '',
		numeroEscritura: 0,
		motivo: '',
		fechaBajaDia: 1,
		fechaBajaMes: 1,
		fechaBajaAnyo: 1900,
		revocacionId: -1,
		_state: app.RVC_SHOW,
		_validMatricula: false,
		_ajaxMatriculaUrl: 'http://localhost:8080/amibRegistro/revocacion/obtenerSustentantePorMatricula'
	},
	
	getState: function(){
		return this.get('_state');
	},
	
	setNewState: function(){
		this.set("_state", app.RVC_NEW);
	},
	setShowState: function(){
		this.set("_state", app.RVC_SHOW);
	},
	setEditState: function(){
		this.set("_state",app.RVC_EDIT);
	},
	
	isMatriculaValida: function(){
		return this.get('_validMatricula');
	},
	
	setValidMatricula: function(){
		this.set("_validMatricula",true);
	},
	setInvalidMatricula: function(){
		this.set("_validMatricula",false);
	}
	
});

app.Revocados = Backbone.Collection.extend({
	model: app.Revocado,
	
	checarSiYaHayMatricula: function(numeroMatricula){
		var hayMatricula = false;
		this.forEach( function(item){
			console.log( item.toJSON() )
			if(item.get("numeroMatricula") == numeroMatricula && item.getState() != app.RVC_NEW){
				hayMatricula = true;
			}
		}
		, this);
		return hayMatricula;
	}
});

app.RevocadoView = Backbone.View.extend({
	tagname: 'div',
	className: 'list-group-item',
	matriculaUrl: 'http://localhost:8080/amibRegistro/revocacion/obtenerSustentantePorMatricula',
	
	templateShow: _.template( $('#revocadoTemplateShow').html() ),
	templateNew: _.template( $('#revocadoTemplateNew').html() ),
	templateEdit: _.template( $('#revocadoTemplateEdit').html() ),
	
	errors: [], //errType,errField
	errorMatriculaAjax: app.RVC_ERR_MAT_NO, //errType
	
	_busy: false,
	
	render: function() {
		if(this.model.getState() == app.RVC_NEW) {
			this.$el.html( this.templateNew( this.model.toJSON() ) );
		}
		else if(this.model.getState() == app.RVC_SHOW) {
			this.$el.html( this.templateShow( this.model.toJSON() ) );
		}
		else if(this.model.getState() == app.RVC_EDIT) {
			this.$el.html( this.templateEdit( this.model.toJSON() ) );
			this.$(".fechaBaja_day").val( this.model.get("fechaBajaDia") );
			this.$(".fechaBaja_month").val( this.model.get("fechaBajaMes") );
			this.$(".fechaBaja_year").val( this.model.get("fechaBajaAnyo") );
		}
		
		//limpia todos los mensajes y los campos de validación
		this.$(".msgRevProcesandoDatos").hide();
		this.$(".msgRevMatriculaYaEnLista").hide();
		this.$(".msgRevMatriculaNoEncontrada").hide();
		this.$(".msgErrorPeticion").hide();
		this.$(".msgRevErrorEnCampos").hide();
		
		return this;
	},
	renderCleanValidation: function() {
		//limpia todos los mensajes y los campos de validación
		this.$(".msgRevProcesandoDatos").hide();
		this.$(".msgRevMatriculaYaEnLista").hide();
		this.$(".msgRevMatriculaNoEncontrada").hide();
		this.$(".msgErrorPeticion").hide();
		
		this.$(".msgRevErrorEnCampos").hide();
		
		this.$(".numeroMatriculaRow").removeClass( 'has-error' );
		this.$(".numeroEscrituraRow").removeClass( 'has-error' );
		this.$(".motivoRow").removeClass( 'has-error' );
		this.$(".fechaBajaRow").removeClass( 'has-error' );
	},
	renderValidate: function() {
		this.renderCleanValidation();
		_.each(this.errors, function(err){
			if(err.errType != app.RVC_ERR_NO){
				this.$("." + err.errField + "Row").addClass('has-error');
				this.$(".msgRevErrorEnCampos").show();
			}
		}, this);
	},
	renderBusyMessage: function() {
		if(this._busy == true){
			this.$(".msgRevProcesandoDatos").show();
		}
		else{
			this.$(".msgRevProcesandoDatos").hide();
		}
	},
	renderMatriculaErrorMessage: function(){
		var errType = this.errorMatriculaAjax;
		
		this.$(".msgRevMatriculaYaEnLista").hide();
		this.$(".msgRevMatriculaNoEncontrada").hide();
		this.$(".msgErrorPeticion").hide();
		this.$(".numeroMatriculaRow").removeClass( 'has-error' );
		
		if(errType == app.RVC_ERR_MAT_EN_LISTA){
			this.$(".msgRevMatriculaYaEnLista").show();
			this.$(".numeroMatriculaRow").addClass( 'has-error' );
		}
		else if(errType == app.RVC_ERR_MAT_NOT_FOUND){
			this.$(".msgRevMatriculaNoEncontrada").show();
			this.$(".numeroMatriculaRow").addClass( 'has-error' );
		}
		else if(errType == app.RVC_ERR_MAT_REQUEST){
			this.$(".msgErrorPeticion").show();
			this.$(".numeroMatriculaRow").addClass( 'has-error' );
		}
	},
	
	events: {
		//eventos en NEW
		'blur .numeroMatricula': 'buscarSustentante',
		'click .save':'guardarRevocado',
		'click .cancelCreate':'cancelarCrearRevocado',
		//eventos en SHOW
		'click .edit':'editarRevocado',
		'click .delete':'eliminarRevocado',
		//eventos en EDIT
		'click .update':'actualizarRevocado',
		'click .cancelEdit':'cancelarEditarRevocado',
	},
	
	trimFields: function(){
		this.$(".numeroMatricula").val( $.trim( this.$(".numeroMatricula").val() ) );
		this.$(".numeroEscritura").val( $.trim( this.$(".numeroEscritura").val() ) );
		this.$(".motivo").val( $.trim( this.$(".motivo").val() ) );
	},
	
	setBusy: function(){
		this._busy = true;
		this.renderBusyMessage();
	},
	setAvailable: function(){
		this._busy = false;
		this.renderBusyMessage();
	},
	isBusy: function(){
		return this._busy;
	},
	setErrorMatriculaAjax: function(errType){
		this.errorMatriculaAjax = errType;
		this.renderMatriculaErrorMessage();
	},
	cleanErrorMatriculaAjax: function(){
		this.errorMatriculaAjax = app.RVC_ERR_MAT_NO;
		this.renderMatriculaErrorMessage();
	},
	
	//acciones en NEW
	buscarSustentante: function(e){
		var ajaxUrl = this.matriculaUrl;
		e.preventDefault();
		this.trimFields();
		
		if(!this.isBusy()){
			this.setBusy();
			var numeroMatricula = this.$(".numeroMatricula").val();
			
			var context = this;
			$.ajax({
				type: "POST",
				url: ajaxUrl + "/" + numeroMatricula,
			}).done(function(_data,_status,_jqXHR){
				try{
					if(_data.status == "OK"){
						context.model.set("numeroMatricula",_data.object.numeroMatricula);
						if(context.model.collection.checarSiYaHayMatricula(_data.object.numeroMatricula)){
							context.model.setInvalidMatricula();
							context.$(".nombreCompleto").val("");
							context.setAvailable();
							context.setErrorMatriculaAjax(app.RVC_ERR_MAT_EN_LISTA);
						}
						else{
							context.model.setValidMatricula();
							context.$(".numeroMatricula").val( _data.object.numeroMatricula );
							context.$(".nombreCompleto").val( _data.object.nombre + " " + _data.object.primerApellido + " " + _data.object.segundoApellido );
							context.setAvailable();
							context.cleanErrorMatriculaAjax();
						}
					}
					else{
						context.model.setInvalidMatricula();
						context.$(".nombreCompleto").val("");
						context.setAvailable();
						context.setErrorMatriculaAjax(app.RVC_ERR_MAT_NOT_FOUND);
					}
				}
				catch(err){
					context.model.setInvalidMatricula();
					context.$(".nombreCompleto").val("");
					context.setAvailable();
					context.setErrorMatriculaAjax(app.RVC_ERR_MAT_REQUEST);
				}
			});
		}
	},
	guardarRevocado: function(e){
		e.preventDefault();
		this.trimFields();
		
		var valid = this.validarCamposNew();
		if(valid == false){
			this.renderValidate();
		}
		else{
			this.model.set("numeroMatricula", this.$(".numeroMatricula").val() );
			this.model.set("nombreCompleto", this.$(".nombreCompleto").val() );
			this.model.set("numeroEscritura", Encoder.XSSEncode(this.$(".numeroEscritura").val()) );
			this.model.set("motivo", Encoder.XSSEncode(this.$(".motivo").val()) );
			this.model.set("fechaBajaDia", this.$(".fechaBaja_day").val() );
			this.model.set("fechaBajaMes", this.$(".fechaBaja_month").val() );
			this.model.set("fechaBajaAnyo", this.$(".fechaBaja_year").val() );
			this.model.setShowState();
			this.render();
		}
	},
	cancelarCrearRevocado: function(e){
		e.preventDefault();
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	},
	
	validarCamposNew: function(){
		this.errors = [];
		if( this.$(".numeroMatricula").val() == "" ){
			this.errors.push({ errType: app.RVC_ERR_EMPTY, errField: "numeroMatricula" });
		}
		if( this.model.isMatriculaValida() == false ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "numeroMatricula" });
		}
		if( this.$(".numeroEscritura").val() == "" ){
			this.errors.push({ errType: app.RVC_ERR_EMPTY, errField: "numeroEscritura" });
		}
		if( this.$(".motivo").val() == "" ){
			this.errors.push({ errType: app.RVC_ERR_EMPTY, errField: "motivo" });
		}
		if( this.$(".fechaBaja_day").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if( this.$(".fechaBaja_month").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if( this.$(".fechaBaja_year").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if(this.errors.length > 0)
			return false;
		else
			return true;
	},
			
	//acciones en SHOW
	editarRevocado: function(e){
		e.preventDefault();
		//cambia el estado a editable
		this.model.setEditState();
		this.render();
	},
	eliminarRevocado: function(e){
		e.preventDefault();
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	},
	
	//acciones en EDIT
	actualizarRevocado: function(e){
		e.preventDefault();
		this.trimFields();
		
		var valid = this.validarCamposEdit();
		if(valid == false){
			this.renderValidate();
		}
		else{
			this.model.set("numeroEscritura", Encoder.XSSEncode(this.$(".numeroEscritura").val()) );
			this.model.set("motivo", Encoder.XSSEncode(this.$(".motivo").val()) );
			this.model.set("fechaBajaDia", this.$(".fechaBaja_day").val() );
			this.model.set("fechaBajaMes", this.$(".fechaBaja_month").val() );
			this.model.set("fechaBajaAnyo", this.$(".fechaBaja_year").val() );
			this.model.setShowState();
			this.render();
		}
	},
	cancelarEditarRevocado: function(e){
		e.preventDefault();
		this.model.setShowState();
		this.render();
	},
	validarCamposEdit: function(){
		this.errors = [];
		if( this.$(".numeroEscritura").val() == "" ){
			this.errors.push({ errType: app.RVC_ERR_EMPTY, errField: "numeroEscritura" });
		}
		if( this.$(".motivo").val() == "" ){
			this.errors.push({ errType: app.RVC_ERR_EMPTY, errField: "motivo" });
		}
		if( this.$(".fechaBaja_day").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if( this.$(".fechaBaja_month").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if( this.$(".fechaBaja_year").val() == "null" ){
			this.errors.push({ errType: app.RVC_ERR_VALID, errField: "fechaBaja" });
		}
		if(this.errors.length > 0)
			return false;
		else
			return true;
	}
	
});

app.RevocadosView = Backbone.View.extend({
	el: '#divLgRevocados',
	matriculaUrl: 'http://localhost:8080/amibRegistro/revocacion/obtenerSustentantePorMatricula',
	
	initialize: function( initialRevocados, matriculaUrl ){
		this.matriculaUrl = matriculaUrl;
		this.collection = new app.Revocados(initialRevocados);
		this.render();
		
		this.listenTo( this.collection, 'add', this.renderElement );
		
		this.listenTo( this.collection, 'add', this.renderHiddenData );
		this.listenTo( this.collection, 'change', this.renderHiddenData );
		this.listenTo( this.collection, 'remove', this.renderHiddenData );
		this.listenTo( this.collection, "reset", this.renderHiddenData );
	},
	
	events: {
		'click .add':'agregarNuevoRevocado'
	},
	
	render: function(){
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
	},
	renderElement: function(item){
		console.log("paso aqui");
		var revocadoView = new app.RevocadoView({model:item});
		//this.$( revocadoView.render().el ).prependTo( '.newElementAction' );
		//$(revocadoView.render().el).prependTo('#divRevocadosNewElement');
		//this.$el.prepend( revocadoView.render().el );
		this.$(".newElementAction").before( revocadoView.render().el );
		
		var context = this;
		$('html, body').animate({
			'scrollTop': context.$('.newElementAction').offset().top - 150
		}, 'fast');
	},
	renderHiddenData: function(){
		var busyCount = 0;
		var readyCount = 0;
		this.collection.forEach( function(item){
			if(item.getState() != app.RVC_SHOW){
				busyCount = busyCount + 1;
			}
			else{
				readyCount = readyCount + 1;
			}
		}
		, this);

		$("#hdnRevocadosWidgetBusyCount").val( busyCount );
		$("#hdnRevocadosWidgetCount").val( readyCount );
	},
	
	agregarNuevoRevocado: function(e){
		e.preventDefault();
		
		var revocado = new app.Revocado();
		revocado.setNewState();
		
		this.collection.add(revocado);
	}
});