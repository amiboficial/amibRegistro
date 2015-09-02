var app = app || {};

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

app.REV_IDX_OPTION_NUMESCRITURA = 0;
app.REV_IDX_OPTION_FECREV = 1;
app.REV_IDX_OPTION_ENTFINANCIERA = 2;

app.RevocacionSearchResultVM = Backbone.Model.extend({
	defaults:{
		grailsId: -1,
		numeroEscritura: -1,
		fechaRevocacionUnixEpoch: 0,
		fechaRevocacionDDMMYYYY: '',
		nombreCompletoNotario: ''
	},
});

app.RevocacionSearchResultVMCollection = Backbone.Collection.extend({
	model: app.RevocacionSearchResultVM,
	
	_max: 10,
	_offset: 0,
	_sort: "asc",
	_order: "grailsId",
	
	_query: '', //último "metodo" al que se llamo
	_lastAttributes: {}, //últimos atributos, estos se ocupan cuando se hace un sort o un cambio de página
	
	findAllByNumeroEscrituraUrl: '',
	findAllByFechaRevocacionUrl: '',
	findAllByGrupoFinancieroUrl: '',
	findAllByInstitucionUrl: '',
	
	/* NOTIFICACION DE ESTATUS DE PROCESAMIENTO */
	_processing: false,
	_errorOnRequest: false,
	_warningNotFound: false,
	isProcessing: function(){
		return this._processing;
	},
	setProcessingStatus: function(processingSt){
		this._processing = processingSt;
		this.trigger('processing',processingSt);
	},
	setErrorOnRequest: function(errorSt){
		this._errorOnRequest = errorSt;
		this.trigger('errorOnRequest',errorSt);
	},
	getErrorOnRequest: function(){
		return this._errorOnRequest;
	},
	setWarningNotFound: function(warnSt){
		this._warningNotFound = warnSt;
		this.trigger('warningNotFound',warnSt);
	},
	getWarningNotFound: function(){
		return this._warningNotFound;
	},
	
	/* CONSULTAS AJAX */
	findAllByNumeroEscritura: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = 1;
		this._offset = 0;
		this._sort = 'id';
		this._order = 'asc';
		
		this._query = 'findAllByNumeroEscritura';
		this._lastAttributes = { numeroEscritura: options.numeroEscritura }
		
		$.ajax({
			url: _this.findAllByNumeroEscrituraUrl, 
			beforeSend: function(xhr){
				_this.setProcessingStatus(true);
				_this.setWarningNotFound(false);
				_this.setErrorOnRequest(false);
			},
			data: {
				numeroEscritura: options.numeroEscritura
			},
			type: 'GET'
		}).done( function(data){
			_this.reset( null );
			if(data.status == "OK"){
				var listE = data.list
				var countE = data.count
				if(countE > 0){
					for(var i=0; i<listE.length; i++){
						_this.add(new app.RevocacionSearchResultVM(listE[i]));
					}
				}
				else{
					_this.setWarningNotFound(true);
				}
				_this.trigger('reset', this, {});
				_this.setProcessingStatus(false);
			}
			else{
				_this.setErrorOnRequest(true);
				_this.setProcessingStatus(false);
			}
		} );
		
	},
	findAllByFechaRevocacion: function(options){
		var _this = this;
		
		this._count = 0;
		this._max = options.max;
		this._offset = options.offset;
		this._sort = options.sort;
		this._order = options.order;
		
		this._query = 'findAllByFechaRevocacion';
		this._lastAttributes = {
			fechaRevocacionDel_day: options.fechaRevocacionDel_day,
			fechaRevocacionDel_month: options.fechaRevocacionDel_month,
			fechaRevocacionDel_year: options.fechaRevocacionDel_year,
			fechaRevocacionAl_day: options.fechaRevocacionAl_day,
			fechaRevocacionAl_month: options.fechaRevocacionAl_month,
			fechaRevocacionAl_year: options.fechaRevocacionAl_year
		}
		
		$.ajax({
			url: _this.findAllByFechaRevocacionUrl, 
			beforeSend: function(xhr){
				_this.setProcessingStatus(true);
				_this.setWarningNotFound(false);
				_this.setErrorOnRequest(false);
			},
			data: options,
			type: 'GET'
		}).done( function(data){
			_this.reset( null );
			if(data.status == "OK"){
				var listE = data.list
				var countE = data.count
				if(countE > 0){
					for(var i=0; i<listE.length; i++){
						_this.add(new app.RevocacionSearchResultVM(listE[i]));
					}
				}
				else{
					_this.setWarningNotFound(true);
				}
				_this.trigger('reset', this, {});
				_this.setProcessingStatus(false);
			}
			else{
				_this.setErrorOnRequest(true);
				_this.setProcessingStatus(false);
			}
		} );
	},
	findAllByGrupoFinanciero: function(options){
		alert('NOT YET IMPLEMENTED _> GF');
	},
	findAllByInstitucion: function(options){
		alert('NOT YET IMPLEMENTED -> INS');
	},
	sortAndOrderBy: function(order, sort){
		var _this = this;
		var opts = {};
		
		this._order = order;
		this._sort = sort;
		
		if(this._query == "findAllByFechaRevocacion"){
			alert('NOT YET IMPLEMENTED');
		}
		else if(this._query == "findAllByGrupoFinanciero"){
			alert('NOT YET IMPLEMENTED');
		}
		else if(this._query == "findAllByInstitucion"){
			alert('NOT YET IMPLEMENTED');
		}
		else{
			alert("NO ACTION REQUIRED");
		}
	},
	goToPage: function(pagenum){
		alert('NOT YET IMPLEMENTED');
	},
	
	/* METODOS CON DETALLES DE PAGINACION */
	getCurrentPage: function(){
		return Math.floor(this._offset/this._max) + 1;
	},
	getTotalPages: function(){
		return Math.ceil(this._count/this._max);
	},
	getNextPage: function(){
		var nextPage = 0;
		nextPage = this.getCurrentPage() + 1;
		return nextPage;
	},
	getBackPage: function(){
		var backPage = 0;
		backPage = this.getCurrentPage() - 1;
		return backPage;
	}
});

