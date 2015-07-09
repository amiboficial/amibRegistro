var app = app || {};

app.APODERADOS_READY = 0;
app.APODERADOS_VALIDATED = 1;
app.APODERADOS_PROC = 2;

app.APODERADOS_ERRMSG_NOAPOINLIST = "APODERADOS_ERRMSG_NOAPOINLIST";

app.APODERADOS_ERRMSG_NMINVALID = "APODERADOS_ERRMSG_NMINVALID"; //NUMERO DE MATRICULA NO VALIDO
app.APODERADOS_ERRMSG_NOTFOUND = "APODERADOS_ERRMSG_NOTFOUND"; //NO ENCONTRADO
app.APODERADOS_ERRMSG_EPROC = "APODERADOS_ERRMSG_EPROC"; //ERROR AL PROCESAR LA PETICION
app.APODERADOS_ERRMSG_ALREADY = "APODERADOS_ERRMSG_ALREADY ";

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
	msgErrorValidacion: app.APODERADOS_ERRMSG_NOAPOINLIST,
	
	//modelLoaded: false,
	
	apoderableGetUrl: "",
	
	template: _.template( $('#apoderados').html() ),
	
	initialize: function( initialCollection ){
		this.collection = initialCollection;
		this.model = new app.Apoderado();
		this.render();
		this.listenTo( this.collection, 'add', this.renderElement );
	},
	
	events: {
		'change .numeroMatriculaBuscar':'buscarApoderable',
		'click .add':'agregarApoderable',
		'click .submit':'submit',
		'click .edit':'edit',
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		
		//oculta todos los mensajes de error
		this.$('.errorBusqueda ').hide();
		this.$('.errorValidacion').hide();
		
		//oculta todos los mensajes de procesamiento
		this.$('.procBusqueda').hide();
		
		//rendera cada uno de los apoderados
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		
		if(this.getState() == app.APODERADOS_READY){
			//hablitar todos los campos
			this.enableFields();
			this.enableSubmitDisableEdit();
			
			//si hay algun error, renderea errores correspondiente
			if(this.errorBusqueda){
				this.$('.add').prop("disable",true);
				this.$('.msgErrorBusqueda').text(this.msgErrorBusqueda);
				this.$('.errorBusqueda').show();
			}
			if(this.errorValidacion){
				this.$('.msgErrorValidacion').text(this.msgErrorValidacion);
				this.$('.errorValidacion').show();
			}
			
			//si el modelo de busqueda tiene una matricula menor que 0, entonces
			//no se ha cargado ningun modelo y se quedo el modelo vacion, por tanto, agregar esta
			//deshabilitado
			//así mismo, si hubo un error en la busqueda se deshabilita
			if(this.model.get("numeroMatricula") <= 0 || this.hasErrorBusqueda() ) {
				this.$('.add').prop("disabled",true);
			}
			
			this.enableSubmitDisableEdit();
		}
		else if(this.getState() == app.APODERADOS_PROC){
			this.$('.procBusqueda').show();
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
		this.$(".numeroMatriculaBuscar").prop( "disabled", true );
		this.$(".add").prop( "disabled", true );
		this.$(".delete").prop( "disabled", true );
	},
	enableFields: function(){
		this.$(".numeroMatriculaBuscar").prop( "disabled", false );
		this.$(".add").prop( "disabled", false );
		this.$(".delete").prop( "disabled", false );
	},
	enableSubmitDisableEdit: function() {
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", true );
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", false );
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
	hasErrorBusqueda: function(){
		return this.errorBusqueda;
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
	getState: function(){
		return this.state;
	},
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
			view.model = new app.Apoderado();
			this.setErrorBusqueda(app.APODERADOS_ERRMSG_NMINVALID);
			this.setReady();
		}
		else{
			//carga a un apoderableGetUrl
			$.ajax({
				url: view.apoderableGetUrl, 
				beforeSend: function(xhr){
				
					//En lo que se carga el apoderado, muetra el número de matricula
					//a buscar, dado que este modelo es rendereado cuando se cambia
					//al estado de processing
					view.model = new app.Apoderado();
					view.model.set("numeroMatricula",numeroMatricula);
					
					view.clearErrorBusqueda();
					view.setProcessing();
				},
				data: { numeroMatricula:numeroMatricula }
			}).done( function(data){
				if(data.status == "OK"){
				
					//revisa si la matricula del apoderado ya se encuentra en la coleccion
					view.collection.each(function(item){
						if(item.get("numeroMatricula") == data.object.sustentante.numeroMatricula){
							view.setErrorBusqueda(app.APODERADOS_ERRMSG_ALREADY);
						}
					},view);
				
					//si encontro el apoderado
					view.model = new app.Apoderado();
					//view.model.set("id",data.object.sustentante.numeroMatricula);
					view.model.set("numeroMatricula",data.object.sustentante.numeroMatricula);
					view.model.set("nombreCompleto",data.object.sustentante.nombre + " " + data.object.sustentante.primerApellido + " " + data.object.sustentante.segundoApellido);
					view.model.set("nombreFigura",data.object.certificacion.varianteFigura.nombre);
					view.model.set("nombreVarianteFigura",data.object.certificacion.varianteFigura.nombreFigura);
					view.model.set("idCertificacion",data.object.certificacion.id);
					view.setReady();
				}
				else if(data.status == "NOT_FOUND"){
					//no encontrado
					view.model = new app.Apoderado();
					view.setErrorBusqueda(app.APODERADOS_ERRMSG_NOTFOUND);
					view.setReady();
				}
				else{
					//error alguno
					view.model = new app.Apoderado();
					view.setErrorBusqueda(app.APODERADOS_ERRMSG_EPROC);
					view.setReady();
				}
			} );
		}
	},
	agregarApoderable: function(){
		//se agrega el modelo a la colleccion
		this.collection.add(this.model);
		this.render();
	},
	submit: function(e){
		e.preventDefault();
		//El modelo ya se encuentra en objeto, solo procedera a validar la información
		console.log("HACIENDO SUBMIT");
		if( this.validate() ){
			console.log("LOS DATOS FUERON VALIDOS");
			
			//limpiar los errores que hayas sido causado por la busqueda
			this.clearErrorBusqueda();
			this.clearErrorValidacion();
			//limpiar el modelo usado en la busqueda
			this.model = new app.Apoderado();
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
		//checar que haya al menos un apoderado en la collections
		if(this.collection.size() < 1){
			this.setErrorValidacion();
		}
		return !this.hasErrorValidacion();;
	},
});