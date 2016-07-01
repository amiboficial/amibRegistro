var app = app || {};

app.EXP_TEL_OPEN = 0;
app.EXP_TEL_VALIDATED = 1;

app.EXP_TEL_ERRMSG_NOLADA = "EXP_TEL_ERRMSG_NOLADA";

app.EXP_TEL_ERRMSG_NOTELS = "Debe haber al menos un telefono";

app.Telefono = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		lada: "",
		telefono: "",
		extension: "",
		idTipoTelefono: -1,
		dsTipoTelefono: "",
	},
});

app.Telefonos = Backbone.Collection.extend({
	model: app.Telefono
});

app.TelefonoView = Backbone.View.extend({
	tagName: 'tr',
	template: _.template( $('#expedienteTelefono').html() ),
	state: app.EXP_TEL_OPEN,
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .remove': 'eliminarTelefono',
	},
	
	eliminarTelefono: function(e){
		e.preventDefault();
		if(this.state == app.EXP_TEL_OPEN){
			this.model.destroy();
			this.remove();
		}
	},
});

app.TelefonosView = Backbone.View.extend({
	checkId: -1,
	el: '#divTelefonos',
	state: app.EXP_TEL_OPEN,
	template: _.template( $('#expedienteTelefonos').html() ),
	errors:[],

	initialize: function(initialData){
		this.collection = new app.Telefonos(initialData);
		this.render();
		
		this.listenTo( this.collection, 'add', this.renderElement );
	},
	
	render: function(){
		this.$el.html( this.template() );
		
		this.collection.each( function(item){
			this.renderElement(item);
		},this );

		//depediendo del estado... renderea como habilitado o deshabilitado
		if(this.state == app.EXP_TEL_OPEN) {
			this.$(".lada").prop( "disabled", false );
			this.$(".telefono").prop( "disabled", false );
			this.$(".extension").prop( "disabled", false );
			this.$(".tipo").prop( "disabled", false );
			this.$(".add").prop( "disabled", false );
			this.$(".remove").prop( "disabled", false );

			this.$(".submit").prop( "disabled", false );
			this.$(".edit").prop( "disabled", true );
		}
		else{
			this.$(".lada").prop( "disabled", true );
			this.$(".telefono").prop( "disabled", true );
			this.$(".extension").prop( "disabled", true );
			this.$(".tipo").prop( "disabled", true );
			this.$(".add").prop( "disabled", true );
			this.$(".remove").prop( "disabled", true );

			this.$(".submit").prop( "disabled", true );
			this.$(".edit").prop( "disabled", false );
		}

		return this;
	},
	
	renderElement: function(item){
		var elementView =  new app.TelefonoView({model:item});
		elementView.viewModel = this.viewModel;
		this.$(".table").append( elementView.render().el );
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
		this.state = app.EXP_TEL_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_TEL_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},

	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},

	events: {
		'click .add':'agregarTelefono',
		'click .submit': 'establecerDatos',
		'click .edit': 'habilitarEdicionDatos',
	},
	
	agregarTelefono: function(e){
		e.preventDefault();
		if(this.validarDatosAgregar() && this.state == app.EXP_TEL_OPEN){
			var tel = new app.Telefono();
			tel.set('lada',$.trim(this.$('.lada').val()));
			tel.set('telefono',$.trim(this.$('.telefono').val()));
			tel.set('extension',$.trim(this.$('.extension').val()));
			tel.set('idTipoTelefono', parseInt(this.$('.tipo').val()) );
			tel.set('dsTipoTelefono',this.$('.tipo option:selected').text());
			this.collection.add(tel);
			//limpia campos
			this.$(".lada").val( "" );
			this.$(".telefono").val( "" );
			this.$(".extension").val( "" );
			this.$(".tipo").val( "-1" );
		}
	},
	
	validarDatosAgregar: function(){
		var valid = true;
		if($.trim(this.$('.telefono').val()).length == 0){
			valid = false;
		}
		if(this.$('.tipo').val() == -1){
			valid = false;
		}
		var matchesList = this.collection.findWhere({lada:$.trim(this.$('.lada').val()), telefono:$.trim(this.$('.telefono').val()), extension:$.trim(this.$('.extension').val())});
		if(matchesList != undefined){
			valid = false;
		}
		return valid;
	},

	establecerDatos: function(){
		this.validarDatos();
		if(this.errors.length > 0){
			this.renderErrorMsgs();
		}
		else{
			//en este caso los telefonos ya se encuentran agregados al modelo
			//por lo que no es necesario "establecer los datos"
			this.setValidatedState();
			this.render();
		}
	},

	validarDatos: function(){
		//debe haber al menos un telefono
		this.errors = new Array();
		if(this.collection.size() == 0){
			this.errors.push(app.EXP_TEL_ERRMSG_NOTELS);
		}
	},

	habilitarEdicionDatos: function(){
		this.setOpenState();
		this.render();
	},
});