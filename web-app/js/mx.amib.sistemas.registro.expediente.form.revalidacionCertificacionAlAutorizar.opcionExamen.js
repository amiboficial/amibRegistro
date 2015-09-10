var app = app || {};

app.ExamenVM = Backbone.Model.extend({
	defaults:{
		grailsId: -1, //id de reservación de exámen
		numeroMatricula: -1,
		fechaAplicacionExamen: '01/01/1900',
		fechaAplicacionExamenUnixEpoch: -2208988800000, //unix epoch time del 01/01/1900
		descripcionFigura: '',
		
		seleccionado: false
	}
});

app.ExamenVMCollection = Backbone.Collection.extend({
	model: app.ExamenVM,
	seleccionarExamen: function(graisId){
		this.each(function(item){
			if( item.get('grailsId') == graisId ){
				item.set('seleccionado', true);
			}
			else{
				item.set('seleccionado', false);
			}
		}, this);
		this.trigger('examenSeleccionado',{});
	},
	getExamenSeleccionado: function(){
		var seleccionado = null;
		this.each(function(item){
			if( item.get('seleccionado') == true ){
				seleccionado = item;
			}
		}, this);
		return seleccionado;
	}
});

app.OpcionExamenVM = Backbone.Model.extend({
	defaults:{
		examenVMCollection : new app.ExamenVMCollection(),
	},
	seleccionarExamen: function(graisId){
		this.get('examenVMCollection').seleccionarExamen(graisId);
	},
	getExamenSeleccionado: function(){
		return this.get('examenVMCollection').getExamenSeleccionado();
	}
});

app.OpcionExamenView = Backbone.View.extend({
	model: null,
	template: _.template( $('#opcionExamenViewTemplate').html() ),
	el: '#prueba123'
	
	initialize: function(options){
		this.model = new app.OpcionExamenVM();
		if( options.examenes != null ){
			this.model.set('examenVMCollection', new app.ExamenVMCollection(options.examenes) );
		}
		else{
			this.model.set('examenVMCollection', new app.ExamenVMCollection() );
		}
		
		this.render();
		
		this.listenTo( this.model.get('examenVMCollection'), 'examenSeleccionado', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	}
	
	render: function(){
		this.$el.html( this.template() );
		return this;
	}
	
	events: {
		'click .seleccionarExamen': 'seleccionarExamen'
	},
	
	seleccionarExamen: function(ev){
		var grailsId = this.$(ev.currentTarget).data("grailsid");
		
		this.model.seleccionarExamen(grailsId);
	}
	
});