app.RevocacionSearchVM = Backbone.Model.extend({
	//Triggers desencadenados
	//1) change de cada atributo en caso de no ser "silent"
	//2) institucionesCargadas
	//3) allErrorsCleared
	//4) allDataCleared
	//5) everythingCleared
	//6) validated
	defaults:{
		numeroEscritura: '',
		fechaRevocacionDel_day: -1,
		fechaRevocacionDel_month: -1,
		fechaRevocacionDel_year: -1,
		fechaRevocacionAl_day: -1,
		fechaRevocacionAl_month: -1,
		fechaRevocacionAl_year: -1,
		nombreCompletoNotario: '',
		idGrupoFinanciero: -1,
		gruposFinancieros: [ {id:'-1',text:'-Seleccione-',instituciones:[]} ] ,
		idInstitucion: -1,
		instituciones: [ {id:'-1',text:'-Seleccione-'} ],
		
		criterioBusqueda: app.REV_IDX_OPTION_NUMESCRITURA,
		
		processing: false,
		
		errorNumeroEscrituraBlank: false,
		errorNumeroEscrituraNonNumeric: false,
		
		errorFechaRevocacionDelBlank: false,
		errorFechaRevocacionAlBlank: false,
		errorFechaRevocacionWrongRange: false,
		
		errorGrupoFinancieroNonSelected: false
	},
	
	initialize: function(){
		this.listenTo( this, 'change:idGrupoFinanciero', this.cargarInstitucionesDeGrupoFinanciero );
		this.listenTo( this, 'change:criterioBusqueda', this.clearAll );
		
		Backbone.Model.prototype.initialize.call(this);
	},
	
	clearAllErrors: function(){
		this.set({
			errorNumeroEscrituraBlank: false,
			errorNumeroEscrituraNonNumeric: false,
			errorFechaRevocacionDelBlank: false,
			errorFechaRevocacionAlBlank: false,
			errorFechaRevocacionWrongRange: false,
			errorGrupoFinancieroNonSelected: false
		},{silent:true});
		//manda una notificacion de que se limpiaron todos los errores
		this.trigger('allErrorsCleared',{});
	},
	clearAllData: function(){
		this.set({
			numeroEscritura: '',
			fechaRevocacionDel_day: -1,
			fechaRevocacionDel_month: -1,
			fechaRevocacionDel_year: -1,
			fechaRevocacionAl_day: -1,
			fechaRevocacionAl_month: -1,
			fechaRevocacionAl_year: -1,
			nombreCompletoNotario: '',
			idGrupoFinanciero: -1,
			idInstitucion: -1,
			instituciones: [ {id:'-1',text:'-Seleccione-'} ],
		});
		//manda una notificacion de que se han limpiado los datos de busqueda
		this.trigger('allDataCleared',{});
	},
	clearAll: function(){
		this.clearAllErrors();
		this.clearAllData();
		//manda una notificacion de que se ha limpiado todo
		this.trigger('everythingCleared',{});
	},
	
	cargarInstitucionesDeGrupoFinanciero: function(){
		var grupoFinancieroSeleccionado;
		var institucionesGrupoFinanciero;
		
		//si se escoge el "-1" en grupo financiero
		if(this.get('idGrupoFinanciero') == -1){
			this.set({
				idInstitucion: -1,
				instituciones: [ {id:'-1',text:'-Seleccione-'} ],
			});
		}
		else{
			//busca el grupo financiero con la id correspondiente
			_.each(this.get('gruposFinancieros'), function(item){
				if(item.id == this.get('idGrupoFinanciero')){
					grupoFinancieroSeleccionado = item;
				}
			}, this);
			//setea el correspondiente array de instituciones
			this.set('instituciones',grupoFinancieroSeleccionado.instituciones);
		}
		
		//manda una notificacion de que se acualizaron las instituciones
		this.trigger('institucionesCargadas',{});
	},
	
	validate: function(){
		var valid = true;
		
		var criterioBusqueda = this.get('criterioBusqueda');
		var numericRegEx = /^[0-9]{1,10}$/;
		
		this.clearAllErrors();
		
		if( criterioBusqueda == app.REV_IDX_OPTION_NUMESCRITURA ){
			if( this.get('numeroEscritura') == '' ){
				this.set('errorNumeroEscrituraBlank',true);
				valid = false;
			}
			else if( !numericRegEx.test( this.get('numeroEscritura') ) ){
				this.set('errorNumeroEscrituraNonNumeric',true);
				valid = false;
			}
		}
		else if( criterioBusqueda == app.REV_IDX_OPTION_FECREV ){
			if( this.get('fechaRevocacionDel_day') == -1 || this.get('fechaRevocacionDel_month') == -1 ||  this.get('fechaRevocacionDel_year') == -1 ){
				this.set('errorFechaRevocacionDelBlank',true);
				valid = false;
			}
			if( this.get('fechaRevocacionAl_day') == -1 || this.get('fechaRevocacionAl_month') == -1 ||  this.get('fechaRevocacionAl_year') == -1 ){
				this.set('errorFechaRevocacionAlBlank',true);
				valid = false;
			}
			if(valid == true){
				var dateDel = new Date(parseInt(this.get('fechaRevocacionDel_year')), parseInt(this.get('fechaRevocacionDel_month')) - 1, parseInt(this.get('fechaRevocacionDel_day')), 0, 0, 0, 0);
				var dateAl = new Date(parseInt(this.get('fechaRevocacionAl_year')), parseInt(this.get('fechaRevocacionAl_month')) - 1, parseInt(this.get('fechaRevocacionAl_day')), 0, 0, 0, 0);
				
				if(dateAl < dateDel){
					this.set('errorFechaRevocacionWrongRange',true);
					valid = false;
				}
			}
		}
		else if( criterioBusqueda == app.REV_IDX_OPTION_ENTFINANCIERA ){
			if( this.get('idGrupoFinanciero') == -1 ){
				this.set('errorGrupoFinancieroNonSelected',true);
				valid = false;
			}
		}
		
		this.trigger('validated',{});
		return valid;
	}
});

