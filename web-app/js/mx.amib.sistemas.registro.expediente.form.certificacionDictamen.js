var app = app || {};

//CONSTANTES
app.CERTDICT_CERT_ST_OPEN = 0;
app.CERTDICT_CERT_ST_VALIDATED = 1;

app.CERTDICT_ST_ENTREGA_NOAPLICA = 0;
app.CERTDICT_ST_ENTREGA_ENTREGO = 1;
app.CERTDICT_ST_ENTREGA_NOENTREGO = 2;
app.CERTDICT_ST_ENTREGA_MSGS = ["No aplica","Entregó","No entregó"];

app.CERTDICT_ERR_SUBMITVAL = "CERTDICT_ERR_SUBMITVAL"; //mensaje a desplegar al haber algun error en un submit

app.CERTDICT_ERR_FHOBT_BLANK = "CERTDICT_ERR_FHOBT_BLANK";//falta fecha de obtención
app.CERTDICT_ERR_ST_EHI_BLANK = "CERTDICT_ERR_ST_EHI_BLANK";//falta entrego historial informe
app.CERTDICT_ERR_ST_ECR_BLANK = "CERTDICT_ERR_ST_ECR_BLANK";//falta entreog carta de recomentacion
app.CERTDICT_ERR_ST_CBV_BLANK = "CERTDICT_ERR_ST_CBV_BLANK";//falta constancia bolsa de valores

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

//MODELOS PARA/DE VISTA
app.CertificacionViewModel = Backbone.Model.extend({ 
	defaults: { 
		grailsId: -1,
		
		nombreFigura: "NOMBRE DE FIGURA",
		nombreVarianteFigura: "VARIANTE DE LA FIGURA",
		tipoAutorizacionFigura: "TIPO DE AUTORIZACION",
		
		fechaInicio_day: -1,
		fechaInicio_month: -1,
		fechaInicio_year: -1,
		fechaFin_day: -1,
		fechaFin_month: -1,
		fechaFin_year: -1,
		fechaObtencion_day: -1,
		fechaObtencion_month: -1,
		fechaObtencion_year: -1,
		
		
		fechaInicioAutorizacion_day: -1,
		fechaInicioAutorizacion_month: -1,
		fechaInicioAutorizacion_year: -1,
		fechaFinAutorizacion_day: -1,
		fechaFinAutorizacion_month: -1,
		fechaFinAutorizacion_year: -1,
		
		
		statusEntHistorialInforme: -1,
		obsEntHistorialInforme: "",
		statusEntCartaRec: -1,
		obsEntCartaRec: "",
		statusConstBolVal: -1,
		obsConstBolVal: "",
		
		viewErrMessages: new Array(),
		viewMsgErrorValidacion: app.CERTDICT_ERR_SUBMITVAL,
		
		errValidacion: false,
		errFechaObtencion: false,
		errStatusEntHistorialInforme: false,
		errStatusEntCartaRec: false,
		errStatusConstBolVal: false
	}
});

