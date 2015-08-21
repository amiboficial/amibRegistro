var app = app || {};

app.AutorizadoVM = Backbone.Model.extend({
	defaults: {
		idCertificacion: -1,
		idSustentante: -1,
		numeroMatricula: '',
		nombreCompleto: '',
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		dsFigura: '',
		dsVarianteFigura: '',
		dsTipoAutorizacion: ''
	}
});

app.AutorizadoVMCollection = Backbone.Collection.extend({ 
	model: app.AutorizadoVM,
	
	_sort: "idCertificacion",
	_order: "asc",
		
	comparator: function(itemA, itemB){
		if(this._sort == "idCertificacion"){
			if(this._order == "desc"){
				if(itemA.get('idCertificacion') == itemB.get('idCertificacion'))
					return 0;
				else if(itemA.get('idCertificacion') > itemB.get('idCertificacion'))
					return -1;
				else
					return 1;
			}
			else{
				if(itemA.get('idCertificacion') <= itemB.get('idCertificacion'))
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "idSustentante"){
			if(this._order == "desc"){
				if(itemA.get('idSustentante') > itemB.get('idSustentante'))
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('idSustentante') <= itemB.get('idSustentante'))
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "numeroMatricula"){
			if(this._order == "desc"){
				if(itemA.get('numeroMatricula') > itemB.get('numeroMatricula'))
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('numeroMatricula') <= itemB.get('numeroMatricula'))
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "nombreCompleto"){
			if(this._order == "desc"){
				if(itemA.get('nombreCompleto').toUpperCase() > itemB.get('nombreCompleto').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('nombreCompleto').toUpperCase() <= itemB.get('nombreCompleto').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "nombre"){
			if(this._order == "desc"){
				if(itemA.get('nombre').toUpperCase() > itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('nombre').toUpperCase() <= itemB.get('nombre').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "primerApellido"){
			if(this._order == "desc"){
				if(itemA.get('primerApellido').toUpperCase() > itemB.get('primerApellido').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('primerApellido').toUpperCase() <= itemB.get('primerApellido').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "segundoApellido"){
			if(this._order == "desc"){
				if(itemA.get('segundoApellido').toUpperCase() > itemB.get('segundoApellido').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('segundoApellido').toUpperCase() <= itemB.get('segundoApellido').toUpperCase())
					return -1;
				else
					return 1
			}
		}
		else if(this._sort == "dsTipoAutorizacion"){
			if(this._order == "desc"){
				if(itemA.get('dsTipoAutorizacion').toUpperCase() > itemB.get('dsTipoAutorizacion').toUpperCase())
					return -1;
				else
					return 1
			}
			else{
				if(itemA.get('dsTipoAutorizacion').toUpperCase() <= itemB.get('dsTipoAutorizacion').toUpperCase())
					return -1;
				else
					return 1
			}
		}
	},
	
	sortAndOrderBy: function(order, sort){
		this._order = order;
		this._sort = sort;
		
		this.sort();
	}
});