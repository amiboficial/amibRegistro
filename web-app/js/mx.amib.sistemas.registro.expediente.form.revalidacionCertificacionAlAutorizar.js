var app = app || {};

app.RCA_MV_EXAMEN = 1;
app.RCA_MV_PUNTOS = 2;
app.RCA_MV_EXPERIENCIA = 3;
app.RCA_MV_PFI = 4;

app.RCA_MV_READY = 0;
app.RCA_MV_VALIDATED = 1;


//TODO: agregar una peticion para traer los metodos desde el catalogo
app.RevCertAutVM = Backbone.Model.extend({
	defaults:{
		idMetodoValidacion: -1,
		metodosValidacion: [
			{ id:'-1',text:'-Seleccione-' },
			{ id:'1',text:'Exámen' },
			{ id:'2',text:'Puntos' },
			{ id:'3',text:'Experiencia' },
			{ id:'4',text:'Examen PFI' },
		],
		opcionExamenVM : null, //app.OpcionExamenVM
		puntaje: 0,
		examenPFIvalido : false,
		errorPFICantSelect : false,
		
		errorEnSeleccionExamen: false,
		errorNoMetodoValidacion: false,
		errorPuntajeBlank: false,
		errorPuntajeNonNumeric: false
	},
	
	initialize: function(){
		this.listenTo( this,'change:idMetodoValidacion',this.cleanValidationErrors );
	},
	
	validate: function(){
		var valid = true;
		var regExpIsNumeric = /^[0-9]{1,10}$/; 
		var idMetodoValidacion = this.get('idMetodoValidacion');
		var metodoValidacionSeleccionado =  (this.get('idMetodoValidacion') != -1)
		
		this.cleanValidationErrors();
		
		if(!metodoValidacionSeleccionado){
			this.set('errorNoMetodoValidacion',true);
			this.trigger('errorOnValidate');
			valid = false;
		}
		else{
			if(idMetodoValidacion == app.RCA_MV_EXAMEN){
				if(!this.get('opcionExamenVM').validate()){
					this.set('errorEnSeleccionExamen',true);
					this.trigger('errorOnValidate');
					valid = false;
				}
			}
			else if(idMetodoValidacion == app.RCA_MV_PUNTOS){
				if( !regExpIsNumeric.test( this.get('puntaje') ) ){
					this.set('errorPuntajeNonNumeric',true);
					this.trigger('errorOnValidate');
					valid = false;
				}
			}
			else if(idMetodoValidacion == app.RCA_MV_PFI){
				if( !this.get('examenPFIvalido')){
					this.set('errorPFICantSelect',true);
					this.trigger('errorOnValidate');
					valid = false;
				}
			}
		}
		
		return valid;
	},
	cleanValidationErrors: function(){
		this.set({
			errorEnSeleccionExamen: false,
			errorNoMetodoValidacion: false,
			errorPuntajeBlank: false,
			errorPuntajeNonNumeric: false
		});
		this.get('opcionExamenVM').cleanValidationErrors();
		this.trigger('validationErrorsCleaned',{});
	}
});

