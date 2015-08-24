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

app.RevocableVM = Backbone.Model.extend ({
	defaults: {
		idApoderado: -1,
		apoderamientosEncontrados:  [ { id:'-1',text:'-Seleccione-' } ] ,
		
		idCertificacion: -1,
		idSustentante: -1,
		numeroMatricula: '',
		nombreCompleto: '',
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		dsFigura: '',
		dsVarianteFigura: '',
		dsTipoAutorizacion: '',
		fechaBaja_day: -1,
		fechaBaja_month: -1,
		fechaBaja_year: -1,
		dsMotivo: '',
		
		seEncontroMatricula: false,
		
		errorNumeroMatriculaBlank: false,
		errorNumeroMatriculaNonNumeric: false,
		errorNumeroMatriculaNotFound: false,
		errorNumeroMatriculaInList: false,
		
		errorIdApoderadoNotSelected: false,
		errorDsMotivoBlank: false,
		errorFechaBajaNotValid: false,
		
		findByNumeroMatriculaUrl: '',
	},
	findByNumeroMatricula: function(){
		var _this = this;
		var numeroMatricula = this.get('numeroMatricula');
		
		$.ajax({
			url:  _this.get('findByNumeroMatriculaUrl'),
			beforeSend: function(xhr){
				_this.set('processing',true);
				_this.set('seEncontroMatricula',false);
				_this.clearErrorFlags();
			},
			type: 'GET',
			data: { numeroMatricula:numeroMatricula }
		}).done( function(data){
			_this.set('processing',false);
			if(data.status == "OK"){ //es mayor a 1 porque ya incluy el dato del "nulo"
				_this.set('seEncontroMatricula',true);
				_this.set(data.object);
			}
			else{
				_this.set('errorNotarioNotFound',true);
			}
		});
	},
	invalidateResultadoBusqueda: function(){
		this.set({
			idApoderado: -1,
			apoderamientosEncontrados:  [ { id:'-1',text:'-Seleccione-' } ] ,
			
			idCertificacion: -1,
			idSustentante: -1,
			nombreCompleto: '',
			nombre: '',
			primerApellido: '',
			segundoApellido: '',
			dsFigura: '',
			dsVarianteFigura: '',
			dsTipoAutorizacion: '',
			fechaBaja_day: -1,
			fechaBaja_month: -1,
			fechaBaja_year: -1,
			dsMotivo: '',
			
			seEncontroMatricula: false,
			
			errorNumeroMatriculaBlank: false,
			errorNumeroMatriculaNonNumeric: false,
			errorNumeroMatriculaNotFound: false,
			errorNumeroMatriculaInList: false,
			errorIdApoderadoNotSelected: false,
			errorDsMotivoBlank: false,
			errorFechaBajaNotValid: false
		},{silent:true});
		this.trigger("resultsInvalidated", {});
	},
	clearErrorFlags: function(){
		this.set({
			errorNumeroMatriculaBlank: false,
			errorNumeroMatriculaNonNumeric: false,
			errorNumeroMatriculaNotFound: false,
			errorNumeroMatriculaInList: false,
			errorIdApoderadoNotSelected: false,
			errorDsMotivoBlank: false,
			errorFechaBajaNotValid: false
		},{silent:true});
		this.trigger("errorFlagsCleared", {});
	},
	clearResults: function(){
		this.invalidateResultadoBusqueda();
		this.trigger("resultsCleared", {});
	}
});

app.RevocadoVM = Backbone.Model.extend ({
	defaults: {
		idApoderado: -1,
		idCertificacion: -1,
		idSustentante: -1,
		numeroMatricula: '',
		nombreCompleto: '',
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		dsFigura: '',
		dsVarianteFigura: '',
		dsTipoAutorizacion: '',
		fechaBaja_day: -1,
		fechaBaja_month: -1,
		fechaBaja_year: -1,
		dsMotivo: ''
	}
});

