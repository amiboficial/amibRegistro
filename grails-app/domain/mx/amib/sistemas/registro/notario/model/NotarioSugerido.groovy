package mx.amib.sistemas.registro.notario.model

import mx.amib.sistemas.registro.notario.model.catalog.EstatusSugerencia;

class NotarioSugerido {

	Integer idEntidadFederativa
	Integer numeroNotario
	String nombre
	String apellido1
	String apellido2
	String observaciones
	Date fechaCreacion
	Date fechaModificacion
	EstatusSugerencia estatusSugerencia

	static belongsTo = [EstatusSugerencia]

	static mapping = {
		table 't202_t_sugnotario'
		
		id generator: "assigned"
		
		idEntidadFederativa column:'id_f_entidadfed'
		numeroNotario column:'nu_numnotariope'
		nombre column:'nb_nombre'
		apellido1 column:'nb_apellido1'
		apellido2 column:'nb_apellido2'
		observaciones column:'tx_observaciones'
		fechaCreacion column:'fh_creacion'
		fechaModificacion column:'fh_modificacion'
		
		estatusSugerencia column:'id_203_stsugerencia'
	}

	static constraints = {
		nombre maxSize: 100
		apellido1 maxSize: 80
		apellido2 maxSize: 80
		observaciones nullable: true, maxSize: 1000
		fechaCreacion nullable: true
		fechaModificacion nullable: true
	}
}
