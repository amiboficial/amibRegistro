package mx.amib.sistemas.registro.apoderamiento.model

class Revocado {

	Integer numeroMatricula
	String nombreCompleto
	Integer numeroEscritura
	String motivo
	Date fechaBaja
	Revocacion revocacion

	boolean toBeUpdated
	
	static transients = ['toBeUpdated']
	static belongsTo = [Revocacion]

	static mapping = {
		table 't106_t_revocado'
		
		numeroMatricula column:'nu_matricula'
		nombreCompleto column:'tx_nombrecompleto'
		numeroEscritura column:'nu_escritura'
		motivo column:'tx_motivo'
		fechaBaja column:'fh_baja'
		
		revocacion column:'id_105_revocacion'
		
		id generator: "identity"
	}

	static constraints = {
		nombreCompleto maxSize: 1000
		motivo maxSize: 1000
	}
}