app.RevCertAutView = Backbone.View.extend({
	el: '#divRevCert',
	model: null, //app.RevCertAutVM
	template: _.template( $('#revCertAutViewTemplate').html() ),
	_savedFocus: null,
	
	initialize: function(options){
		
		//INICIALIZACIÓN DE LOS VIEWMODELS
		this.model = new app.RevCertAutVM();
		
		if(options.metodosValidacion != null){
			this.model.set('metodosValidacion', options.metodosValidacion);
		}
		
		this.model.set('opcionExamenVM', new app.OpcionExamenVM() );
		if(options.examenVMCollection != null){
			console.log('PASO AQUI !!!!');
			console.dir(options.examenVMCollection.toJSON());
			this.model.get('opcionExamenVM').set('examenVMCollection', options.examenVMCollection);
		}
		
		//CALLBACKS DE CAMBIOS EN EL MODELO
		this.listenTo( this.model, 'change:idMetodoValidacion', this.render ); 
		this.listenTo( this.model, 'validationErrorsCleaned', this.renderError ); 
		this.listenTo( this.model, 'errorOnValidate', this.renderError ); 
		this.listenTo( this, 'stateChange', this.renderStateChange );
		
		this.listenTo( this, 'stateChange', this.propagateStateChange );
		//LLAMADO AL RENDER
		this.render();
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderOpcionExamen();
		this.renderOpcionPuntos();
		this.renderOpcionPFI();
		this.renderError();
		this.renderStateChange();
		
		if(this._savedFocus != null){
			this.$('.' + this._savedFocus).focus();
			this._savedFocus = null;
		}
		return this;
	},
	renderOpcionExamen: function(){
		var view = null;
		
		if( this.model.get('idMetodoValidacion') == app.RCA_MV_EXAMEN ){
			view = new app.OpcionExamenView( { model:this.model.get('opcionExamenVM') } );
			this.$('.div-opcionExamenVM').html( view.render().el );
		}
		else{
			this.$('.div-opcionExamenVM').html( '' );
		}
		
		return view;
	},
	renderOpcionPuntos: function(){
		if( this.model.get('idMetodoValidacion') == app.RCA_MV_PUNTOS ){
			this.$('.opcionPuntos').show();
		}
		else{
			this.$('.opcionPuntos').hide();
		}
	},
	renderOpcionPFI: function(){
		if( this.model.get('idMetodoValidacion') == app.RCA_MV_PFI ){
			this.$('#opcionPFI').show();
			if(xmlResponsecontentstring == undefined || xmlResponsecontentstring == "" ){
				this.$('#clasicPFIrevalidation').html('<div class="form-group"><label class="col-md-2 col-sm-3 control-label">No se pudo contactar el sericio intentelo mas tarde</label></div>');
				this.set('examenPFIvalido',false);
			}else{
				if(xmlResponsecontentstring=="FALSE"){
					this.$('#clasicPFIrevalidation').html('<div class="form-group"><label class="col-md-2 col-sm-3 control-label">No se encontro la matricula </label></div>');
					this.set('examenPFIvalido',false);
				}
				else{
					var ENDRESULTHTML = "";
					var multiplesExamenes = xmlResponsecontentstring.split("*|");
					var coutinuacion = 0;
					var elementos = [];
					var elementCont = "";
					for(coutinuacion = 0; coutinuacion < multiplesExamenes.length ; coutinuacion++){
						elementCont = multiplesExamenes[coutinuacion];
						elementos = elementCont.split('-}');
						
						if(elementos.length >=6 ){
								var aproved;
								var validTargeting = "";
								if(elementos[5] == "APROBADO"){
									aproved = true;
								}else{
									aproved = false;
									validTargeting = "style='cursor: not-allowed;'";
								}
								var htmlcontentPFIexam = '<a  href="javascript:void(0)" class="list-group-item seleccionarPFI" '+validTargeting+'  data-field="'+aproved+'" >'
								+'<div class="form-group">'
								+'<label class="col-md-2 col-sm-3 control-static">'+elementos[0]+'</label>'
								+'<div class="col-md-9 col-sm-9"><p class="form-control-static">'+elementos[3]+'</p></div></div>'
								+'<div class="form-group">'
								+'	<label class="col-md-2 col-sm-3 control-static">'
								+elementos[4]
								+'	</label>'
								+'	<div class="col-md-9 col-sm-9">'
								+'		<p class="form-control-static">'+elementos[5]+'</p>'
								+'	</div>'
								+'</div>'
								+'</a><br />';
								
								ENDRESULTHTML += htmlcontentPFIexam;
						}
					}
					this.$('#clasicPFIrevalidation').html(ENDRESULTHTML);
				}
			}
		}
		else{
			this.$('#opcionPFI').hide();
		}
	},
	renderError: function(){
		this.$('.alert-errorNoMetodoValidacion').hide();
		this.$('.alert-errorPuntajeBlank').hide();
		this.$('.alert-errorPuntajeNonNumeric').hide();
		this.$('.div-totalpuntos').removeClass('has-error');
		
		if(this.model.get('errorNoMetodoValidacion') == true){
			this.$('.alert-errorNoMetodoValidacion').show();
		}
		
		if(this.model.get('errorPuntajeBlank') == true){
			this.$('.alert-errorPuntajeBlank').show();
			this.$('.div-totalpuntos').addClass('has-error');
		}
		if(this.model.get('errorPuntajeNonNumeric') == true){
			this.$('.alert-errorPuntajeNonNumeric').show();
			this.$('.div-totalpuntos').addClass('has-error');
		}
		if(this.model.get('errorPFICantSelect') == true){
			this.$('.alert-errorPFICantSelect').show();
		}
	},
	renderStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.$('input').prop('disabled',false);
			this.$('button').prop('disabled',false);
			this.$('select').prop('disabled',false);
			this.$('.submit').prop('disabled',false);
			this.$('.edit').prop('disabled',true);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.$('input').prop('disabled',true);
			this.$('button').prop('disabled',true);
			this.$('select').prop('disabled',true);
			this.$('.submit').prop('disabled',true);
			this.$('.edit').prop('disabled',false);
		}
	},
	
	propagateStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.model.get('opcionExamenVM').set('disabled',false);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.model.get('opcionExamenVM').set('disabled',true);
		}
	},
	
	//CHECKLIST ID ATTRIBUTES
	//métodos y atributo para implementar complemento 
	//en un checklist
	checkId: -1,
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	events: {
		'change .field': 'updateModel',
		'click .submit': 'submit',
		'click .edit': 'edit',
		'click .seleccionarPFI':'pfiselec'
	},
	
	//VIEW STATUS
	//estatus de vista
	state: app.RCA_MV_READY,
	getState: function(){
		return this.state;
	},
	setReady: function(){
		this.state = app.RCA_MV_READY;
		this.trigger("stateChange","READY",this.checkId);
	},
	setValidated: function(){
		this.state = app.RCA_MV_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},
	
	//MÉTODO PARA EL BINDEAO DE DATOS	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		if(fieldName == 'idMetodoValidacion'){
			this.saveFocus(fieldName); //guarda un foco para los campos que disparan cambios
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
	},
	saveFocus: function(fieldName){
		if(fieldName == 'idMetodoValidacion'){
			//this._savedFocus = 'idMetodoValidacion';
		}
	},
	submit: function(ev){
		ev.preventDefault();
		if( this.model.validate() ){
			this.setValidated();
		}
	},
	edit: function(ev){
		ev.preventDefault();
		this.setReady();
	},
	pfiselec: function(truOrFalse){
		this.model.set('examenPFIvalido',truOrFalse);
		if(truOrFalse){
			$("[data-field='true'].seleccionarPFI").addClass("active");
		}else{
			$(".seleccionarPFI").removeClass("active");
		}
	}
	
});


