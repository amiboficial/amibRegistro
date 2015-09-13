var app = app || {};

app.ExamenVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1, //id de reservación de exámen
		numeroMatricula: -1,
		fechaAplicacionExamen: '01/01/1900',
		fechaAplicacionExamenUnixEpoch: -2208988800000, //unix epoch time del 01/01/1900
		descripcionFigura: 'XXXX',
		
		seleccionado: false,
		
		disabled: false
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
		
		errorNoHaySeleccion: false
	},
	seleccionarExamen: function(graisId){
		this.cleanValidationErrors();
		this.get('examenVMCollection').seleccionarExamen(graisId);
	},
	getExamenSeleccionado: function(){
		return this.get('examenVMCollection').getExamenSeleccionado();
	},
	validate: function(){
		var valid = true;
		var coleccion = this.get('examenVMCollection');
		var seleccionado = null;
		
		this.set('errorNoHaySeleccion', false);
		
		seleccionado = coleccion.getExamenSeleccionado();
		if(seleccionado == null){
			valid = false;
			this.set('errorNoHaySeleccion', true);
			this.trigger('errorOnValidate');
		}
		
		return valid; //TODO: Validar que haya un validado
	},
	cleanValidationErrors: function(){
		this.set({
			errorNoHaySeleccion: false
		});
	}
});

app.OpcionExamenView = Backbone.View.extend({
	model: null,
	template: _.template( $('#opcionExamenViewTemplate').html() ),
	
	initialize: function(options){
		
		if( options.model != null ){
			console.log("PASO AQUI options.model != null  ");
			this.model = options.model;
		}
		else{
			this.model = new app.OpcionExamenVM();
		}
		
		//this.render(); el render lo llama la vista padre
		this.listenTo( this.model.get('examenVMCollection') , 'examenSeleccionado', this.render );
		this.listenTo( this.model , 'errorOnValidate', this.renderError );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		this.$('.alert-errorNoHaySeleccion').hide();
		
		if( this.model.get('errorNoHaySeleccion') == true ){
			this.$('.alert-errorNoHaySeleccion').show();
		}
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
		var deshabilidado = this.model.get('disabled');
		if(!deshabilidado){
			var grailsId = this.$(ev.currentTarget).data("grailsid");
			this.model.seleccionarExamen(grailsId);
		}
	}
	
});