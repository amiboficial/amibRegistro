var app = app || {};

app.LoteElementVM = Backbone.Model.extend({
	defaults: {
		grailsId: -1,
		numeroMatricula: -1,
		idSustentante: -1,
		nombre: "",
		primerApellido: "",
		segundoApellido: "",
		
		checked: false,
		showing: true
	}
});

app.LoteElementCollectionVM = Backbone.Collection.extend({
	model: app.LoteElementCollectionVM,
	count: 0,
	max: 10,
	offset: 0,
	sort: "id",
	order: "asc",
	
	initialize: function(){
        // if collection is empty, fetch from server
        if(this.size() == 0)
            this.fetchAll();
    }

	comparator : 'grailsId',
    changeComparator: function (sortProperty) {
		if( sortProperty == 'grailsId' || sortProperty == 'idSustentante' ||
			sortProperty == 'nombre' || sortProperty == 'primerApellido' || 
			sortProperty == 'segundoApellido' ){
			 this.comparator = sortProperty;
		}
    },
	
	/* METODOS PARA CAMBIO DE VALORES CON "EVENTO" */
	setOffset: function(offset){
		this.offset = offset;
		this.refreshShowing();
	},
	
	/* ESTADOS DE PROCESAMIENTO */
	_processing: false,
	_startProcessing: function(){
		this._processing = true;
		this.trigger('processingStarted');
	},
	_stopProcessing: function(){
		this._processing = false;
		this.trigger('processingStopped');
	},
	_stopProcessingWithError: function(){
		this._processing = false;
		this.trigger('processingError');
	},
	isProcessing: function(){
		return this._processing;
	},
	
	/* PAGINADO */
	getCurrentPage: function(){
		return Math.floor(this.offset/this.max) + 1;
	},
	getTotalPages: function(){
		console.log("COUNT: " + this.count + ";MAX: " + this.max);
		return Math.ceil(this.count/this.max);
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
	},
	
	/* OBTENICION DE DATOS AJAX */
	fetchAll: function(){
		this.add( new app.LoteElementVM({
			grailsId: 1, 
			idSustentante: 1, 
			numeroMatricula: 1, 
			nombre: "ZZZZ", 
			primerApellido: "YYYYYY", 
			segundoApellido: "ZZZZZZZ", 
			
			checked: false, 
			showing: true
		}) );
		this.add( new app.LoteElementVM({
			grailsId: 2, 
			idSustentante: 2, 
			numeroMatricula: 2, 
			nombre: "ZZZZAAAAA", 
			primerApellido: "YYYYYYAAAAA", 
			segundoApellido: "ZZZZZZZAAAAAA", 
			
			checked: false, 
			showing: true
		}) );
		this.add( new app.LoteElementVM({
			grailsId: 3, 
			idSustentante: 3, 
			numeroMatricula: 3, 
			nombre: "ZZZZBBBB", 
			primerApellido: "YYYYYYBBBB", 
			segundoApellido: "ZZZZZZZBBBB", 
			
			checked: false, 
			showing: true
		}) );
		this.add( new app.LoteElementVM({
			grailsId: 4, 
			idSustentante: 4, 
			numeroMatricula: 4, 
			nombre: "ZZZZCCCCC", 
			primerApellido: "YYYYYYCCCCC", 
			segundoApellido: "ZZZZZZZCCCCCCCC", 
			
			checked: false, 
			showing: true
		}) );
		this.add( new app.LoteElementVM({
			grailsId: 5, 
			idSustentante: 5, 
			numeroMatricula: 5, 
			nombre: "ZZZZDDDDD", 
			primerApellido: "YYYYYYDDDDD", 
			segundoApellido: "ZZZZZZZDDDD", 
			
			checked: false, 
			showing: true
		}) );
	},
	
	/* ORDENAMIENTO DE DATOS */
	sortAndOrderBy: function(order,sort){
		this.changeComparator(order);
		this.sort({silent:true});
		if(sort == 'desc'){
			this.models.reverse();
		}
		this.trigger('reset', this, {});
	},
	
	/* CAMBIO DE PAGINA */
	goToPage: function(pagenum){
		this.setOffset((pagenum-1) * _this.max);
	},
	
	/* CUANDO EL VALOR DE OFFSET ES CAMBIADO, AUTOMATICAMENTE SE CAMBIA LOS VISIBLES */
	refreshShowing: function(){
		var i = 0;
		var upperLimitEx = (_this.offset+_this.max);
		var _this = this;
		
		i = 0;
		this.forEach( function(item){
			if(i >= _this.offset && i < upperLimitEx ){
				item.set('showing',true);
			}
			else{
				item.set('showing',false);
			}
			i++;
		} , item );
	},
	
	/* MÉTODOS "PRIVADOS" CON LOS QUE SE "COPIA" LA INFORMACIÓN DEL JSON RECIBIDO */
	
	_getResult: function(){
		var elemento = new app.ResultVM();
		var _this = this;
		elemento.set(result);
		elemento.set( { checked: false, showing: true } );
		return elemento;
	}
	
});

