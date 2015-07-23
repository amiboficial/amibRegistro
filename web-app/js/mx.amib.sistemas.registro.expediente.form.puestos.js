var app = app || {};

app.EXP_PUES_MODE_NEW = 0;
app.EXP_PUES_MODE_EDIT = 1;

app.EXP_PUES_ST_OPEN = 0;
app.EXP_PUES_ST_VALIDATED = 1;

app.EXP_PUEST_ERR_RANGO_FECHA_NO_COINCIDE = "";


app.PuestoViewModel = Backbone.Model.extend({ 
	defaults: {
		grailsId: -1,

		idInstitucion: -1,
		dsInstitucion: "",
		fechaInicio_day: -1,
		fechaInicio_month: -1,
		fechaInicio_year: -1,
		fechaFin_day: -1,
		fechaFin_month: -1,
		fechaFin_year: -1,
		nombrePuesto: "",
		statusEntManifProtesta: 0,
		obsEntManifProtesta: "",
		statusEntCartaInter: 0,
		obsEntCartaInter: "",
		esActual: true,
		
		//status de vista
		viewStatus: app.EXP_PUES_ST_OPEN,
		viewMode: app.EXP_PUES_MODE_NEW,
		viewErrMessages: new Array(),
		
		//status de errores
		errInstitucion: false,
		errFechaInicio: false,
		errFechaFin: false,
		errNombrePuesto: false
	}
});

app.PuestoViewModelCollection =  Backbone.Collection.extend({
	model: app.PuestoViewModel
});

app.PuestoView = Backbone.View.extend({
	parentView: {},
	tagname: 'div',
	className: 'list-group-item',
	template: _.template( $('#expedientePuesto').html() ),
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		
		this.listenTo( this.model, 'change:viewStatus', this.render );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	
	events: {
		'click .cancelNew': 'cancelNew',
		'click .edit': 'edit',
		'click .cancelEdit': 'cancelEdit',
		'click .update': 'update',
		'click .save': 'save',
		'click .delete': 'delete',
		'change field':'updateModel',
	},
	
	//actualiza el modelo ante cualquier cambio en campos indicados con clase field
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		this.model.set(fieldName,fieldValue);
	},
	
	//
	cancelNew: function(e){
		e.preventDefault();
		//destroy
		if(this.model.get("viewStatus") == app.EXP_PUES_ST_OPEN){
			this.model.destroy();
			this.remove();
		}
	},
	
	edit: function(e){
		e.preventDefault();
		this.model.set("viewStatus",app.EXP_PUES_ST_OPEN);
	},
	
	cancelEdit: function(e){
		e.preventDefault();
		this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
	},

	update: function(e){
		e.preventDefault();
		this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
	},
	
	save: function(e){
		e.preventDefault();
		this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
	},
	
	delete: function(e){
		e.preventDefault();
		if(this.model.get("viewStatus") == app.EXP_PUES_ST_VALIDATED){
			this.model.destroy();
			this.remove();
		}
	}

});

app.PuestosView = Backbone.View.extend({
	checkId: -1,
	el: '#divPues',
	state: app.EXP_PUES_ST_OPEN,
	template: _.template( $('#expedientePuestos').html() ),
	collection: {},
	errors: new Array(),
	
	initialize: function(initialData){
		this.collection = new app.PuestoViewModelCollection(initialData);
		this.render();
		
		this.listenTo( this.collection, 'add', this.renderList );
	},
	
	//métodos de rendereo
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		return this;
	},
	renderList: function(){
		this.$(".listaPuestos").html("");
		this.collection.each( function(item){
			this.renderElement(item);
		},this );
	},
	renderElement: function(item){
		var view = this;
		var elementView =  new app.PuestoView({model:item,parentView:view});
		elementView.viewModel = this.viewModel;
		this.$(".listaPuestos").append( elementView.render().el );
	},
	renderErrorMsgs: function(){
		this.$(".validationErrorMessage").show();
		this.$(".errorMessagesContainer").text("");
		_.each(this.errors,function(item){
			this.$(".errorMessagesContainer").append(item);
			this.$(".errorMessagesContainer").append("<br/>");
		},this);
	},
	renderCleanErrorMsgs: function(){
		this.$(".validationErrorMessage").hide();
	},
	
	//métodos indicados para cambiar estatus
	setOpenState: function(){
		this.state = app.EXP_TEL_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_TEL_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},
	
	//métodos para cambiar el identificador de elemento en checklist
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(){
		return this.checkId;
	},
	
	//eventos
	events: {
		'click .add':'agregarNuevoElemento',
		'click .submit': 'establecerDatos',
		'click .edit': 'habilitarEdicionDatos'
	},
	
	agregarNuevoElemento: function(e){
		e.preventDefault();
		if(this.state == app.EXP_PUES_ST_OPEN){
			var elem = new app.PuestoViewModel();
			this.collection.add(elem);
		}
	}
	
});