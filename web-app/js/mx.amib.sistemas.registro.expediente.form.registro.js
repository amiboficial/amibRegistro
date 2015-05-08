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
		fechaObtencionDay: -1,
		fechaObtencionDay: -2,
		fechaObtencionDay: -3,
		descAutorizacion: "",
	},
});

app.RegistroView = Backbone.View.extend({
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
	
	establecerDatos: function(){
	},
	
	habilitarEdicionDatos: function(){
		this.state = app.EXP_REG_OPEN;
		this.render();
	},
	
	validarDatos: function(){
		
	},
	
	
});