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
		errorNumeroMatriculaNotRevocable: false,
		
		errorIdApoderadoNotSelected: false,
		errorDsMotivoBlank: false,
		errorFechaBajaNotValid: false,
		
		findByNumeroMatriculaUrl: '',
	},
	initialize: function(){
		this.listenTo(this,'change:numeroMatricula',this.invalidateResultadoBusqueda);
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
			if(data.status == "OK"){ //es mayor a 1 porque ya incluyo el dato del "nulo"
				if(data.object.apoderamientosEncontrados.length > 1){
					_this.set(data.object);
					_this.set('seEncontroMatricula',true);
				}
				else{
					_this.set('errorNumeroMatriculaNotRevocable',true);
				}
			}
			else{
				_this.set('errorNumeroMatriculaNotFound',true);
			}
		});
		
	},
	invalidateResultadoBusqueda: function(){
		console.log("paso por -> RevocableVM.invalidateResultadoBusqueda");
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
			errorNumeroMatriculaNotRevocable: false,
			
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
			errorNumeroMatriculaNotRevocable: false,
			errorIdApoderadoNotSelected: false,
			errorDsMotivoBlank: false,
			errorFechaBajaNotValid: false
		},{silent:true});
		this.trigger("errorFlagsCleared", {});
	},
	clearResults: function(){
		this.invalidateResultadoBusqueda();
		this.trigger("resultsCleared", {});
	},
	validateToAdd: function(){
		var valid = true;
		
		var hayApoderamientoARevocar;
		var motivoEnBlanco;
		var fechaBajaValida;
		
		hayApoderamientoARevocar = (this.get('idApoderado') != -1);
		motivoEnBlanco = ($.trim(this.get('dsMotivo')) == '');
		fechaBajaValida = this.get('fechaBaja_day') != -1 && this.get('fechaBaja_month') != -1 && this.get('fechaBaja_year') != -1 
	
		this.set('errorIdApoderadoNotSelected',false,{silent:true});
		this.set('errorDsMotivoBlank',false,{silent:true});
		this.set('errorFechaBajaNotValid',false,{silent:true});
		if(!hayApoderamientoARevocar){
			this.set('errorIdApoderadoNotSelected',true,{silent:true});
			valid = false;
		}
		if(motivoEnBlanco){
			this.set('errorDsMotivoBlank',true,{silent:true});
			valid = false;
		}
		if(!fechaBajaValida){
			this.set('errorFechaBajaNotValid',true,{silent:true});
			valid = false;
		}
		
		this.trigger('errorSet');
		
		return valid;
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
		dsMotivo: '',
		dsPoderRevocar: '',
		
		vistaExpandida: false
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
	},
	
	setVistaExpandida: function(idApoderado, isVistaExpandida){
		console.log( 'PASO AQUI setVistaExpandida CON PARAMETROS: ' + idApoderado + ',' + isVistaExpandida);
		this.each(function(item){
			if(item.get('idApoderado') == idApoderado){
				item.set('vistaExpandida',isVistaExpandida);
			}
		});
		this.trigger('reset',{});
		//this.sort();
	},
	removeByIdApoderado: function(idApoderado){
		var itemABorrar;
		
		this.each(function(item){
			if(item.get('idApoderado') == idApoderado){
				itemABorrar = item;
			}
		});
		
		this.remove([ item ]);
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
	rowTemplate: _.template( $('#formRevocadosRowTemplate').html() ),
	
	initialize: function(options){
		this.model = new Backbone.Model( { collection:options.collection } );
		this.collection = options.collection;
		
		this.listenTo( this.collection , 'add', this.render );
		this.listenTo( this.collection , 'remove', this.render );
		this.listenTo( this.collection , 'sort', this.render );
		this.listenTo( this.collection , 'reset', this.render );
		
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderItems();
		return this;
	},
	renderItems: function(){
		var itemsHtml = '';
		this.collection.each(function(item){
			itemsHtml += this.rowTemplate( item.toJSON() );
		},this);
		this.$('.list-items').html(itemsHtml);
	},
	
	//aqui se realizará lo correspondiente al rendereo de la lista
	enableInput: function(){
		this.$('button').prop('disabled',false);
	},
	disableInput: function(){
		this.$('button').prop('disabled',true);
	},
	
	events: {
		'click .expandRow' : 'expandRow',
		'click .collapseRow' : 'collapseRow',
		'click .removeItem' : 'removeItem',
	},
	expandRow: function(e){
		e.preventDefault();
		
		var idApoderado = this.$(e.currentTarget).data("id");
		
		this.collection.setVistaExpandida(idApoderado,true);
	},
	collapseRow: function(e){
		e.preventDefault();
		
		var idApoderado = this.$(e.currentTarget).data("id");
		
		this.collection.setVistaExpandida(idApoderado,false);
	},
	removeItem: function(e){
		e.preventDefault();
		
		var idApoderado = this.$(e.currentTarget).data("id");
		
		this.collection.removeByIdApoderado(idApoderado);
	}
});

