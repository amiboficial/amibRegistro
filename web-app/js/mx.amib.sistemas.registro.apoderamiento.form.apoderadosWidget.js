var apoderadosWidget = apoderadosWidget || {}

apoderadosWidget.Apoderado = Backbone.Model.extend({
	defaults: {
		matricula: -1,
		nombreCompleto: '(Sin nombre)',
		idAutorizadoCNBV: -1,
		claveDga: '(Sin DGA)',
		validado: 0
	}
});

apoderadosWidget.Apoderados = Backbone.Collection.extend({
	model: apoderadosWidget.Apoderado
});

apoderadosWidget.ApoderadoView = Backbone.View.extend({
	tagName: 'tr',
	className: 'apoderadoRow',
	template: _.template( $('#apoderadoTemplate').html() ),

	render : function() {				
		this.$el.html( this.template( this.model.toJSON() ) );
		return this;
	},

	events:{
		'click .delete':'quitarApoderado'
	},

	quitarApoderado: function() {
		//Borra el model
		this.model.destroy();
		//Destruye esta vista
		this.remove();
	}

});

apoderadosWidget.ApoderadosView = Backbone.View.extend({
	state: 'LISTO', //LISTO,LISTO_YA_HAY_MATRICULA,LISTO_ERROR_MATRICULA,LISTO_DGA_NO_VALIDO,PROCESANDO,LISTO_PARA_AGREGAR
	el: '#tbdyApoderados',
	currentMatricula: '',
	url: '',
	
	initialize: function( initialApoderados, url ){
		this.url = url;
		this.collection = new apoderadosWidget.Apoderados(initialApoderados);
		this.render();
		this.listenTo( this.collection, 'add', this.renderApoderado );
		
		this.listenTo( this.collection, 'add', this.renderHiddenData );
		this.listenTo( this.collection, 'remove', this.renderHiddenData );
		this.listenTo( this.collection, "reset", this.renderHiddenData );
	},
	
	render: function() {
		this.collection.each( function(item){
			this.renderApoderado(item);
		},this );
		
		this.changeStateToListo();
	},
	renderApoderado: function(item){
		var apoderadoView = new apoderadosWidget.ApoderadoView({model:item});
		this.$el.append( apoderadoView.render().el );
	},
	renderHiddenData: function(item){
		//actualiza cantidad en var hidden
		$("#hdnCountApoderados").val( _.size(this.collection) );
	},
	
	events:{
		'click #btnAdd': 'agregarApoderado', 
		'blur #txtNewMatricula': 'buscarPorMatricula'
	},

	//importante cambiar el estado con estos métodos
	changeStateToListo: function(){
		//mensajes
		$('#divMsgMatriculaYaEnLista').hide();
		$('#divMsgMatriculaNoEncontrada').hide();
		$('#divMsgMatriculaSinDga').hide();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').hide();
		//campos
		$('#txtNewMatricula').val('');
		$('#txtNewNombre').val('');
		$('#selNewDGA').html('');
		$('#btnAdd').prop('disabled', true);
		//status
		state = 'LISTO';
		
	},
	changeStateToListoYaHayMatricula: function(){
		//mensajes
		$('#divMsgMatriculaYaEnLista').show();
		$('#divMsgMatriculaNoEncontrada').hide();
		$('#divMsgMatriculaSinDga').hide();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').hide();
		//campos
		//se deja el campo de nueva matricula tal cual
		$('#txtNewNombre').val('');
		$('#selNewDGA').html('');
		$('#btnAdd').prop('disabled', true);
		//status
		state = 'LISTO_YA_HAY_MATRICULA';
	},
	changeStateToListoErrorMatricula: function(){
		//mensajes
		$('#divMsgMatriculaYaEnLista').hide();
		$('#divMsgMatriculaNoEncontrada').show();
		$('#divMsgMatriculaSinDga').hide();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').hide();
		//campos
		//se deja el campo de nueva matricula tal cual
		$('#txtNewNombre').val('');
		$('#selNewDGA').html('');
		$('#btnAdd').prop('disabled', true);
		//status
		state = 'LISTO_ERROR_MATRICULA';
	},
	changeStateToListoDgaNoValido: function(nombreCompleto){
		//mensajes
		$('#divMsgMatriculaYaEnLista').hide();
		$('#divMsgMatriculaNoEncontrada').hide();
		$('#divMsgMatriculaSinDga').show();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').hide();
		//campos
		//se deja el campo de nueva matricula tal cual
		$('#txtNewNombre').val(nombreCompleto);
		$('#selNewDGA').html('');
		$('#btnAdd').prop('disabled', true);
		//status
		state = 'LISTO_DGA_NO_VALIDO';
	},
	changeStateToProcesando: function(){
		//mensajes
		$('#divMsgMatriculaYaEnLista').hide();
		$('#divMsgMatriculaNoEncontrada').hide();
		$('#divMsgMatriculaSinDga').hide();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').show();
		
		state = 'PROCESANDO';
	},
	changeStateToListoAgregar: function(apoderadoConDgas){
		//mensajes
		$('#divMsgMatriculaYaEnLista').hide();
		$('#divMsgMatriculaNoEncontrada').hide();
		$('#divMsgMatriculaSinDga').hide();
		$('#divMsgAlMenosUnApoderado').hide();
		$('#divMsgProcesandoApoderado').hide();
		
		$('#txtNewNombre').val(apoderadoConDgas.get('nombreCompleto'));
		$('#selNewDGA').html('');


		var dgas = apoderadoConDgas.get('autorizacionesCNBV');

		dgas.forEach(function(model){ 
			$('#selNewDGA').append($("<option></option>").attr("value",model.idAutorizadoCNBV).text(model.claveDga));
		});

		$('#btnAdd').prop('disabled', false);
		
		state = 'LISTO_PARA_AGREGAR';
	},
	
	//agregarApoderado: LISTOAGREGAR -> LISTO
	agregarApoderado: function(e) {
		e.preventDefault();

		//captura los datos del formulario
		var newMatricula = $('#txtNewMatricula').val();
		var newNombre = $('#txtNewNombre').val();
		var newIdAutorizado = $('#selNewDGA').val();
		var newDga = $('#selNewDGA option:selected').text();
		var apoderado = new apoderadosWidget.Apoderado( { matricula: newMatricula, nombreCompleto: newNombre, idAutorizadoCNBV: newIdAutorizado, claveDga: newDga } );

		this.collection.add(apoderado);
		
		//cambia a estado de "listo"
		this.changeStateToListo();
	},

	buscarPorMatricula: function(e) {
		e.preventDefault();

		var newMatricula = $.trim($('#txtNewMatricula').val());
		var yaExisteMatricula = false;
		
		if( newMatricula == '' )
		{
			//cambia a estado de "listo"
			this.changeStateToListo();
		}
		else
		{
			this.collection.forEach( function(model){
				if(model.get('matricula') == newMatricula)
					yaExisteMatricula = true
			} );
			
			if(yaExisteMatricula == true)
				this.changeStateToListoYaHayMatricula();
			else
			{
				var ApoderadoResponse = Backbone.Model.extend({urlRoot : this.url});
				var apoderadoResponse = new ApoderadoResponse({id: newMatricula});
				var currentView = this;

				apoderadoResponse.fetch({
					success: function(){

						//if(apoderadoResponse.get('autorizacionesCNBV'))
						if(apoderadoResponse.get('numeroMatricula') == -1)
						{
							currentView.changeStateToListoErrorMatricula();
						}
						else if(apoderadoResponse.get('autorizacionesCNBV').length == 0)
						{
							currentView.changeStateToListoDgaNoValido( apoderadoResponse.get('nombreCompleto') );
						}
						else
						{
							currentView.changeStateToListoAgregar( apoderadoResponse );
						}
					}
				});

				this.changeStateToProcesando();
			}
		}
		
	}
});