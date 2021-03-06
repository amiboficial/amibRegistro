var app = app || {};

app.AutBrwResVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		idSustentante: -1,
		numeroMatricula: -1,
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		
		nombreFigura: '',
		nombreVarianteFigura: '',
		dsStatusCertificacion: '',
		dsStatusAutorizacion: '',
		dsFechaRangoVigencia: '',
		
		iconoBotonAccion: 'asterisk',
		mensajeBotonAccion: 'Ir a proceso',
		accionUrl: '', //url a la que se dirigirá 
		
		expanded: false
	}
});

app.AutBrwResVMCol = Backbone.Collection.extend({
	model: app.AutBrwResVM,
	
	/* EVENTOS (TRIGGERS) LANZADOS POR ESTE OBJETO */
	// processing
	// errorOnRequest
	// warningNotFound
	//
	//
	
	/* DETALLES DE CONTEO Y ORDENAMIENTO */
	_count: 0,
	_max: 10,
	_offset: 0,
	_sort: "asc",
	_order: "id",
	
	_query: '', //último "metodo" al que se llamo
	_lastAttributes: {}, //últimos atributos, estos se ocupan cuando se hace un sort o un cambio de página
	
	
	/* URL PARA OBTENER RESULTADOS */
	/*
	** esto puede variar dependiendo de las
	** reglas aplicadas por "controlador", 
	** p.ej. "obtener los aptos para cambio de figura",
	** "obtener a los aptos para reposición", etc.
	*/
	findAllByNumeroMatriculaUrl: '',
	findAllByIdSustentanteUrl: '',
	findAllByNombresAndCertificacionUrl: '',
	getAllUrl: '',
	
	/* NOTIFICACION DE ESTATUS DE PROCESAMIENTO Y ERROR */
	_processing: false,
	_errorOnRequest: false,
	_warningNotFound: false,
	isProcessing: function(){
		return this._processing;
	},
	setProcessingStatus: function(processingSt){
		this._processing = processingSt;
		this.trigger('processing',processingSt);
	},
	setErrorOnRequest: function(errorSt){
		this._errorOnRequest = errorSt;
		this.trigger('errorOnRequest',errorSt);
	},
	getErrorOnRequest: function(){
		return this._errorOnRequest;
	},
	setWarningNotFound: function(warnSt){
		this._warningNotFound = warnSt;
		this.trigger('warningNotFound',warnSt);
	},
	getWarningNotFound: function(){
		return this._warningNotFound;
	},
	
	/* OBTENCION DE ELEMENTOS EN LA COLECCION ACTUAL */
	getItemBy: function(fieldName, fieldExpectedValue){
		var seleccionado = null;
		this.each(function(item){
			if( item.get(fieldName) == fieldExpectedValue ){
				seleccionado = item;
			}
		},this);
		return seleccionado;
	},
	
	/* CONSULTAS AJAX */
	_sendQuery: function(optionsToSend,urlToSend){
		var _this = this;
		$.ajax({
			url: urlToSend, 
			beforeSend: function(xhr){
				_this.setProcessingStatus(true);
				_this.setWarningNotFound(false);
				_this.setErrorOnRequest(false);
			},
			data: optionsToSend,
			type: 'GET'
		}).done( function(data){
			_this.reset( null );
			if(data.status == "OK"){
				var listE = data.list
				var countE = data.count
				if(countE > 0){
					for(var i=0; i<listE.length; i++){
						_this.add(new app.AutBrwResVM(listE[i])); //de esta forma el JSON se convierte al "model" de backbone
					}
					_this._count = countE;
				}
				else{
					_this.setWarningNotFound(true);
				}
				_this.trigger('reset', this, {});
				_this.setProcessingStatus(false);
			}
			else{
				_this.setErrorOnRequest(true);
				_this.setProcessingStatus(false);
			}
		} );
	},
	findAllByNumeroMatricula: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = options.max;
		this._offset = options.offset;
		this._sort = options.sort;
		this._order = options.order;
		
		this._query = 'findAllByNumeroMatricula';
		this._lastAttributes = { numeroMatricula: options.numeroMatricula }
		
		this._sendQuery( options ,this.findAllByNumeroMatriculaUrl );
	},
	findAllByIdSustentante: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = options.max;
		this._offset = options.offset;
		this._sort = options.sort;
		this._order = options.order;
		
		this._query = 'findAllByIdSustentante';
		this._lastAttributes = { idSustentante: options.idSustentante }
		
		this._sendQuery( options ,this.findAllByIdSustentanteUrl );
	},
	findAllByNombresAndCertificacion: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = options.max;
		this._offset = options.offset;
		this._sort = options.sort;
		this._order = options.order;
		
		this._query = 'findAllByNombresAndCertificacion';
		this._lastAttributes = { 
			nombre: options.nombre,
			primerApellido: options.primerApellido,
			segundoApellido: options.segundoApellido,
			idFigura: options.idFigura,
			idVarianteFigura: options.idVarianteFigura
		}
		
		this._sendQuery( options ,this.findAllByNombresAndCertificacionUrl );
	},
	getAll: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = options.max;
		this._offset = options.offset;
		this._sort = options.sort;
		this._order = options.order;
		
		this._query = 'getAll';
		this._lastAttributes = { 
			nombre: '',
			primerApellido: '',
			segundoApellido: '',
			idFigura: -1,
			idVarianteFigura: -1
		}
				
		this._sendQuery( options ,this.getAllUrl );
	},
	sortAndOrderBy: function(order, sort){
		var _this = this;
		
		this._order = order;
		this._sort = sort;
		
		if(this._query == "findAllByNumeroMatricula"){
			this.findAllByNumeroMatricula({
				max: _this._max,
				offset: 0,
				sort: _this._sort,
				order: _this._order,
				
				numeroMatricula: _this._lastAttributes.numeroMatricula
			});
		}
		else if(this._query == "findAllByIdSustentante"){
			this.findAllByNumeroMatricula({ 
				max: _this._max,
				offset: 0,
				sort: _this._sort,
				order: _this._order,
				
				idSustentante: _this._lastAttributes.idSustentante
			});
		}
		else if(this._query == "findAllByNombresAndCertificacion"){
			this.findAllByNombresAndCertificacion({ 
				max: _this._max,
				offset: 0,
				sort: _this._sort,
				order: _this._order,
				
				nombre: _this._lastAttributes.nombre,
				primerApellido: _this._lastAttributes.primerApellido,
				segundoApellido: _this._lastAttributes.segundoApellido,
				idFigura: _this._lastAttributes.idFigura,
				idVarianteFigura: _this._lastAttributes.idVarianteFigura
			});
		}
		else if(this._query == "getAll"){
			this.getAll({
				max: _this._max,
				offset: 0,
				sort: _this._sort,
				order: _this._order
			});
		}
	},
	goToPage: function(pagenum){
		var _this = this;
		this._offset = ((pagenum-1) * _this._max);
		
		if(this._query == "findAllByNumeroMatricula"){
			this.findAllByNumeroMatricula({
				max: _this._max,
				offset: _this._offset,
				sort: _this._sort,
				order: _this._order,
				
				numeroMatricula: _this._lastAttributes.numeroMatricula
			});
		}
		else if(this._query == "findAllByIdSustentante"){
			this.findAllByNumeroMatricula({ 
				max: _this._max,
				offset: _this._offset,
				sort: _this._sort,
				order: _this._order,
				
				idSustentante: _this._lastAttributes.idSustentante
			});
		}
		else if(this._query == "findAllByNombresAndCertificacion"){
			this.findAllByNombresAndCertificacion({ 
				max: _this._max,
				offset: _this._offset,
				sort: _this._sort,
				order: _this._order,
				
				nombre: _this._lastAttributes.nombre,
				primerApellido: _this._lastAttributes.primerApellido,
				segundoApellido: _this._lastAttributes.segundoApellido,
				idFigura: _this._lastAttributes.idFigura,
				idVarianteFigura: _this._lastAttributes.idVarianteFigura
			});
		}
		else if(this._query == "getAll"){
			this.getAll({
				max: _this._max,
				offset: _this._offset,
				sort: _this._sort,
				order: _this._order
			});
		}
	},
	
	/* METODOS CON DETALLES DE PAGINACION */
	getCurrentPage: function(){
		return Math.floor(this._offset/this._max) + 1;
	},
	getTotalPages: function(){
		return Math.ceil(this._count/this._max);
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

	/* MÉTODOS ADICIONALES */
	expandResult: function(grailsId){
		var item = this.getItemBy('grailsId',grailsId);
		item.set('expanded',true);
		this.trigger('itemChanged',item);
	},
	collapseResult: function(grailsId){
		var item = this.getItemBy('grailsId',grailsId);
		item.set('expanded',false);
		this.trigger('itemChanged',item);
	},
	expandAllResults: function(){
		this.each( function(item){
			item.set('expanded',true)
		},this );
		this.trigger('itemChanged',{});
	},
	collapseAllResults: function(){
		this.each( function(item){
			item.set('expanded',false)
		},this );
		this.trigger('itemChanged',{});
	}
	
});