app.RevocacionResultsView = Backbone.View.extend({
	template: _.template( $('#revocacionResultsViewTemplate').html() ),
	templateElement: _.template( $('#revocacionResultViewTemplate').html() ),
	collection: new Backbone.Collection(),
	
	initialize: function(options){
		this.collection = options.collection;
		
		this.render();
		
		this.listenTo( this.collection, 'processing', this.renderProcessing );
		this.listenTo( this.collection, 'errorOnRequest', this.renderError );
		this.listenTo( this.collection, 'warningNotFound', this.renderWarning );
		
		this.listenTo( this.collection, 'reset', this.renderList );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template() );
		this.renderList();
		this.renderProcessing();
		this.renderError();
		this.renderWarning();
		return this;
	},
	
	renderList: function(){
		this.$('.list-items').html('');
		this.collection.each( function(item){
			this.$('.list-items').append( this.templateElement( item.toJSON() ) );
		},this );
	},
	renderProcessing: function(){
		if( this.collection.isProcessing() ){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.enableInput();
		}
	},
	renderError: function(){
		var errorOnRequest = this.collection.getErrorOnRequest();
		
		this.$('.alert-errorOnRequest').hide();
		
		if(errorOnRequest){
			this.$('.alert-errorOnRequest').show();
		}
	},
	renderWarning: function(){
		var warningNotFound = this.collection.getWarningNotFound();
		
		this.$('.alert-warningNotFound').hide();
		
		if(warningNotFound){
			this.$('.alert-warningNotFound').show();
		}
	},
	renderPagination: function(){
		var paginationStr = "";
		var totalPages = this.collection.getTotalPages();
		var currentPage = this.collection.getCurrentPage();
		
		if(currentPage == 1){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&lt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage-1) + '"><a href="javascript:void(0);">&lt;</a></li>'
		}
		
		for(var i=1; i<=totalPages; i++){
			if(i == currentPage){
				paginationStr += '<li class="active"><a href="javascript:void(0);">' + i + '</a></li>';
			}
			else{
				paginationStr += '<li class="page handCursor" data-page="' + i + '"><a href="javascript:void(0);">' + i + '</a></li>';
			}
		}
		
		if(currentPage == totalPages || totalPages == 0){
			paginationStr += '<li class="disabled"><a href="javascript:void(0);">&gt;</a></li>'
		}
		else{
			paginationStr += '<li class="page handCursor" data-page="' + (currentPage+1) + '"><a href="javascript:void(0);">&gt;</a></li>'
		}
		
		
		this.$(".pagination").html("");
		this.$(".pagination").html(paginationStr);
	},
	disableInput: function(){
		this.$('input').prop('disabled',true);
		this.$('select').prop('disabled',true);
		this.$('button').prop('disabled',true);
	},
	enableInput: function(){
		this.$('input').prop('disabled',false);
		this.$('select').prop('disabled',false);
		this.$('button').prop('disabled',false);
	},
	
	events: {
		'click .sort': 'mandarOrdenar',
	},
	
	mandarOrdenar: function(ev){
		var sort = this.$(ev.currentTarget).data("sort");
		var order = this.$(ev.currentTarget).data("order");
		
		alert('implementando sort para: ' + sort + ',' + order);
	},
	
});

