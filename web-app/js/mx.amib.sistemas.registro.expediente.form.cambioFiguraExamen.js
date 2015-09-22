var app = app || {};


//CONSTANTES

app.RCA_MV_EXAMEN = 1;
app.RCA_MV_PUNTOS = 2;
app.RCA_MV_EXPERIENCIA = 3;

app.RCA_MV_READY = 0;
app.RCA_MV_VALIDATED = 1;

app.CAMFIGEX_CERT_ST_OPEN = 0;
app.CAMFIGEX_CERT_ST_VALIDATED = 1;

app.CAMFIGEX_ST_ENTREGA_NOAPLICA = 0;
app.CAMFIGEX_ST_ENTREGA_ENTREGO = 1;
app.CAMFIGEX_ST_ENTREGA_NOENTREGO = 2;
app.CAMFIGEX_ST_ENTREGA_MSGS = ["No aplica","Entregó","No entregó"];

app.CAMFIGEX_ERR_SUBMITVAL = "CAMFIGEX_ERR_SUBMITVAL"; //mensaje a desplegar al haber algun error en un submit

app.CAMFIGEX_ERR_FHOBT_BLANK = "CAMFIGEX_ERR_FHOBT_BLANK";//falta fecha de obtención
app.CAMFIGEX_ERR_ST_EHI_BLANK = "CAMFIGEX_ERR_ST_EHI_BLANK";//falta entrego historial informe
app.CAMFIGEX_ERR_ST_ECR_BLANK = "CAMFIGEX_ERR_ST_ECR_BLANK";//falta entreog carta de recomentacion
app.CAMFIGEX_ERR_ST_CBV_BLANK = "CAMFIGEX_ERR_ST_CBV_BLANK";//falta constancia bolsa de valores

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

app.CertificacionVM = Backbone.Model.extend({ 
	//triggers
	//errorOnValidate,errorsCleaned,dataChanged
	defaults: { 
		grailsId: -1,
		idCertificaionACambiar: -1,
		
		variantesFigura: new Array(),
		//cada elemento debe incluir los siguientes campos
		//id,nombreFigura,nombreVarianteFigura,tipoAutorizacionFigura
		
		nombreFigura: "",
		nombreVarianteFigura: "",
		tipoAutorizacionFigura: "",
		idVarianteFigura: -1,
		
		fechaInicio_day: -1,
		fechaInicio_month: -1,
		fechaInicio_year: -1,
		fechaFin_day: -1,
		fechaFin_month: -1,
		fechaFin_year: -1,
		fechaObtencion_day: -1,
		fechaObtencion_month: -1,
		fechaObtencion_year: -1,
		
		statusEntHistorialInforme: -1,
		obsEntHistorialInforme: "",
		statusEntCartaRec: -1,
		obsEntCartaRec: "",
		statusConstBolVal: -1,
		obsConstBolVal: "",
		
		errValidacion: false,
		errFechaObtencion: false,
		errFechaInicio: false,
		errFechaFin: false,
		errStatusEntHistorialInforme: false,
		errStatusEntCartaRec: false,
		errStatusConstBolVal: false
	},
	
	validate: function(){
		var valid = true;
		var coleccion = this.get('examenVMCollection');
		var seleccionado = null;
		
		var noHayFechaObtencion = (this.get('fechaObtencion_day') == -1 || this.get('fechaObtencion_month') == -1 || this.get('fechaObtencion_year') == -1);
		var noHayFechaInicio = (this.get('fechaInicio_day') == -1 || this.get('fechaInicio_month') == -1 || this.get('fechaInicio_year') == -1);
		var noHayFechaFin = (this.get('fechaFin_day') == -1 || this.get('fechaFin_month') == -1 || this.get('fechaFin_year') == -1);
		var noHayStatusEntHistorialInforme = (this.get('statusEntHistorialInforme') == -1);
		var noHayStatusEntCartaRec = (this.get('statusEntCartaRec') == -1);
		var noHayStatusConstBolVal = (this.get('statusConstBolVal') == -1);
		
		this.cleanValidationErrors();
		
		if(noHayFechaObtencion){
			this.set('errFechaObtencion',true);
			valid = false;
		}
		if(noHayFechaInicio){
			this.set('errFechaInicio',true);
			valid = false;
		}
		if(noHayFechaFin){
			this.set('errFechaFin',true);
			valid = false;
		}
		if(noHayStatusEntHistorialInforme){
			this.set('errStatusEntHistorialInforme',true);
			valid = false;
		}
		if(noHayStatusEntCartaRec){
			this.set('errStatusEntCartaRec',true);
			valid = false;
		}
		if(noHayStatusConstBolVal){
			this.set('errStatusConstBolVal',true);
			valid = false;
		}
		
		if(!valid){
			this.set('errValidacion',true);
			this.trigger('errorOnValidate');
		}
		
		return valid; //TODO: Validar que haya un validado
	},
	cleanValidationErrors: function(){
		this.set({
			errValidacion: false,
			errFechaObtencion: false,
			errFechaInicio: false,
			errFechaFin: false,
			errStatusEntHistorialInforme: false,
			errStatusEntCartaRec: false,
			errStatusConstBolVal: false
		});
		this.trigger('errorsCleaned');
	},
	setDatosDeExamenSeleccionado: function(datos){
		var varianteFigura = null;
		var variantesFigura = this.get('variantesFigura');
		
		this.cleanValidationErrors();
		
		for(var i=0; i<variantesFigura.length; i++){
			if(variantesFigura[i].id == datos.idVarianteFigura){
				varianteFigura = variantesFigura[i];
				break;
			}
		}
		
		if(varianteFigura != null){
			this.set({
				nombreFigura: varianteFigura.nombreFigura,
				nombreVarianteFigura: varianteFigura.nombreVarianteFigura,
				tipoAutorizacionFigura: varianteFigura.tipoAutorizacionFigura,
				
				idVarianteFigura: datos.idVarianteFigura,
				fechaInicio_day: datos.fechaInicio_day,
				fechaInicio_month: datos.fechaInicio_month,
				fechaInicio_year: datos.fechaInicio_year,
				fechaFin_day: datos.fechaFin_day,
				fechaFin_month: datos.fechaFin_month,
				fechaFin_year: datos.fechaFin_year,
				fechaObtencion_day: datos.fechaObtencion_day,
				fechaObtencion_month: datos.fechaObtencion_month,
				fechaObtencion_year: datos.fechaObtencion_year
			});
			this.trigger('dataChanged');
		}
	}
	
});

