var app = app || {};

app.HPoderVM = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		numeroEscritura: -1,
		nombreCompletoNotario: "",
		fechaApoderamiento: "",
		fechaApoderamientoUnixEpoch: -1,
		grupoFinancieroNombre: "",
		institucionNombre: "",
		poderUrl: '',
		
		visible: true
	}
});

app.HPoderVMCollection = Backbone.Collection.extend({
	model: app.HPoderVM,
	
	_offset: 0,
	_max: 10,
	
	_sort: 'asc',
	_order: 'fechaApoderamientoUnixEpoch',
	
	comparator: function(itemA, itemB){
		if(this._sort == "grailsId"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('grailsId')) == parseInt(itemB.get('grailsId')))
					return 0;
				else if(parseInt(itemA.get('grailsId')) > parseInt(itemB.get('grailsId')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('grailsId')) == parseInt(itemB.get('grailsId')))
					return 0;
				else if(parseInt(itemA.get('grailsId')) <= parseInt(itemB.get('grailsId')))
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "numeroEscritura"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('numeroEscritura')) == parseInt(itemB.get('numeroEscritura')))
					return 0;
				else if(parseInt(itemA.get('numeroEscritura')) > parseInt(itemB.get('numeroEscritura')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('numeroEscritura')) == parseInt(itemB.get('numeroEscritura')))
					return 0;
				else if(parseInt(itemA.get('numeroEscritura')) <= parseInt(itemB.get('numeroEscritura')))
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "nombreCompletoNotario"){
			if(this._order == "desc"){
				if(itemA.get('nombreCompletoNotario').toUpperCase() == itemB.get('nombreCompletoNotario').toUpperCase())
					return 0;
				else if(itemA.get('nombreCompletoNotario').toUpperCase() > itemB.get('nombreCompletoNotario').toUpperCase())
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('nombreCompletoNotario').toUpperCase() == itemB.get('nombreCompletoNotario').toUpperCase())
					return 0;
				else if(itemA.get('nombreCompletoNotario').toUpperCase() <= itemB.get('nombreCompletoNotario').toUpperCase())
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "fechaApoderamiento" || this._sort == "fechaApoderamientoUnixEpoch"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('fechaApoderamientoUnixEpoch')) == parseInt(itemB.get('fechaApoderamientoUnixEpoch')))
					return 0;
				else if(parseInt(itemA.get('fechaApoderamientoUnixEpoch')) > parseInt(itemB.get('fechaApoderamientoUnixEpoch')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('fechaApoderamientoUnixEpoch')) == parseInt(itemB.get('fechaApoderamientoUnixEpoch')))
					return 0;
				else if(parseInt(itemA.get('fechaApoderamientoUnixEpoch')) <= parseInt(itemB.get('fechaApoderamientoUnixEpoch')))
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "grupoFinancieroNombre"){
			if(this._order == "desc"){
				if(itemA.get('grupoFinancieroNombre').toUpperCase() == itemB.get('grupoFinancieroNombre').toUpperCase())
					return 0;
				else if(itemA.get('grupoFinancieroNombre').toUpperCase() > itemB.get('grupoFinancieroNombre').toUpperCase())
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('grupoFinancieroNombre').toUpperCase() == itemB.get('grupoFinancieroNombre').toUpperCase())
					return 0;
				else if(itemA.get('grupoFinancieroNombre').toUpperCase() <= itemB.get('grupoFinancieroNombre').toUpperCase())
					return -1;
				else
					return 1;
			}
		}
		else if(this._sort == "institucionNombre"){
			if(this._order == "desc"){
				if(itemA.get('institucionNombre').toUpperCase() == itemB.get('institucionNombre').toUpperCase())
					return 0;
				else if(itemA.get('institucionNombre').toUpperCase() > itemB.get('institucionNombre').toUpperCase())
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('institucionNombre').toUpperCase() == itemB.get('institucionNombre').toUpperCase())
					return 0;
				else if(itemA.get('institucionNombre').toUpperCase() <= itemB.get('institucionNombre').toUpperCase())
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
			if( i >= lowerLimitInclusive && i <= upperLimitInclusive){
				item.set('visible',true);
			}
			else{
				item.set('visible',false);
			}
			i++;
		} , this );
		
		this.trigger('pageChanged',{});
	},
	
	/* METODOS CON DETALLES DE PAGINACION */
	getCurrentPage: function(){
		return Math.floor(this._offset/this._max) + 1;
	},
	getTotalPages: function(){
		return Math.ceil(this.length/this._max);
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

app.HPoderVMCollectionView = Backbone.View.extend({ 
	el: '#divHistoricoPoderSustentante',
	template: _.template( $('#hpoderesTemplate').html() ),
	templateElement: _.template( $('#hpoderTemplate').html() ),
	
	_poderUrl: '',
	
	initialize: function(options){
		this.collection = new app.HPoderVMCollection(options.elementsArray);
		this._poderUrl = options.poderUrl;
		this.collection.goToPage(1);
		this.render();
		
		//this.listenTo( this.collection , 'sort', this.render );
		this.listenTo( this.collection , 'pageChanged', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
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
		'click .sort': 'ordernarLista',
		'click .page': 'irAPagina',
		'click .download': 'irAPoder'
	},
	
	ordernarLista: function(ev){
		var sort  = this.$(ev.currentTarget).data("sort");
		var order  = this.$(ev.currentTarget).data("order");
		
		this.collection.sortAndOrderBy(sort,order);
		this.collection.goToPage(1);
	},
	
	irAPagina: function(ev){
		var numeroPag = this.$(ev.currentTarget).data("page");
		
		this.collection.goToPage(numeroPag);
	},
	
	irAPoder: function(ev){
		location.assign(this._poderUrl + '/' + this.$(ev.currentTarget).data("id"));
	}
	
});