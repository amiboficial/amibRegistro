var app = app || {};


app.EXP_CEA_SELECTED_TAB_MAT = 0;
app.EXP_CEA_SELECTED_TAB_FOL = 1;
app.EXP_CEA_SELECTED_TAB_BAV = 2;

app.EXP_CEA_RSLTS_ST_READY = 0;
app.EXP_CEA_RSLTS_ST_PROC = 1;

app.EXP_CEA_RSLT_ST_NO_ENVIADO = 0;
app.EXP_CEA_RSLT_ST_ENVIADO = 1;

app.EXP_CEA_RSLT_NOSEL_COLOR = "#FFFFFF"; //blanco
app.EXP_CEA_RSLT_SEL_COLOR = "#D9EDF7"; //azul claro
app.EXP_CEA_RSLT_ENLOTE_COLOR = "#EFEDFA"; //morado claro
app.EXP_CEA_RSLT_SELENLOTE_COLOR = "#DEF7D9"; //verde claro
app.EXP_CEA_RSLT_PROC_COLOR = "#F8FAED"; //amarizho

app.EXP_CEA_REFRESH_MILIS = 10000;
app.EXP_CEA_REFRESH_STOP_MILIS = 180000;

app.Figura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.variantesFigura = new Array();
}

app.VarianteFigura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.figura = {};
}

/*
app.CertPendAutMainVM = Backbone.Model.extend({
	defaults: {
		selectedTab: app.EXP_CEA_SELECTED_TAB_MAT
	}
});
*/
app.MatriculaTabVM = Backbone.Model.extend({
	defaults: {
		numeroMatricula: -1,
		errorNumeroMatricula: false
	}
});

app.FolioTabVM = Backbone.Model.extend({
	defaults: {
		idSustentante: -1,
		errorIdSustentante: false
	}
});

app.BusqAvVM = Backbone.Model.extend({
	initialize: function(){
		this.listenTo( this, 'change:idFigura', this.changeFigura );
	},
	defaults: {
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		idVarianteFigura: -1,
		
		viewFiguras: [],
		viewVariantesFigura: []
	},
	changeFigura: function(){
		var selIdFigura = this.get('idFigura');
		var selFigura = {};
		
		if(selIdFigura != -1){
			for(var i=0; i<this.get('viewFiguras').length; i++){
				if( this.get('viewFiguras')[i].id == selIdFigura ){
					selFigura = this.get('viewFiguras')[i];
					break;
				}
			}
			this.set('idVarianteFigura',-1);
			this.set('viewVariantesFigura', _.sortBy(selFigura.variantesFigura, function(item){ return item.nombre }, this)  );
		}
		else{
			this.set('idVarianteFigura',-1);
			this.set('viewVariantesFigura', new Array() );
		}
	}
});

app.ResultVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		idSustentante: -1,
		numeroMatricula: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		dsFigura: "",
		idVarianteFigura: -1,
		dsVarianteFigura: "",
		
		yaEnLote: false,
		
		viewChecked: false,
		
		sendToLoteUrl: "",
		
		procesando: false,
	},
	
	
	_startProcessing: function(){
		this.set('procesando',true);
		this.trigger('processingStarted');
	},
	_stopProcessing: function(){
		this.set('procesando',false);
		this.trigger('processingStopped');
	},
	_stopProcessingWithError: function(){
		this.set('procesando',false);
		this.trigger('processingError');
	},
	isProcessing: function(){
		return this.get('procesando');
	},
	
	getViewSelectionColor: function(){	
		var colorHexStr = app.EXP_CEA_RSLT_NOSEL_COLOR;
		if(this.get('yaEnLote') == true && this.get('viewChecked') == true && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_SELENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == true && this.get('viewChecked') == false && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_ENLOTE_COLOR;
		}
		else if(this.get('yaEnLote') == false && this.get('viewChecked') == true && this.get('procesando') == false){
			colorHexStr = app.EXP_CEA_RSLT_SEL_COLOR;
		}
		else if(this.get('procesando') == true){
			colorHexStr = app.EXP_CEA_RSLT_PROC_COLOR;
		}
		return colorHexStr;
	},
	
	//Async
	sendToLote: function(){
		var _this = this;
		
		$.ajax({
			url: _this.get('sendToLoteUrl'), 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			contentType: 'application/json; charset=utf-8',
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
				_this.set({'viewChecked':false},{silent:true});
				_this.set({'yaEnLote':true},{silent:true});
				
				_this._stopProcessing();
				_this.trigger('sentToLote');
			}
			else{
				_this.set({'yaEnLote':false},{silent:true});
				_this._stopProcessingWithError();
			}
		} );
	}
	
});

