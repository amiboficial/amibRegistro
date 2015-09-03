var app = app || {};

app.ResRevShw = Backbone.Model.extend({
	defaults:{
		idSustentante: -1,
		numeroMatricula: -1,
		nombre: '',
		primerApellido: '',
		segundoApellido: ''
	}
});

app.ResRevShwCol = Backbone.Collection.extend ({
	model: app.ResRevShw,
	
	_sort: "numeroMatricula",
	_order: "asc",
	
	comparator: function(itemA, itemB){
		if(this._sort == "idSustentante"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('idSustentante')) == parseInt(itemB.get('idSustentante')))
					return 0;
				else if(parseInt(itemA.get('idSustentante')) > parseInt(itemB.get('idSustentante')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('idSustentante')) == parseInt(itemB.get('idSustentante')))
					return 0;
				else if(parseInt(itemA.get('idSustentante')) <= parseInt(itemB.get('idSustentante')))
					return -1;
				else
					return 1
			}
		}	
		else if(this._sort == "numeroMatricula"){
			if(this._order == "desc"){
				if(parseInt(itemA.get('numeroMatricula')) == parseInt(itemB.get('numeroMatricula')))
					return 0;
				else if(parseInt(itemA.get('numeroMatricula')) > parseInt(itemB.get('numeroMatricula')))
					return -1;
				else
					return 1;
			}
			else{
				if(parseInt(itemA.get('numeroMatricula')) == parseInt(itemB.get('numeroMatricula')))
					return 0;
				else if(parseInt(itemA.get('numeroMatricula')) <= parseInt(itemB.get('numeroMatricula')))
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
});

app.ResRevShwColView = Backbone.View.extend ({
	el: '#revocados72cbc179',
	template: _.template( $('#resRevShwColTemplate').html() ),
	templateElement: _.template( $('#resRevShwTemplate').html() ),
	
	showExpedienteUrl: '',
	
	initialize: function(options){
		this.collection = options.collection;
		this.showExpedienteUrl = options.showExpedienteUrl;
		
		this.render();
		
		this.listenTo( this.collection , 'sort', this.render );
		//this.listenTo( this.collection , 'reset', this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		return this;
	},
	
	renderList: function(){
		this.collection.each(function(item){
			this.$('.list-items').append( this.templateElement( item.toJSON() ) );
		},this);
	},
	
	events: {
		'click .show':'irAExpediente',
		'click .sort':'ordernarLista'
	},
	
	irAExpediente: function(ev){
		var idSustentante = this.$(ev.currentTarget).data("idsustentante");
		
		window.location.assign(this.showExpedienteUrl + '/' + idSustentante);
	},
	
	ordernarLista: function(ev){
		var sort  = this.$(ev.currentTarget).data("sort");
		var order  = this.$(ev.currentTarget).data("order");
		
		this.collection.sortAndOrderBy(order,sort);
	}
});