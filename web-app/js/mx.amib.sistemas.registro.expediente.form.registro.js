var app = app || {};

app.EXP_REG_OPEN = 1;
app.EXP_REG_VALIDATED = 2;
app.EXP_REG_PROCESSING = 3;

app.EXP_REG_ST_NOAPLICA = 0;
app.EXP_REG_ST_ENTREGADO = 1;
app.EXP_REG_ST_NO_ENTREGADO = 2;

app.EXP_REG_ERRMSG_NOFECCERT = "Debe seleccionar un valor en el campo Fecha certificación";
app.EXP_REG_ERRMSG_NOVALFECCERT = "EXP_REG_ERRMSG_NOVALFECCERT";//no se usa
app.EXP_REG_ERRMSG_NOINST = "Debe seleccionar un valor en el campo Intermediario del mercado de valores o asesor de inversión";
app.EXP_REG_ERRMSG_NOFECLAB = "Debe seleccionar un valor en el campo Fecha a partir de la cual labora";
app.EXP_REG_ERRMSG_NOVALFECLAB = "EXP_REG_ERRMSG_NOVALFECLAB";//no se usa
app.EXP_REG_ERRMSG_NOPUESTOACT = "Introduzca datos en el campo Puesto actual";

app.Registro = Backbone.Model.extend({
	defaults: {
		nombrePuesto: "",
		fechaInicioDay: -1,
		fechaInicioMonth: -1,
		fechaInicioYear: (new Date()).getFullYear(),
		idInstitucion: -1,
		
		statusEntManifProtesta: app.EXP_REG_ST_NOAPLICA ,
		obsEntManifProtesta: "",
		statusEntCartaInter: app.EXP_REG_ST_NOAPLICA ,
		obsEntCartaInter: "",
		
		idVarianteFigura: 195, //solo por propositos de test
		descVarianteFigura: "",
		descAutorizacion: "",
		fechaObtencionDay: -1,
		fechaObtencionMonth: -1,
		fechaObtencionYear: -1,
		
		statusEntHistorialInforme: app.EXP_REG_ST_NOAPLICA ,
		obsEntHistorialInforme: "",
		statusEntCartaRec: app.EXP_REG_ST_NOAPLICA ,
		obsEntCartaRec: "",
		statusConstBolVal: app.EXP_REG_ST_NOAPLICA ,
		obsConstBolVal: ""
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

		this.$("input[name=statusEntHistorialInforme][value='" + this.model.get("statusEntHistorialInforme") + "']").prop("checked", true );
		this.$(".obsEntHistorialInforme").val(this.model.get("obsEntHistorialInforme"));
		this.$("input[name=statusEntCartaRec][value='" + this.model.get("statusEntCartaRec") + "']").prop("checked", true );
		this.$(".obsEntCartaRec").val(this.model.get("obsEntCartaRec"));
		this.$("input[name=statusConstBolVal][value='" + this.model.get("statusConstBolVal") + "']").prop("checked", true );
		this.$(".obsConstBolVal").val(this.model.get("obsConstBolVal"));
		
		this.$("input[name=statusEntManifProtesta][value='" + this.model.get("statusEntManifProtesta") + "']").prop("checked", true );
		this.$(".obsEntManifProtesta").val(this.model.get("obsEntManifProtesta"));
		this.$("input[name=statusEntCartaInter][value='" + this.model.get("statusEntCartaInter") + "']").prop("checked", true );
		this.$(".obsEntCartaInter").val(this.model.get("obsEntCartaInter"));

		//this.$(".idVarianteFigura").val(this.model.get("idVarianteFigura"));
		//this.$(".descVarianteFigura").val(this.model.get("descVarianteFigura"));
		//this.$(".descAutorizacion").val(this.model.get("descAutorizacion"));

		if(this.state == app.EXP_REG_OPEN) {
			this.$(".fechaCertificacionDay").prop( "disabled", false );
			this.$(".fechaCertificacionMonth").prop( "disabled", false );
			this.$(".fechaCertificacionYear").prop( "disabled", false );
			this.$(".intermediario").prop( "disabled", false );

			this.$(".statusEntHistorialInforme").prop( "disabled", false );
			this.$(".obsEntHistorialInforme").prop( "disabled", false );
			this.$(".statusEntCartaRec").prop( "disabled", false );
			this.$(".obsEntCartaRec").prop( "disabled", false );
			this.$(".statusConstBolVal").prop( "disabled", false );
			this.$(".obsConstBolVal").prop( "disabled", false );
			
			this.$(".fechaLaboraDay").prop( "disabled", false );
			this.$(".fechaLaboraMonth").prop( "disabled", false );
			this.$(".fechaLaboraYear").prop( "disabled", false );
			this.$(".puestoActual").prop( "disabled", false );

			this.$(".statusEntManifProtesta").prop( "disabled", false );
			this.$(".obsEntManifProtesta").prop( "disabled", false );
			this.$(".statusEntCartaInter").prop( "disabled", false );
			this.$(".obsEntCartaInter").prop( "disabled", false );
			
			this.$(".submit").prop( "disabled", false );
			this.$(".edit").prop( "disabled", true );
		}
		else{
			this.$(".fechaCertificacionDay").prop( "disabled", true );
			this.$(".fechaCertificacionMonth").prop( "disabled", true );
			this.$(".fechaCertificacionYear").prop( "disabled", true );
			this.$(".intermediario").prop( "disabled", true );

			this.$(".statusEntHistorialInforme").prop( "disabled", true );
			this.$(".obsEntHistorialInforme").prop( "disabled", true );
			this.$(".statusEntCartaRec").prop( "disabled", true );
			this.$(".obsEntCartaRec").prop( "disabled", true );
			this.$(".statusConstBolVal").prop( "disabled", true );
			this.$(".obsConstBolVal").prop( "disabled", true );
			
			this.$(".fechaLaboraDay").prop( "disabled", true );
			this.$(".fechaLaboraMonth").prop( "disabled", true );
			this.$(".fechaLaboraYear").prop( "disabled", true );
			this.$(".puestoActual").prop( "disabled", true );

			this.$(".statusEntManifProtesta").prop( "disabled", true );
			this.$(".obsEntManifProtesta").prop( "disabled", true );
			this.$(".statusEntCartaInter").prop( "disabled", true );
			this.$(".obsEntCartaInter").prop( "disabled", true );
			
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

			this.model.set("statusEntHistorialInforme", this.$("input[name='statusEntHistorialInforme']:checked").val() );
			this.model.set("obsEntHistorialInforme", $.trim(this.$(".obsEntHistorialInforme").val()));
			this.model.set("statusEntCartaRec", this.$("input[name='statusEntCartaRec']:checked").val() );
			this.model.set("obsEntCartaRec", $.trim(this.$(".obsEntCartaRec").val()));
			this.model.set("statusConstBolVal", this.$("input[name='statusConstBolVal']:checked").val() );
			this.model.set("obsConstBolVal", $.trim(this.$(".obsConstBolVal").val()));
			
			this.model.set("fechaInicioDay",$.trim(this.$(".fechaLaboraDay").val()));
			this.model.set("fechaInicioMonth",$.trim(this.$(".fechaLaboraMonth").val()));
			this.model.set("fechaInicioYear",$.trim(this.$(".fechaLaboraYear").val()));
			this.model.set("nombrePuesto",$.trim(this.$(".puestoActual").val()));

			this.model.set("statusEntManifProtesta", this.$("input[name='statusEntManifProtesta']:checked").val() );
			this.model.set("obsEntManifProtesta", $.trim(this.$(".obsEntManifProtesta").val()));
			this.model.set("statusEntCartaInter", this.$("input[name='statusEntCartaInter']:checked").val() );
			this.model.set("obsEntCartaInter", $.trim(this.$(".obsEntCartaInter").val()));
			
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