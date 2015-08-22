var app = app || {};

app.Notario = Backbone.Model.extend ({
	defaults: {
		numeroNotaria: '',
		idEntidadFederativa: -1,
		entidadesFederativas: new Array(),
		
		notariosEncontrados: new Array(),
		idNotarioSeleccionado: -1
	}
});

app.NotarioView =  Backbone.View.extend({
	
});