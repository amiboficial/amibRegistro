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
	//count: 0,
	max: 10,
	offset: 0,
	
	state: app.EXP_LEA_RSLTS_ST_READY,
	error: false,
	
	initialize: function(){
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
	
	/* METODOS PARA CAMBIO DE VALORES CON "EVENTO" */
	setOffset: function(offset){
		this.offset = offset;
		this.refreshShowing();
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
		
		//Este es un fetch AJAX
		this.add( [{
			grailsId: 1, 
			idSustentante: 1, 
			numeroMatricula: 1, 
			nombre: "ZZZZ", 
			primerApellido: "YYYYYY", 
			segundoApellido: "ZZZZZZZ", 
			
			checked: false, 
			showing: true
		},{
			grailsId: 2, 
			idSustentante: 2, 
			numeroMatricula: 2, 
			nombre: "ABELARDO", 
			primerApellido: "YYYYYYAAAAA", 
			segundoApellido: "ZZZZZZZAAAAAA", 
			
			checked: false, 
			showing: true
		},{
			grailsId: 3, 
			idSustentante: 3, 
			numeroMatricula: 3, 
			nombre: "JEAN CLAUDE", 
			primerApellido: "YYYYYYBBBB", 
			segundoApellido: "ZZZZZZZBBBB", 
			
			checked: false, 
			showing: true
		},{
			grailsId: 4, 
			idSustentante: 4, 
			numeroMatricula: 4, 
			nombre: "FRANCOIS", 
			primerApellido: "YYYYYYCCCCC", 
			segundoApellido: "ZZZZZZZCCCCCCCC", 
			
			checked: false, 
			showing: true
		},{
			grailsId: 5, 
			idSustentante: 5, 
			numeroMatricula: 5, 
			nombre: "ZZZZDDDDD", 
			primerApellido: "YYYYYYDDDDD", 
			segundoApellido: "ZZZZZZZDDDD", 
			
			checked: false, 
			showing: true
		}] );
		
	},
	
	/* ORDENAMIENTO DE DATOS */
	sortAndOrderBy: function(order,sort){
		console.log("sortAndOrderBy: " + order + "," + sort);
		this.changeComparator(sort);
		this.sort({silent:true});
		if(order == 'desc'){
			this.models.reverse();
		}
		this.trigger('reset', this, {});
	},
	
	/* CAMBIO DE PAGINA */
	goToPage: function(pagenum){
		this.setOffset((pagenum-1) * _this.max);
	},
	
	/* CUANDO EL VALOR DE OFFSET ES CAMBIADO, AUTOMATICAMENTE SE CAMBIA LOS VISIBLES */
	refreshShowing: function(){
		var i = 0;
		var upperLimitEx = (_this.offset+_this.max);
		var _this = this;
		
		i = 0;
		this.forEach( function(item){
			if(i >= _this.offset && i < upperLimitEx ){
				item.set('showing',true);
			}
			else{
				item.set('showing',false);
			}
			i++;
		} , item );
	},
	
	/* MÉTODOS "PRIVADOS" CON LOS QUE SE "COPIA" LA INFORMACIÓN DEL JSON RECIBIDO */
	
	_getResult: function(){
		var elemento = new app.ResultVM();
		var _this = this;
		elemento.set(result);
		elemento.set( { checked: false, showing: true } );
		return elemento;
	},
	
	/* MÉTODOS DEL MODELO  */
	selectAll: function(){
		this.each( function(item){
			item.set('checked',true);
		},this );
	},
	selectNone: function(){
		this.each( function(item){
			item.set('checked',false);
		},this );
	},
	removeSelected: function(){
		//MANDA LLAMAR A METODO AJAX PARA HACER EL ELIMINADO
			//en caso de que no sirva, triggerea error
		//HACE UN "REFETCH" DE LOS DATOS
			//en caso de que no sirva, triggerea error
		console.log('removeSelected - Metodo no implementado');
	}, 
	empty: function(){
		//MANDA LLAMAR A METODO AJAX PARA HACER EL VACIADO
			//en caso de que no sirva, triggerea error
		//DE HACERLO CORRECTAMIENTE, BORRA TODOS LOS DATOS EN LA COLECCION
		console.log('empty - Metodo no implementado');
	}, 
	exportxls: function(){
		//MANDA LLAMAR A METODO 
		console.log('exportxls - Metodo no implementado');
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
		elementView.viewModel = this.viewModel;
		this.$(".list-items").append( elementView.render().el );
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
		var collection = new app.LoteElementCollectionVM();
		
		var view = new app.LoteElementCollectionView({ collection:collection, parentView:parentView });
		
		this.$el.html("");
		this.$el.append( view.render().el );
		
		return view;
	}
	
});