var app = app || {}

app.EXP_GRAL_OPEN = 0;
app.EXP_GRAL_VALIDATED = 1;
app.EXP_GRAL_PROCESSING = 2;

app.EXP_GRAL_ERRMSG_NONOMBRE = "EXP_GRAL_ERRMSG_NONOMBRE";
app.EXP_GRAL_ERRMSG_NOAP1 = "EXP_GRAL_ERRMSG_NOAP1";
app.EXP_GRAL_ERRMSG_NOFECNAC = "EXP_GRAL_ERRMSG_NOFECNAC";
app.EXP_GRAL_ERRMSG_NOGEN = "EXP_GRAL_ERRMSG_NOGEN";
app.EXP_GRAL_ERRMSG_NORFC = "EXP_GRAL_ERRMSG_NORFC";
app.EXP_GRAL_ERRMSG_NOCURP = "EXP_GRAL_ERRMSG_NOCURP";
app.EXP_GRAL_ERRMSG_NOVALRFC = "EXP_GRAL_ERRMSG_NOVALRFC";
app.EXP_GRAL_ERRMSG_NOVALCURP = "EXP_GRAL_ERRMSG_NOVALCURP";
app.EXP_GRAL_ERRMSG_NOEMAIL = "EXP_GRAL_ERRMSG_NOEMAIL";
app.EXP_GRAL_ERRMSG_NOVALEMAIL = "EXP_GRAL_ERRMSG_NOVALEMAIL";
app.EXP_GRAL_ERRMSG_NOEDOCIVIL = "EXP_GRAL_ERRMSG_NOEDOCIVIL";
app.EXP_GRAL_ERRMSG_NONIVEST = "EXP_GRAL_ERRMSG_NONIVEST";
app.EXP_GRAL_ERRMSG_NONAL = "EXP_GRAL_ERRMSG_NONAL";

app.Generales = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		fechaNacimientoDay: -1,
		fechaNacimientoMonth: -1,
		fechaNacimientoYear: -1,
		genero: "M",
		rfc: "",
		curp: "",
		correoElectronico: "",
		profesion: "",
		calidadMigratoria: "",
		
		nacionalidad: 117,
		nivelEstudios: -1,
		estadoCivil: -1,
	},
});

