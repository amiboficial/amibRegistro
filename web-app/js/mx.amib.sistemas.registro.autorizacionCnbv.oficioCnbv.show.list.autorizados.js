var app = app || {};

app.AutorizadoResultView = Backbone.View.extend({
	parentView: {},
	tagName: 'tr',
	template: _.template( $('#oficioCnbvShowAutorizadosElementTemplate').html() ),
	model: new Backbone.Model(),
	
	showExpedienteUrl: '',
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .show': 'irAlExpediente'
	},
	
	irAlExpediente: function(e){
		e.preventDefault();
		window.location.assign(showExpedienteUrl + '/' + this.model.get('idSustentante'))
	}
});

app.AutorizadoResultsView = Backbone.View.extend({
	template: _.template( $('#oficioCnbvShowAutorizadosListTemplate').html() ),
	collection: new Backbone.Collection(),
	el: '#autorizados485b227985f34dfcadf8369d1525f925',
	
	showExpedienteUrl: '',
	
	initialize: function(options){
		this.collection = options.collection;
		this.showExpedienteUrl = options.showExpedienteUrl;
		
		this.render();
		
		this.listenTo( this.collection, 'reset', this.renderList );
		this.listenTo( this.collection, 'sort', this.renderList );
		this.listenTo( this.collection, 'add', this.renderList );
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		return this;
	},
	renderList: function(){
		this.$(".list-items").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		}, this );
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.AutorizadoResultView({model:item,parentView:view,showExpedienteUrl:view.showExpedienteUrl});
		this.$(".list-items").append( elementView.render().el );
		return elementView;
	},
	
	events: {
		'click .sort': 'mandarOrdenar'
	},
	
	mandarOrdenar: function(e){
		var order = this.$(e.currentTarget).data("order");
		var sort = this.$(e.currentTarget).data("sort");
		
		e.preventDefault();
		this.collection.sortAndOrderBy(order,sort);
	}
	/*
	descargarDocumento: function(e){
		e.preventDefault();
		var url = this.$(e.currentTarget).data("url");
		var uuid = this.$(e.currentTarget).data("uuid");
		
		window.open(url + uuid);
	}*/
});