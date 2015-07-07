var app = app || {};

app.APODERADOS_READY = 0;
app.APODERADOS_VALIDATED = 1;
app.APODERADOS_PROC = 2;

app.APODERADOS_ERRMSG_NOAPO = "";
app.APODERADOS_ERRMSG_NOTFOUND = "";
app.APODERADOS_ERRMSG_ALREADY = "";

app.Apoderado = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		nombreCompletoSustentante: "",
		nombreFigura: "",
		nombreVarianteFigura: "",
		idCertificacion: -1
	}
});

app.Apoderados = Backbone.Collection.extend({
	model: app.Apoderado
});

app.ApoderadoView = Backbone.View.extend({
	tagname: 'div',
	className: 'list-group-item',
	template: _.template( $('#apoderado').html() ),
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .delete':'deleteApoderado'
	},
	
	deleteApoderado: function(e){
		e.preventDefault();
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	}
});

app.ApoderadosView = Backbone.View.extend({
	checkId: -1,
	el: '#divApoderados',
	
	state: app.APODERADOS_READY,
	errorNumeroMatriculaBuscar: false,
	msgErrorNumeroMatriculaBuscar: "",
	errorValidacion: false,
	msgErrorValidacion: app.APODERADOS_ERRMSG_NOAPO,
	
	apoderableGetUrl: "",
	
	template: _.template( $('#apoderados').html() ),
	
	initialize: function( initialCollection ){
		this.collection = initialCollection;
		this.render();
		this.listenTo( this.collection, 'add', this.renderElement );
	},
	
	events: {
		'change .numeroMatriculaBuscar':'buscarApoderable',
		'click .add','add',
		'click .submit':'submit',
		'click .edit':'edit',
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		if(this.getState() == app.APODERADOS_READY){
			//hablitar todos los campos
			this.enableFields();
			this.enableSubmitDisableEdit();
		}
		else if(this.getState() == app.APODERADOS_PROC){
			this.disableFields();
		}
		else if(this.getState() == app.APODERADOS_VALIDATED){
			this.disableFields();
			this.disableSubmitEnableEdit();
		}
	},
	renderElement: function(item){
		var elementView =  new app.ApoderadoView({model:item});
		this.$(".listaApoderados").append( elementView.render().el );
	},
	clearErrorsOnFields: function(){
		//TODO: LIMPIA LA MARCA CON "ROJITO" DE LOS CAMPOS CON ERROR
	},
	showErrorsOnFields: function(){
		//TODO: MARCA CON "ROJITO" LOS CAMPOS CON ERROR
	},
	
	disableFields: function(){
	},
	enableFields: function(){	
	},
	enableSubmitDisableEdit: function() {
	},
	disableSubmitEnableEdit: function(){
	},
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	//Cambios en status de errores
	setErrorNumeroMatriculaBuscar: function(msgErrorNumeroMatriculaBuscar){
		this.errorNumeroMatriculaBuscar = true;
		this.msgErrorNumeroMatriculaBuscar = msgErrorNumeroMatriculaBuscar;
	},
	clearErrorNumeroMatriculaBuscar: function(){
		this.errorNumeroMatriculaBuscar = false;
		this.msgErrorNumeroMatriculaBuscar = "";
	},
	hasErrorValidacion: function(){
		return this.errorValidacion;
	},
	setErrorValidacion: function(){
		this.errorValidacion = true;
	},
	clearErrorValidacion: function(){
		this.errorValidacion = false;
	},
	
	//Cambios de estado con rendereo consecuente
	setReady: function(){
		this.state = app.APODERADOS_READY;
		this.trigger("stateChange","READY",this.checkId);
		this.render();
	},
	setProcessing: function(){
		this.state = app.APODERADOS_PROC;
		this.render();
	},
	setValidated: function(){
		this.state = app.APODERADOS_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
		this.render();
	},
	
	//Seteo de URLs para peticiones AJAX
	setApoderableGetUrl: function(apoderableGetUrl){
		this.apoderableGetUrl = apoderableGetUrl;
	},
	
	//callbacks
	buscarApoderable: function(){
		var view = this;
		var numericRegEx = /^[0-9]{1,10}$/;

		var numeroMatricula = $(".numeroMatriculaBuscar").val().trim();

		if( !numericRegEx.test(numeroMatricula) ){
			//console.log("NO PASO LA 1ERA VALIDACION");
			this.setErrorNotario(app.PODER_ERRMSG_NUMNOTARIO_NOVALID);
			view.setReady();
		}
	},
	submit: function(){
	},
	edit: function(){
	},
	
	//funciones adicionales
	validate: function(){
	},
});