app.GeneralesView = Backbone.View.extend({
	checkId: -1,
	el: '#divGen',
	ajaxUrl: '',
	state: app.EXP_GRAL_OPEN,
	errors: [],
	selectedId: -1,
	template: _.template( $('#expedienteDatosGenerales').html() ),
	
	initialize: function( initialObject ){
		this.model = initialObject;
		this.render();
		this.renderNoErrorMsgs();
	},
	
	events: {
		'click .submit':'establecerDatos',
		'click .edit':'habilitarEdicionDatos'
	},

	//métodos para rendereo

	render: function(){
		
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$(".nombre").val(this.model.get("nombre"));
		this.$(".primerApellido").val(this.model.get("primerApellido"));
		this.$(".segundoApellido").val(this.model.get("segundoApellido"));
		this.$(".fechaNacimientoDay").val(this.model.get("fechaNacimientoDay"));
		this.$(".fechaNacimientoMonth").val(this.model.get("fechaNacimientoMonth"));
		this.$(".fechaNacimientoYear").val(this.model.get("fechaNacimientoYear"));
		this.$(".rfc").val(this.model.get("rfc"));
		this.$(".curp").val(this.model.get("curp"));
		this.$(".correoElectronico").val(this.model.get("correoElectronico"));
		if(this.model.get("genero") == "M"){
			this.$(".generoM").prop( "checked", true );
			//this.$(".generoF").prop( "checked", false );
		}
		else{
			//this.$(".generoM").prop( "checked", false );
			this.$(".generoF").prop( "checked", true );
		}
		this.$(".estadoCivil").val(this.model.get("estadoCivil"));
		this.$(".nivelEstudios").val(this.model.get("nivelEstudios"));
		this.$(".nacionalidad").val(this.model.get("nacionalidad"));
		this.$(".profesion").val(this.model.get("profesion"));
		this.$(".calidadMigratoria").val(this.model.get("calidadMigratoria"));
		
		if(this.state == app.EXP_GRAL_OPEN){
			this.$(".nombre").prop( "disabled", false );
			this.$(".primerApellido").prop( "disabled", false );
			this.$(".segundoApellido").prop( "disabled", false );
			
			this.$(".fechaNacimientoDay").prop( "disabled", false );
			this.$(".fechaNacimientoMonth").prop( "disabled", false );
			this.$(".fechaNacimientoYear").prop( "disabled", false );
			
			this.$(".rfc").prop( "disabled", false );
			this.$(".curp").prop( "disabled", false );
			this.$(".correoElectronico").prop( "disabled", false );
			
			this.$(".generoM").prop( "disabled", false );
			this.$(".generoF").prop( "disabled", false );
			
			this.$(".profesion").prop( "disabled", false );
			this.$(".calidadMigratoria").prop( "disabled", false );
			
			this.$(".estadoCivil").prop( "disabled", false );
			this.$(".nivelEstudios").prop( "disabled", false );
			this.$(".nacionalidad").prop( "disabled", false );
			
			this.$(".submit").prop( "disabled", false );
			this.$(".edit").prop( "disabled", true );
		}
		
		else if(this.state == app.EXP_GRAL_VALIDATED){
			this.$(".nombre").prop( "disabled", true );
			this.$(".primerApellido").prop( "disabled", true );
			this.$(".segundoApellido").prop( "disabled", true );
			
			this.$(".fechaNacimientoDay").prop( "disabled", true );
			this.$(".fechaNacimientoMonth").prop( "disabled", true );
			this.$(".fechaNacimientoYear").prop( "disabled", true );
			
			this.$(".rfc").prop( "disabled", true );
			this.$(".curp").prop( "disabled", true );
			this.$(".correoElectronico").prop( "disabled", true );
			
			this.$(".generoM").prop( "disabled", true );
			this.$(".generoF").prop( "disabled", true );
			
			this.$(".profesion").prop( "disabled", true );
			this.$(".calidadMigratoria").prop( "disabled", true );
			
			this.$(".estadoCivil").prop( "disabled", true );
			this.$(".nivelEstudios").prop( "disabled", true );
			this.$(".nacionalidad").prop( "disabled", true );
			
			this.$(".submit").prop( "disabled", true );
			this.$(".edit").prop( "disabled", false );
		}
		
		//revisar estado
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
		this.state = app.EXP_GRAL_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_GRAL_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},

	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},

	//métodos de control

	establecerDatos: function(){
		this.validarDatos();
		
		if(this.errors.length > 0){
			this.renderErrorMsgs();
		}
		else{

			//captura lso datos al modelo
			this.model.set("nombre",$.trim(this.$(".nombre").val()));
			this.model.set("primerApellido",$.trim(this.$(".primerApellido").val()));
			this.model.set("segundoApellido",$.trim(this.$(".segundoApellido").val()));
			this.model.set("fechaNacimientoDay",$.trim(this.$(".fechaNacimientoDay").val()));
			this.model.set("fechaNacimientoMonth",$.trim(this.$(".fechaNacimientoMonth").val()));
			this.model.set("fechaNacimientoYear",$.trim(this.$(".fechaNacimientoYear").val()));
			this.model.set("rfc",$.trim(this.$(".rfc").val()));
			this.model.set("curp",$.trim(this.$(".curp").val()));
			this.model.set("correoElectronico",$.trim(this.$(".correoElectronico").val()));
			this.model.set("genero",this.$('input[name=ZXhwZWRpZW50ZS5nZW5lcm8]:checked').val());
			this.model.set("profesion",$.trim(this.$(".profesion").val()));
			this.model.set("calidadMigratoria",$.trim(this.$(".calidadMigratoria").val()));
			this.model.set("estadoCivil",$.trim(this.$(".estadoCivil").val()));
			this.model.set("nivelEstudios",$.trim(this.$(".nivelEstudios").val()));
			this.model.set("nacionalidad",$.trim(this.$(".nacionalidad").val()));

			this.setValidatedState();
			this.render();
		}
	},
	
	habilitarEdicionDatos: function(){
		this.setOpenState();
		this.render();
	},
	
	validarDatos: function(){
		var emailPattern = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
		this.errors = new Array();
		if($.trim(this.$(".nombre").val()).length == 0){
			this.errors.push(app.EXP_GRAL_ERRMSG_NONOMBRE);
		}
		if($.trim(this.$(".primerApellido").val()).length == 0){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOAP1);
		}
		if(this.$(".fechaNacimientoDay").val() <= 0 || this.$(".fechaNacimientoMonth").val() <= 0 || this.$(".fechaNacimientoYear").val() <= 0){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOFECNAC);
		}
		if($.trim(this.$(".rfc").val()).length < 13){
			this.errors.push(app.EXP_GRAL_ERRMSG_NORFC);
		}
		if($.trim(this.$(".curp").val()).length < 18){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOCURP);
		}
		if($.trim(this.$(".correoElectronico").val()).length == 0){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOEMAIL);
		}
		if(emailPattern.test($.trim(this.$(".correoElectronico").val())) == false){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOVALEMAIL);
		}
		if(this.$(".estadoCivil").val() == -1){
			this.errors.push(app.EXP_GRAL_ERRMSG_NOEDOCIVIL);
		}
		if(this.$(".nivelEstudios").val() == -1){
			this.errors.push(app.EXP_GRAL_ERRMSG_NONIVEST);
		}
		if(this.$(".nacionalidad").val() == -1){
			this.errors.push(app.EXP_GRAL_ERRMSG_NONAL);
		}
	},
});
