var app = app || {};

app.CHK_GRALES = 0;
app.CHK_TELS = 1;
app.CHK_SEPOMEX = 2;
app.CHK_CERT = 3;
app.CHK_PUES = 4;
app.CHK_REVALCERT = 5;

app.CheckSubmit = Backbone.Model.extend({
	defaults: {
		checkarray: [false,false,false,false,false,false],
		viewsarray: [undefined,undefined,undefined,undefined,undefined,undefined]
	}
});

app.CheckSubmitView = Backbone.View.extend({
	el: '#divCheckSubmit',
	allchecked: false,
	model: new app.CheckSubmit(),

	initialize: function(){
		this.render();
	},

	events: {
		'click .submit': 'submitDatos',
	},

	render: function(){
		var arr = this.model.get("checkarray");
		var allChecked = true;
		if(arr[app.CHK_GRALES] == false){
			allChecked = false;
			this.$("#spnCheckGrales").removeClass("glyphicon-check");
			this.$("#spnCheckGrales").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckGrales").removeClass("glyphicon-unchecked");
			this.$("#spnCheckGrales").addClass("glyphicon-check");
		}
		if(arr[app.CHK_TELS] == false){
			allChecked = false;
			this.$("#spnCheckTels").removeClass("glyphicon-check");
			this.$("#spnCheckTels").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckTels").removeClass("glyphicon-unchecked");
			this.$("#spnCheckTels").addClass("glyphicon-check");
		}
		if(arr[app.CHK_SEPOMEX] == false){
			allChecked = false;
			this.$("#spnCheckSepomex").removeClass("glyphicon-check");
			this.$("#spnCheckSepomex").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckSepomex").removeClass("glyphicon-unchecked");
			this.$("#spnCheckSepomex").addClass("glyphicon-check");
		}
		if(arr[app.CHK_CERT] == false){
			allChecked = false;
			this.$("#spnCheckFigura").removeClass("glyphicon-check");
			this.$("#spnCheckFigura").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckFigura").removeClass("glyphicon-unchecked");
			this.$("#spnCheckFigura").addClass("glyphicon-check");
		}
		if(arr[app.CHK_PUES] == false){
			allChecked = false;
			this.$("#spnCheckPuestos").removeClass("glyphicon-check");
			this.$("#spnCheckPuestos").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckPuestos").removeClass("glyphicon-unchecked");
			this.$("#spnCheckPuestos").addClass("glyphicon-check");
		}
		if(arr[app.CHK_REVALCERT] == false){
			allChecked = false;
			this.$("#spnCheckRevCert").removeClass("glyphicon-check");
			this.$("#spnCheckRevCert").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckRevCert").removeClass("glyphicon-unchecked");
			this.$("#spnCheckRevCert").addClass("glyphicon-check");
		}
		if(allChecked == false){
			this.$(".submit").prop( "disabled", true );
		}
		else{
			this.$(".submit").prop( "disabled", false );
		}
	},

	setViewInstance: function(viewIndex,viewInstance){
		var arr = this.model.get('viewsarray');
		var context = this;

		viewInstance.setCheckId(viewIndex); // <- setea el viewIndex como checkId
		arr[viewIndex] = viewInstance;

		viewInstance.on("stateChange",function(newState, checkId){
			context.checkElement(newState,checkId); //<- usa el checkId como viewIndex
		});
	},

	//TODO: EVENTS, EL SUBMIT CON TODOS LOS DATOS PARA EL REGISTRO
	checkElement: function(newState,viewIndex){
		var checkarr = this.model.get('checkarray');
		if(newState == "VALIDATED")
			checkarr[viewIndex] = true;
		else
			checkarr[viewIndex] = false;
		this.render();
	},

	submitDatos: function(){
		var arr = this.model.get('viewsarray');
		//El método introduce los datos en campos "hidden" con los que se hará POST
		this.$("#spnHdnPostData").html("");
		//datos generales
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.id" value="' + arr[app.CHK_GRALES].model.get('grailsId') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroMatricula" value="' + arr[app.CHK_GRALES].model.get('numeroMatricula') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.nombre" value="' + arr[app.CHK_GRALES].model.get('nombre') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.primerApellido" value="' + arr[app.CHK_GRALES].model.get('primerApellido') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.segundoApellido" value="' + arr[app.CHK_GRALES].model.get('segundoApellido') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.genero" value="' + arr[app.CHK_GRALES].model.get('genero') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.rfc" value="' + arr[app.CHK_GRALES].model.get('rfc') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.curp" value="' + arr[app.CHK_GRALES].model.get('curp') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_day" value="' + arr[app.CHK_GRALES].model.get('fechaNacimientoDay') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_month" value="' + arr[app.CHK_GRALES].model.get('fechaNacimientoMonth') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_year" value="' + arr[app.CHK_GRALES].model.get('fechaNacimientoYear') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.correoElectronico" value="' + arr[app.CHK_GRALES].model.get('correoElectronico') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calidadMigratoria" value="' + arr[app.CHK_GRALES].model.get('calidadMigratoria') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.profesion" value="' + arr[app.CHK_GRALES].model.get('profesion') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNacionalidad" value="' + arr[app.CHK_GRALES].model.get('nacionalidad') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNivelEstudios" value="' + arr[app.CHK_GRALES].model.get('nivelEstudios') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idEstadoCivil" value="' + arr[app.CHK_GRALES].model.get('estadoCivil') + '" />');
		//datos de telefonos
		var telsJson = "[";
		arr[app.EXP_EDT_CHK_TELS].collection.each(function(item){
			telsJson += JSON.stringify(item) + ",";
		}, this);
		telsJson += "]";
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.telefonos_json" value=\'' + telsJson + '\' />');
		//datos de sepomex
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idSepomex" value="' + arr[app.CHK_SEPOMEX].model.get('idSepomex') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calle" value="' + arr[app.CHK_SEPOMEX].model.get('calle') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroInterior" value="' + arr[app.CHK_SEPOMEX].model.get('numeroInterior') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroExterior" value="' + arr[app.CHK_SEPOMEX].model.get('numeroExterior') + '" />');
		//datos de certificacion
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.id" value="' + arr[app.CHK_CERT].model.get('grailsId') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_day" value="' + arr[app.CHK_CERT].model.get('fechaObtencion_day') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_month" value="' + arr[app.CHK_CERT].model.get('fechaObtencion_month') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_year" value="' + arr[app.CHK_CERT].model.get('fechaObtencion_year') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusEntHistorialInforme" value="' + arr[app.CHK_CERT].model.get('statusEntHistorialInforme') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsEntHistorialInforme" value="' + arr[app.CHK_CERT].model.get('obsEntHistorialInforme') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusEntCartaRec" value="' + arr[app.CHK_CERT].model.get('statusEntCartaRec') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsEntCartaRec" value="' + arr[app.CHK_CERT].model.get('obsEntCartaRec') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusConstBolVal" value="' + arr[app.CHK_CERT].model.get('statusConstBolVal') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsConstBolVal" value="' + arr[app.CHK_CERT].model.get('obsConstBolVal') + '" />');
		//datos de puestos
		var puestosJson = JSON.stringify(arr[app.CHK_PUES].collection.toJSON());
		this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.puestos_json" value=\'' + puestosJson + '\' />');
		$("#frmApp").submit();
	},
});