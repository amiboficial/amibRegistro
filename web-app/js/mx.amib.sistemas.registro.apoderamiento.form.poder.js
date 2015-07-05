var app = app || {};

app.PODER_READY = 0;
app.PODER_VALIDATED = 1;
app.PODER_PROC_INST = 2;
app.PODER_PROC_NOT = 3;

app.PODER_ERRMSG_INSTIT_REQUESTERROR = "PODER_ERRMSG_INSTIT_REQUESTERROR";

app.PODER_ERRMSG_NUMNOTARIO_NOVALID = "PODER_ERRMSG_NUMNOTARIO_NOVALID";
app.PODER_ERRMSG_NOTARIO_NOTFOUND = "PODER_ERRMSG_NOTARIO_NOTFOUND";
app.PODER_ERRMSG_NOTARIO_REQUESTERROR = "PODER_ERRMSG_NOTARIO_REQUESTERROR";

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
		institucionList: [],
		
		idNotario: -1,
		numeroNotariaNotario: "",
		idEntidadFederativaNotario: -1,
		notarioList: [],
		
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
	
	state: app.PODER_READY,
	errorInstituciones: false,
	msgErrorInstituciones: "",
	errorNotario: false,
	msgErrorNotario: "",
	errorValidacion: false,
	msgErrorValidacion: "",
	validationErrorMsgs: [],
	validationErrorDivs: [],
	
	grupoFinancieroGetUrl: "",
	notarioFindUrl: "",
	
	template: _.template( $('#poder').html() ),
	
	initialize: function( initialModel ){
		this.model = initialModel;
		this.render();
	},
	
	events: {
		'change .field':'updateModel',
		'change .idGrupoFinanciero':'cargarInstituciones',
		'change .numeroNotariaNotario':'cargarNotarios',
		'change .idEntidadFederativaNotario':'cargarNotarios',
		'click .submit':'establecerDatos',
		'click .edit':'habilitarEdicionDatos',
	},
	
	render: function(){
	
		//rendering inicial del modelo
		var clonedModel = JSON.parse( JSON.stringify(this.model) ); //se obtiene una "copia" el modelo debido a que al setear el template se sobreescribirá por los callbacks "change"
		this.$el.html( this.template( this.model.toJSON() ) ); //se setea el modelo al template
		$(".idEntidadFederativaNotario").val( clonedModel.idEntidadFederativaNotario ); //se setean los valores que no se pudieron setear por template
		$(".idGrupoFinanciero").val( clonedModel.idGrupoFinanciero ); //se setean los valores que no se pudieron setear por template
		
		//oculta todos los mensajes de error
		this.$('.errorInstituciones').hide();
		this.$('.errorNotario').hide();
		this.$('.errorValidacion').hide();
		
		//oculta todos los mensajes de procesamiento
		this.$('.procInstituciones').hide();
		this.$('.procNotario').hide();
		
		if(this.state == app.PODER_READY){
			//habilitar todos los campos
			this.enableFields();
			//solo dejar "validar" habilitado
			//si hay algun error, renderea errores correspondientes y validación
			
			if(this.errorInstituciones){
				this.$('.msgErrorInstituciones').text(this.msgErrorInstituciones);
				this.$('.errorInstituciones').show();
			}
			
			if(this.errorNotario){
				this.$('.msgErrorNotario').text(this.msgErrorNotario);
				this.$('.errorNotario').show();
			}
			
			if(this.errorValidacion){
				this.$('.msgErrorValidacion').text(this.msgErrorValidacion);
				this.$('.errorValidacion').show();
			}
			
			this.enableSubmitDisableEdit();
		}
		else if(this.state == app.PODER_PROC_INST || this.state == app.PODER_PROC_NOT){
			//desahibilitar todos campos
			this.disableFields();
			//dependiendo del tipo de proceso, mostrar mensaje
			if(this.state == app.PODER_PROC_INST){
				this.$('.procInstituciones').show();
			}
			else if(this.state == app.PODER_PROC_NOT){
				this.$('.procNotario').show();
			}
		}
		else if(this.state == app.PODER_VALIDATED){
			//deshabilitar todos los campos
			this.disableFields();
			//solo dejar "editar" habilidado
			this.disableSubmitEnableEdit();
		}
	},
	
	disableFields: function(){
		this.$(".idGrupoFinanciero").attr("disabled","disabled");
		this.$(".idInstitucion").attr("disabled","disabled");
		this.$(".representanteLegalNombre").attr("disabled","disabled");
		this.$(".representanteLegalApellido1").attr("disabled","disabled");
		this.$(".representanteLegalApellido2").attr("disabled","disabled");
		this.$(".numeroEscritura").attr("disabled","disabled");
		this.$(".fechaApoderamiento_day").attr("disabled","disabled");
		this.$(".fechaApoderamiento_month").attr("disabled","disabled");
		this.$(".fechaApoderamiento_year").attr("disabled","disabled");
		this.$(".numeroNotariaNotario").attr("disabled","disabled");
		this.$(".idEntidadFederativaNotario").attr("disabled","disabled");
		this.$(".nombreCompletro").attr("disabled","disabled");
		
		this.$(".submit").attr("disabled","disabled");
		this.$(".edit").attr("disabled","disabled");
		
	},
	enableFields: function(){
		this.$(".idGrupoFinanciero").removeAttr("disabled");
		this.$(".idInstitucion").removeAttr("disabled");
		this.$(".representanteLegalNombre").removeAttr("disabled");
		this.$(".representanteLegalApellido1").removeAttr("disabled");
		this.$(".representanteLegalApellido2").removeAttr("disabled");
		this.$(".numeroEscritura").removeAttr("disabled");
		this.$(".fechaApoderamiento_day").removeAttr("disabled");
		this.$(".fechaApoderamiento_month").removeAttr("disabled");
		this.$(".fechaApoderamiento_year").removeAttr("disabled");
		this.$(".numeroNotariaNotario").removeAttr("disabled");
		this.$(".idEntidadFederativaNotario").removeAttr("disabled");
		this.$(".nombreCompletro").removeAttr("disabled");
		
		this.$(".submit").removeAttr("disabled");
		this.$(".edit").removeAttr("disabled");
	},
	enableSubmitDisableEdit: function(){
		this.$(".submit").attr("disabled","disabled");
		this.$(".edit").attr("disabled","disabled");
		this.$(".submit").removeAttr("disabled");		
	},
	disableSubmitEnableEdit: function(){
		this.$(".submit").attr("disabled","disabled");
		this.$(".edit").attr("disabled","disabled");
		this.$(".edit").removeAttr("disabled");
	},
	
	//actualiza el modelo ante cualquier cambio en campos indicados con clase field
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		this.model.set(fieldName,fieldValue);
		console.log("actualizando modelo...");
		//console.dir(this.model.attributes);
		//this.$(ev.currentTarget).val(this.model.get(fieldName));
	},
	
	//Cambios en status de errores
	setErrorNotario: function(msgErrorNotario){
		this.errorNotario = true;
		this.msgErrorNotario = msgErrorNotario;
		//this.render();
	},
	clearErrorNotario: function(){
		this.errorNotario = false;
		this.msgErrorNotario = "";
		//this.render();
	},
	setErrorInstitucioneses: function(msgErrorInstituciones){
		this.errorInstituciones = true;
		this.msgErrorInstituciones = msgErrorInstituciones;
	},
	clearErrorInstituciones: function(){
		this.errorInstituciones = false;
		this.msgErrorInstituciones = "";
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
	setProcessingInstituciones: function(){
		this.state = app.PODER_PROC_INST;
		this.render();
	},
	setValidated: function(){
		this.state = app.PODER_VALIDATED;
		this.render();
	},
	
	//Seteo de URLs para peticiones AJAX
	setGrupoFinancieroGetUrl: function(grupoFinancieroGetUrl){
		this.grupoFinancieroGetUrl = grupoFinancieroGetUrl;
	},
	setNotarioFindUrl: function(notarioFindUrl){
		this.notarioFindUrl = notarioFindUrl;
	},
	
	cargarInstituciones: function(){
		var view = this;
		var idGrupoFinanciero = $(".idGrupoFinanciero").val();
		
		if(idGrupoFinanciero>0){
			//Carga las instituciones
			$.ajax({
				url: view.grupoFinancieroGetUrl,
				beforeSend: function( xhr ){
					console.log("PASO B4 SNND CON AL URL " + view.grupoFinancieroGetUrl);
					view.clearErrorInstituciones();
					//setea status a procesando
					view.setProcessingInstituciones();
				},
				data: { idGrupoFinanciero:idGrupoFinanciero }
			}).done( function( data ) {
					//console.log("PASO EL DONE");
					//console.dir(data);
					//setea posibles errores y status a ready
					if(data.status == "OK"){
						if(data.object.length > 0){
							//rellena el select con instituciones de la entidad federativa
							view.model.set('institucionList',data.object);
						}
						else{
							//deja solo la opcion "seleccionar"
							view.model.set('institucionList',new Array());
							//view.setErrorNotario(app.PODER_ERRMSG_INSTIT_REQUESTERROR);
						}
					}
					else{
						//deja solo la opcion "seleccionar"
						view.model.set('institucionList',new Array());
						view.setErrorInstitucioneses(app.PODER_ERRMSG_INSTIT_REQUESTERROR);
					}
					
					view.setReady();
				}
			);
		}
		else{
			//Limpia el campo
			view.model.set('institucionList',new Array());
			view.setReady();
		}
	},
	
	cargarNotarios: function(){
		
		var view = this;
		var numericRegEx = /[0-9]{1,10}/;
	
		var numeroNotariaNotario = $(".numeroNotariaNotario").val().trim();
		var idEntidadFederativaNotario = $(".idEntidadFederativaNotario").val();
		
		if( !numericRegEx.test(numeroNotariaNotario) && idEntidadFederativaNotario > 0 ){
			//console.log("NO PASO LA 1ERA VALIDACION");
			this.setErrorNotario(app.PODER_ERRMSG_NUMNOTARIO_NOVALID);
			view.setReady();
		}
		else if( idEntidadFederativaNotario > 0  ){
			//console.log("PASO LA 1ERA VALIDACION");
			$.ajax({
				url: view.notarioFindUrl,
				beforeSend: function( xhr ){
					console.log("PASO B4 SNND CON AL URL " + view.notarioFindUrl);
					view.clearErrorNotario();
					//setea status a procesando
					view.setProcessingNotario();
				},
				data: { idEntidadFederativa:idEntidadFederativaNotario, numeroNotaria:numeroNotariaNotario }
			}).done( function( data ) {
					//console.log("PASO EL DONE");
					//console.dir(data);
					//setea posibles errores y status a ready
					if(data.status == "OK"){
						if(data.object.count > 0){
							//rellena el select con instituciones de la entidad federativa
							view.model.set('notarioList',data.object.list);
						}
						else{
							//deja solo la opcion "seleccionar"
							view.model.set('notarioList',new Array());
							view.setErrorNotario(app.PODER_ERRMSG_NOTARIO_NOTFOUND);
						}
					}
					else{
						//deja solo la opcion "seleccionar"
						view.model.set('notarioList',new Array());
						view.setErrorNotario(app.PODER_ERRMSG_NOTARIO_REQUESTERROR);
					}
					
					view.setReady();
				}
			);
		}
		
	},
	
	submit: function(){},
	edit: function(){}
	
});


