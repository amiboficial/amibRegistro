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

app.REV_IDX_OPTION_NUMESCRITURA = 0;
app.REV_IDX_OPTION_FECREV = 1;
app.REV_IDX_OPTION_ENTFINANCIERA = 2;

app.RevocacionSearchResultVM = Backbone.Model.extend({
	defaults:{
		grailsId: -1,
		numeroEscritura: -1,
		fechaRevocacionUnixEpoch: 0,
		fechaRevocacionDDMMYYYY: '',
		nombreCompletoNotario: ''
	},
});

app.RevocacionSearchResultVMCollection = Backbone.Collection.extend({
	model: app.RevocacionSearchResultVM,
	
	_max: 10,
	_offset: 0,
	_sort: "asc",
	_order: "grailsId",
	
	_query: '', //último "metodo" al que se llamo
	_lastAttributes: {}, //últimos atributos, estos se ocupan cuando se hace un sort o un cambio de página
	
	findAllByNumeroEscrituraUrl: '',
	findAllByFechaRevocacionUrl: '',
	findAllByGrupoFinancieroUrl: '',
	findAllByInstitucionUrl: '',
	
	/* NOTIFICACION DE ESTATUS DE PROCESAMIENTO */
	_processing: false,
	_error: false,
	isProcessing: function(){
		return this._processing;
	},
	setProcessingStatus: function(processingSt){
		this._processing = processingSt;
		this.trigger('processing',processingSt);
	},
	setErrorStatus: function(errorSt){
		this._error = false;
		this.trigger('error',errorSt);
	},
	
	/* CONSULTAS AJAX */
	findAllByNumeroEscritura: function(options){
		alert('NOT YET IMPLEMENTED');
	},
	findAllByFechaRevocacion: function(options){
		alert('NOT YET IMPLEMENTED');
	},
	findAllByGrupoFinanciero: function(options){
		alert('NOT YET IMPLEMENTED');
	},
	findAllByInstitucion: function(options){
		alert('NOT YET IMPLEMENTED');
	},
	sortAndOrderBy: function(order, sort){
		alert('NOT YET IMPLEMENTED');
	},
	goToPage: function(pagenum){
		alert('NOT YET IMPLEMENTED');
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
	}
});

app.RevocacionSearchVM = Backbone.Model.extend({
	defaults:{
		numeroEscritura: -1,
		fechaRevocacionDel_day: -1,
		fechaRevocacionDel_month: -1,
		fechaRevocacionDel_year: -1,
		fechaRevocacionAl_day: -1,
		fechaRevocacionAl_month: -1,
		fechaRevocacionAl_year: -1,
		nombreCompletoNotario: '',
		idGrupoFinanciero: -1,
		gruposFinancieros: [ {id:'-1',text:'-Seleccione-',instituciones:[]} ] ,
		idInstitucion: -1,
		instituciones: [ {id:'-1',text:'-Seleccione-'} ],
		
		criterioBusqueda: app.REV_IDX_OPTION_NUMESCRITURA,
		
		processing: false,
		
		errorNumeroEscrituraBlank: false,
		errorNumeroEscrituraNonNumeric: false,
		errorFechaRevocacionDelBlank: false,
		errorFechaRevocacionAlBlank: false,
		errorFechaRevocacionWrongRange: false,
		errorGrupoFinancieroNonSelected: false
	},
});

app.RevocacionResultsView = Backbone.View.extend({
	template: _.template( $('#revocacionResultsViewTemplate').html() ),
	templateElement: _.template( $('#revocacionResultViewTemplate').html() ),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.collection = options.collection;
		
		this.render();
		
		this.listenTo( this.collection, 'processing', this.renderProcessing );
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		this.renderProcessing();
		return this;
	},
	
	renderList: function(){
		this.$('.list-items').html('');
		this.collection.each( function(item){
			this.$('.list-items').append( this.templateElement( item.toJSON() ) );
		},this );
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
	
});

app.RevocacionSearchView = Backbone.View.extend({
	template: _.template( $('#revocacionSearchViewTemplate').html() ),
	model:  new Backbone.Model(),
	searchResultVMCollection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.searchResultVMCollection = options.searchResultVMCollection;
		
		this.render();
		
		this.listenTo( this.collection, 'processing', this.renderProcessing );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		//this.renderProcessing();
		//this.renderCriterioBusqueda();
		return this;
	},
	
	renderProcessing: function(){
		if( this.searchResultVMCollection.isProcessing() ){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.enableInput();
			this.renderCriterioBusqueda();
		}
	},
	
	renderCriterioBusqueda: function(){
		if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_NUMESCRITURA ){
			this.$('.numeroEscritura').prop('disabled',false);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',true);
			this.$('.fechaRevocacionDel_month').prop('disabled',true);
			this.$('.fechaRevocacionDel_year').prop('disabled',true);
			this.$('.fechaRevocacionAl_day').prop('disabled',true);
			this.$('.fechaRevocacionAl_month').prop('disabled',true);
			this.$('.fechaRevocacionAl_year').prop('disabled',true);
			
			this.$('.idGrupoFinanciero').prop('disabled',true);
			this.$('.idInstitucion').prop('disabled',true);
		}
		else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_FECREV ){
			this.$('.numeroEscritura').prop('disabled',true);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',false);
			this.$('.fechaRevocacionDel_month').prop('disabled',false);
			this.$('.fechaRevocacionDel_year').prop('disabled',false);
			this.$('.fechaRevocacionAl_day').prop('disabled',false);
			this.$('.fechaRevocacionAl_month').prop('disabled',false);
			this.$('.fechaRevocacionAl_year').prop('disabled',false);
			
			this.$('.idGrupoFinanciero').prop('disabled',true);
			this.$('.idInstitucion').prop('disabled',true);
		}
		else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_ENTFINANCIERA ){
			this.$('.numeroEscritura').prop('disabled',true);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',true);
			this.$('.fechaRevocacionDel_month').prop('disabled',true);
			this.$('.fechaRevocacionDel_year').prop('disabled',true);
			this.$('.fechaRevocacionAl_day').prop('disabled',true);
			this.$('.fechaRevocacionAl_month').prop('disabled',true);
			this.$('.fechaRevocacionAl_year').prop('disabled',true);
			
			this.$('.idGrupoFinanciero').prop('disabled',false);
			this.$('.idInstitucion').prop('disabled',false);
		}
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
	
	
	
});

app.RevocacionIndexView = Backbone.View.extend({
	el: '#divRevocacionIndex',
	template: _.template( $('#revocacionIndexViewTemplate').html() ),
	searchVM: new Backbone.Model(),
	searchResultVMCollection: new Backbone.Collection(),
	
	initialize: function(options){
		this.searchVM = options.searchVM;
		this.searchResultVMCollection = options.searchResultVMCollection;
		
		this.render();
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(options){
		this.$el.html( this.template() );
		this.renderSearchView();
		this.renderResultsView();
		
		return this;
	},
	
	renderSearchView: function(){
		var parentView = this;
		var view;
		var model = this.searchVM;
		
		view = new app.RevocacionSearchView( { 
			parentView: parentView, 
			model :model, 
			searchResultVMCollection: this.searchResultVMCollection
		} );
		
		this.$('.div-revocacionSearch').html( view.render().el );
		
		return view;
	},
	
	renderResultsView: function(){
		var parentView = this;
		var view;
		var collection = this.searchResultVMCollection;
		
		view = new app.RevocacionResultsView({ 
			parentView:parentView, 
			collection:collection 
		});
		
		this.$('.div-revocacionResults').html( view.render().el );
		
		return view;
	}
	
});