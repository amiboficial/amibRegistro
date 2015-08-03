var app = app || {};

app.EXP_CEA_SELECTED_TAB_MAT = 0;
app.EXP_CEA_SELECTED_TAB_FOL = 1;
app.EXP_CEA_SELECTED_TAB_BAV = 2;

app.EXP_CEA_RSLTS_ST_READY = 0;
app.EXP_CEA_RSLTS_ST_PROC = 0;

app.Figura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.variantesFigura = new Array();
}

app.VarianteFigura = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
	this.figura = {};
}

app.MatriculaTabVM = Backbone.Model.extend({
	defaults: {
		numeroMatricula: -1
	}
});

app.FolioTabVM = Backbone.Model.extend({
	defaults: {
		idSustentante: -1
	}
});

app.BusqAvVM = Backbone.Model.extend({
	defaults: {
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		idVarianteFigura: -1,
		
		viewFiguras: [],
		viewVariantesFigura: []
	}
});

app.ResultVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		idFigura: -1,
		dsFigura: "",
		idVarianteFigura: -1,
		dsVarianteFigura: "",
		
		yaEnLote: false,
		
		viewChecked: false
	}
});

app.ResultVMCollection = Backbone.Collection.extend({
	model: app.ResultVM
});

app.ResultsVM = Backbone.Model.extend({
	defaults: {
		showYaEnLote: true,
		totalEnLote: 0,
		
		state: app.EXP_CEA_RSLTS_ST_READY,
		error: false,
		
		max: 10,
		offset: 0,
		sort: "id",
		order: "asc",
	},
	getCurrentPage: function(){
		return -1;
	},
	getTotalPages: function(){
		return -1;
	},
	getNextPage: function(){
		return -1;
	},
	getBackPage: function(){
		return -1;
	}
});

app.CertPendAutMainView = Backbone.View.extend({
	el: '#divCertPendAut',
});

app.MatriculaTabView = Backbone.View.extend({
	
});

app.FolioTabView = Backbone.View.extend({
	
});

app.BusqAvView = Backbone.View.extend({
	
});

app.ResultView = Backbone.View.extend({
	
});

app.ResultsView = Backbone.View.extend({
	
});