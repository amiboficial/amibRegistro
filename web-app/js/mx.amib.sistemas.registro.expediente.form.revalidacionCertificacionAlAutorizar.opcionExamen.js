var app = app || {};

app.ExamenVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1, //id de reservación de exámen
		numeroMatricula: -1,
		fechaAplicacionExamen: '01/01/1900',
		fechaAplicacionExamenUnixEpoch: -2208988800000, //unix epoch time del 01/01/1900
		descripcionFigura: 'XXXX',
		
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
	},
	validate: function(){
		return true; //TODO: Validar que haya un validado
	}
});

app.OpcionExamenView = Backbone.View.extend({
	model: null,
	template: _.template( $('#opcionExamenViewTemplate').html() ),
	
	initialize: function(options){
		
		if( options.opcionExamenVM != null ){
			this.model = options.opcionExamenVM;
		}
		else{
			this.model = new app.OpcionExamenVM();
		}
		
		//this.render(); el render lo llama la vista padre
		this.listenTo( this.model.get('examenVMCollection'), 'examenSeleccionado', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
				
		return this;
	},
	renderError: function(){
		
	},
	events: {
		'change .field': 'updateModel',
		'click .seleccionarExamen': 'seleccionarExamen',
	},
	
	
	//MÉTODO PARA EL BINDEAO DE DATOS	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	},
	
	seleccionarExamen: function(ev){
		var grailsId = this.$(ev.currentTarget).data("grailsid");
		//alert('EXAMEN SELECCIONADO -> ' + grailsId);
		this.model.seleccionarExamen(grailsId);
	}
	
});