app.CertificacionView = Backbone.View.extend({
	model: null,
	template: _.template( $('#datosCertificacionViewTemplate').html() ),
	
	initialize: function(options){
		
		if( options.model != null ){
			console.log("PASO AQUI options.model != null  ");
			this.model = options.model;
		}
		else{
			this.model = new app.CertificacionVM();
		}
		
		//this.render(); el render lo llama la vista padre
		this.listenTo( this.model , 'errorOnValidate', this.renderError );
		this.listenTo( this.model , 'errorsCleaned', this.renderError );
		this.listenTo( this.model , 'dataChanged', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		this.$('.div-fechaObtencion').removeClass('has-error');
		this.$('.div-fechaInicio').removeClass('has-error');
		this.$('.div-fechaFin').removeClass('has-error');
		this.$('.div-statusEntHistorialInforme').removeClass('has-error');
		this.$('.div-statusEntCartaRec').removeClass('has-error');
		this.$('.div-statusConstBolVal').removeClass('has-error');
		this.$('.alert-errValidacion').hide();
		
		if( this.model.get('errValidacion') == true ){
			this.$('.alert-errValidacion').show();
		}
		if( this.model.get('errFechaObtencion') == true ){
			this.$('.div-fechaObtencion').addClass('has-error');
		}
		if( this.model.get('errFechaInicio') == true ){
			this.$('.div-fechaInicio').addClass('has-error');
		}
		if( this.model.get('errFechaFin') == true ){
			this.$('.div-fechaFin').addClass('has-error');
		}
		if( this.model.get('errStatusEntHistorialInforme') == true ){
			this.$('.div-statusEntHistorialInforme').addClass('has-error');
		}
		if( this.model.get('errStatusEntCartaRec') == true ){
			this.$('.div-statusEntCartaRec').addClass('has-error');
		}
		if( this.model.get('errStatusConstBolVal') == true ){
			this.$('.div-statusConstBolVal').addClass('has-error');
		}
	},
	
	events: {
		'change .field': 'updateModel',
	},
	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	}
});

