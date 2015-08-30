var app = app || {};

app.REV_CREATE_CHKIDX_MSG = "REV_CREATE_CHKIDX_MSG"

app.REV_CREATE_CHKIDX_DATOFICIO = 0;
app.REV_CREATE_CHKIDX_NOTARIO = 1;
app.REV_CREATE_CHKIDX_REVOCADOS = 2;
app.REV_CREATE_CHKIDX_DOCS = 3;

app.CheckSubmit = Backbone.Model.extend({
	defaults: {
		checkarray: [false,false,false,false],
		viewsarray: [undefined,undefined,undefined,undefined]
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
		
		if(arr[app.REV_CREATE_CHKIDX_DATOFICIO] == false){
			allChecked = false;
			this.$("#spnCheckOficioRevocacion").removeClass("glyphicon-check");
			this.$("#spnCheckOficioRevocacion").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckOficioRevocacion").removeClass("glyphicon-unchecked");
			this.$("#spnCheckOficioRevocacion").addClass("glyphicon-check");
		}
		if(arr[app.REV_CREATE_CHKIDX_NOTARIO] == false){
			allChecked = false;
			this.$("#spnCheckNotario").removeClass("glyphicon-check");
			this.$("#spnCheckNotario").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckNotario").removeClass("glyphicon-unchecked");
			this.$("#spnCheckNotario").addClass("glyphicon-check");
		}
		if(arr[app.REV_CREATE_CHKIDX_REVOCADOS] == false){
			allChecked = false;
			this.$("#spnCheckRevocados").removeClass("glyphicon-check");
			this.$("#spnCheckRevocados").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckRevocados").removeClass("glyphicon-unchecked");
			this.$("#spnCheckRevocados").addClass("glyphicon-check");
		}
		if(arr[app.REV_CREATE_CHKIDX_DOCS] == false){
			allChecked = false;
			this.$("#spnCheckDocs").removeClass("glyphicon-check");
			this.$("#spnCheckDocs").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckDocs").removeClass("glyphicon-unchecked");
			this.$("#spnCheckDocs").addClass("glyphicon-check");
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

		//aqui es donde se "suscribe" el método "checkElement" a la llamada "stateChange" de cualquier componente validable
		viewInstance.on("stateChange",function(newState, checkId){
			context.checkElement(newState,checkId); //<- usa el checkId como viewIndex
		});
	},

	checkElement: function(newState,viewIndex){
		var checkarr = this.model.get('checkarray');
		if(newState == "VALIDATED")
			checkarr[viewIndex] = true;
		else
			checkarr[viewIndex] = false;
		this.render();
	},

	submitDatos: function(e){
		e.preventDefault();
		
		var arr = this.model.get('viewsarray');
		var i;
		
		//Limpia los datos del "span" donde se introducirán los hiddens
		$('#spnHdnPostData').html("");
		
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.idGrupoFinanciero" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('idGrupoFinanciero') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.idInstitucion" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('idInstitucion') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.numeroEscritura" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('numeroEscritura') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.representanteLegalNombre" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('representanteLegalNombre') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.representanteLegalApellido1" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('representanteLegalApellido1') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.representanteLegalApellido2" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('representanteLegalApellido2') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.fechaRevocacion_day" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('fechaRevocacion_day') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.fechaRevocacion_month" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('fechaRevocacion_month') + '" />');
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.fechaRevocacion_year" value="' + arr[app.REV_CREATE_CHKIDX_DATOFICIO].model.get('fechaRevocacion_year') + '" />');
		
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.idNotario" value="' + arr[app.REV_CREATE_CHKIDX_NOTARIO].model.get('idNotarioSeleccionado') + '" />');
		
		arr[app.REV_CREATE_CHKIDX_REVOCADOS].revocadoVMCollection.each(function(item){
			this.$("#spnHdnPostData").append('<input type="hidden" name="revocados.apoderado" value="' + JSON.stringify(item.toJSON()).replace(/["]/g, "'") + '" />');
		},this);
		
		this.$("#spnHdnPostData").append('<input type="hidden" name="revocacion.uuidDocumentoRespaldo" value="' + arr[app.REV_CREATE_CHKIDX_DOCS].collection.at(0).get("uuid") + '" />');
		
		if(confirm(app.REV_CREATE_CHKIDX_MSG))
			$("#frmApp").submit();

	},
});
