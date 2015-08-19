var app = app || {};

app.OFA_CREATE_CHKIDX_MSG = "OFA_CREATE_CHKIDX_MSG"

app.OFA_CREATE_CHKIDX_DATOFICIO = 0;
app.OFA_CREATE_CHKIDX_AUTORIZADOS = 1;
app.OFA_CREATE_CHKIDX_DOCS = 2;

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
		if(arr[app.OFA_CREATE_CHKIDX_DATOFICIO] == false){
			allChecked = false;
			this.$("#spnCheckOficioCnbv").removeClass("glyphicon-check");
			this.$("#spnCheckOficioCnbv").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckOficioCnbv").removeClass("glyphicon-unchecked");
			this.$("#spnCheckOficioCnbv").addClass("glyphicon-check");
		}
		if(arr[app.OFA_CREATE_CHKIDX_AUTORIZADOS] == false){
			allChecked = false;
			this.$("#spnCheckAutorizados").removeClass("glyphicon-check");
			this.$("#spnCheckAutorizados").addClass("glyphicon-unchecked");
		}
		else{
			this.$("#spnCheckAutorizados").removeClass("glyphicon-unchecked");
			this.$("#spnCheckAutorizados").addClass("glyphicon-check");
		}
		if(arr[app.OFA_CREATE_CHKIDX_DOCS] == false){
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
		//Limpia los datos del "span" donde se introducirán los hiddens
		$('#spnHdnPostData').html("");
		
		//Datos del poder
		//this.$("#spnHdnPostData").append('<input type="hidden" name="poder.idGrupoFinanciero" value="' + arr[app.PODER_CREATE_CHKIDX_PODER].model.get('idGrupoFinanciero') + '" />');
		
		if(confirm(app.OFA_CREATE_CHKIDX_MSG))
			$("#frmApp").submit();
	},
});
