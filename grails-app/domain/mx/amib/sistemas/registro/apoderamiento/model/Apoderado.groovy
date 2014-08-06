package mx.amib.sistemas.registro.apoderamiento.model

class Apoderado {

	Long version
	
	Integer numeroMatricula
	String nombreCompleto
	String claveDga
	Poder poder

	static belongsTo = [Poder]

	static mapping = {
		table 't102_t_apoderado'
		
		numeroMatricula column:'nu_matricula'
		nombreCompleto column:'tx_nombrecompleto'
		claveDga column:'tx_dga'
		
		poder column:'id_101_poder'
		
		id generator: "assigned"
	}

	static constraints = {
		nombreCompleto maxSize: 1000
		claveDga maxSize: 16
	}
}