app.CamFigExVM = Backbone.Model.extend({
	defaults:{
		opcionExamenVM : null, //app.OpcionExamenVM
		certificacionVM : null,
		
		errorEnSeleccionExamen: false,
		errorEnDatosCertificacion: false
	},
	
	validate: function(){
		var valid = true;
		
		this.cleanValidationErrors();
		
		if(!this.get('opcionExamenVM').validate()){
			this.set('errorEnSeleccionExamen',true);
			this.trigger('errorOnValidate');
			valid = false;
		}
		
		if(!this.get('certificacionVM').validate()){
			this.set('errorEnSeleccionExamen',true);
			this.trigger('errorOnValidate');
			valid = false;
		}
		
		return valid;
	},
	cleanValidationErrors: function(){
		this.set({
			errorEnSeleccionExamen: false,
			errorEnDatosCertificacion: false
		});
		this.get('opcionExamenVM').cleanValidationErrors();
		this.get('certificacionVM').cleanValidationErrors();
		this.trigger('validationErrorsCleaned',{});
	}
	
});

app.CamFigExView = Backbone.View.extend({
	el: '#divCamFigEx',
	model: null, //app.CamFigExVM
	template: _.template( $('#cambioFiguraExamenViewTemplate').html() ),
	_savedFocus: null,
	
	initialize: function(options){
		
		//INICIALIZACIÓN DE LOS VIEWMODELS
		this.model = new app.CamFigExVM();
				
		this.model.set('opcionExamenVM', new app.OpcionExamenVM() );
		if(options.examenVMCollection != null){
			this.model.get('opcionExamenVM').set('examenVMCollection', options.examenVMCollection);
		}
		this.model.set('certificacionVM', new app.CertificacionVM() );
		if(options.variantesFigura != null){
			this.model.get('certificacionVM').set('variantesFigura', options.variantesFigura);
			this.model.get('certificacionVM').listenTo( this.model.get('opcionExamenVM').get('examenVMCollection'), 'examenSeleccionado', this.model.get('certificacionVM').setDatosDeExamenSeleccionado ); 
		}
		
		//CALLBACKS DE CAMBIOS EN EL MODELO
		this.listenTo( this.model, 'validationErrorsCleaned', this.renderError ); 
		this.listenTo( this.model, 'errorOnValidate', this.renderError ); 
		this.listenTo( this, 'stateChange', this.renderStateChange );
		
		this.listenTo( this, 'stateChange', this.propagateStateChange );
		//LLAMADO AL RENDER
		this.render();
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderOpcionExamen();
		this.renderDatosCertificacion();
		this.renderError();
		this.renderStateChange();
		
		if(this._savedFocus != null){
			this.$('.' + this._savedFocus).focus();
			this._savedFocus = null;
		}
		return this;
	},
	renderOpcionExamen: function(){
		var view = null;
		
		view = new app.OpcionExamenView( { model:this.model.get('opcionExamenVM') } );
		this.$('.div-opcionExamenVM').html( view.render().el );
		
		return view;
	},
	renderDatosCertificacion: function(){
		var view = null;
		
		view = new app.CertificacionView( { model:this.model.get('certificacionVM') } );
		this.$('.div-datosCertificacionVM').html( view.render().el );
		
		return view;
	},
	renderError: function(){

	},
	renderStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.$('input').prop('disabled',false);
			this.$('button').prop('disabled',false);
			this.$('select').prop('disabled',false);
			this.$('.submit').prop('disabled',false);
			this.$('.edit').prop('disabled',true);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.$('input').prop('disabled',true);
			this.$('button').prop('disabled',true);
			this.$('select').prop('disabled',true);
			this.$('.submit').prop('disabled',true);
			this.$('.edit').prop('disabled',false);
		}
	},
	
	propagateStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.model.get('opcionExamenVM').set('disabled',false);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.model.get('opcionExamenVM').set('disabled',true);
		}
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
	
	events: {
		'change .field': 'updateModel',
		'click .submit': 'submit',
		'click .edit': 'edit'
	},
	
	//VIEW STATUS
	//estatus de vista
	state: app.RCA_MV_READY,
	getState: function(){
		return this.state;
	},
	setReady: function(){
		this.state = app.RCA_MV_READY;
		this.trigger("stateChange","READY",this.checkId);
	},
	setValidated: function(){
		this.state = app.RCA_MV_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},
	
	//MÉTODO PARA EL BINDEAO DE DATOS	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	},
	saveFocus: function(fieldName){
	},
	submit: function(ev){
		ev.preventDefault();
		if( this.model.validate() ){
			this.setValidated();
		}
	},
	edit: function(ev){
		ev.preventDefault();
		this.setReady();
	}
	
});