app.ResultVMCollection = Backbone.Collection.extend({
	model: app.ResultVM, 
	
	count: 0,
	max: 10,
	offset: 0,
	sort: "id", //TODO: CAMBIAR ESTA VARIABLE SORT, ESTA SOBREESCRIBIENDO METODO SORT
	order: "asc",
	
	lastQuery: -1, //EXP_CEA_SELECTED_TAB_MAT,EXP_CEA_SELECTED_TAB_FOL,EXP_CEA_SELECTED_TAB_BAV
	lastMatricula: -1,
	lastIdSustentante: -1,
	lastNombre: "",
	lastPrimerApellido: "",
	lastSegundoApellido: "",
	lastIdFigura: -1,
	lastIdVarianteFigura: -1,
	
	findAllByMatriculaUrl: "",
	findAllByIdSustentanteUrl: "",
	findAllUrl: "",
	sendAllToLoteUrl: "",
	sendToLoteUrl: "",
	
	_processing: false,
	_startProcessing: function(){
		this._processing = true;
		this.trigger('processingStarted');
	},
	_stopProcessing: function(){
		this._processing = false;
		this.trigger('processingStopped');
	},
	_stopProcessingWithError: function(){
		this._processing = false;
		this.trigger('processingError');
	},
	isProcessing: function(){
		return this._processing;
	},
	
	findAllByMatricula: function(options){ //Async
		var _this = this;

		_this.lastQuery = app.EXP_CEA_SELECTED_TAB_MAT;
		_this.lastMatricula = options.numeroMatricula;
		_this.lastIdSustentante = -1;
		_this.lastNombre = "";
		_this.lastPrimerApellido = "";
		_this.lastSegundoApellido = "";
		_this.lastIdFigura = -1;
		_this.lastIdVarianteFigura = -1;
		
		$.ajax({
			url: _this.findAllByMatriculaUrl + "/" + options.numeroMatricula, 
			beforeSend: function(xhr){
				_this._startProcessing();
			}
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object.list
			
				_this.count = data.object.count;
				_this.offset = options.offset;
				_this.sort = options.sort;
				_this.order = options.order;
				_this.reset( null );
				
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );

	},
	findAllByIdSustentante: function(options){ //Async
		var _this = this;

		_this.lastQuery = app.EXP_CEA_SELECTED_TAB_FOL;
		_this.lastMatricula = -1;
		_this.lastIdSustentante = options.idSustentante;
		_this.lastNombre = "";
		_this.lastPrimerApellido = "";
		_this.lastSegundoApellido = "";
		_this.lastIdFigura = -1;
		_this.lastIdVarianteFigura = -1;
		
		$.ajax({
			url: _this.findAllByIdSustentanteUrl + "/" + options.idSustentante, 
			beforeSend: function(xhr){
				_this._startProcessing();
			}
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object.list
			
				_this.count = data.object.count;
				_this.offset = options.offset;
				_this.sort = options.sort;
				_this.order = options.order;
				_this.reset( null );
				
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
	},
	findAll: function(options){ //Async		
		var _this = this;

		_this.lastQuery = app.EXP_CEA_SELECTED_TAB_BAV; //EXP_CEA_SELECTED_TAB_MAT,EXP_CEA_SELECTED_TAB_FOL,
		_this.lastMatricula = -1;
		_this.lastIdSustentante = -1;
		_this.lastNombre = options.nombre;
		_this.lastPrimerApellido = options.primerApellido;
		_this.lastSegundoApellido = options.segundoApellido;
		_this.lastIdFigura = options.idFigura;
		_this.lastIdVarianteFigura = options.idVarianteFigura;
		
		$.ajax({
			url: _this.findAllUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			data: {
				max: options.max, 
				offset: options.offset, 
				sort: options.sort, 
				order: options.order,
				nom: options.nombre,
				ap1: options.primerApellido,
				ap2: options.segundoApellido,
				idfig: options.idFigura,
				idvarfig: options.idVarianteFigura
			},
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object.list
			
				_this.count = data.object.count;
				_this.offset = options.offset;
				_this.sort = options.sort;
				_this.order = options.order;
				_this.reset( null );
				
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
		
	},
	sendAllToLote: function(options){ //Async
		var _this = this;
		var ids = new Array();
		
		//Rellena con ids seleccionados de los certificados
		this.each(function(item){ 
			if(item.get('viewChecked') == true && item.get('yaEnLote') == false){
				ids.push(item.get('grailsId'));
				item.set({'procesando':true});
			}
			else if(item.get('viewChecked') == true && item.get('yaEnLote') == true){
				item.set({'viewChecked':false});
			}
		}, this);
	
		if(ids.length > 0){
			
			$.ajax({
				url: _this.sendAllToLoteUrl, 
				beforeSend: function(xhr){
					_this._startProcessing();
				},
				data: JSON.stringify( { 'ids' : ids } ),
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				type: 'POST'
			}).done( function(data){
				if(data.status == "OK"){
					_this.each(function(item){ 
						if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
							item.set({'viewChecked':false},{silent:true});
							item.set({'yaEnLote':true},{silent:true});
							item.set({'procesando':false});
						}
					}, _this);
					_this._stopProcessing();
					_this.trigger('sentToLote');
				}
				else{
					_this.each(function(item){ 
						if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
							item.set({'procesando':false});
						}
					}, _this);
					_this._stopProcessingWithError();
				}
			} );
			
		}
	},
	
	getCurrentPage: function(){
		return Math.floor(this.offset/this.max) + 1;
	},
	getTotalPages: function(){
		console.log("COUNT: " + this.count + ";MAX: " + this.max);
		return Math.ceil(this.count/this.max);
	},
	getNextPage: function(){
		var nextPage = 0;
		nextPage = this.getCurrentPage() + 1;
		return nextPage;
	},
	getBackPage: function(){
		var backPage = 0;
		backPage = this.getCurrentPage() - 1;
		return backPage;
	},
	
	sortAndOrderBy: function(order,sort){
		var _this = this;
		
		this.sort = sort;
		this.order = order;
		
		if(this.lastQuery == app.EXP_CEA_SELECTED_TAB_BAV){
			this.findAll({ 
				max: _this.max, 
				offset: _this.offset, 
				sort: _this.sort, 
				order: _this.order,
				nombre: _this.lastNombre,
				primerApellido: _this.lastPrimerApellido,
				segundoApellido: _this.lastSegundoApellido,
				idFigura: _this.lastIdFigura,
				idVarianteFigura: _this.lastIdVarianteFigura
			});
		}
		
	},
	goToPage: function(pagenum){
		var _this = this;
		this.offset = ((pagenum-1) * _this.max);
		
		if(this.lastQuery == app.EXP_CEA_SELECTED_TAB_BAV){
			this.findAll({ 
				max: _this.max, 
				offset: _this.offset, 
				sort: _this.sort, 
				order: _this.order,
				nombre: _this.lastNombre,
				primerApellido: _this.lastPrimerApellido,
				segundoApellido: _this.lastSegundoApellido,
				idFigura: _this.lastIdFigura,
				idVarianteFigura: _this.lastIdVarianteFigura
			});
		}
	},
	
	_getResult: function(result){
		var elemento = new app.ResultVM();
		var _this = this;
	
		elemento.set('grailsId',result.id);
		elemento.set('idSustentante',result.idSustentante);
		elemento.set('numeroMatricula',result.numeroMatricula);
		elemento.set('nombre',result.nombre);
		elemento.set('primerApellido',result.primerApellido);
		elemento.set('segundoApellido',result.segundoApellido);
		elemento.set('idFigura',result.idFigura);
		elemento.set('dsFigura',result.dsFigura);
		elemento.set('idVarianteFigura',result.idVarianteFigura);
		elemento.set('dsVarianteFigura',result.dsVarianteFigura);
		
		elemento.set('yaEnLote',result.yaEnLote); // <- checar con los que ya estan en lote
		elemento.set('procesando',false);
		
		elemento.set('viewChecked',false);
		elemento.set('sendToLoteUrl',this.sendToLoteUrl + '/' + result.id); // <- enviar URL
		
		this.listenTo( elemento, 'processingStarted', this._startProcessing );
		this.listenTo( elemento, 'processingStopped', this._stopProcessing );
		this.listenTo( elemento, 'processingError', this._stopProcessingWithError );
		this.listenTo( elemento, 'sentToLote', function(){ _this.trigger('sentToLote'); } );
		
		return elemento;
	}
	
});

app.ResultsVM = Backbone.Model.extend({
	defaults: {
		results: new app.ResultVMCollection(),
		
		totalEnLote: 0,
		totalEnLoteUrl: "",
		verLoteUrl: "",
		
		_intervalTotalEnLote: 0,
		_timeElapsedTotalEnLote: 0,
		
		
		state: app.EXP_CEA_RSLTS_ST_READY,
		error: false
	},
	_refreshTotalEnLote: function(){
		var _this = this;
		
		$.ajax({
			url: _this.get('totalEnLoteUrl'), 
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
				_this.set('totalEnLote',data.object);
			}
		} );
	},
	startRefreshingTotalEnLote: function(){
		var _this = this;
		//no se si ya se debe iniciar aqui
		_this._refreshTotalEnLote();
		_this.set('_intervalTotalEnLote', window.setInterval( function(){ 
			_this._refreshTotalEnLote();
			_this.set('_timeElapsedTotalEnLote', _this.get('_timeElapsedTotalEnLote')+app.EXP_CEA_REFRESH_MILIS )
		}, app.EXP_CEA_REFRESH_MILIS ) );
	},
	stopRefreshingTotalEnLote: function(){
		var _this = this;
		window.clearInterval(_this.get('_intervalTotalEnLote'));
		_this.set('_timeElapsedTotalEnLote', 0);
	},
	forceRefreshTotalEnLote: function(){
		console.log('paso por el force refresh');
		this.stopRefreshingTotalEnLote();
		this.startRefreshingTotalEnLote();
	}
});

app.CertPendAutMainView = Backbone.View.extend({
	el: '#divCertPendAut',
	template: _.template( $('#certPendAutMainTemplate').html() ),
	options: {},
	
	initialize: function(options){
		//this.collection = new app.PuestoViewModelCollection(initialData);
		this.options = options;
		this.render();
		//this.listenTo( this.collection, 'add', this.renderList );
		//this.listenTo( this.collection, 'sort', this.renderList );
	},
	
	//MÉTODOS DE RENDEREO
	render: function(){
		this.$el.html( this.template() );
		this.renderMatriculaTabView();
		this.renderFolioTabView();
		this.renderBusqAvView();
		this.renderResultView();
		return this;
	},
	renderMatriculaTabView: function(){
		var parentView = this;
		var model = new app.MatriculaTabVM();
		var collection = this.options.resultVMCollection;
		
		this.$(".tab-pane-matricula").html("");
		var view = new app.MatriculaTabView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-matricula").append( view.render().el );
		return view;
	},
	renderFolioTabView: function(){
		var parentView = this;
		var model = new app.MatriculaTabVM();
		var collection = this.options.resultVMCollection;
		
		model.results = collection;
		
		this.$(".tab-pane-folio").html("");
		var view = new app.FolioTabView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-folio").append( view.render().el );
		return view;
	},
	renderBusqAvView: function(){
		var parentView = this;
		var model = this.options.busqAvVM;
		var collection = this.options.resultVMCollection;
		
		this.$(".tab-pane-busqav").html("");
		var view = new app.BusqAvView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-busqav").append( view.render().el );
		return view;
	},
	renderResultView: function(){
		var parentView = this;
		var model = this.options.resultsVM;
		var collection = this.options.resultVMCollection;
		
		var view = new app.ResultsView({ model:model, collection:collection, parentView:parentView });

		this.$(".div-resultados").html("");
		this.$(".div-resultados").append( view.render().el );
		
		return view;
	}
	
});

app.MatriculaTabView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#matriculaTabTemplate').html() ),
	model: new Backbone.Model(),
	collection: new app.ResultVMCollection(),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		this.collection = options.collection;
		
		//this.render();
		this.listenTo( this.model, 'change:numeroMatricula', this.render );
		this.listenTo( this.model, 'change:errorNumeroMatricula', this.renderError );
		
		this.listenTo( this.collection, 'processingStarted', this.disableInput );
		this.listenTo( this.collection, 'processingStopped', this.enableInput );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		if( this.model.get('errorNumeroMatricula') == true ){
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		else{
			this.$('.div-numeroMatricula').removeClass('has-error');
		}
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
	},
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByNumeroMatricula',
		'change .field' : 'updateModel'
	},
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	},
	
	limpiar : function(e){
		e.preventDefault();
		this.model.set("numeroMatricula","");
	},
	findByNumeroMatricula : function(e){
		e.preventDefault();
		if(this.validate()){
			this.collection.findAllByMatricula({ max:1, offset:0, sort:"id", order:"desc", numeroMatricula: this.model.get('numeroMatricula') });
		}		
	},
	validate: function(){
		var valid = true;
		var numericRegEx = /^[0-9]{1,10}$/;
		
		this.model.set('errorNumeroMatricula', false);
		
		if( !numericRegEx.test( this.model.get('numeroMatricula') ) ){
			valid = false;
			this.model.set('errorNumeroMatricula', true);
		}
		
		return valid;
	}
});

