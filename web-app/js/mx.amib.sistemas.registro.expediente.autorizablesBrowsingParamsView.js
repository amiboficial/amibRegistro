var app = app || {};

app.MODO_DICTAMEN_PREV = 0;
app.MODO_ACTUALIZACION_AUT = 1;
app.MODO_REPOSICION_AUT = 2;
app.MODO_CAMBIO_FIG = 3;

app.CRIT_MATRICULA = 0;
app.CRIT_FOLIO = 1;
app.CRIT_BUSQAV = 2;
app.CRIT_TODOS = 3;

app.AutBrwParamsVM = Backbone.Model.extend({
	//triggers disparados:
	//varianteFiguraChanged
	//errorOnValidate
	//validated
	//attributesCleaned
	//validationErrorsCleaned
	//everythingCleared
	//change:processing
	defaults:{
		modo: app.MODO_DICTAMEN_PREV,
		criterio: app.CRIT_MATRICULA,
		
		numeroMatricula: '',
		
		idSustentante: '',
		
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		idFigura: -1,
		figuras: [ {id:'-1',text:'-Seleccione-', variantesFigura: [ {id:'-1',text:'-Seleccione-'} ] } ],
		idVarianteFigura: -1,
		variantesFigura: [ {id:'-1',text:'-Seleccione-'} ],
		
		errorNumeroMatriculaBlank: false,
		errorNumeroMatriculaNonNumeric: false,
		
		errorIdSustentanteBlank: false,
		errorIdSustentanteNonNumeric: false,
		
		errorBusqAvNoHayAlMenosUnParametro: false,
		
		processing: false
	},
	
	initialize: function(){
		this.listenTo( this, 'change:idFigura', this.cargarVariantesFigura );
		this.listenTo( this, 'change:criterio', this.clearAll );
		
		Backbone.Model.prototype.initialize.call(this);
	},
	
	cargarVariantesFigura: function(){
		var figuraSeleccionada = null;
		
		_.each(this.get('figuras'), function(item){
			if( item.id == this.get('idFigura') ){
				figuraSeleccionada = item;
			}
		},this);
		
		if(figuraSeleccionada != null){
			this.set('variantesFigura',figuraSeleccionada.variantesFigura);
		}
		
		this.trigger('varianteFiguraChanged',{});
	},
	
	validate: function(){
		var valid = true;
		var criterio = this.get('criterio');
		
		var regExpIsNumeric = /^[0-9]{1,10}$/;
		
		this.cleanValidationErrors();
		
		if(criterio == app.CRIT_MATRICULA){
			if(this.get('numeroMatricula') == ''){
				valid = false;
				this.set('errorNumeroMatriculaBlank',true);
			}
			else if( !regExpIsNumeric.test(this.get('numeroMatricula')) ){
				valid = false;
				this.set('errorNumeroMatriculaNonNumeric',true);
			}
		}
		else if(criterio == app.CRIT_FOLIO){
			if(this.get('idSustentante') == ''){
				valid = false;
				this.set('errorIdSustentanteBlank',true);
			}
			else if( !regExpIsNumeric.test(this.get('idSustentante')) ){
				valid = false;
				this.set('errorIdSustentanteNonNumeric',true);
			}
		}
		else if(criterio == app.CRIT_BUSQAV){
			var nombreBlank = (this.get('nombre') == '');
			var primerApellidoBlank = (this.get('primerApellido') == '');
			var segundoApellidoBlank = (this.get('segundoApellido') == '');
			var idFiguraNonSelected = (this.get('idFigura') == -1);
			
			if(nombreBlank && primerApellidoBlank && segundoApellidoBlank && idFiguraNonSelected){
				valid = false;
				this.set('errorBusqAvNoHayAlMenosUnParametro',true);
			}
		}
		
		if(!valid){
			this.trigger('errorOnValidate');
		}
		else{
			this.trigger('okValidate',{});
		}
		
		
		return valid;
	},
	
	cleanAttributes: function(){
		/*var criterio = this.get('criterio');
		if(criterio == app.CRIT_MATRICULA){
			this.set('numeroMatricula','',{silent:true});
		}
		else if(criterio == app.CRIT_FOLIO){
			this.set('idSustentante','',{silent:true});
		}
		else if(criterio == app.CRIT_BUSQAV){
			this.set({
				nombre: '',
				primerApellido: '',
				segundoApellido: '',
				idFigura: -1,
				idVarianteFigura: -1,
			},{silent:true})
		}*/
		this.set({
			numeroMatricula: '',
			idSustentante: '',
			nombre: '',
			primerApellido: '',
			segundoApellido: '',
			idFigura: -1,
			idVarianteFigura: -1,
			variantesFigura: [ {id:'-1',text:'-Seleccione-'} ],
		},{silent:true})
		this.trigger('attributesCleaned',{});
	},
	
	cleanValidationErrors: function(){
		this.set({
			errorNumeroMatriculaBlank: false,
			errorNumeroMatriculaNonNumeric: false,
			
			errorIdSustentanteBlank: false,
			errorIdSustentanteNonNumeric: false,
			
			errorBusqAvNoHayAlMenosUnParametro: false
		});
		this.trigger('validationErrorsCleaned',{});
	},
	
	clearAll: function(){
		this.cleanValidationErrors();
		this.cleanAttributes();
		//manda una notificacion de que se ha limpiado todo
		this.trigger('everythingCleared',{});
	},
	
	performSearch: function(){
		if(this.validate()){
			this.set('processing',true);
		}
	}
});