app.RevocableView = Backbone.View.extend ({
	model: new app.RevocableVM(),
	template: _.template( $('#formRevocableTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
		
		this.listenTo(this.model,'change:seEncontroMatricula',this.renderMatriculaEncontrada);
		this.listenTo(this.model,'resultsInvalidated',this.renderMatriculaEncontrada);
		
		this.listenTo(this.model,'change:errorNumeroMatriculaBlank',this.renderError);
		this.listenTo(this.model,'change:errorNumeroMatriculaNonNumeric',this.renderError);
		this.listenTo(this.model,'change:errorNumeroMatriculaNotRevocable',this.renderError);
		this.listenTo(this.model,'errorSet',this.renderError);
		this.listenTo(this.model,'errorFlagsCleared',this.renderError);
	},
	
	render: function(){
		
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderMatriculaEncontrada();
		this.renderError();
		return this;
	},
	renderError: function(){
		
		this.$('.alert-errorNumeroMatriculaBlank').hide();
		this.$('.alert-errorNumeroMatriculaNonNumeric').hide();
		this.$('.alert-errorNumeroMatriculaNotRevocable').hide();
		this.$('.alert-errorNumeroMatriculaNotFound').hide();
		this.$('.div-numeroMatricula').removeClass('has-error');
		
		if(this.model.get('errorNumeroMatriculaBlank')){
			this.$('.alert-errorNumeroMatriculaBlank').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		if(this.model.get('errorNumeroMatriculaNonNumeric')){
			this.$('.alert-errorNumeroMatriculaNonNumeric').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		if(this.model.get('errorNumeroMatriculaNotRevocable')){
			this.$('.alert-errorNumeroMatriculaNotRevocable').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		
		if(this.model.get('errorNumeroMatriculaNotFound')){
			this.$('.alert-errorNumeroMatriculaNotFound').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		
		if(this.model.get('errorNumeroMatriculaInList')){
			this.$('.alert-errorNumeroMatriculaInList').show();
		}
		else{
			this.$('.alert-errorNumeroMatriculaInList').hide();
		}
		
		if(this.model.get('errorIdApoderadoNotSelected')){
			this.$('.alert-errorIdApoderadoNotSelected').show();
		}
		else{
			this.$('.alert-errorIdApoderadoNotSelected').hide();
		}
		
		if(this.model.get('errorDsMotivoBlank')){
			this.$('.alert-errorDsMotivoBlank').show();
		}
		else{
			this.$('.alert-errorDsMotivoBlank').hide();
		}
		
		if(this.model.get('errorFechaBajaNotValid')){
			this.$('.alert-errorFechaBajaNotValid').show();
		}
		else{
			this.$('.alert-errorFechaBajaNotValid').hide();
		}
	},
	renderMatriculaEncontrada: function(){
		//this.renderError();
		if(this.model.get('seEncontroMatricula') == true){
			this.renderValues();
			this.$('.verifyNumeroMatricula').prop('disabled',true);
			this.$('.idApoderado').prop('disabled',false);
			this.$('.dsMotivo').prop('disabled',false);
			this.$('.fechaBaja_day').prop('disabled',false);
			this.$('.fechaBaja_month').prop('disabled',false);
			this.$('.fechaBaja_year').prop('disabled',false);
		}
		else{
			this.renderValues();
			this.$('.verifyNumeroMatricula').prop('disabled',false);
			this.$('.idApoderado').prop('disabled',true);
			this.$('.dsMotivo').prop('disabled',true);
			this.$('.fechaBaja_day').prop('disabled',true);
			this.$('.fechaBaja_month').prop('disabled',true);
			this.$('.fechaBaja_year').prop('disabled',true);
		}
	},
	renderValues: function(){
		var apoderamientosHtml = '';
		var apoderaminetos;
		
		this.$('.nombreCompleto').val( this.model.get('nombreCompleto') );
		this.$('.fechaBaja_day').val( this.model.get('fechaBaja_day') );
		this.$('.fechaBaja_month').val( this.model.get('fechaBaja_month') );
		this.$('.fechaBaja_year').val( this.model.get('fechaBaja_year') );
		this.$('.dsMotivo').val( this.model.get('dsMotivo') );
		
		apoderaminetos = this.model.get('apoderamientosEncontrados');
		_.each(apoderaminetos,function(item){
			apoderamientosHtml += '<option value="'+item.id+'">'+item.text+'</option>'
		},this);
		this.$('.idApoderado').html(apoderamientosHtml);
		this.$('.idApoderado').val( this.model.get('idApoderado') );
	},
	
	enableInput: function(){
		this.$('.field').prop('disabled',false);
		this.$('button').prop('disabled',false);
		this.renderMatriculaEncontrada();
	},
	disableInput: function(){
		this.$('.field').prop('disabled',true);
		this.$('button').prop('disabled',true);
	},
	
	events: {
		'click .verifyNumeroMatricula':'verifyNumeroMatricula',
		'change .field':'updateModel'
	},
	
	updateModel: function(e){
		var fieldName = this.$(e.currentTarget).data("field");
		var fieldValue = $.trim(this.$(e.currentTarget).val());
		
		console.log('updateModel:'+fieldName+':'+fieldValue);
		if(fieldName == 'numeroMatricula'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		
	},
	
	verifyNumeroMatricula: function(e){
		e.preventDefault();
		if(this._validateNumeroMatricula()){
			this.model.findByNumeroMatricula();
		}		
	},
	
	_validateNumeroMatricula: function(){
		//expresion regular
		var num10CarExp = /^[0-9]{1,10}$/;
		//variable de validacion incial
		var valid = true;
		//obtencion de valores a validar
		var numeroMatricula = this.model.get('numeroMatricula');
		//booleanos de validacion
		var isBlank;
		var isNumeric;
		
		//limpia errores si es que hubo
		this.model.set('errorNumeroMatriculaBlank',false,{silent:true});
		this.model.set('errorNumeroMatriculaNonNumeric',false,{silent:true});
		this.model.trigger('change:errorNumeroMatriculaBlank');
		this.model.trigger('change:errorNumeroMatriculaNonNumeric');
		
		isBlank = ($.trim(numeroMatricula) == '');
		isNumeric = num10CarExp.test($.trim(numeroMatricula));
		
		if(isBlank){
			valid = false;
			this.model.set('errorNumeroMatriculaBlank',true);
		}
		else if(!isNumeric){
			valid = false;
			this.model.set('errorNumeroMatriculaNonNumeric',true);
		}
		
		return valid;
	}
	
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
	
	findByNumeroMatriculaUrl: '',
	
	initialize: function(options){
		this.revocadoVMCollection = options.collection;
		this.revocableVM.set('findByNumeroMatriculaUrl', options.findByNumeroMatriculaUrl);
		
		this.render();
		
		this.listenTo( this.model, 'change:validated', this.renderValidated );
		this.listenTo( this.model, 'change:processing', this.renderProcessing );
		
		this.listenTo( this.revocableVM, 'change:processing', function(item){ 
			this.model.set('processing',item.attributes.processing); 
		} );
		this.listenTo( this.revocableVM, 'change:seEncontroMatricula', this.renderMatriculaEncontrada );
		this.listenTo( this.revocableVM, 'resultsInvalidated', this.renderMatriculaEncontrada );
	},
	
	render: function(){
		this.$el.html( this.template() );
		
		this.renderRevocableView();
		this.renderRevocadoVMCollectionView();
		
		this.renderError();
		this.renderValidated();
		this.renderMatriculaEncontrada();
		
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
	renderMatriculaEncontrada: function(){
		if(this.revocableVM.get('seEncontroMatricula') == true){
			this.$('.add').prop('disabled',false);
		}
		else{
			this.$('.add').prop('disabled',true);
		}
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
		this.$(".add").prop('disabled',true);
		
		this.revocableView.disableInput();
		this.revocadoVMCollectionView.disableInput();
	},
	enableInput: function(){
		this.revocableView.enableInput();
		this.revocadoVMCollectionView.enableInput();
		this.renderMatriculaEncontrada();
	},
	enableSubmit: function(){
		
		this.enableInput();
		this.$(".edit").prop('disabled',true);
		this.$(".submit").prop('disabled',false);
	},
	disableSubmit: function(){
		
		this.disableInput();
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
		'click .add': 'add',
		'click .submit':'submit',
		'click .edit':'edit'
	},
	
	add: function(e){
		e.preventDefault();
		if(this._validateAdd()){
			
			var dsPoderRevocar;
			var apoderamientosEncontrados = this.revocableVM.get('apoderamientosEncontrados');
			var idApoderado = this.revocableVM.get('idApoderado');
			_.each(apoderamientosEncontrados,function(item){
				if(item.id == idApoderado){
					dsPoderRevocar = item.text;
				}
			},this);
			
			var revToAdd = new app.RevocadoVM();
			revToAdd.set({
				idApoderado: this.revocableVM.get('idApoderado'),
				idCertificacion: this.revocableVM.get('idCertificacion'),
				idSustentante: this.revocableVM.get('idSustentante'),
				numeroMatricula: this.revocableVM.get('numeroMatricula'),
				nombreCompleto: this.revocableVM.get('nombreCompleto'),
				nombre: this.revocableVM.get('nombre'),
				primerApellido: this.revocableVM.get('primerApellido'),
				segundoApellido: this.revocableVM.get('segundoApellido'),
				fechaBaja_day: this.revocableVM.get('fechaBaja_day'),
				fechaBaja_month: this.revocableVM.get('fechaBaja_month'),
				fechaBaja_year: this.revocableVM.get('fechaBaja_year'),
				dsMotivo: this.revocableVM.get('dsMotivo'),
				dsPoderRevocar: dsPoderRevocar,
				vistaExpandida: true
			});
			this.revocadoVMCollection.add(revToAdd);
			this.revocableVM.invalidateResultadoBusqueda();
		}
	},
	_validateAdd: function(){
		return this.revocableVM.validateToAdd();
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