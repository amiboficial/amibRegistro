//En este componente TODOS los cambios en los campos automáticamente entran al modelo

var app = app || {};

app.PODER_READY = 0;
app.PODER_VALIDATED = 1;
app.PODER_PROC_INST = 2;
app.PODER_PROC_NOT = 3;
app.PODER_PROC_NUMESC = 4;

//Estatus para el campo validacionDisponiblidadNumeroEscritura
app.PODER_NUMESC_EMPTY = 0;
app.PODER_NUMESC_AVAILABLE = 1;
app.PODER_NUMESC_NON_AVAILABLE = 2;
app.PODER_NUMESC_NONCHECKED = 3;
app.PODER_NUMESC_CHECKING = 4;

app.PODER_ERRMSG_NUMESC_NON_AVAILABLE = "PODER_ERRMSG_NUMESC_NON_AVAILABLE";
app.PODER_ERRMSG_NUMESC_NONCHECKED = "PODER_ERRMSG_NUMESC_NONCHECKED";

app.PODER_ERRMSG_INSTIT_REQUESTERROR = "PODER_ERRMSG_INSTIT_REQUESTERROR";

app.PODER_ERRMSG_NUMNOTARIO_NOVALID = "PODER_ERRMSG_NUMNOTARIO_NOVALID";
app.PODER_ERRMSG_NOTARIO_NOTFOUND = "PODER_ERRMSG_NOTARIO_NOTFOUND";
app.PODER_ERRMSG_NOTARIO_REQUESTERROR = "PODER_ERRMSG_NOTARIO_REQUESTERROR";

app.PODER_ERRMSG_NUMESCREP = "PODER_ERRMSG_NONUMESCREP"; //El número de escritura no ha sido validado correctamente

app.PODER_ERRMSG_NOVALID = "PODER_ERRMSG_NOVALID";
app.PODER_ERRMSG_NOGPOFIN = "PODER_ERRMSG_NOGPOFIN";
app.PODER_ERRMSG_NORLNOM = "PODER_ERRMSG_NORLNOM";
app.PODER_ERRMSG_NORLAP1 = "PODER_ERRMSG_NORLAP1";
app.PODER_ERRMSG_NUMESC_NOVALID = "PODER_ERRMSG_NONUMESC_NOVALID";
app.PODER_ERRMSG_NONUMESC = "PODER_ERRMSG_NONUMESC";
app.PODER_ERRMSG_NOFECAP = "PODER_ERRMSG_NOFECAP";
app.PODER_ERRMSG_NONOTARIO = "PODER_ERRMSG_NONOTARIO";
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
		dispNumeroEscritura: app.PODER_NUMESC_EMPTY,
		representanteLegalNombre: "",
		representanteLegalApellido1: "",
		representanteLegalApellido2: "",
	}
});

