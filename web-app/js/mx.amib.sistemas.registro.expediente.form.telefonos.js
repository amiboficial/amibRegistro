var app = app || {};

app.EXP_TEL_DISABLED = 0;
app.EXP_TEL_ENABLED = 1;

app.Telefono = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		lada: "",
		telefono: "",
		extension: "",
		idTipoTelefono: "",
		dsTipoTelefono: "",
	},
});

app.Telefonos = Backbone.Collection.extend({
	model: app.Telefono
});

app.TelefonoView = Backbone.View.extend({
	tagName: 'tr',
	template: _.template( $('#expedienteTelefono').html() ),
	state: app.EXP_TEL_ENABLED,
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .remove': 'eliminarTelefono',
	},
	
	eliminarTelefono: function(e){
		e.preventDefault();
		console.log("EJECUTA QUITAR TELEFONO");
		if(this.state == app.EXP_TEL_ENABLED){
			this.model.destroy();
			this.remove();
		}
	},
});

app.TelefonosView = Backbone.View.extend({
	el: '#divTelefonos',
	state: app.EXP_TEL_ENABLED,
	template: _.template( $('#expedienteTelefonos').html() ),
	
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
		return this;
	},
	
	renderElement: function(item){
		var elementView =  new app.TelefonoView({model:item});
		elementView.viewModel = this.viewModel;
		this.$(".table").append( elementView.render().el );
	},
	
	events: {
		'click .add':'agregarTelefono',
	},
	
	agregarTelefono: function(e){
		e.preventDefault();
		console.log("EJECUTA ARGREGAR TELEFONO");
		
		var tel = new app.Telefono();
		tel.set('lada',this.$('.lada').val());
		tel.set('telefono',this.$('.telefono').val());
		tel.set('extension',this.$('.extension').val());
		tel.set('idTipoTelefono',this.$('.tipo').val());
		tel.set('dsTipoTelefono',this.$('.tipo [option="' + this.$('.tipo').val() + '"]').text());
		this.collection.add(tel);
	},
	
});