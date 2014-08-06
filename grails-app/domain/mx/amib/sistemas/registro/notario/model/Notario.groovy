package mx.amib.sistemas.registro.notario.model

import mx.amib.sistemas.registro.apoderamiento.model.Poder;
import mx.amib.sistemas.registro.apoderamiento.model.Revocacion;

class Notario {

	Integer idEntidadFederativa
	Integer numeroNotario
	String nombre
	String apellido1
	String apellido2
	Date fechaCreacion
	Date fechaModificacion

	static hasMany = [poderes: Poder,
	                  revocaciones: Revocacion]

	static mapping = {
		table 't201_t_notario'
		
		id generator: "assigned"
		
		idEntidadFederativa column:'id_f_entidadfed'
		numeroNotario column:'nu_numnotariope'
		nombre column:'nb_nombre'
		apellido1 column:'nb_apellido1'
		apellido2 column:'nb_apellido2'
		fechaCreacion column:'fh_creacion'
		fechaModificacion column:'fh_modificacion'
		
		
	}

	static constraints = {
		idEntidadFederativa unique: ["numeroNotario"]
		nombre maxSize: 100
		apellido1 maxSize: 80
		apellido2 maxSize: 80
		fechaCreacion nullable: true
		fechaModificacion nullable: true
	}
}