app.RevocacionSearchView = Backbone.View.extend({
	template: _.template( $('#revocacionSearchViewTemplate').html() ),
	templateInstituciones: _.template( $('#revocacionSearchViewInstitucionesTemplate').html() ),
	model:  new Backbone.Model(),
	searchResultVMCollection: new Backbone.Collection(),
	
	initialize: function(options){
		this.model = options.model;
		this.searchResultVMCollection = options.searchResultVMCollection;
		
		this.render();
		
		this.listenTo( this.collection, 'processing', this.renderProcessing );
		
		//this.listenTo( this.model, 'change:criterioBusqueda', this.renderCriterioBusqueda );
		//al cambiar criterio, se limpian campos y se llama a everythingClear, por lo que no es necesario bindear
		this.listenTo( this.model, 'institucionesCargadas', this.renderInstituciones );
		this.listenTo( this.model, 'everythingCleared', this.render );
		this.listenTo( this.model, 'allErrorsCleared', this.renderError );
		this.listenTo( this.model, 'validated', this.renderError );
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(){
		this.$el.html( this.template( this.model.toJSON() ) );
		this.renderProcessing();
		this.renderInstituciones();
		this.renderError();
		return this;
	},
	
	renderProcessing: function(){
		if( this.searchResultVMCollection.isProcessing() ){
			this.$('.alert-processing').show();
			this.disableInput();
		}
		else{
			this.$('.alert-processing').hide();
			this.enableInput();
			this.renderCriterioBusqueda();
		}
	},
	renderError: function(){
		
		this.$('.alert-errorNumeroEscrituraBlank').hide();
		this.$('.alert-errorNumeroEscrituraNonNumeric').hide();
		this.$('.alert-errorFechaRevocacionDelBlank').hide();
		this.$('.alert-errorFechaRevocacionAlBlank').hide();
		this.$('.alert-errorFechaRevocacionWrongRange').hide();
		this.$('.alert-errorGrupoFinancieroNonSelected').hide();
		
		this.$('.div-numeroEscritura').removeClass('has-error');
		this.$('.div-fechaRevocacionDel').removeClass('has-error');
		this.$('.div-fechaRevocacionAl').removeClass('has-error');
		this.$('.div-idGrupoFinanciero').removeClass('has-error');
		this.$('.div-idInstitucion').removeClass('has-error');
		
		if(this.model.get('errorNumeroEscrituraBlank') == true){
			this.$('.alert-errorNumeroEscrituraBlank').show();
			this.$('.div-numeroEscritura').addClass('has-error');
		}
		if(this.model.get('errorNumeroEscrituraNonNumeric') == true){
			this.$('.alert-errorNumeroEscrituraNonNumeric').show();
			this.$('.div-numeroEscritura').addClass('has-error');
		}
		if(this.model.get('errorFechaRevocacionDelBlank') == true){
			this.$('.alert-errorFechaRevocacionDelBlank').show();
			this.$('.div-fechaRevocacionDel').addClass('has-error');
		}
		if(this.model.get('errorFechaRevocacionAlBlank') == true){
			this.$('.alert-errorFechaRevocacionAlBlank').show();
			this.$('.div-fechaRevocacionAl').addClass('has-error');
		}
		if(this.model.get('errorFechaRevocacionWrongRange') == true){
			this.$('.alert-errorFechaRevocacionWrongRange').show();
			this.$('.div-fechaRevocacionDel').addClass('has-error');
			this.$('.div-fechaRevocacionAl').addClass('has-error');
		}
		if(this.model.get('errorGrupoFinancieroNonSelected') == true){
			this.$('.alert-errorGrupoFinancieroNonSelected').show();
			this.$('.div-idGrupoFinanciero').addClass('has-error');
		}
		
	},
	renderCriterioBusqueda: function(){
		if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_NUMESCRITURA ){
			this.$('.numeroEscritura').prop('disabled',false);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',true);
			this.$('.fechaRevocacionDel_month').prop('disabled',true);
			this.$('.fechaRevocacionDel_year').prop('disabled',true);
			this.$('.fechaRevocacionAl_day').prop('disabled',true);
			this.$('.fechaRevocacionAl_month').prop('disabled',true);
			this.$('.fechaRevocacionAl_year').prop('disabled',true);
			
			this.$('.idGrupoFinanciero').prop('disabled',true);
			this.$('.idInstitucion').prop('disabled',true);
		}
		else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_FECREV ){
			this.$('.numeroEscritura').prop('disabled',true);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',false);
			this.$('.fechaRevocacionDel_month').prop('disabled',false);
			this.$('.fechaRevocacionDel_year').prop('disabled',false);
			this.$('.fechaRevocacionAl_day').prop('disabled',false);
			this.$('.fechaRevocacionAl_month').prop('disabled',false);
			this.$('.fechaRevocacionAl_year').prop('disabled',false);
			
			this.$('.idGrupoFinanciero').prop('disabled',true);
			this.$('.idInstitucion').prop('disabled',true);
		}
		else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_ENTFINANCIERA ){
			this.$('.numeroEscritura').prop('disabled',true);
			
			this.$('.fechaRevocacionDel_day').prop('disabled',true);
			this.$('.fechaRevocacionDel_month').prop('disabled',true);
			this.$('.fechaRevocacionDel_year').prop('disabled',true);
			this.$('.fechaRevocacionAl_day').prop('disabled',true);
			this.$('.fechaRevocacionAl_month').prop('disabled',true);
			this.$('.fechaRevocacionAl_year').prop('disabled',true);
			
			this.$('.idGrupoFinanciero').prop('disabled',false);
			this.$('.idInstitucion').prop('disabled',false);
		}
	},
	renderInstituciones: function(){
		console.log('PASO AQUI!!!!');
		this.$('.idInstitucion').html( this.templateInstituciones( this.model.toJSON() ) );
	},
	disableInput: function(){
		this.$('input').prop('disabled',true);
		this.$('select').prop('disabled',true);
		this.$('button').prop('disabled',true);
	},
	enableInput: function(){
		this.$('input').prop('disabled',false);
		this.$('select').prop('disabled',false);
		this.$('button').prop('disabled',false);
	},
	
	events:{
		'change .field':'updateModel',
		'click .limpiar':'limpiar',
		'click .buscar ':'buscar'
	},
	
	updateModel: function(ev){
		ev.preventDefault();
		
		var fieldName = this.$(ev.currentTarget).data("field");
		var fieldValue = this.$(ev.currentTarget).val().trim();
		
		if(fieldName == 'criterioBusqueda' || fieldName == 'idGrupoFinanciero'){
			this.model.set(fieldName,fieldValue);
		}
		else{
			this.model.set(fieldName,fieldValue,{silent:true});
		}
		
		console.log("Se actualizo modelo en el atributo: " + fieldName + ":" + fieldValue);
	},
	
	limpiar: function(ev){
		ev.preventDefault();
		this.model.clearAll();
	},
	
	buscar: function(ev){
		ev.preventDefault();
		
		if( this.model.validate() ){
			if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_NUMESCRITURA ){
				this.searchResultVMCollection.findAllByNumeroEscritura({
					numeroEscritura : this.model.get('numeroEscritura'),
					max: 10,
					offset: 0,
					sort: "asc",
					order: "id",
				});
			}
			else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_FECREV ){
				this.searchResultVMCollection.findAllByFechaRevocacion({
					fechaRevocacionDel_day: this.model.get('fechaRevocacionDel_day'),
					fechaRevocacionDel_month: this.model.get('fechaRevocacionDel_month'),
					fechaRevocacionDel_year: this.model.get('fechaRevocacionDel_year'),
					fechaRevocacionAl_day: this.model.get('fechaRevocacionAl_day'),
					fechaRevocacionAl_month: this.model.get('fechaRevocacionAl_month'),
					fechaRevocacionAl_year: this.model.get('fechaRevocacionAl_year'),
					max: 10,
					offset: 0,
					sort: "asc",
					order: "id"
				});
			}
			else if( this.model.get('criterioBusqueda') == app.REV_IDX_OPTION_ENTFINANCIERA ){
				if( this.model.get('idInstitucion') == -1 ){
					this.searchResultVMCollection.findAllByGrupoFinanciero({
						idGrupoFinanciero: this.model.get('idGrupoFinanciero'),
						max: 10,
						offset: 0,
						sort: "asc",
						order: "id"
					});
				}
				else{
					this.searchResultVMCollection.findAllByInstitucion({
						idInstitucion: this.model.get('idInstitucion'),
						max: 10,
						offset: 0,
						sort: "asc",
						order: "id"
					});
				}	
			}
		}
		
	},
});

