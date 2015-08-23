var app = app || {};

app.Notario = Backbone.Model.extend ({
	defaults: {
		numeroNotaria: '',
		idEntidadFederativa: -1,
		entidadesFederativas: [ { id:'-1',text:'-Seleccione-' } ] ,
		
		notariosEncontrados: [ { id:'-1',text:'-Seleccione-' } ],
		idNotarioSeleccionado: -1,
		
		//flags de estado
		processing: false,
		
		//errores de "valdidación" al momento de buscar el notario
		errorNumeroNotariaInvalidType: false,
		errorNumeroNotariaBlank: false,
		errorEntidadFederativaNonSelected: false,
		
		//errores al no encontrar notario
		errorNotarioNotFound: false,
		
		//error al no seleccionar ningun notario
		errorNotarioNotSelected: false,
		
		//url para obtener al notario
		findNotarioByNumeroNotariaAndIdEntidadFederativaUrl: ''
	},
	setBlankNotarioEncontrados: function(){
		this.set('notariosEncontrados',[ { id:'-1',text:'-Seleccione-' } ]);
	},
	findNotarioByNumeroNotariaAndIdEntidadFederativa: function(numeroNotario,idEntidadFederativa){
		//llamada ajax para actualizar a los notarios
		$.ajax({
			url: _this.get('findNotarioByNumeroNotariaAndIdEntidadFederativaUrl'),
			beforeSend: function( xhr ){
				_this.set('processing',true);
				_this.set('errorNumeroNotariaInvalidType',false);
				_this.set('errorNumeroNotariaBlank',false);
				_this.set('errorEntidadFederativaNonSelected',false);
				_this.set('errorNotarioNotFound',false);
				_this.set('errorNotarioNotSelected',false);
			},
			type: 'GET',
			data: { numeroNotario:numeroNotario, idEntidadFederativa:idEntidadFederativa },
		}).done( function( data ) {
			_this.set('processing',false);
			if(data.status == "OK"){
				_this.set('notariosEncontrados',data.object);
			}
			else{
				_this.set('errorNotarioNotFound',true);
			}
		});
	}
});

app.NotarioView =  Backbone.View.extend({
	el: '#divNotario',
	template: _.template( $('#notarioTemplate').html() ),
	
	initialize: function(options){
		this.render();
		
		this.listenTo(this.model, 'change:numeroNotaria', this.invalidateEntry );
		this.listenTo(this.model, 'change:entidadesFederativas', this.invalidateEntry );
		
		this.listenTo(this.model, 'change:notariosEncontrados', this.renderNotariosEncontrados );
		
		this.listenTo(this.model, 'change:processing', this.renderProcessing );
		
		this.listenTo(this.model, 'change:errorNumeroNotariaInvalidType', this.renderError );
		this.listenTo(this.model, 'change:errorNumeroNotariaBlank', this.renderError );
		this.listenTo(this.model, 'change:errorEntidadFederativaNonSelected', this.renderError );
		this.listenTo(this.model, 'change:errorNotarioNotFound', this.renderError );
		this.listenTo(this.model, 'change:errorNotarioNotSelected', this.renderError );
	},
	
	//al haber cualquier cambio en el numero de Notario y/o entidad Federativa
	invalidateEntry: function(){
		
	},
});