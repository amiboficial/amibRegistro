var app = app || {};

app.EXP_REG_OPEN = 1;
app.EXP_REG_VALIDATED = 2;
app.EXP_REG_PROCESSING = 3;

app.EXP_REG_ERRMSG_NOFECCERT = "EXP_REG_ERRMSG_NOFECCERT";
app.EXP_REG_ERRMSG_NOVALFECCERT = "EXP_REG_ERRMSG_NOVALFECCERT";
app.EXP_REG_ERRMSG_NOINST = "EXP_REG_ERRMSG_NOINST";
app.EXP_REG_ERRMSG_NOFECLAB = "EXP_REG_ERRMSG_NOFECLAB";
app.EXP_REG_ERRMSG_NOVALFECLAB = "EXP_REG_ERRMSG_NOVALFECLAB";
app.EXP_REG_ERRMSG_NOPUESTOACT = "EXP_REG_ERRMSG_NOPUESTOACT";

app.Registro = Backbone.Model.extend({
	defaults: {
		_printName: "registro",
		nombrePuesto: "",
		fechaInicioDay: -1,
		fechaInicioMonth: -1,
		fechaInicioYear: -1,
		idInstitucion: -1,
		idVarianteFigura: -1,
		descVarianteFigura: "",
		descAutorizacion: "",
		fechaObtencionDay: -1,
		fechaObtencionMonth: -1,
		fechaObtencionYear: -1,
	},
});

app.RegistroView = Backbone.View.extend({
	checkId: -1,
	el: '#divReg',
	state: app.EXP_REG_OPEN,
	errors: [],
	template: _.template( $('#expedienteDatosRegistro').html() ),
	
	initialize: function( initialObject ){
		this.model = initialObject;
		this.render();
		this.renderNoErrorMsgs();
	},
	
	events: {
		'click .submit':'establecerDatos',
		'click .edit':'habilitarEdicionDatos'
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );

		this.$(".fechaCertificacionDay").val(this.model.get("fechaObtencionDay"));
		this.$(".fechaCertificacionMonth").val(this.model.get("fechaObtencionMonth"));
		this.$(".fechaCertificacionYear").val(this.model.get("fechaObtencionYear"));
		this.$(".intermediario").val(this.model.get("idInstitucion"));

		this.$(".fechaLaboraDay").val(this.model.get("fechaInicioDay"));
		this.$(".fechaLaboraMonth").val(this.model.get("fechaInicioMonth"));
		this.$(".fechaLaboraYear").val(this.model.get("fechaInicioYear"));
		this.$(".puestoActual").val(this.model.get("nombrePuesto"));

		//this.$(".idVarianteFigura").val(this.model.get("idVarianteFigura"));
		//this.$(".descVarianteFigura").val(this.model.get("descVarianteFigura"));
		//this.$(".descAutorizacion").val(this.model.get("descAutorizacion"));

		if(this.state == app.EXP_REG_OPEN) {
			this.$(".fechaCertificacionDay").prop( "disabled", false );
			this.$(".fechaCertificacionMonth").prop( "disabled", false );
			this.$(".fechaCertificacionYear").prop( "disabled", false );
			this.$(".intermediario").prop( "disabled", false );

			this.$(".fechaLaboraDay").prop( "disabled", false );
			this.$(".fechaLaboraMonth").prop( "disabled", false );
			this.$(".fechaLaboraYear").prop( "disabled", false );
			this.$(".puestoActual").prop( "disabled", false );

			this.$(".submit").prop( "disabled", false );
			this.$(".edit").prop( "disabled", true );
		}
		else{
			this.$(".fechaCertificacionDay").prop( "disabled", true );
			this.$(".fechaCertificacionMonth").prop( "disabled", true );
			this.$(".fechaCertificacionYear").prop( "disabled", true );
			this.$(".intermediario").prop( "disabled", true );

			this.$(".fechaLaboraDay").prop( "disabled", true );
			this.$(".fechaLaboraMonth").prop( "disabled", true );
			this.$(".fechaLaboraYear").prop( "disabled", true );
			this.$(".puestoActual").prop( "disabled", true );

			this.$(".submit").prop( "disabled", true );
			this.$(".edit").prop( "disabled", false );
		}
		return this;
	},
	
	renderErrorMsgs: function(){
		this.$(".validationErrorMessage").show();
		this.$(".errorMessagesContainer").text("");
		_.each(this.errors,function(item){
			this.$(".errorMessagesContainer").append(item);
			this.$(".errorMessagesContainer").append("<br/>");
		},this);
	},
	
	renderNoErrorMsgs: function(){
		this.$(".validationErrorMessage").hide();
	},

	//métodos para setear estatus

	setOpenState: function(){
		this.state = app.EXP_REG_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_REG_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},

	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},

	establecerDatos: function(){
		this.validarDatos();
		if(this.errors.length > 0){
			this.renderErrorMsgs();
		}
		else {
			this.model.set("fechaObtencionDay",$.trim(this.$(".fechaCertificacionDay").val()));
			this.model.set("fechaObtencionMonth",$.trim(this.$(".fechaCertificacionMonth").val()));
			this.model.set("fechaObtencionYear",$.trim(this.$(".fechaCertificacionYear").val()));
			this.model.set("idInstitucion",$.trim(this.$(".intermediario").val()));

			this.model.set("fechaInicioDay",$.trim(this.$(".fechaLaboraDay").val()));
			this.model.set("fechaInicioMonth",$.trim(this.$(".fechaLaboraMonth").val()));
			this.model.set("fechaInicioYear",$.trim(this.$(".fechaLaboraYear").val()));
			this.model.set("nombrePuesto",$.trim(this.$(".puestoActual").val()));

			this.setValidatedState();
			this.render();
		}
	},
	
	habilitarEdicionDatos: function(){
		this.setOpenState();
		this.render();
	},
	
	validarDatos: function(){
		this.errors = new Array();
		if(this.$(".fechaCertificacionDay").val() <= 0 || this.$(".fechaCertificacionMonth").val() <= 0 || this.$(".fechaCertificacionYear").val() <= 0){
			this.errors.push(app.EXP_REG_ERRMSG_NOFECCERT);
		}
		if(this.$(".intermediario").val() == -1){
			this.errors.push(app.EXP_REG_ERRMSG_NOINST);
		}
		if(this.$(".fechaLaboraDay").val() <= 0 || this.$(".fechaLaboraMonth").val() <= 0 || this.$(".fechaLaboraYear").val() <= 0){
			this.errors.push(app.EXP_REG_ERRMSG_NOFECLAB);
		}
		if($.trim(this.$(".puestoActual").val()).length == 0){
			this.errors.push(app.EXP_REG_ERRMSG_NOPUESTOACT);
		}
	},
	
	
});