app.RevocacionIndexView = Backbone.View.extend({
	el: '#divRevocacionIndex',
	template: _.template( $('#revocacionIndexViewTemplate').html() ),
	searchVM: new Backbone.Model(),
	searchResultVMCollection: new Backbone.Collection(),
	
	initialize: function(options){
		this.searchVM = options.searchVM;
		this.searchResultVMCollection = options.searchResultVMCollection;
		
		this.render();
		
		Backbone.View.prototype.initialize.call(this);
	},
	
	render: function(options){
		this.$el.html( this.template() );
		this.renderSearchView();
		this.renderResultsView();
		
		return this;
	},
	
	renderSearchView: function(){
		var parentView = this;
		var view;
		var model = this.searchVM;
		
		view = new app.RevocacionSearchView( { 
			parentView: parentView, 
			model :model, 
			searchResultVMCollection: this.searchResultVMCollection
		} );
		
		this.$('.div-revocacionSearch').html( view.render().el );
		
		return view;
	},
	
	renderResultsView: function(){
		var parentView = this;
		var view;
		var collection = this.searchResultVMCollection;
		
		view = new app.RevocacionResultsView({ 
			parentView:parentView, 
			collection:collection 
		});
		
		this.$('.div-revocacionResults').html( view.render().el );
		
		return view;
	}
	
});