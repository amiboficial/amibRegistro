var app = app || {};

app.EXP_LEA_RSLTS_ST_READY = 0;
app.EXP_LEA_RSLTS_ST_PROC = 1;

app.EXP_LEA_RSLT_NOSEL_COLOR = "#FFFFFF"; //blanco
app.EXP_LEA_RSLT_SEL_COLOR = "#D9EDF7"; //azul claro
app.EXP_LEA_RSLT_ENLOTE_COLOR = "#EFEDFA"; //morado claro
app.EXP_LEA_RSLT_SELENLOTE_COLOR = "#DEF7D9"; //verde claro
app.EXP_LEA_RSLT_PROC_COLOR = "#F8FAED"; //amarizho

app.LoteElementVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		idSustentante: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		
		checked: false,
		showing: true
	},
	getViewSelectionColor: function(){
		if(this.get('checked')){
			colorHexStr = app.EXP_LEA_RSLT_SEL_COLOR;
		}
		else{
			colorHexStr = app.EXP_LEA_RSLT_NOSEL_COLOR;
		}
		return colorHexStr;
	}
});

app.LoteElementCollectionVM = Backbone.Collection.extend({
	model: app.LoteElementVM,
	max: 10,
	offset: 0,
	
	state: app.EXP_LEA_RSLTS_ST_READY,
	error: false,
	
	getAllCompleteResultUrl: '',
	removeUrl: '',
	removeAllUrl: '',
	emptyUrl: '',
	exportxlsUrl: '',
		
	initialize: function(options){
		this.getAllCompleteResultUrl = options.getAllCompleteResultUrl;
		this.removeUrl = options.removeUrl;
		this.removeAllUrl = options.removeAllUrl;
		this.emptyUrl = options.emptyUrl;
		this.exportxlsUrl = options.exportxlsUrl;
        // if collection is empty, fetch from server
        if(this.size() == 0)
            this.fetchAll();
    },

	comparator : 'grailsId',
    changeComparator: function (sortProperty) {
		if( sortProperty == 'grailsId' || sortProperty == 'idSustentante' ||
			sortProperty == 'nombre' || sortProperty == 'primerApellido' || 
			sortProperty == 'segundoApellido' ){
			 this.comparator = sortProperty;
		}
    },
	
	/* ESTADOS DE PROCESAMIENTO */
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
	
	/* PAGINADO */
	getCurrentPage: function(){
		return Math.floor(this.offset/this.max) + 1;
	},
	getTotalPages: function(){
		console.log("COUNT: " + this.count + ";MAX: " + this.max);
		return Math.ceil(this.size()/this.max);
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
	
	/* OBTENICION DE DATOS AJAX */
	fetchAll: function(){
		
		var _this = this;
		
		$.ajax({
			url: _this.getAllCompleteResultUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
			
				var listE = data.object
				_this.changeComparator('nombre');
				_this.reset( null );
				for(var i=0; i<listE.length; i++){					
					var elemento = _this._getResult(listE[i]);	
					_this.add(elemento);
				}
				_this.setOffset(0);
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
		
	},
	
	/* ORDENAMIENTO DE DATOS */
	sortAndOrderBy: function(order,sort){
		console.log("sortAndOrderBy: " + order + "," + sort);
		this.changeComparator(sort);
		this.sort({silent:true});
		if(order == 'desc'){
			this.models.reverse();
		}
		this.refreshShowing();
	},
	
	/* CAMBIO DE PAGINA */
	setOffset: function(offset){
		this.offset = offset;
		this.refreshShowing();
	},
	goToPage: function(pagenum){
		this.setOffset((pagenum-1) * this.max);
	},
	
	/* CUANDO EL VALOR DE OFFSET ES CAMBIADO, AUTOMATICAMENTE SE CAMBIA LOS VISIBLES */
	refreshShowing: function(){
		var i = 0;
		//var _this = this;
		var upperLimitEx = (this.offset+this.max);
		
		i = 0;
		this.forEach( function(item){
			if(i >= this.offset && i < upperLimitEx ){
				item.set('showing',true);
				item.set('checked',false);
			}
			else{
				item.set('showing',false);
				item.set('checked',false);
			}
			i++;
		} , this );
		
		this.trigger('reset', this, {});
	},
	
	/* MÉTODOS "PRIVADOS" CON LOS QUE SE "COPIA" LA INFORMACIÓN DEL JSON RECIBIDO */
	
	_getResult: function(result){
		var elemento = new app.LoteElementVM();
		var _this = this;
		elemento.set(result);
		elemento.set( { checked: false, showing: true } );
		return elemento;
	},
	
	/* MÉTODOS DEL MODELO  */
	selectAll: function(){
		this.each( function(item){
			if(item.get('showing') == true){
				item.set('checked',true);
			}
		},this );
	},
	selectNone: function(){
		this.each( function(item){
			if(item.get('showing') == true){
				item.set('checked',false);
			}
		},this );
	},
	removeSelected: function(){
		//MANDA LLAMAR A METODO AJAX PARA HACER EL ELIMINADO
			//en caso de que no sirva, triggerea error
		//HACE UN "REFETCH" DE LOS DATOS
			//en caso de que no sirva, triggerea error
		
		var _this = this;
		var ids = new Array();
		var modelsToDelete = new Array();
		
		//llena el arreglo con los ids de las certificaciones a eliminar
		this.forEach( function(item){
			if( item.get('checked') ){
				ids.push( item.get('grailsId') );
				modelsToDelete.push( item );
			}
		},this );
		
		$.ajax({
			url: _this.removeAllUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			data: JSON.stringify( { 'ids' : ids } ),
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			type: 'POST'
		}).done( function(data){
			if(data.status == "OK"){
				_this.remove(modelsToDelete, {silent:true} );
				_this.setOffset(0);
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );
	}, 
	empty: function(){
		//MANDA LLAMAR A METODO AJAX PARA HACER EL VACIADO
			//en caso de que no sirva, triggerea error
		//DE HACERLO CORRECTAMIENTE, BORRA TODOS LOS DATOS EN LA COLECCION
		
		var _this = this;
		
		$.ajax({
			url: _this.emptyUrl, 
			beforeSend: function(xhr){
				_this._startProcessing();
			},
			type: 'GET'
		}).done( function(data){
			if(data.status == "OK"){
				_this.reset(null, {silent:true} );
				_this.setOffset(0);
				
				_this._stopProcessing();
			}
			else{				
				_this._stopProcessing();
			}
		} );

	}, 
	exportxls: function(){
		if(this.size() > 0){
			window.open(this.exportxlsUrl,'_blank');
		}
	}
	
});

app.LoteElementView = Backbone.View.extend({ 
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#elemLoteTemplate').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		
		this.render();
		
		this.listenTo( this.model, 'change:checked', this.render );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.$el.css( "background-color" , this.model.getViewSelectionColor() );
		return this;
	},
	
	events: {
		'click .check' : 'seleccionar'
	},
	
	seleccionar: function(e){
		e.preventDefault();
		
		if( this.model.get('checked') == false ){
			this.model.set('checked',true);
		}
		else{
			this.model.set('checked',false);
		}
	}
});

app.LoteElementCollectionView = Backbone.View.extend({
	parentView: {},
	template: _.template( $('#loteEnvAutTemplate').html() ),
	
	initialize: function(options){
		this.collection = options.collection;
		this.parentView = options.parentView;
		
		this.render();
		
		this.listenTo( this.collection, 'add', this.renderElement );
		this.listenTo( this.collection, 'reset', this.renderList );
	},
	
	render: function(){
		this.$el.html( this.template() );
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
		var elementView =  new app.LoteElementView({model:item,parentView:view});
		//elementView.viewModel = this.viewModel;
		
		if(item.get('showing') == true){
			this.$(".list-items").append( elementView.render().el );
		}
		
		return this;
	},
	renderStateChange: function(){
		if(this.collection.state == app.EXP_LEA_RSLTS_ST_READY){
			this.$('.procMessage').hide();
			this.enableInput();
		}
		else{
			this.$('.procMessage').show();
			this.disableInput();
		}
		if(this.collection.error == false){
			this.$('.errorMessage').hide();
		}
		else{
			this.$('.errorMessage').show();
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
		'click .selectAll' : 'seleccionarTodos',
		'click .selectNone' : 'quitarSeleccionTodos',
		'click .removeSelected' : 'eliminarSeleccionadosLote',
		'click .empty' : 'vaciarLote',
		'click .exportxls' : 'exportarExcel',
		'click .sort': 'mandarOrdenar',
		'click .page': 'mandarAPagina'
	},
	
	seleccionarTodos: function(e){
		e.preventDefault();
		this.collection.selectAll();
	},
	quitarSeleccionTodos: function(e){
		e.preventDefault();
		this.collection.selectNone();
	},
	eliminarSeleccionadosLote: function(e){
		e.preventDefault();
		this.collection.removeSelected();
	},
	vaciarLote: function(e){
		e.preventDefault();
		this.collection.empty();
	},
	exportarExcel: function(e){
		e.preventDefault();
		this.collection.exportxls();
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
		this.collection.goToPage(pagina);
	},
});

app.LoteEnvioAutorizacionMainView = Backbone.View.extend({ 
	el: '#divLoteEnvAut',
	options: {},
	
	//ACCIONES AL INICIALIZAR
	initialize: function(options){
		this.options = options;
		this.render();
	},
	
	//MÉTODOS DE RENDEREO
	render: function(){
		this.renderLoteElementCollectionView();
		return this;
	},
	renderLoteElementCollectionView: function(){
		var parentView = this;
		var collection = new app.LoteElementCollectionVM( { 
			getAllCompleteResultUrl: this.options.getAllCompleteResultUrl,  
			removeUrl: this.options.removeUrl, 
			removeAllUrl: this.options.removeAllUrl,
			emptyUrl: this.options.emptyUrl,
			exportxlsUrl: this.options.exportxlsUrl
		} );
		
		var view = new app.LoteElementCollectionView({ collection:collection, parentView:parentView });
		
		this.$el.html("");
		this.$el.append( view.render().el );
		
		return view;
	}
	
});