app.FolioTabView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#folioTabTemplate').html() ),
	model: new Backbone.Model(),
	collection: new app.ResultVMCollection(),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		this.collection = options.collection;
		
		//this.render();
		this.listenTo( this.model, 'change:idSustentante', this.render );
		this.listenTo( this.model, 'change:errorIdSustentante', this.renderError );
		
		this.listenTo( this.collection, 'processingStarted', this.disableInput );
		this.listenTo( this.collection, 'processingStopped', this.enableInput );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		if( this.model.get('errorIdSustentante') == true ){
			this.$('.div-idSustentante').addClass('has-error');
		}
		else{
			this.$('.div-idSustentante').removeClass('has-error');
		}
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
	},
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findByIdSustentante',
		'change .field' : 'updateModel'
	},
	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	},
	
	limpiar : function(e){
		e.preventDefault();
		this.model.set("idSustentante","");
	},
	findByIdSustentante : function(e){
		e.preventDefault();
		if(this.validate()){
			this.collection.findAllByIdSustentante({ max:1, offset:0, sort:"id", order:"desc", idSustentante: this.model.get('idSustentante') });
		}		
	},
	validate: function(){
		var valid = true;
		var numericRegEx = /^[0-9]{1,10}$/;
		
		this.model.set('errorIdSustentante', false);
		
		if( !numericRegEx.test( this.model.get('idSustentante') ) ){
			valid = false;
			this.model.set('errorIdSustentante', true);
		}
		
		return valid;
	}
	
});