app.RepCertAutVM = Backbone.Model.extend({
	defaults:{
		opcionExamenVM : null, //app.OpcionExamenVM
		errorEnSeleccionExamen: false
	},
	
	validate: function(){
		var valid = true;
		
		this.cleanValidationErrors();
		
		if(!this.get('opcionExamenVM').validate()){
			this.set('errorEnSeleccionExamen',true);
			this.trigger('errorOnValidate');
			valid = false;
		}
		
		return valid;
	},
	cleanValidationErrors: function(){
		this.set({
			errorEnSeleccionExamen: false,
		});
		this.get('opcionExamenVM').cleanValidationErrors();
		this.trigger('validationErrorsCleaned',{});
	}
	
});

app.RepCertAutView = Backbone.View.extend({
	el: '#divRepCert',
	model: null, //app.RepCertAutVM
	template: _.template( $('#repCertAutViewTemplate').html() ),
	_savedFocus: null,
	
	initialize: function(options){
		
		//INICIALIZACIÓN DE LOS VIEWMODELS
		this.model = new app.RepCertAutVM();
				
		this.model.set('opcionExamenVM', new app.OpcionExamenVM() );
		if(options.examenVMCollection != null){
			console.log('PASO AQUI !!!!');
			console.dir(options.examenVMCollection.toJSON());
			this.model.get('opcionExamenVM').set('examenVMCollection', options.examenVMCollection);
		}
		
		//CALLBACKS DE CAMBIOS EN EL MODELO
		this.listenTo( this.model, 'validationErrorsCleaned', this.renderError ); 
		this.listenTo( this.model, 'errorOnValidate', this.renderError ); 
		this.listenTo( this, 'stateChange', this.renderStateChange );
		
		this.listenTo( this, 'stateChange', this.propagateStateChange );
		//LLAMADO AL RENDER
		this.render();
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderOpcionExamen();
		this.renderError();
		this.renderStateChange();
		
		if(this._savedFocus != null){
			this.$('.' + this._savedFocus).focus();
			this._savedFocus = null;
		}
		return this;
	},
	renderOpcionExamen: function(){
		var view = null;
		
		view = new app.OpcionExamenView( { model:this.model.get('opcionExamenVM') } );
		this.$('.div-opcionExamenVM').html( view.render().el );
		
		return view;
	},
	renderError: function(){

	},
	renderStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.$('input').prop('disabled',false);
			this.$('button').prop('disabled',false);
			this.$('select').prop('disabled',false);
			this.$('.submit').prop('disabled',false);
			this.$('.edit').prop('disabled',true);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.$('input').prop('disabled',true);
			this.$('button').prop('disabled',true);
			this.$('select').prop('disabled',true);
			this.$('.submit').prop('disabled',true);
			this.$('.edit').prop('disabled',false);
		}
	},
	
	propagateStateChange: function(){
		if(this.state == app.RCA_MV_READY){
			this.model.get('opcionExamenVM').set('disabled',false);
		}
		else if(this.state == app.RCA_MV_VALIDATED){
			this.model.get('opcionExamenVM').set('disabled',true);
		}
	},
	
	//CHECKLIST ID ATTRIBUTES
	//métodos y atributo para implementar complemento 
	//en un checklist
	checkId: -1,
	setCheckId: function(checkId){
		this.checkId = checkId;
	},
	getCheckId: function(checkId){
		return checkId;
	},
	
	events: {
		'change .field': 'updateModel',
		'click .submit': 'submit',
		'click .edit': 'edit'
	},
	
	//VIEW STATUS
	//estatus de vista
	state: app.RCA_MV_READY,
	getState: function(){
		return this.state;
	},
	setReady: function(){
		this.state = app.RCA_MV_READY;
		this.trigger("stateChange","READY",this.checkId);
	},
	setValidated: function(){
		this.state = app.RCA_MV_VALIDATED;
		this.trigger("stateChange","VALIDATED",this.checkId);
	},
	
	//MÉTODO PARA EL BINDEAO DE DATOS	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		this.model.set(fieldName,fieldValue,{silent:true});
	},
	saveFocus: function(fieldName){
	},
	submit: function(ev){
		ev.preventDefault();
		if( this.model.validate() ){
			this.setValidated();
		}
	},
	edit: function(ev){
		ev.preventDefault();
		this.setReady();
	}
	
});