app.AutBrwParamsView = Backbone.View.extend({
	el: '#divAutBrwParams',
	
	model: new app.AutBrwParamsVM(),
	
	template: _.template( $('#templateAutBrwParamsView').html() ),
	
	_savedFocus: null,
	
	initialize: function(options){
		if(options != null){
			this.model = options.model;
		}
		
		this.render();
		
		this.listenTo( this.model , 'everythingCleared' , this.render );
		this.listenTo( this.model , 'varianteFiguraChanged' , this.render );
		this.listenTo( this.model , 'change:processing' , this.renderProcessing );
		this.listenTo( this.model , 'errorOnValidate' , this.renderError );
		this.listenTo( this.model , 'okValidate' , this.render );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		
		if(this._savedFocus != null){
			this.$('.' + this._savedFocus).focus();
			this._savedFocus = null;
		}
	},
	
	renderProcessing: function(){
		//disables all inputs and shows processing message when proc. event is raised
		var _this = this;
		
		if(this.model.get('processing',true)){
			this.$('.alert-processing').show();
			this.disableInput();
			setTimeout(function(){ _this.model.set('processing',false); }, 1000);
		}
		else{
			this.render();
		}
		
	},
	
	renderError: function(){
		//clean all errors first
		this.render();

		
		if( this.model.get('errorNumeroMatriculaBlank') == true ){
			this.$('.alert-errorNumeroMatriculaBlank').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		if( this.model.get('errorNumeroMatriculaNonNumeric') == true ){
			this.$('.alert-errorNumeroMatriculaNonNumeric').show();
			this.$('.div-numeroMatricula').addClass('has-error');
		}
		
		if( this.model.get('errorIdSustentanteBlank') == true ){
			this.$('.alert-errorIdSustentanteBlank').show();
			this.$('.div-idSustentante').addClass('has-error');
		}
		if( this.model.get('errorIdSustentanteNonNumeric') == true ){
			this.$('.alert-errorIdSustentanteNonNumeric').show();
			this.$('.div-idSustentante').addClass('has-error');
		}
		
		if( this.model.get('errorBusqAvNoHayAlMenosUnParametro') == true ){
			this.$('.alert-errorBusqAvNoHayAlMenosUnParametro').show();
			this.$('.div-busqavparam').addClass('has-error');
		}
		
	},
	
	disableInput: function(){
		this.$('input').prop('disabled',true);
		this.$('select').prop('disabled',true);
		this.$('button').prop('disabled',true);
	},
	
	events: {
		'change .field': 'updateModel',
		'click .limpiarCampos':'limpiarCampos',
		'click .realizarBusqueda':'realizarBusqueda'
    },
	
	//MÉTODO PARA EL BINDEAO DE DATOS	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		if(fieldName == 'criterio' || fieldName == 'idFigura'){
			this.saveFocus(fieldName); //guarda un foco para los campos que disparan cambios
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		//console.dir(this.model.toJSON());
	},
	saveFocus: function(fieldName){
		if(fieldName == 'idFigura'){
			this._savedFocus = 'idVarianteFigura';
		}
	},
	
	//MÉTODOS PARA LOS CLICK DE LOS BUTTONS
	limpiarCampos: function(ev){
		ev.preventDefault();
		this.model.clearAll();
	},
	
	realizarBusqueda: function(ev){
		ev.preventDefault();
		this.model.performSearch();
	}
	
});