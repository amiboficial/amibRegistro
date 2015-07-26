var app = app || {};

app.CERTDICT_CERT_ST_OPEN = 0;
app.CERTDICT_CERT_ST_VALIDATED = 1;

app.CERTDICT_ST_ENTREGA_NOAPLICA = 0;
app.CERTDICT_ST_ENTREGA_ENTREGO = 1;
app.CERTDICT_ST_ENTREGA_NOENTREGO = 2;
app.CERTDICT_ST_ENTREGA_MSGS = ["No aplica","Entregó","No entregó"];

app.CERTDICT_ERR_SUBMITVAL = "EXP_CERTDICT_ERR_SUBMITVAL";

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

app.CertificacionViewModel = Backbone.Model.extend({ 
	defaults: { 
		grailsId: -1,
		
		nombreFigura: "XXXXXXXXXXXXXXXX",
		nombreVarianteFigura: "XXXXXXXXXXXXXXXXXXXXXXX",
		tipoAutorizacionFigura: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		
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
		obsEntHistorialInforme: "AAAAAAA",
		statusEntCartaRec: -1,
		obsEntCartaRec: "AAAAAAAAAAAAAAAA",
		statusConstBolVal: -1,
		obsConstBolVal: "AAAAAAAAAAAAAAAAAA",
		
		errFechaObtencion: false,
		errStatusEntHistorialInforme: false,
		errStatusConstBolVal: false
	}
});

app.CertificacionView = Backbone.View.extend({
	checkId: -1,
	el: '#divCert',
	state: app.CERTDICT_CERT_ST_OPEN,
	template:  _.template( $('#certificacionDictamen').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.render();
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	renderErrMessages: function(){
		if(this.model.get("showErrMessages") == true){
			this.$(".errorMessagesContainer").html("");
			_.each(this.model.get("viewErrMessages"),function(item){
				this.$(".errorMessagesContainer").append(item + "<br/>");
			},this );
			this.$(".validationErrorMessage").show();
		}
		else{
			this.$(".validationErrorMessage").hide();
		}
	},
	
	renderErrFechaObtencion: function(){
		if(this.model.get("errFechaObtencion") == true){
			this.$(".div-fechaObtencion").addClass("has-error");
		}
		else{
			this.$(".div-fechaObtencion").removeClass("has-error");
		}
	},
	
	renderErrStatusEntHistorialInforme: function(){
		if(this.model.get("errStatusEntHistorialInforme") == true){
			this.$(".div-statusEntHistorialInforme").addClass("has-error");
		}
		else{
			this.$(".div-statusEntHistorialInforme").removeClass("has-error");
		}
	},
	
	renderErrStatusConstBolVal: function(){
		if(this.model.get("errStatusConstBolVal") == true){
			this.$(".div-statusConstBolVal").addClass("has-error");
		}
		else{
			this.$(".div-statusConstBolVal").removeClass("has-error");
		}
	},
	
	//métodos indicados para cambiar estatus
	setOpenState: function(){
		this.state = app.CERTDICT_CERT_ST_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
		this.render();
	},
	setValidatedState: function(){
		this.state = app.CERTDICT_CERT_ST_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
		this.render();
	},
	
	//métodos para cambiar el identificador de elemento en checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},
	
	//métodos para habilitar y deshabilitar campos
	disableFields: function(){
		/*this.$(".field").prop( "disabled", true );
		this.$(".update").prop( "disabled", true );
		this.$(".cancelEdit").prop( "disabled", true );
		this.$(".save").prop( "disabled", true );
		this.$(".cancelNew").prop( "disabled", true );
		this.$(".edit").prop( "disabled", true );
		this.$(".delete").prop( "disabled", true );
		this.$(".editElement").prop( "disabled", true );
		this.$(".add").prop( "disabled", true );*/
	},
	enableFields: function(){
		/*this.$(".field").prop( "disabled", false );
		this.$(".update").prop( "disabled", false );
		this.$(".cancelEdit").prop( "disabled", false );
		this.$(".save").prop( "disabled", false );
		this.$(".cancelNew").prop( "disabled", false );
		this.$(".edit").prop( "disabled", false );
		this.$(".delete").prop( "disabled", false );
		this.$(".editElement").prop( "disabled", false );
		this.$(".add").prop( "disabled", false );*/
	},
	enableSubmitDisableEdit: function() {
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", true );
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", false );
	},
	
	//validacion y errores
	errorValidacion: false,
	msgErrorValidacion: app.EXP_PUES_ERR_SUBMITVAL,
	msgsErrorValidacion: [],
	hasErrorValidacion: function(){
		return this.errorValidacion;
	},
	setErrorValidacion: function(msgError){
		this.errorValidacion = true;
		this.msgsErrorValidacion.push(msgError);
		this.renderErrMessages();
	},
	clearErrorValidacion: function(){
		this.errorValidacion = false;
		this.msgsErrorValidacion = new Array();
		this.renderErrMessages();
	},
	
	//eventos
	events: {
		'change .field': 'updateModel',
		'click .submit': 'establecerDatos',
		'click .edit': 'habilitarEdicionDatos'
	},
	
	//hace actuliazacíon "automatica" al modelo
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();		
		this.model.set(fieldName,fieldValue);
	},
	
	establecerDatos: function(e){
		e.preventDefault();
	},
	
	habilitarEdicionDatos: function(e){
		e.preventDefault();
	}
	
});