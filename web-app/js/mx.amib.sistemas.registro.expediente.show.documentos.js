var app = app || {};

app.DocumentoSustentanteVM = Backbone.Model.extend({ 
	defaults: { 
		uuid: '',
		dsTipo: '',
		nombre: '',
		vigente: false,
		fechaCarga: 'dd/MM/yyyy',
		fechaCargaUnixEpoch: -1,
		
		visible: false
	}
});

app.DocumentoSustentanteVMCollection = Backbone.Collection.extend({ 
	model: app.DocumentoSustentanteVM,
	
	_offset: 0,
	_max: 10,
	
	_sort: 'asc',
	_order: 'dsTipo',
	
	_count: 0,
	
	comparator: function(itemA, itemB){
		//console.log('sort:' + this._sort + "; order:" + this._order);
		//console.log('comparator called:' +itemA.get('dsTipo').toUpperCase() +":"+ itemB.get('dsTipo').toUpperCase() );
		if(this._sort == "dsTipo"){
			if(this._order == "desc"){
				if(itemA.get('dsTipo').toUpperCase() == itemB.get('dsTipo').toUpperCase())
					return 0;
				else if(itemA.get('dsTipo').toUpperCase() > itemB.get('dsTipo').toUpperCase())
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('dsTipo').toUpperCase() == itemB.get('dsTipo').toUpperCase())
					return 0;
				else if(itemA.get('dsTipo').toUpperCase() <= itemB.get('dsTipo').toUpperCase())
					return -1;
				else
					return 1;
			}
		}	
		else if(this._sort == "nombre"){
			if(this._order == "desc"){
				if(itemA.get('nombre').toUpperCase() == itemB.get('nombre').toUpperCase())
					return 0;
				else if(itemA.get('nombre').toUpperCase() > itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('nombre').toUpperCase() == itemB.get('nombre').toUpperCase())
					return 0;
				else if(itemA.get('nombre').toUpperCase() <= itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "fechaCargaUnixEpoch"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('fechaCargaUnixEpoch')) == parseInt(itemB.get('fechaCargaUnixEpoch')))
					return 0;
				else if(parseInt(itemA.get('fechaCargaUnixEpoch')) > parseInt(itemB.get('fechaCargaUnixEpoch')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('fechaCargaUnixEpoch')) == parseInt(itemB.get('fechaCargaUnixEpoch')))
					return 0;
				else if(parseInt(itemA.get('fechaCargaUnixEpoch')) <= parseInt(itemB.get('fechaCargaUnixEpoch')))
					return -1;
				else
					return 1;
			}
		}
		
	},
	
	sortAndOrderBy: function(sort,order){
		this._sort = sort;
		this._order = order;
		this.sort();
	},
	goToPage: function(pagenum){
		var i = 0;
		var lowerLimitInclusive = 0;
		var upperLimitExclusive = 0;
		
		
		this._offset = (pagenum-1)*this._max;
		lowerLimitInclusive = this._offset;
		upperLimitInclusive  = this._offset+this._max-1;
		
		this.forEach( function(item){
			i++;
			if( i >= lowerLimitInclusive && i <= upperLimitInclusive){
				item.set('visible',true);
			}
			else{
				item.set('visible',false);
			}
		} , this );
		this.trigger('pageChanged',{});
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

app.DocumentoSustentanteCollectionView = Backbone.View.extend({ 
	el: '#divDocumentosSustentante',
	template: _.template( $('#docsTemplate').html() ),
	templateElement: _.template( $('#docTemplate').html() ),
	downloadUrl: '',
	
	initialize: function(options){
		this.collection = new app.DocumentoSustentanteVMCollection(options.docsArray);
		this.downloadUrl = options.downloadUrl;
		
		this.render();
		
		this.listenTo( this.collection , 'sort', this.render );
		this.listenTo( this.collection , 'pageChanged', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		console.log('llamada a render');
		this.$el.html( this.template() );
		this.renderList();
		this.renderPagination();
		return this;
	},
	
	renderList: function(){
		this.collection.each(function(item){
			if( item.get('visible') == true ){
				this.$('.table-body').append( this.templateElement( item.toJSON() ) );
			}
		},this);
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
		
		this.$(".pagination").html(paginationStr);
	},
	
	events: {
		'click .download':'descargarDocumento',
		'click .sort':'ordernarLista'
	},
	
	descargarDocumento: function(ev){
		var uuid = this.$(ev.currentTarget).data("uuid");
		
		window.open(this.downloadUrl + '/' + uuid);
	},
	
	ordernarLista: function(ev){
		var sort  = this.$(ev.currentTarget).data("sort");
		var order  = this.$(ev.currentTarget).data("order");
		
		this.collection.sortAndOrderBy(sort,order);
	}
});