app.AutBrwResColView = Backbone.View.extend({
	el: '#divAutBrwRes',
	
	template: _.template( $('#templateAutBrwResultsView').html() ) ,
	templateItem: _.template( $('#templateAutBrwResultItemView').html() ) ,
	collection: new app.AutBrwResVMCol(),
	
	initialize: function(options){
		this.collection = options.collection;
		
		this.render();
		
		this.listenTo( this.collection, 'processing', this.renderProcessing );
		this.listenTo( this.collection, 'errorOnRequest', this.renderError );
		this.listenTo( this.collection, 'warningNotFound', this.renderWarning );
		
		this.listenTo( this.collection, 'reset', this.renderList );
		
		this.listenTo( this.collection, 'itemChanged', this.renderList );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		this.renderProcessing();
		this.renderError();
		this.renderWarning();
		return this;
	},
	
	renderList: function(){
		this.$('.list-items').html('');
		this.collection.each( function(item){
			this.$('.list-items').append( this.templateItem( item.toJSON() ) );
			//this.$('.list-items').append( this.templateItem()  );
		},this );
		this.renderPagination();
	},
	renderProcessing: function(){
		if( this.collection.isProcessing() ){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.enableInput();
		}
	},
	renderError: function(){
		var errorOnRequest = this.collection.getErrorOnRequest();
		
		this.$('.alert-errorOnRequest').hide();
		
		if(errorOnRequest){
			this.$('.alert-errorOnRequest').show();
		}
	},
	renderWarning: function(){
		var warningNotFound = this.collection.getWarningNotFound();
		
		this.$('.alert-warningNotFound').hide();
		
		if(warningNotFound){
			this.$('.alert-warningNotFound').show();
		}
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
		this.$('input').prop('disabled',true);
		this.$('select').prop('disabled',true);
		this.$('button').prop('disabled',true);
	},
	enableInput: function(){
		this.$('input').prop('disabled',false);
		this.$('select').prop('disabled',false);
		this.$('button').prop('disabled',false);
	},
	
	events: {
		'click .sort': 'mandarOrdenar',
		'click .page':'irPagina',
		'click .performAction': 'realizarAccion',
		'click .showinfo': 'mostrarInfoAdicional',
		'click .hideinfo': 'ocultarInfoAdicional',
		'click .showallinfo': 'mostrarInfoAdicionalTodos',
		'click .hideallinfo': 'ocultarInfoAdicionalTodos',
	},
	
	mandarOrdenar: function(ev){
		var order = this.$(ev.currentTarget).data("order");
		var sort = this.$(ev.currentTarget).data("sort");
		
		this.collection.sortAndOrderBy(order,sort);
	},
	
	irPagina: function(ev){
		var pagenum =  this.$(ev.currentTarget).data("page");
		
		this.collection.goToPage(pagenum);
	},
	
	realizarAccion: function(ev){
		var grailsId = this.$(ev.currentTarget).data("grailsid"); //el atributo data-* solo permite minusculas
		var seleccionado = this.collection.getItemBy('grailsId', grailsId);
		
		console.dir(seleccionado);
		
		if(seleccionado != null){
			window.location.assign( seleccionado.get('accionUrl') )
			//alert('NOT YET IMPLEMENTED - realizarAccion');
		}
	},
	
	mostrarInfoAdicional: function(ev){
		var grailsId = this.$(ev.currentTarget).data("grailsid"); //el atributo data-* solo permite minusculas
		
		this.collection.expandResult(grailsId);
	},
	
	ocultarInfoAdicional: function(ev){
		var grailsId = this.$(ev.currentTarget).data("grailsid"); //el atributo data-* solo permite minusculas
		
		this.collection.collapseResult(grailsId);
	},
	
	mostrarInfoAdicionalTodos: function(){
		this.collection.expandAllResults();
	},
	
	ocultarInfoAdicionalTodos: function(){
		this.collection.collapseAllResults();
	}
});