var app = app || {};

app.EXP_PUES_MODE_NEW = 0;
app.EXP_PUES_MODE_EDIT = 1;

app.EXP_PUES_ST_OPEN = 0;
app.EXP_PUES_ST_VALIDATED = 1;

app.EXP_PUES_ST_ENTREGA_NOAPLICA = 0;
app.EXP_PUES_ST_ENTREGA_ENTREGO = 1;
app.EXP_PUES_ST_ENTREGA_NOENTREGO = 2;
app.EXP_PUES_ST_ENTREGA_MSGS = ["No aplica","Entregó","No entregó"];

app.EXP_PUES_ERR_RANGO_FECHA_NO_COINCIDE = "EXP_PUEST_ERR_RANGO_FECHA_NO_COINCIDE";
app.EXP_PUES_ERR_INSTIT_BLANK = "EXP_PUES_ERR_INSTIT_BLANK";
app.EXP_PUES_ERR_FECINI_NONVAL = "EXP_PUES_ERR_FECINI_NONVAL";
app.EXP_PUES_ERR_FECFIN_NONVAL = "EXP_PUES_ERR_FECFIN_NONVAL";
app.EXP_PUES_ERR_NOMPUES_BLANK = "EXP_PUES_ERR_NOMPUES_BLANK";
app.EXP_PUES_ERR_STMANIFPROT_BLANK = "EXP_PUES_ERR_STMANIFPROT_BLANK";
app.EXP_PUES_ERR_STCARTINTER_BLANK = "EXP_PUES_ERR_STCARTINTER_BLANK";

//no se crea como backbone model porque no requiere de listeners
app.Institucion = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
}
//arreglo "global" con listado de instituciones
app.instituciones = new Array();

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
		statusEntManifProtesta: -1,
		obsEntManifProtesta: "",
		statusEntCartaInter: -1,
		obsEntCartaInter: "",
		
		//status de vista
		viewStatus: app.EXP_PUES_ST_OPEN,
		viewMode: app.EXP_PUES_MODE_NEW,
		viewErrMessages: new Array(),
		
		//status de errores
		errInstitucion: false,
		errFechaInicio: false,
		errFechaFin: false,
		errNombrePuesto: false,
		errStatusEntManifProtesta: false,
		errStatusEntCartaInter: false,
		showErrMessages: false //si esta bandera se pone en true, se renderea la pila de erores
	}
});

app.PuestoViewModelCollection = Backbone.Collection.extend({
	model: app.PuestoViewModel,
	comparator: function(item){
		var d = {};
		var milis = 0;
		
		if(item.get("fechaInicio_day") == -1 || 
			item.get("fechaInicio_month") == -1 || 
			item.get("fechaInicio_year") == -1){
		
			milis = Number.MIN_VALUE;
			
		}
		else{
			milis = (new Date(item.get("fechaInicio_year"), 
							item.get("fechaInicio_month"), 
							item.get("fechaInicio_day"), 
							0, 0, 0, 0)).getTime() * -1;
		}
		return milis;
	}
	
});

