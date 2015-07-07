var app = app || {};

app.PODER_CREATE_CHKIDX_PODER = 0;
app.PODER_CREATE_CHKIDX_APODERADOS = 1;
app.PODER_CREATE_CHKIDX_DOCS = 2;

app.CheckSubmit = Backbone.Model.extend({
	defaults: {
		checkarray: [false,false,false],
		viewsarray: [undefined,undefined,undefined]
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
		if(arr[app.PODER_CREATE_CHKIDX_PODER] == false){
			allChecked = false;
			this.$("#spnCheckPoder").removeClass("glyphicon-check");
			this.$("#spnCheckPoder").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckPoder").removeClass("glyphicon-unchecked");
			this.$("#spnCheckPoder").addClass("glyphicon-check");
		}
		if(arr[app.PODER_CREATE_CHKIDX_APODERADOS] == false){
			allChecked = false;
			this.$("#spnCheckApoderados").removeClass("glyphicon-check");
			this.$("#spnCheckApoderados").addClass("glyphicon-unchecked");
		}
		else{
			console.log("fue true el de telefonos");
			this.$("#spnCheckApoderados").removeClass("glyphicon-unchecked");
			this.$("#spnCheckApoderados").addClass("glyphicon-check");
		}
		if(arr[app.PODER_CREATE_CHKIDX_DOCS] == false){
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

	submitDatos: function(){
		var arr = this.model.get('viewsarray');
		//Limpia los datos del "span" donde se introducirán los hiddens
		$('#spnHdnPostData').html("");
		//El método introduce los datos en campos "hidden" con los que se hará POST
		//datos generales
		//this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroMatricula" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('numeroMatricula') + '" />');
		//this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_day" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoDay') + '" />');
		//this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_month" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoMonth') + '" />');
		//this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_year" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoYear') + '" />');
		//datos de telefonos
		//var telsJson = "[";
		//arr[app.EXP_REG_CHK_TELS].collection.each(function(item){
		//	telsJson += JSON.stringify(item) + ",";
		//}, this);
		//telsJson += "]";

		//$("#frmApp").submit();
	},
});

/*

Ejemplo de instanciamineto en el GSP,JSP,etc..-

var checkSubmitView = new app.CheckSubmitView();
checkSubmitView.setViewInstance(app.EXP_REG_CHK_GRALES,generalesView);
checkSubmitView.setViewInstance(app.EXP_REG_CHK_TELS,telefonosView);
checkSubmitView.setViewInstance(app.EXP_REG_CHK_SEPOMEX,sepomexView);
checkSubmitView.setViewInstance(app.EXP_REG_CHK_REGISTRO,registroView);

$(window).bind("pageshow", function(){
	$('#spnHdnPostData').html("");
});
*/