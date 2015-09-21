var app = app || {};

app.ExamenVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1, //id de reservación de exámen
		numeroMatricula: -1,
		fechaAplicacionExamen: '01/01/1900',
		fechaAplicacionExamenUnixEpoch: -2208988800, //unix epoch time del 01/01/1900
		descripcionFigura: 'XXXX',
		
		idVarianteFigura: -1,
		fechaInicio_day: -1,
		fechaInicio_month: -1,
		fechaInicio_year: -1,
		fechaFin_day: -1,
		fechaFin_month: -1,
		fechaFin_year: -1,
		fechaObtencion_day: -1,
		fechaObtencion_month: -1,
		fechaObtencion_year: -1,
		
		seleccionado: false,
		
		disabled: false
	}
});

app.ExamenVMCollection = Backbone.Collection.extend({
	model: app.ExamenVM,
	seleccionarExamen: function(graisId){
		var seleccionado = null;
		this.each(function(item){
			if( item.get('grailsId') == graisId ){
				item.set('seleccionado', true);
				seleccionado = item;
			}
			else{
				item.set('seleccionado', false);
			}
		}, this);
		this.trigger('examenSeleccionado', seleccionado.toJSON() );
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