app.BusqAvView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#busqAvTemplate').html() ),
	model: new Backbone.Model(),
	collection: new app.ResultVMCollection(),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		this.collection = options.collection;
		
		//this.render();
		
		this.listenTo( this.model, 'change:nombre', this.changeNombreField );
		this.listenTo( this.model, 'change:primerApellido', this.changePrimerApellidoField );
		this.listenTo( this.model, 'change:segundoApellido', this.changeSegundoApellidoField );
		this.listenTo( this.model, 'change:idFigura', this.changeIdFiguraField );
		
		this.listenTo( this.model, 'change:viewVariantesFigura', this.renderVariantesFigura );
		
		this.listenTo( this.collection, 'processingStarted', this.disableInput );
		this.listenTo( this.collection, 'processingStopped', this.enableInput );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderError();
		return this;
	},
	renderError: function(){
		/*if( this.model.get('errorIdSustentante') == true ){
			this.$('.div-idSustentante').addClass('has-error');
		}
		else{
			this.$('.div-idSustentante').removeClass('has-error');
		*/
	},
	renderVariantesFigura: function(){
		var vfigsStr = "";
		this.$('.idVarianteFigura').html("");
		this.$('.idVarianteFigura').append('<option value="-1">-Seleccione-</option>');
		var vfigs = this.model.get('viewVariantesFigura');
		for(var i=0; i<vfigs.length; i++){
			vfigsStr += '<option value="' + vfigs[i].id + '">' + vfigs[i].nombre + '</option>'
		}
		this.$('.idVarianteFigura').append(vfigsStr);
	},
	changeNombreField: function(){
		this.$('.nombre').val( this.model.get("nombre") )
	},
	changePrimerApellidoField: function(){
		this.$('.primerApellido').val( this.model.get("primerApellido")  )
	},
	changeSegundoApellidoField: function(){
		this.$('.segundoApellido').val( this.model.get("segundoApellido")  )
	},
	changeIdFiguraField: function(){
		this.$('.idFigura').val( this.model.get("idFigura")  )
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
		this.$("select").prop('disabled',true);
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
		this.$("select").prop('disabled',false);
	},
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findAll',
		'change .field' : 'updateModel'
	},
	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		if(fieldName != "idFigura")
			this.model.set(fieldName,fieldValue,{silent:true});
		else
			this.model.set(fieldName,fieldValue);
	},
	
	limpiar : function(e){
		e.preventDefault();
		this.model.set("nombre","");
		this.model.set("primerApellido","");
		this.model.set("segundoApellido","");
		this.model.set("idFigura",-1);
		//this.model.set("idVarianteFigura","-1",{silent:true});
	},
	
	findAll: function(e){
		e.preventDefault();

		//aqui se deben agregar mas opciones
		this.collection.findAll({ 
			max:10, 
			offset:0, 
			sort:"id", 
			order:"desc",
			nombre: this.model.get("nombre"),
			primerApellido: this.model.get("primerApellido"),
			segundoApellido: this.model.get("segundoApellido"),
			idFigura: this.model.get("idFigura"),
			idVarianteFigura: this.model.get("idVarianteFigura")
		});

	},
	
	validate: function(){
		var valid = true;

		if(
			this.model.get("nombre") == "" &&
			this.model.get("primerApellido") == "" &&
			this.model.get("segundoApellido") == "" &&
			this.model.get("idFigura") == "-1"
		){
			valid = false;
		}
		
		return valid;
	}
	
});