app.PoderView = Backbone.View.extend({
	checkId: -1,
	el: '#divPoder',
	
	state: app.PODER_READY,
	errorInstituciones: false,
	msgErrorInstituciones: "",
	errorNotario: false,
	msgErrorNotario: "",
	errorValidacion: false,
	msgErrorValidacion: app.PODER_ERRMSG_NOVALID,
	validationErrorMsgs: [],
	validationErrorFields: [],
	
	grupoFinancieroGetUrl: "",
	notarioFindUrl: "",
	isNumeroEscrituraAvailableUrl: "",
	
	template: _.template( $('#poder').html() ),
	
	initialize: function( initialModel ){
		this.model = initialModel;
		this.render();
		
		this.listenTo(this.model, 'change:numeroEscritura', this.valDispNumeroEscritura );
	},
	
	events: {
		'change .field':'updateModel',
		'change .idGrupoFinanciero':'cargarInstituciones',
		'change .numeroNotariaNotario':'cargarNotarios',
		'change .idEntidadFederativaNotario':'cargarNotarios',
		'click .submit':'submit',
		'click .edit':'edit',
	},
	
	render: function(){
	
		//rendering inicial del modelo
		var clonedModel = this.model.toJSON(); //se obtiene una "copia" el modelo debido a que al setear el template se sobreescribirá por los callbacks "change"
		
		this.$el.html( this.template( this.model.toJSON() ) ); //se setea el modelo al template
		
		//se setean los valores que no se pudieron setear por template
		// - por lo general, todos los "select" se han de setear de esta forma
		//console.dir(clonedModel);
		this.$(".idEntidadFederativaNotario").val( clonedModel.idEntidadFederativaNotario );
		this.$(".idGrupoFinanciero").val( clonedModel.idGrupoFinanciero ); 
		this.$(".fechaApoderamiento_day").val( clonedModel.fechaApoderamiento_day );
		this.$(".fechaApoderamiento_month").val( clonedModel.fechaApoderamiento_month );
		this.$(".fechaApoderamiento_year").val( clonedModel.fechaApoderamiento_year );
		//console.dir(clonedModel);
		this.$(".idInstitucion").val( clonedModel.idInstitucion );
		this.$(".idNotario").val( clonedModel.idNotario );
		
		//oculta todos los mensajes de error
		this.$('.errorInstituciones').hide();
		this.$('.errorNotario').hide();
		this.$('.errorValidacion').hide();
		this.$('.errorNumeroEscritura').hide();
		
		//oculta todos los mensajes de procesamiento
		this.$('.procInstituciones').hide();
		this.$('.procNotario').hide();
		this.$('.procNumeroEscritura').hide();
		
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
				
				var msg = "";
				_.each(this.validationErrorMsgs,function(item){
					msg += "<li>" + item + "</li>";
				},this);
				this.$('.validationErrorMsgs').html(msg);
				
				this.$('.errorValidacion').show();
			}
			
			if(this.model.get("dispNumeroEscritura") == app.PODER_NUMESC_NON_AVAILABLE){
				this.$('.msgErrorNumeroEscritura').text(app.PODER_ERRMSG_NUMESC_NON_AVAILABLE);
				this.$('.errorNumeroEscritura').show();
			}
			
			if(this.model.get("dispNumeroEscritura") == app.PODER_NUMESC_NONCHECKED){
				this.$('.msgErrorNumeroEscritura').text(app.PODER_ERRMSG_NUMESC_NONCHECKED);
				this.$('.errorNumeroEscritura').show();
			}
			
			this.enableSubmitDisableEdit();
		}
		else if(this.state == app.PODER_PROC_INST || this.state == app.PODER_PROC_NOT || this.state == app.PODER_PROC_NUMESC){
			//desahibilitar todos campos
			this.disableFields();
			//dependiendo del tipo de proceso, mostrar mensaje
			if(this.state == app.PODER_PROC_INST){
				this.$('.procInstituciones').show();
			}
			else if(this.state == app.PODER_PROC_NOT){
				this.$('.procNotario').show();
			}
			else if(this.state == app.PODER_PROC_NUMESC){
				this.$('.procNumeroEscritura').show();
			}
		}
		else if(this.state == app.PODER_VALIDATED){
			//deshabilitar todos los campos
			this.disableFields();
			//solo dejar "editar" habilidado
			this.disableSubmitEnableEdit();
		}
	},
	clearErrorsOnFields: function(){
		//TODO: LIMPIA LA MARCA CON "ROJITO" DE LOS CAMPOS CON ERROR
	},
	showErrorsOnFields: function(){
		//TODO: MARCA CON "ROJITO" LOS CAMPOS FALTANTES
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
		this.$(".idNotario ").attr("disabled","disabled");
		
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
		this.$(".idNotario ").removeAttr("disabled");
		
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
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
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
	hasErrorValidacion: function(){
		return this.errorValidacion;
	},
	setErrorValidacion: function(field, fieldErrorMsg){
		this.errorValidacion = true;
		this.validationErrorFields.push(field);
		this.validationErrorMsgs.push(fieldErrorMsg);
	},
	clearErrorValidacion: function(){
		this.errorValidacion = false;
		this.validationErrorMsgs = new Array();
		this.validationErrorFields = new Array();
	},
	
	
	//Cambios de estado con rendereo consecuente
	setReady: function(){
		this.state = app.PODER_READY;
		this.trigger("stateChange","READY",this.checkId);
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
	setProcessingNumeroEscritura: function(){
		this.state = app.PODER_PROC_NUMESC;
		this.render();
	},
	setValidated: function(){
		this.state = app.PODER_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
		this.render();
	},
	
	//Seteo de URLs para peticiones AJAX
	setGrupoFinancieroGetUrl: function(grupoFinancieroGetUrl){
		this.grupoFinancieroGetUrl = grupoFinancieroGetUrl;
	},
	setNotarioFindUrl: function(notarioFindUrl){
		this.notarioFindUrl = notarioFindUrl;
	},
	setIsNumeroEscrituraAvailableUrl: function(isNumeroEscrituraAvailableUrl){
		this.isNumeroEscrituraAvailableUrl = isNumeroEscrituraAvailableUrl;
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
							view.model.set('idInstitucion',-1);
						}
						else{
							//deja solo la opcion "seleccionar"
							
							view.model.set('institucionList',new Array());
							//view.setErrorNotario(app.PODER_ERRMSG_INSTIT_REQUESTERROR);
						}
					}
					else{
						//deja solo la opcion "seleccionar"
						view.model.set('idInstitucion',-1);
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
		var numericRegEx = /^[0-9]{1,10}$/;
	
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
							view.model.set('idNotario',-1);
						}
						else{
							//deja solo la opcion "seleccionar"
							view.model.set('notarioList',new Array());
							view.model.set('idNotario',-1);
							view.setErrorNotario(app.PODER_ERRMSG_NOTARIO_NOTFOUND);
						}
					}
					else{
						//deja solo la opcion "seleccionar"
						view.model.set('notarioList',new Array());
						view.model.set('idNotario',-1);
						view.setErrorNotario(app.PODER_ERRMSG_NOTARIO_REQUESTERROR);
					}
					
					view.setReady();
				}
			);
		}
		
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
	
	//En caso de requerirse, aquí se agregan expresiones regulares
	validate: function(){
		var num10CarExp = /^[0-9]{1,10}$/
		
		this.clearErrorValidacion();
		
		if(this.model.get("idGrupoFinanciero") == -1){
			this.setErrorValidacion("idGrupoFinanciero",app.PODER_ERRMSG_NOGPOFIN);
		}
		if(this.model.get("representanteLegalNombre") == ""){
			this.setErrorValidacion("representanteLegalNombre",app.PODER_ERRMSG_NORLNOM);
		}
		if(this.model.get("representanteLegalApellido1") == ""){
			this.setErrorValidacion("representanteLegalApellido1",app.PODER_ERRMSG_NORLAP1);
		}
		
		if(this.model.get("numeroEscritura") == ""){
			this.setErrorValidacion("numeroEscritura",app.PODER_ERRMSG_NONUMESC);
		}
		//app.PODER_ERRMSG_NUMESC_NOVALID
		else if(num10CarExp.test(this.model.get("numeroEscritura")) == false){
			this.setErrorValidacion("numeroEscritura",app.PODER_ERRMSG_NUMESC_NOVALID);
		}
//		else{
//			//revisa si el numero de matrícula ya fue revisado de disponibilidad
//			if(this.model.get("dispNumeroEscritura") != app.PODER_NUMESC_AVAILABLE){
//				this.setErrorValidacion("numeroEscritura",app.PODER_ERRMSG_NUMESCREP);
//			}
//		}
		
		if(this.model.get("fechaApoderamiento_day") == -1 || this.model.get("fechaApoderamiento_month") == -1 || 
			this.model.get("fechaApoderamiento_year") == -1 ){
			this.setErrorValidacion("fechaApoderamiento",app.PODER_ERRMSG_NOFECAP);
		}
		
		if(this.model.get("idNotario") == -1){
			this.setErrorValidacion("idNotario",app.PODER_ERRMSG_NONOTARIO);
		}
		
		return !this.hasErrorValidacion();
	},
	
	//funciones "privadas"
	
	//valida si el id de escritura esta disponible
	//nota: esta función en syncrona
	_isNumeroEscrituraAvailable: function(){
		var view = this;
		var gresult = false;
		$.ajax({
			url: view.isNumeroEscrituraAvailableUrl + "?numeroEscritura=" + view.model.get("numeroEscritura") ,
			async: false,
			success: function(result){
				if(result.status == "OK")
					gresult = result.object.isNumeroEscrituraAvailable;
			}
		});
		
		if(gresult == true){
			return true;
		}
		else{
			return false;
		}
	},
	
	valDispNumeroEscritura: function(){
		var view = this;
		
		if($.trim(this.model.get("dispNumeroEscritura")) == ""){
			view.model.set("dispNumeroEscritura",app.PODER_NUMESC_EMPTY);
		}
		
		$.ajax({
			url: view.isNumeroEscrituraAvailableUrl + "?numeroEscritura=" + view.model.get("numeroEscritura") ,
			beforeSend: function(){
				view.model.set("dispNumeroEscritura",app.PODER_NUMESC_NONCHECKED);
				view.setProcessingNumeroEscritura();
			},
			success: function(result){
				if(result.status == "OK")
					if(result.object.isNumeroEscrituraAvailable == true)
						view.model.set("dispNumeroEscritura",app.PODER_NUMESC_AVAILABLE);
					else
						view.model.set("dispNumeroEscritura",app.PODER_NUMESC_NON_AVAILABLE);
				else
					view.model.set("dispNumeroEscritura",app.PODER_NUMESC_NONCHECKED);
				view.setReady();
			}
		});
	}
});


