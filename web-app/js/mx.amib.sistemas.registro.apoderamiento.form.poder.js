var app = app || {};

app.PODER_READY = 0;
app.PODER_VALIDATED = 1;
app.PODER_PROC_INST = 2;
app.PODER_PROC_NOT = 3;

app.PODER_ERRMSG_NUMNOTARIO_NOVALID = "PODER_ERRMSG_NUMNOTARIO_NOVALID";
app.PODER_ERRMSG_NOTARIO_NOTFOUND = "PODER_ERRMSG_NOTARIO_NOTFOUND";

app.PODER_ERRMSG_NOGPOFIN = "PODER_ERRMSG_NOGPOFIN";
app.PODER_ERRMSG_NONOTARIO = "PODER_ERRMSG_NONOTARIO";
app.PODER_ERRMSG_NONUMESC = "PODER_ERRMSG_NONUMESC";
app.PODER_ERRMSG_NORLNOM = "PODER_ERRMSG_NORLNOM";
app.PODER_ERRMSG_NORLAP1 = "PODER_ERRMSG_NORLAP1";
app.PODER_ERRMSG_NOFECAP = "PODER_ERRMSG_NOFECAP";
app.PODER_ERRMSG_NODOCRESP = "PODER_ERRMSG_NODOCRESP";

app.Poder = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		version: 1,
		
		idGrupoFinanciero: -1,
		
		idInstitucion: -1,
		
		idNotario: -1,
		numeroNotariaNotario: "",
		idEntidadFederativaNotario: -1,
		
		fechaApoderamiento_day: -1,
		fechaApoderamiento_month: -1,
		fechaApoderamiento_year: -1,
		
		numeroEscritura: "",
		representanteLegalNombre: "",
		representanteLegalApellido1: "",
		representanteLegalApellido2: "",
	}
});

app.PoderView = Backbone.View.extend({
	checkId: -1,
	el: '#divPoder',
	ajaxDocumentoRespaldoUrl: '',
	ajaxNotario: '',
	
	state: app.EXP_GRAL_OPEN,
	errorInstituciones: false,
	msgErrorInstituciones: "",
	errorNotario: false,
	msgErrorNotario: "",
	errorValdacion: false,
	msgErrorValdacion: "",
	validationErrorMsgs: [],
	
	template: _.template( $('#poder').html() ),
	
	initialize: function( initialModel ){
		this.model = initialModel;
		this.render();
	},
	
	events: {
		'change .field':'updateModel',
		'change .numeroNotariaNotario':'cargarNotarios',
		'change .idEntidadFederativaNotario':'cargarNotarios',
		'click .submit':'establecerDatos',
		'click .edit':'habilitarEdicionDatos',
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		if(this.state == app.PODER_READY){
		
		}
		else if(this.state == app.PODER_PROC_INST || this.state == app.PODER_PROC_NOT){
		
		}
		else if(this.state == app.PODER_VALIDATED){
		
		}
	},
	
	//actualiza el modelo ante cualquier cambio en campos indicados con clase field
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		this.model.set(fieldName,fieldValue);
		console.log("actualizando modelo...");
		console.dir(this.model.attributes);
		this.$(ev.currentTarget).val(this.model.get(fieldName));
	},
	
	//Cambios en status de errores
	setErrorNotario: function(msgErrorNotario){
		this.errorNotario = true;
		this.msgErrorNotario = msgErrorNotario;
		this.render();
	},
	
	//Cambios de estado con rendereo consecuente
	setReady: function(){
		this.state = app.PODER_READY;
		this.render();
	},
	setProcessingNotario: function(){
		this.state = app.PODER_PROC_NOT;
		this.render();
	},
	setProcessingInstitucion: function(){
		this.state = app.PODER_PROC_INST;
		this.render();
	},
	setValidated: function(){
		this.state = app.PODER_VALIDATED;
		this.render();
	},
	
	cargarNotarios: function(){
		
		var numericRegEx = /[0-9]{1,10}/;
	
		var numeroNotariaNotario = $(".numeroNotariaNotario").val().trim();
		var idEntidadFederativaNotario = $(".idEntidadFederativaNotario").val();
		
		if( !numericRegEx.test(numeroNotariaNotario) && idEntidadFederativaNotario > 0 ){
			this.setErrorNotario(app.PODER_ERRMSG_NUMNOTARIO_NOVALID);
		}
		else if( idEntidadFederativaNotario > 0  ){
			/*$.ajax({
				url: "",
				beforeSend: function( xhr ){
					//setea status a procesando
					
				}
			}).done({ function( data ) {
					//setea posibles errores y status a ready
				}
			});*/
		}
		
	},
	
	submit: function(){},
	edit: function(){},
	
	disableFields: function(){ },
	enableFields: function(){ }
	
});