app.PuestoView = Backbone.View.extend({
	parentView: {},
	tagname: 'div',
	className: 'list-group-item',
	template: _.template( $('#expedientePuesto').html() ),
	undoModel: {},
	
	initialize: function(options){
		this.model = options.model;
		this.parentView = options.parentView;
		
		this.listenTo( this.model, 'change:viewStatus', this.render );
		
		this.listenTo( this.model, 'change:showErrMessages', this.renderErrMessages );
		this.listenTo( this.model, 'change:errInstitucion', this.renderErrInstitucion );
		this.listenTo( this.model, 'change:errFechaInicio', this.renderErrFechaInicio );
		this.listenTo( this.model, 'change:errFechaFin', this.renderErrFechaFin );
		this.listenTo( this.model, 'change:errNombrePuesto', this.renderErrNombrePuesto );
		this.listenTo( this.model, 'change:errStatusEntManifProtesta', this.renderErrStatusEntManifProtesta );
		this.listenTo( this.model, 'change:errStatusEntCartaInter', this.renderErrStatusEntCartaInter );
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},
	renderErrMessages: function(){
		if(this.model.get("showErrMessages") == true){
			this.$(".errorMessagesContainer").html("");
			_.each(this.model.get("viewErrMessages"),function(item){
				this.$(".errorMessagesContainer").append(item + "<br/>");
			},this );
			this.$(".validationErrorMessage").show();
		}
		else{
			this.$(".validationErrorMessage").hide();
		}
	},
	renderErrInstitucion: function(){
		if(this.model.get("errInstitucion") == true){
			this.$(".div-idInstitucion").addClass("has-error");
		}
		else{
			this.$(".div-idInstitucion").removeClass("has-error");
		}
	},
	renderErrFechaInicio: function() {
		//alert("SI PASO AQUI!!!");
		if(this.model.get("errFechaInicio") == true){
			this.$(".div-fechaInicio").addClass("has-error");
		}
		else{
			this.$(".div-fechaInicio").removeClass("has-error");
		}
	},
	renderErrFechaFin: function() {
		if(this.model.get("errFechaFin") == true){
			this.$(".div-fechaFin").addClass("has-error");
		}
		else{
			this.$(".div-fechaFin").removeClass("has-error");
		}
	},
	renderErrNombrePuesto: function() {
		if(this.model.get("errNombrePuesto") == true){
			this.$(".div-nombrePuesto").addClass("has-error");
		}
		else{
			this.$(".div-nombrePuesto").removeClass("has-error");
		}
	},
	renderErrStatusEntManifProtesta: function() {
		if(this.model.get("errStatusEntManifProtesta") == true){
			this.$(".div-statusEntManifProtesta").addClass("has-error");
		}
		else{
			this.$(".div-statusEntManifProtesta").removeClass("has-error");
		}
	},
	renderErrStatusEntCartaInter: function() {
		if(this.model.get("errStatusEntCartaInter") == true){
			this.$(".div-statusEntCartaInter").addClass("has-error");
		}
		else{
			this.$(".div-statusEntCartaInter").removeClass("has-error");
		}
	},
	
	events: {
		'click .cancelNew': 'cancelNew',
		'click .edit': 'edit',
		'click .cancelEdit': 'cancelEdit',
		'click .update': 'update',
		'click .save': 'save',
		'click .delete': 'delete',
		'change .field':'updateModel',
	},
	
	//actualiza el modelo ante cualquier cambio en campos indicados con clase field
	updateModel: function(ev){
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		//solo para el caso de institución
		if(fieldName == "idInstitucion"){
			this.model.set("dsInstitucion",this.$(".idInstitucion option:selected").text());
		}
		
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
		this.undoModel = this.model.toJSON();
		this.model.set("viewMode",app.EXP_PUES_MODE_EDIT);
		this.model.set("viewStatus",app.EXP_PUES_ST_OPEN);
	},
	
	cancelEdit: function(e){
		e.preventDefault();
		//save a copy of the previous model and restores it
		this.model.set( 
		{
			"idInstitucion": this.undoModel.idInstitucion,
			"dsInstitucion": this.undoModel.dsInstitucion,
			"fechaInicio_day": this.undoModel.fechaInicio_day,
			"fechaInicio_month": this.undoModel.fechaInicio_month,
			"fechaInicio_year": this.undoModel.fechaInicio_year,
			"fechaFin_day": this.undoModel.fechaFin_day,
			"fechaFin_month": this.undoModel.fechaFin_month,
			"fechaFin_year": this.undoModel.fechaFin_year,
			"nombrePuesto": this.undoModel.nombrePuesto,
			"statusEntManifProtesta": this.undoModel.statusEntManifProtesta,
			"obsEntManifProtesta": this.undoModel.obsEntManifProtesta,
			"statusEntCartaInter": this.undoModel.statusEntCartaInter,
			"obsEntCartaInter": this.undoModel.obsEntCartaInter
		}
		, { silent:true } );
		this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
	},

	update: function(e){
		e.preventDefault();
		//validar campos
		var valid = this.validate();
		if(valid){
			this.model.collection.sort();
			this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
		}
	},
	
	save: function(e){
		e.preventDefault();
		//validar campos
		var valid = this.validate();
		if(valid){
			this.model.collection.sort();
			this.model.set("viewStatus",app.EXP_PUES_ST_VALIDATED);
		}
	},
	
	delete: function(e){
		e.preventDefault();
		if(this.model.get("viewStatus") == app.EXP_PUES_ST_VALIDATED){
			this.model.destroy();
			this.remove();
		}
	},
	
	//funciones adicionales
	validate: function(){
		var valid = true;
		
		//clean errors from model
		this.model.set("viewErrMessages",new Array());
		this.model.set("errInstitucion", false);
		this.model.set("errFechaInicio", false);
		this.model.set("errFechaFin", false);
		this.model.set("errNombrePuesto", false);
		this.model.set("errStatusEntManifProtesta", false);
		this.model.set("errStatusEntCartaInter", false);
		this.model.set("showErrMessages", false);
		
		if(this.model.get("idInstitucion") <= 0){
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_INSTIT_BLANK);
			this.model.set("errInstitucion", true);
			valid = false;
		}
		if(this.model.get("fechaInicio_day") == -1 || 
			this.model.get("fechaInicio_month") == -1 || 
			this.model.get("fechaInicio_year") == -1){
			
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_FECINI_NONVAL);
			this.model.set("errFechaInicio", true);
			valid = false;
		}
		if(this.model.get("fechaFin_day") == -1 || 
			this.model.get("fechaFin_month") == -1 || 
			this.model.get("fechaFin_year") == -1){
			
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_FECFIN_NONVAL);
			this.model.set("errFechaFin", true);
			valid = false;
		}
		if(this.model.get("nombrePuesto") == ""){
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_NOMPUES_BLANK);
			this.model.set("errNombrePuesto", true);
			valid = false;
		}
		if(this.model.get("statusEntManifProtesta") == -1){
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_STMANIFPROT_BLANK);
			this.model.set("errStatusEntManifProtesta", true);
			valid = false;
		}
		if(this.model.get("statusEntCartaInter") == -1){
			this.model.get("viewErrMessages").push(app.EXP_PUES_ERR_STCARTINTER_BLANK);
			this.model.set("errStatusEntCartaInter", true);
			valid = false;
		}
		if(valid == false){
			this.model.set("showErrMessages", true);
		}
		return valid;
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
		this.listenTo( this.collection, 'sort', this.renderList );
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
		this.state = app.EXP_PUES_ST_OPEN;
		this.trigger("stateChange","OPEN",this.checkId);
	},

	setValidatedState: function(){
		this.state = app.EXP_PUES_ST_VALIDATED;
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
			if(this.validarAgregarNuevoElemento()){
				var elem = new app.PuestoViewModel();
				this.collection.add(elem);
				elem.collection = this.collection;
			}
		}
	},
	
	validarAgregarNuevoElemento: function(){
		var hasNewElem = false; //tiene algun elemento en modo nuevo?
		this.collection.each(function(item){
			if(item.get("viewMode") == app.EXP_PUES_MODE_NEW &&
				item.get("viewStatus") == app.EXP_PUES_ST_OPEN){
				
				hasNewElem = true;
				
			}
		},this);
		return !hasNewElem;
	}
	
});