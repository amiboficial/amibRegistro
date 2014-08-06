package mx.amib.sistemas.registro.notario.model.catalog

import mx.amib.sistemas.registro.notario.model.NotarioSugerido;

class EstatusSugerencia {

	String descripcion
	Boolean vigente

	//static hasMany = [t202TSugnotarios: NotarioSugerido]

	static mapping = {
		table 't203_c_stsugerencia'
		
		id generator: "assigned"
		
		descripcion column:'ds_stsugerencia'
		vigente column:'st_vigente'
		
		version false
		
	}
	
	static constraints = {
		descripcion maxSize: 100
	}
}