app.RevocadoVMCollection = Backbone.Collection.extend ({
	model: app.RevocadoVM,
	
	_sort: "numeroMatricula",
	_order: "asc",
	
	comparator: function(itemA, itemB){
		if(this._sort == "idSustentante"){
			if(this._order == "desc"){
				if(itemA.get('idSustentante') == itemB.get('idSustentante'))
					return 0;
				else if(itemA.get('idSustentante') > itemB.get('idSustentante'))
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('idSustentante') <= itemB.get('idSustentante'))
					return -1;
				else
					return 1
			}
		}	
		else if(this._sort == "numeroMatricula"){
			if(this._order == "desc"){
				if(itemA.get('numeroMatricula') == itemB.get('numeroMatricula'))
					return 0;
				else if(itemA.get('numeroMatricula') > itemB.get('numeroMatricula'))
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('numeroMatricula') <= itemB.get('numeroMatricula'))
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "nombreCompleto"){
			if(this._order == "desc"){
				if(itemA.get('nombreCompleto').toUpperCase() > itemB.get('nombreCompleto').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('nombreCompleto').toUpperCase() <= itemB.get('nombreCompleto').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "nombre"){
			if(this._order == "desc"){
				if(itemA.get('nombre').toUpperCase() > itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('nombre').toUpperCase() <= itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "primerApellido"){
			if(this._order == "desc"){
				if(itemA.get('primerApellido').toUpperCase() > itemB.get('primerApellido').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('primerApellido').toUpperCase() <= itemB.get('primerApellido').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "segundoApellido"){
			if(this._order == "desc"){
				if(itemA.get('segundoApellido').toUpperCase() > itemB.get('segundoApellido').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('segundoApellido').toUpperCase() <= itemB.get('segundoApellido').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		
	},
	
	sortAndOrderBy: function(order, sort){
		this._order = order;
		this._sort = sort;
		
		this.sort();
	}
});

app.RevocadosTabVM = Backbone.Model.extend ({
	defaults: {
		//en esta vista, el unico error sería que no se han insertado revocados
		errorRevocadosListBlank: false,
		validated: false,
		processing: false
	}
});

app.RevocadoVMCollectionView = Backbone.View.extend ({
	model: {},
	template: _.template( $('#formRevocadosCollectionTemplate').html() ),
	
	initialize: function(options){
		this.model = new Backbone.Model( { collection:options.collection } );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	//aqui se realizará lo correspondiente al rendereo de la lista
	enableInput: function(){},
	disableInput: function(){}
});

app.RevocableView = Backbone.View.extend ({
	model: new app.RevocableVM(),
	template: _.template( $('#formRevocableTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	enableInput: function(){},
	disableInput: function(){},
});

app.RevocadosTabView = Backbone.View.extend ({
	checkId: -1,
	el: '#divRevocados',
	template: _.template( $('#formRevocadosTemplate').html() ),
	
	model: new app.RevocadosTabVM(),
	revocableVM: new app.RevocableVM(),
	revocadoVMCollection: {},
	
	revocableView: {},
	revocadoVMCollectionView: {},
	
	initialize: function(options){
		this.revocadoVMCollection = options.collection;
		this.render();
		
		this.listenTo( this.model, 'change:validated', this.renderValidated );
		this.listenTo( this.model, 'change:processing', this.renderProcessing );
	},
	
	render: function(){
		this.$el.html( this.template() );
		
		this.renderRevocableView();
		this.renderRevocadoVMCollectionView();
		
		this.renderError();
		this.renderValidated();
		
		//oculta mensaje de processmiento dado que no se esta procesando nada
		this.$('.alert-processing').hide();
		
		return this;
	},
	renderRevocableView: function(){
		this.revocableView = new app.RevocableView( {model:this.revocableVM} );
		this.$('.div-revocable').html( this.revocableView.render().el );
	},
	renderRevocadoVMCollectionView: function(){
		this.revocadoVMCollectionView = new app.RevocadoVMCollectionView( {collection:this.revocadoVMCollection} );
		this.$('.div-list-revocados').html( this.revocadoVMCollectionView.render().el );
	},
	renderError: function(){
		if(this.model.get('errorRevocadosListBlank')){
			this.$('.alert-errorRevocadosListBlank').show();
		}
		else{
			this.$('.alert-errorRevocadosListBlank').hide();
		}
	},
	renderValidated: function(){
		if(this.model.get('validated') == true){
			this.disableInput();
			this.disableSubmit();
		}
		else{
			this.enableInput();
			this.enableSubmit();
		}
	},
	renderProcessing: function(){
		if(this.model.get('processing') == true){
			this.$('.alert-processing').show();
			
			this.disableInput();
			this.$(".submit").prop('disabled',true);
			this.$(".edit").prop('disabled',true);
		}
		else{
			this.$('.alert-processing').hide();
			
			this.enableInput();
			//vuelve a renderear el estado "validated" en el que se encontraba
			this.renderValidated();
		}
	},
	disableInput: function(){
		this.revocableView.disableInput();
		this.revocadoVMCollectionView.disableInput();
	},
	enableInput: function(){
		this.revocableView.enableInput();
		this.revocadoVMCollectionView.enableInput();
	},
	enableSubmit: function(){
		this.$(".edit").prop('disabled',true);
		this.$(".submit").prop('disabled',false);
	},
	disableSubmit: function(){
		this.$(".submit").prop('disabled',true);
		this.$(".edit").prop('disabled',false);
	},
	
	//metodos para el checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	events: {
		'click .submit':'submit',
		'click .edit':'edit'
	},
	
	submit: function(e){
		e.preventDefault();
		//if(this._validate()){
			this.model.set('validated',true);
			//this.invalidateResult();
			//this.clearNumeroMatricula();
			this.trigger("stateChange","VALIDATED",this.checkId);
		//}
	},
	edit: function(e){
		e.preventDefault();
		this.model.set('validated',false);
		this.trigger("stateChange","READY",this.checkId);
	},
	_validate: function(){
		var valid = true;
		
		//valida que haya al menos un revocado en la coleccion
		this.model.set('errorRevocadosListBlank',false);
		
		if(this.revocadoVMCollection.size() == 0){
			this.model.set('errorRevocadosListBlank',true);
			valid = false;
		}
		
		return valid;
	}
	
});