app.ResultView = Backbone.View.extend({
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#resultTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		
		this.render();
		
		this.listenTo( this.model, 'change:viewChecked', this.render );
		this.listenTo( this.model, 'change:procesando', this.render );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.css( "background-color" , this.model.getViewSelectionColor() );
		return this;
	},
	
	events: {
		'click .send' : 'enviarALote',
		'click .check' : 'seleccionar'
	},
	
	enviarALote: function(e){
		e.preventDefault();
		
		var view = this;
		
		this.model.sendToLote();
		
	},
	
	seleccionar: function(e){
		e.preventDefault();
		
		if( this.model.get('viewChecked') == false ){
			this.model.set('viewChecked',true);
		}
		else{
			this.model.set('viewChecked',false);
		}
	}
});

app.ResultsView = Backbone.View.extend({
	parentView: {},
	tagname: 'div',
	template: _.template( $('#resultsTemplate').html() ),
	
	model: new Backbone.Model(),
	
	initialize: function(options){
		this.model = options.model;
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		//this.render();
		this.listenTo( this.model, 'change:state', this.renderStateChange );
		this.listenTo( this.model, 'change:totalEnLote', this.renderTotalEnLoteChange );
		
		this.listenTo( this.collection, 'add', this.renderElement );
		this.listenTo( this.collection, 'reset', this.renderList );
		
		this.listenTo( this.collection, 'processingStarted', this.iniciaProcesamientoPeticion );
		this.listenTo( this.collection, 'processingError', this.errorProcesamientoPeticion );
		this.listenTo( this.collection, 'processingStopped', this.finProcesamientoPeticion );
		this.listenTo( this.collection, 'sentToLote', this.forceRefreshTotalEnLote );

	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderList();
		this.renderStateChange();
		
		return this;
	},
	renderList: function(){
		this.$(".list-items").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
		this.renderPagination();
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.ResultView({model:item,parentView:view});
		elementView.viewModel = this.viewModel;
		this.$(".list-items").append( elementView.render().el );
		return this;
	},
	renderStateChange: function(){
		if(this.model.get('state') == app.EXP_CEA_RSLTS_ST_READY){
			this.$('.procMessage').hide();
			this.enableInput();
		}
		else{
			this.$('.procMessage').show();
			this.disableInput();
		}
		if(this.model.get('error') == false){
			this.$('.errorMessage').hide();
		}
		else{
			this.$('.errorMessage').show();
		}
	},
	renderTotalEnLoteChange: function(){
		this.$('.totalEnLote').html(this.model.get('totalEnLote'));
	},
	renderPagination: function(){
		var paginationStr = "";
		var totalPages = this.collection.getTotalPages();
		var currentPage = this.collection.getCurrentPage();
		
		if(currentPage == 1){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&lt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage-1) + '"><a href="javascript:void(0);">&lt;</a></li>'
		}
		
		for(var i=1; i<=totalPages; i++){
			if(i == currentPage){
				paginationStr += '<li class="active"><a href="javascript:void(0);">' + i + '</a></li>';
			}
			else{
				paginationStr += '<li class="page handCursor" data-page="' + i + '"><a href="javascript:void(0);">' + i + '</a></li>';
			}
		}
		
		if(currentPage == totalPages || totalPages == 0){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&gt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage+1) + '"><a href="javascript:void(0);">&gt;</a></li>'
		}
		
		
		this.$(".pagination").html("");
		this.$(".pagination").html(paginationStr);
	},
	disableInput: function(){
		this.$("input").prop('disabled',true);
		this.$("button").prop('disabled',true);
		this.$("select").prop('disabled',true);
	},
	enableInput: function(){
		this.$("input").prop('disabled',false);
		this.$("button").prop('disabled',false);
		this.$("select").prop('disabled',false);
	},
	
	events: {
		'click .hideSent' : 'ocultarElementoEnviados',
		'click .selectAll' : 'seleccionarTodos',
		'click .selectNone' : 'quitarSeleccionTodos',
		'click .sendSelected' : 'enviarSeleccionadosLote',
		'click .viewLote' : 'verLote',
		'click .sort': 'mandarOrdenar',
		'click .page': 'mandarAPagina'
	},
	
	ocultarElementoEnviados: function(e){
		e.preventDefault();
	},
	seleccionarTodos: function(e){
		e.preventDefault();
		
		this.collection.each( function(item){
			item.set('viewChecked',true);
		},this );
		
	},
	quitarSeleccionTodos: function(e){
		e.preventDefault();
		
		this.collection.each( function(item){
			item.set('viewChecked',false);
		},this );
		
	},
	enviarSeleccionadosLote: function(e){
		e.preventDefault();
		this.collection.sendAllToLote();
	},
	
	verLote: function(e){
		e.preventDefault();
		window.location.assign(this.model.get('verLoteUrl'));
	},
	
	mandarOrdenar: function(e){
		var order = this.$(e.currentTarget).data("order");
		var sort = this.$(e.currentTarget).data("sort");
		
		e.preventDefault();
		this.collection.sortAndOrderBy(order,sort);
	},
	mandarAPagina: function(e){
		var pagina = this.$(e.currentTarget).data("page");

		e.preventDefault();
		//si no se esta procesando nada en la colección
		if(!this.collection.isProcessing()){
			this.collection.goToPage(pagina);
		}
	},
	
	iniciaProcesamientoPeticion: function(){
		this.model.set('error',false);
		this.model.set('state',app.EXP_CEA_RSLTS_ST_PROC);
	},
	
	finProcesamientoPeticion: function(){
		this.model.set('error',false);
		this.model.set('state',app.EXP_CEA_RSLTS_ST_READY);
	},
	
	errorProcesamientoPeticion: function(){
		this.model.set('error',true);
		this.model.set('state',app.EXP_CEA_RSLTS_ST_READY);
	},
	
	forceRefreshTotalEnLote: function(){
		this.model.forceRefreshTotalEnLote();
	}
});