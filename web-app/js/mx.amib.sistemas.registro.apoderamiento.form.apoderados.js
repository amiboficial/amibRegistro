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
		nombreCompleto: "",
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
	tagName: 'div',
	className: 'list-group-item',
	
	state: app.APODERADOS_READY,
	errorBusqueda: false,
	msgErrorBusqueda: "",
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
		'click .add','agregarApoderable',
		'click .submit':'submit',
		'click .edit':'edit',
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		if(this.getState() == app.APODERADOS_READY){
			//hablitar todos los campos
			this.enableFields();
			this.enableSubmitDisableEdit();
			
			//si hay algun error, renderea errores correspondiente
			if(this.errorBusqueda){
				this.$('.msgErrorBusqueda').text(this.msgErrorInstituciones);
				this.$('.errorBusqueda').show();
			}
			if(this.errorValidacion){
				this.$('.msgErrorValidacion').text(this.msgErrorValidacion);
				this.$('.errorValidacion').show();
			}
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
		this.$(".numeroMatriculaBuscar").prop( "disable", true );
		this.$(".add").prop( "disable", true );
		this.$(".delete").prop( "disable", true );
	},
	enableFields: function(){
		this.$(".numeroMatriculaBuscar").prop( "disable", false );
		this.$(".add").prop( "disable", false );
		this.$(".delete").prop( "disable", false );
	},
	enableSubmitDisableEdit: function() {
		this.$(".submit").prop( "disable", false );
		this.$(".edit").prop( "disable", true );
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop( "disable", true );
		this.$(".edit").prop( "disable", false );
	},
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	//Cambios en status de errores
	setErrorBusqueda: function(msgErrorBusqueda){
		this.errorBusqueda = true;
		this.msgErrorBusqueda = msgErrorBusqueda;
	},
	clearErrorBusqueda: function(){
		this.errorBusqueda = false;
		this.msgErrorBusqueda = "";
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
		else{
			//carga a un apoderableGetUrl
			$.ajax({
				url: view.apoderableGetUrl, 
				beforeSend: function(xhr){
					view.clearErrorBusqueda();
					view.setProcessing();
				},
				data: { numeroMatricula:numeroMatricula }
			}).done( function(data){
				if(data.status == "OK"){
					//si encontro el apoderado
					view.model = new app.Apoderado();
					view.model.set("numeroMatricula",data.object.sustentante.numeroMatricula);
					view.model.set("nombreCompleto",data.object.sustentante.nombre + " " + data.object.sustentante.primerApellido + " " + data.object.sustentante.segundoApellido);
					view.model.set("nombreFigura",data.object.certificacion.varianteFigura.nombre);
					view.model.set("nombreVarianteFigura",data.object.certificacion.varianteFigura.nombreFigura);
					view.model.set("idCertificacion",data.object.certificacion.id);
					
				}
				else if(data.status == "NOT_FOUND"){
					//no encontrado
					
				}
				else{
					//error alguno
					
				}
			} );
		}
	},
	agregarApoderable: function(){
		
	},
	submit: function(e){
		e.preventDefault();
		//El modelo ya se encuentra en objeto, solo procedera a validar la información
		console.log("HACIENDO SUBMIT");
		if( this.validate() ){
			console.log("LOS DATOS FUERON VALIDOS");
			this.setValidated();
		}
		else{
			this.setReady();
		}
	},
	edit: function(e){
		e.preventDefault();
		this.setReady();
	},
	
	//funciones adicionales
	validate: function(){
		return true;
	},
});