var app = app || {};

app.MESES = [
	{ id: 1, nombre: "enero" },
	{ id: 2, nombre: "febrero" },
	{ id: 3, nombre: "marzo" },
	{ id: 4, nombre: "abril" },
	{ id: 5, nombre: "mayo" },
	{ id: 6, nombre: "junio" },
	{ id: 7, nombre: "julio" },
	{ id: 8, nombre: "agosto" },
	{ id: 9, nombre: "septiembre" },
	{ id: 10, nombre: "octubre" },
	{ id: 11, nombre: "noviembre" },
	{ id: 12, nombre: "diciembre" }
]

app.RevocacionDatosOficioTabVM = Backbone.Model.extend({
	defaults:{
		idGrupoFinanciero: -1,
		gruposFinancieros: [ {id:'-1',text:'-Seleccione-',instituciones:[]} ] ,
		idInstitucion:-1,
		instituciones: [ {id:'-1',text:'-Seleccione-'} ],
		numeroEscritura:'',
		representanteLegalNombre:'',
		representanteLegalApellido1:'',
		representanteLegalApellido2:'',
		fechaRevocacion_day:-1,
		fechaRevocacion_month:-1,
		fechaRevocacion_year:-1,
		
		errorNoGrupoFinanciero: false,
		errorNoRepresentanteLegalNombre: false,
		errorNoRepresentanteLegalApellido1: false,
		errorNoNumeroEscritura: false,
		errorNumeroEscrituraNoNumerico: false,
		errorNumeroEscrituraNonCheckedYet: false,
		errorNumeroEscrituraNonUnique: false,
		errorNoFechaRevocacion: false,
		
		numeroEscrituraUniqueChecked: false,
		isNumeroEscrituraUnique: false,
		
		checkNumeroEscrituraUniqueUrl: ''
	},
	
	initialize: function(){
		this.listenTo( this, 'change:numeroEscritura', this.invalidateCheckNumeroEscrituraUnique );
		this.listenTo( this, 'change:idInstitucion', this.cargarInstitucionesDeGrupoFinanciero );
		
		Backbone.Model.prototype.initialize.call(this);
	},
	
	cargarInstitucionesDeGrupoFinanciero: function(){
		var grupoFinancieroSeleccionado;
		var institucionesGrupoFinanciero;
		
		//si se escoge el "-1" en grupo financiero
		if(this.get('idGrupoFinanciero') == -1){
			this.set({
				idInstitucion: -1,
				instituciones: [ {id:'-1',text:'-Seleccione-'} ],
			});
		}
		else{
			//busca el grupo financiero con la id correspondiente
			_.each(this.get('gruposFinancieros'), function(item){
				if(item.id == this.get('idGrupoFinanciero')){
					grupoFinancieroSeleccionado = item;
				}
			}, this);
			//setea el correspondiente array de instituciones
			this.set('instituciones',item.grupoFinancieroSeleccionado);
		}
		//manda una notificacion de que se acualizaron las instituciones
		this.trigger('institucionesCargadas',{});
	},
	validate: function(propagateError){
		var valid = false;
		var num10CarExp = /^[0-9]{1,10}$/;
		
		var grupoFinancieroSeleccionado = (this.get('idGrupoFinanciero') != -1);
		var noRepLegalNombre = (this.get('representanteLegalNombre') == '');
		var noRepLegalAp1 = (this.get('representanteLegalApellido1') == '');
		var noNumeroEscritura = (this.get('numeroEscritura') == '');
		var numeroEscrituraNoNumerico = (!num10CarExp.test(this.get('numeroEscritura')));
		var numeroEscrituraUniqueChecked = this.get('numeroEscrituraUniqueChecked');
		var numeroEscrituraUnique = this.get('isNumeroEscrituraUnique');
		var noFechaRevocacion = ( this.get('fechaRevocacion_day') == -1 || this.get('fechaRevocacion_month') == -1 || this.get('fechaRevocacion_year') == -1)
		
		if(propagateError){
			this.set({
				errorNoGrupoFinanciero: false,
				errorNoRepresentanteLegalNombre: false,
				errorNoRepresentanteLegalApellido1: false,
				errorNoNumeroEscritura: false,
				errorNumeroEscrituraNoNumerico: false,
				errorNumeroEscrituraNonCheckedYet: false,
				errorNumeroEscrituraNonUnique: false,
				errorNoFechaRevocacion: false
			},false);
		}
		
		if(!grupoFinancieroSeleccionado){
			valid = false;
			if(propagateError){
				this.set('errorNoGrupoFinanciero',true);
			}
		}
		if(noRepLegalNombre){
			valid = false;
			if(propagateError){
				this.set('errorNoRepresentanteLegalNombre',true);
			}
		}
		if(noRepLegalAp1){
			valid = false;
			if(propagateError){
				this.set('errorNoRepresentanteLegalApellido1',true);
			}
		}
		if(noNumeroEscritura){
			valid = false;
			if(propagateError){
				this.set('errorNoNumeroEscritura',true);
			}
		}
		if(numeroEscrituraNoNumerico){
			valid = false;
			if(propagateError){
				this.set('errorNumeroEscrituraNoNumerico',true);
			}
		}
		if(!numeroEscrituraUniqueChecked){
			valid = false;
			if(propagateError){
				this.set('errorNumeroEscrituraNonCheckedYet',true);
			}
		}
		else if(!numeroEscrituraUnique){
			valid = false;
			if(propagateError){
				this.set('errorNumeroEscrituraNonUnique',true);
			}
		}
		
		if(noFechaRevocacion){
			valid = false;
			if(propagateError){
				this.set('errorNoFechaRevocacion',true);
			}
		}
		
		this.trigger('validated',valid);
		return valid;
	},
	checkNumeroEscrituraUnique: function(){
		console.log('checkNumeroEscrituraUniqueUrl -> ' + checkNumeroEscrituraUniqueUrl)
		this.set('numeroEscrituraUniqueChecked',true);
		this.set('isNumeroEscrituraUnique',true);
		
		this.trigger('numeroEscrituraUniqueChecked',{});
		return true;
	},
	invalidateCheckNumeroEscrituraUnique: function(){
		this.set({
			errorNumeroEscrituraNonCheckedYet: false,
			errorNumeroEscrituraNonUnique: false,
			numeroEscrituraUniqueChecked: false,
			isNumeroEscrituraUnique: false
		});
		this.trigger('numeroEscrituraUniqueCheckInvalidate',{});
	}
	
});

app.RevocacionDatosOficioTabView = Backbone.View.extend({
	checkId: -1,
	el: '#divRevocacion',
	template: _.template( $('#formRevocacionTemplate').html() ),
	model: new app.RevocacionDatosOficioTabVM(),
	
	initialize: function(options){
		this.model = options.model;
		this.render();
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
	},
	
	events: {
		'change .field':'updateModel',
		'click .submit':'submit',
		'click .edit':'edit'
	},
	
	updateModel: function(e){
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = $.trim(this.$(e.currentTarget).val());
		
		//console.log('updateModel:'+fieldName+':'+fieldValue);
		if(fieldName == 'numeroEscritura' || fieldName == 'idInstitucion'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
	},
	
	submit: function(){
		alert('not yet implemented');
	},
	
	edit: function(){
		alert('not yet implemented');
	}
	
});