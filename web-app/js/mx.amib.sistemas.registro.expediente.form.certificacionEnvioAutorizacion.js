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
app.EXP_CEA_RSLT_ENLOTE_COLOR = "#DEF7D9"; //verde claro
app.EXP_CEA_RSLT_SELENLOTE_COLOR = "#F2D9F7"; //morado claro


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
	defaults: {
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		idVarianteFigura: -1,
		
		viewFiguras: [],
		viewVariantesFigura: []
	}
});

app.ResultVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		dsFigura: "",
		idVarianteFigura: -1,
		dsVarianteFigura: "",
		
		yaEnLote: false,
		procesando: false,
		
		viewChecked: false,
		
		sendToLoteUrl: "",
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
		return colorHexStr;
	},
	
	//Async
	sendToLote: function(){
		
	}
	
});

app.ResultVMCollection = Backbone.Collection.extend({
	model: app.ResultVM, 
	
	count: -1,
	max: 10,
	offset: 0,
	sort: "id",
	order: "asc",
	
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
	
	findAllByMatricula: function(options){ //Async
		var _this = this;
		/*
		this._startProcessing();
		setTimeout(function(){ _this._stopProcessing(); },3000);
		*/
		$.ajax({
			url: _this.findAllByMatriculaUrl + "/" + options.numeroMatricula, 
			beforeSend: function(xhr){
				_this._startProcessing();
			}
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object.list
			
				_this.reset( null );
				
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				
				_this.count = data.object.count;
				_this.offset = options.offset;
				_this.sort = options.sort;
				_this.order = options.order;
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );

	},
	findAllByIdSustentante: function(options){ //Async
		var _this = this;

		$.ajax({
			url: _this.findAllByIdSustentanteUrl + "/" + options.idSustentante, 
			beforeSend: function(xhr){
				_this._startProcessing();
			}
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object.list
			
				_this.reset( null );
				
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				
				_this.count = data.object.count;
				_this.offset = options.offset;
				_this.sort = options.sort;
				_this.order = options.order;
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
	},
	findAll: function(options){ //Async
		alert("find de coleccion 3 que se realizará async...");
	},
	sendAllToLote: function(options){ //Async
		alert("find de coleccion 4 que se realizará async...");
	},
	
	_getResult: function(certificacion){
		var elemento = new app.ResultVM();
	
		elemento.set('grailsId',certificacion.sustentante.id);
		elemento.set('numeroMatricula',certificacion.sustentante.numeroMatricula);
		elemento.set('nombre',certificacion.sustentante.nombre);
		elemento.set('primerApellido',certificacion.sustentante.primerApellido);
		elemento.set('segundoApellido',certificacion.sustentante.segundoApellido);
		elemento.set('idFigura',certificacion.varianteFigura.idFigura);
		elemento.set('dsFigura',certificacion.varianteFigura.nombreFigura);
		elemento.set('idVarianteFigura',certificacion.varianteFigura.id);
		elemento.set('dsVarianteFigura',certificacion.varianteFigura.nombre);
		
		elemento.set('yaEnLote',false); // <- checar con los que ya estan en lote
		elemento.set('procesando',false);
		
		elemento.set('viewChecked',false);
		elemento.set('sendToLoteUrl',""); // <- enviar URL
		
		return elemento;
	}
	
});

app.ResultsVM = Backbone.Model.extend({
	defaults: {
		showYaEnLote: true,
		totalEnLote: 0,
		
		state: app.EXP_CEA_RSLTS_ST_READY,
		error: false,
		
		count: 95,
		max: 10,
		offset: 0,
		sort: "id",
		order: "asc",
		tab: app.EXP_CEA_SELECTED_TAB_MAT
	},
	getCurrentPage: function(){
		return Math.ceil(offset/max);
	},
	getTotalPages: function(){
		return Math.ceil(count/max);
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
		//this.renderBusqAvView();
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
		
		this.$(".tab-pane-folio").html("");
		var view = new app.FolioTabView({ model:model, collection:collection, parentView:parentView });
		this.$(".tab-pane-folio").append( view.render().el );
		return view;
	},
	renderBusqAvView: function(){
		this.$(".tab-pane-busqav").html("");
		var view = new app.BusqAvView(this.options);
		return view.render();
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
	
	events: {
		'click .clean' : 'limpiar',
		'click .find' : 'findAll'
	},
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
		this.listenTo( this.model, 'change:yaEnLote', this.render );
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
		
		//se debe ejecutar una llamada al servidor donde
		//se envie el elemento al lote
		//y en caso de que el eleemto se actualiza, cambie su estatus
		if( view.model.get('yaEnLote') == false ){
			view.model.set('procesando',true);
			setTimeout(function(){
				view.model.set({'procesando':false},{silent:true});
				view.model.set('yaEnLote',true);
			}, 1200);
		}
		
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
		this.listenTo( this.collection, 'add', this.renderElement );
		this.listenTo( this.collection, 'reset', this.renderList );
		//this.listenTo( this.collection, 'sort', this.renderList );
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
		}
		else{
			this.$('.procMessage').show();
		}
		if(this.model.get('error') == false){
			this.$('.errorMessage').hide();
		}
		else{
			this.$('.errorMessage').show();
		}
	},
	
	events: {
		'click .hideSent' : 'ocultarElementoEnviados',
		'click .selectAll' : 'seleccionarTodos',
		'click .selectNone' : 'quitarSeleccionTodos',
		'click .sentSelected' : 'enviarSeleccionadosLote',
		'click .viewLote' : 'verLote'
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
		
		var view = this;
		
		//envía una peticion AJAX "con todos los datos"
		//rendera los que hayan sido satisfactorios
		view.model.set('state',app.EXP_CEA_RSLTS_ST_PROC);
		view.collection.each( function(item){
			if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
				item.set({'procesando':true});
			}
		},view );
		
		setTimeout(function(){
			view.collection.each( function(item){
				if( item.get('viewChecked') == true && item.get('yaEnLote') == false ){
					item.set({'procesando':false},{silent:true});
					item.set('yaEnLote',true);
				}
				view.model.set('state',app.EXP_CEA_RSLTS_ST_READY);
			},view );
		}, 3000);

	},
	verLote: function(e){
		e.preventDefault();
	}
});