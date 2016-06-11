var app = app || {}

app.EXP_SEPOMEX_OPEN = 0;
app.EXP_SEPOMEX_VALIDATED = 1;
app.EXP_SEPOMEX_PROCESSING = 2;

app.EXP_SEPOMEX_ERRMSG_NOASEN = "EXP_SEPOMEX_ERRMSG_NOASEN";
app.EXP_SEPOMEX_ERRMSG_NOCALLE = "EXP_SEPOMEX_ERRMSG_NOCALLE";
app.EXP_SEPOMEX_ERRMSG_NONUMEXT = "EXP_SEPOMEX_ERRMSG_NONUMEXT";
app.EXP_SEPOMEX_ERRMSG_NONUMINT = "EXP_SEPOMEX_ERRMSG_NONUMINT";

app.Domicilio = Backbone.Model.extend({
	defaults: {
		codigoPostal: "",
		idSepomex: -1,
		calle: "",
		numeroInterior: "",
		numeroExterior: "",

		asentamientoOtro : ""
	},
});

app.Sepomex = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		asentamiento: {},
		ciudad: {},
		codigoPostal: "00000",
		vigente: false
	},
});

app.SepomexCollection = Backbone.Collection.extend({
	model: app.Sepomex,
});

app.SepomexView = Backbone.View.extend({
	checkId: -1,
	el: '#divDom',
	ajaxUrl: '',
	state: app.EXP_SEPOMEX_OPEN,
	errors: [],
	template: _.template( $('#expedienteDomicilio').html() ),

	initialize: function( initialSepomexArray, initialDomicilio , ajaxUrl ){
		this.ajaxUrl = ajaxUrl;
		this.errors = new Array();
		this.model = initialDomicilio;
		this.collection = new app.SepomexCollection(initialSepomexArray);
		this.render();
	},

	events: {
		'change .cpchange':'procesarCodigoPostal',
		'click .submit':'establecerDatos',
		'click .edit':'habilitarEdicionDatos'
	},

	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$(".asen").empty();
		this.$(".asen").append($("<option></option>").attr("value","-1").text("-Seleccione-"));
		if(this.collection.length >	 0){
			if(_.size(this.errors) > 0){
				this.$(".validationErrorMessage").show();
			}
			else{
				this.$(".validationErrorMessage").hide();
			}
			this.collection.each(function(item){
				this.$(".asen").append($("<option></option>").attr("value",item.get('id')).text(item.get('asentamiento').nombre));
			},this);
			var curElement = this.collection.sample();
			this.$(".ef").val(curElement.get('asentamiento').municipio.entidadFederativa.nombre);
			this.$(".mun").val(curElement.get('asentamiento').municipio.nombre);
		}
		else
			this.blankFields();

		if(this.state == app.EXP_SEPOMEX_OPEN){
			this.$(".submit").prop( "disabled", false );
			this.$(".edit").prop( "disabled", true );
			
			this.$(".cpchange").prop( "disabled", false );
			this.$(".asen").prop( "disabled", false );
			this.$(".calle").prop( "disabled", false );
			this.$(".numExt").prop( "disabled", false );
			this.$(".numInt").prop( "disabled", false );
			this.$(".otherAscen").prop( "disabled", false );
		}
		else if(this.state == app.EXP_SEPOMEX_PROCESSING){
			this.$(".submit").prop( "disabled", true );
			this.$(".edit").prop( "disabled", true );
			
			this.$(".cpchange").prop( "disabled", true );
			this.$(".asen").prop( "disabled", true );
			this.$(".calle").prop( "disabled", true );
			this.$(".numExt").prop( "disabled", true );
			this.$(".numInt").prop( "disabled", true );
			this.$(".otherAscen").prop( "disabled", true );
		}
		else if(this.state == app.EXP_SEPOMEX_VALIDATED){
			this.$(".submit").prop( "disabled", true );
			this.$(".edit").prop( "disabled", false );
			
			this.$(".cpchange").prop( "disabled", true );
			this.$(".asen").prop( "disabled", true );
			this.$(".calle").prop( "disabled", true );
			this.$(".numExt").prop( "disabled", true );
			this.$(".numInt").prop( "disabled", true );
			this.$(".otherAscen").prop( "disabled", true );
		}


		this.$(".cp").val(this.model.get("codigoPostal"));
		this.$(".asen").val(this.model.get("idSepomex"));
		this.$(".calle").val(this.model.get("calle"));
		this.$(".numExt").val(this.model.get("numeroExterior"));
		this.$(".numInt").val(this.model.get("numeroInterior"));
		this.$(".otherAscen").val(this.model.get("asentamientoOtro"));
		
		if( this.model.get("numeroInterior") == null || this.model.get("numeroInterior") == 'null'){
			this.$(".numInt").val('');
		}
		else{
			this.$(".numInt").val(this.model.get("numeroInterior"));
		}
		
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
		this.state = app.EXP_SEPOMEX_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_SEPOMEX_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},

	setProcessingState: function(){
		this.state = app.EXP_SEPOMEX_PROCESSING;
		this.trigger("stateChange","PROCESSING",this.checkId);
	},

	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},

	blankFields: function(){
		this.$(".validationErrorMessage").hide();
		
		this.$(".cp").val("");
		this.$(".ef").val("");
		this.$(".mun").val("");
		
		this.$(".asen").empty();
		this.$(".asen").append($("<option></option>").attr("value","-1").text("-Seleccione-"));
		this.$(".asen").val("-1");
		
		this.$(".calle").val("");
		this.$(".numExt").val("");
		this.$(".numInt").val("");
		this.$(".otherAscen").val("");
	},

	setInitialAsentamiento: function(initialId){
		this.$(".asen").val(initialId);
	},

	procesarCodigoPostal: function(){
	
		this.model.set("codigoPostal", $.trim(this.$(".cp").val()));
		this.model.set("calle", $.trim(this.$(".calle").val()) );
		this.model.set("numeroInterior", $.trim(this.$(".numInt").val()));
		this.model.set("numeroExterior", $.trim(this.$(".numExt").val()));
		this.model.set("asentamientoOtro",$.trim(this.$(".otherAscen").val()));
	
		this.setProcessingState();
		this.render();
		var context = this;
		$.ajax({
			type: "POST",
			url: context.ajaxUrl + "/" + context.$(".cp").val(),
		}).done(function(_data,_status,_jqXHR){
			try{
				if(_data.status == "OK"){
					var sepomexArray = _data.object;
					context.collection = new app.SepomexCollection(sepomexArray);
				}
				else{
					context.collection = new app.SepomexCollection(new Array());
				}
			}
			catch(err){
				context.collection = new app.SepomexCollection(new Array());
			}
			context.setOpenState();
			context.render();
		});
		
	},

	establecerDatos: function(){
		this.validarDatos();
		if(this.errors.length > 0){
			this.renderErrorMsgs();
		}
		else{
			
			this.model.set("codigoPostal", $.trim(this.$(".cp").val()));
			this.model.set("idSepomex", parseInt(this.$(".asen").val()));
			this.model.set("calle", $.trim(this.$(".calle").val()) );
			this.model.set("numeroInterior", $.trim(this.$(".numInt").val()));
			this.model.set("numeroExterior", $.trim(this.$(".numExt").val()));
			this.model.set("asentamientoOtro",$.trim(this.$(".otherAscen").val()));
			
			this.setValidatedState();
			this.renderNoErrorMsgs();
			this.render();
		}
	},
	
	habilitarEdicionDatos: function(){
		this.setOpenState();
		this.render();
	},
	
	validarDatos: function(){
		this.errors = new Array();
		
		if(this.$(".asen").val() <= 0){
			this.errors.push(app.EXP_SEPOMEX_ERRMSG_NOASEN);
		}
		if($.trim(this.$(".calle").val()).length == 0){
			this.errors.push(app.EXP_SEPOMEX_ERRMSG_NOCALLE);
		}
		if($.trim(this.$(".numExt").val()).length == 0){
			this.errors.push(app.EXP_SEPOMEX_ERRMSG_NONUMEXT);
		}

	},
	
});