//VISTA
app.CertificacionView = Backbone.View.extend({
	
	//PARÁMETROS DE VISTA
	checkId: -1, //checkid empleado para enlazarlo con el componente de checklist
	el: '#divCert', //id del div donde se "reflejara" esta vista
	state: app.CERTDICT_CERT_ST_OPEN, //status inicial de la vista (abierto por default)
	template:  _.template( $('#certificacionDictamen').html() ), //template de vista
	
	//INICIALIZACIÓN DE VISTA
	initialize: function(options){
		//RECUPERACION DE PARAMETROS DE INICIALIZACION
		this.model = options.model;
		
		//CALLBACKS EN CAMPOS DE "ERROR" DEL MODELO
		this.listenTo( this.model, 'change:errValidacion', this.renderErrMessages );
		this.listenTo( this.model, 'change:errFechaObtencion', this.renderErrFechaObtencion );
		this.listenTo( this.model, 'change:errStatusEntHistorialInforme', this.renderErrStatusEntHistorialInforme );
		this.listenTo( this.model, 'change:errStatusEntCartaRec', this.renderErrStatusEntCartaRec );
		this.listenTo( this.model, 'change:errStatusConstBolVal', this.renderErrStatusConstBolVal );
		
		//RENDER INICIAL
		this.render();
	},
	
	//RENDEREO GENERAL
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		
		//dependiendo del status, los campos se habilitan o deshabilitan
		if(this.state == app.CERTDICT_CERT_ST_OPEN){ //status de abierto a edición
			this.enableFields();
			this.enableSubmitDisableEdit();
		}
		else if(this.state == app.CERTDICT_CERT_ST_VALIDATED){ //status de cerrado ó validado
			this.disableFields();
			this.disableSubmitEnableEdit();
		}
		
		return this;
	},
	//RENDEREO DE ERRORES
	//MENSAJE GENERAL DE ERRORES
	renderErrMessages: function(){
		if(this.model.get("errValidacion") == true){
			this.$(".errorMessagesContainer").html("");
			console.log("esta pasando...");
			_.each(this.model.get("viewErrMessages"), function(item){
				console.log("el item paso por aqui...: " + item);
				this.$(".errorMessagesContainer").append(item + "<br/>");
			},this );
			
			this.$(".validationErrorMessage").show();
		}
		else{
			this.$(".validationErrorMessage").hide();
		}
	},
	//ERROR EN CAMPO
	renderErrFechaObtencion: function(){
		if(this.model.get("errFechaObtencion") == true){
			this.$(".div-fechaObtencion").addClass("has-error");
		}
		else{
			this.$(".div-fechaObtencion").removeClass("has-error");
		}
	},
	//ERROR EN CAMPO
	renderErrStatusEntHistorialInforme: function(){
		if(this.model.get("errStatusEntHistorialInforme") == true){
			this.$(".div-statusEntHistorialInforme").addClass("has-error");
		}
		else{
			this.$(".div-statusEntHistorialInforme").removeClass("has-error");
		}
	},
	//ERROR EN CAMPO
	renderErrStatusEntCartaRec: function(){
		if(this.model.get("errStatusEntCartaRec") == true){
			this.$(".div-statusEntCartaRec").addClass("has-error");
		}
		else{
			this.$(".div-statusEntCartaRec").removeClass("has-error");
		}
	},
	//ERROR EN CAMPO
	renderErrStatusConstBolVal: function(){
		if(this.model.get("errStatusConstBolVal") == true){
			this.$(".div-statusConstBolVal").addClass("has-error");
		}
		else{
			this.$(".div-statusConstBolVal").removeClass("has-error");
		}
	},
	//métodos para habilitar y deshabilitar campos
	disableFields: function(){
		this.$(".field").prop( "disabled", true );
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", true );
	},
	enableFields: function(){
		this.$(".field").prop( "disabled", false );
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", false );
	},
	enableSubmitDisableEdit: function() {
		this.$(".submit").prop( "disabled", false );
		this.$(".edit").prop( "disabled", true );
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").prop( "disabled", true );
		this.$(".edit").prop( "disabled", false );
	},
	//MÉTODOS PARA CAMBIOS DE STATUS DE VISTA
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
	//métodos get/set para el identificador de elemento en checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},
	
	//EVENTOS
	events: {
		'change .field': 'updateModel', //EVENTO QUE BINDEA LOS CAMPOS EL MODELO
		'click .submit': 'establecerDatos', //EVENTO QUE CONTROLA EL STATUS DE LA VISTA, LA CAMBIA A UN ESTADO DE VALIDADO
		'click .edit': 'habilitarEdicionDatos' //EVENTO QUE CONTROLA EL STATUS DE LA VISTA, LA CAMBIA A ESTADO DE ABIERTO
	},
	
	//hace actuliazacíon "automatica" al modelo
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();		
		this.model.set(fieldName,fieldValue);
	},
	establecerDatos: function(e){
		e.preventDefault();
		if(this.validar()){
			this.setValidatedState();
		}
	},
	habilitarEdicionDatos: function(e){
		e.preventDefault();
		this.setOpenState();
	},
	
	//VALIDACIÓN
	//valida los campos cuando se le solicita normalmente a través de "establecerDatos"
	//al validar, setea errores en el modelo
	validar: function(){
		var valid = true;
		
		//Limpia cualquier validación anterior
		this.model.set("viewErrMessages", new Array());
		this.model.set("errValidacion", false);
		this.model.set("errFechaObtencion",false);
		this.model.set("errStatusEntHistorialInforme",false);
		this.model.set("errStatusEntCartaRec",false);
		this.model.set("errStatusConstBolVal",false);
		
		var fechaObtencion_day = this.model.get("fechaObtencion_day");
		var fechaObtencion_month = this.model.get("fechaObtencion_month");
		var fechaObtencion_year = this.model.get("fechaObtencion_year");
		var statusEntHistorialInforme = this.model.get("statusEntHistorialInforme");
		var statusEntCartaRec = this.model.get("statusEntCartaRec");
		var statusConstBolVal = this.model.get("statusConstBolVal");
		
		//valida datos del modelo y setear errores en modelo
		if(fechaObtencion_day == -1 || fechaObtencion_month == -1 || fechaObtencion_year == -1){
			valid = false;
			this.model.set("errFechaObtencion",true);
			this.model.get("viewErrMessages").push(app.CERTDICT_ERR_FHOBT_BLANK);
		}
		if(statusEntHistorialInforme == -1){
			valid = false;
			this.model.set("errStatusEntHistorialInforme",true);
			this.model.get("viewErrMessages").push(app.CERTDICT_ERR_ST_EHI_BLANK);
		}
		if(statusEntCartaRec == -1){
			valid = false;
			this.model.set("errStatusEntCartaRec",true);
			this.model.get("viewErrMessages").push(app.CERTDICT_ERR_ST_ECR_BLANK);
		}
		if(statusConstBolVal == -1){
			valid = false;
			this.model.set("errStatusConstBolVal",true);
			this.model.get("viewErrMessages").push(app.CERTDICT_ERR_ST_CBV_BLANK);
		}
		this.model.set("errValidacion", true);
		
		return valid;
	}
	
});