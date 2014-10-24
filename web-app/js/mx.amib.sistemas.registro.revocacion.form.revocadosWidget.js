var app = app || {};

app.RVC_SHOW = 1;
app.RVC_NEW = 2;
app.RVC_EDIT = 3;

app.RVCS_EDIT = 1;
app.RVCS_SHOW = 2;

app.Revocado = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: 0,
		nombreCompleto: '',
		numeroEscritura: 0,
		motivo: '',
		fechaBaja: '1900-01-01T00:00:00Z',
		revocacionId: -1
	}
});

app.Revocados = Backbone.Collection.extend({
	model: app.Revocado
});

app.RevocadoView = Backbone.View.extend({
	state: app.RVC_SHOW,
	el: '#divLgRevocados',
	matriculaUrl: 'http://localhost:8080/amibRegistro/sustentante/findByMatricula',
	
	templateShow: _.template( $('#revocadoTemplateShow').html() ),
	templateNew: _.template( $('#revocadoTemplateNew').html() ),
	templateEdit: _.template( $('#revocadoTemplateEdit').html() ),
	
	render: function() {
		if(this.state == app.RVC_NEW) {
			this.$el.html( this.templateNew() );
		}
		else if(this.state == app.RVC_SHOW) {
			this.$el.html( this.templateShow( this.model.toJSON() ) );
		}
		else if(this.state == app.RVCS_EDIT) {
			this.$el.html( this.templateEdit( this.model.toJSON() ) );
		}
		return this;
	},
	
	events: {
		//eventos en NEW
		'blur .matriculaRevocado': 'buscarSustentante',
		'click .save':'guardarRevocado',
		'click .cancelCreate':'cancelarCrearRevocado',
		//eventos en SHOW
		'click .edit':'editarRevocado',
		'click .delete':'eliminarRevocado',
		//eventos en EDIT
		'click .update':'actualizarRevocado',
		'click .cancelEdit':'cancelarEditarRevocado',
	}
	
	buscarSustante: function(e){
		e.preventDefault();
		
		var matricula = this.$("").
	}
	
});

app.RevocadosView = Backbone.Collection.extend({
	initialize: function( initialRevocados, matriculaUrl ){
		this.matriculaUrl = matriculaUrl;
		this.collection = new app.Revocados(initialApoderados);

	},
});