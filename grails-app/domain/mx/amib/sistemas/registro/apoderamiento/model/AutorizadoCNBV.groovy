package mx.amib.sistemas.registro.apoderamiento.model

class AutorizadoCNBV {

	Integer numeroMatricula
	String nombreCompleto
	
	OficioCNBV oficioCNBV
	
	static belongsTo = [OficioCNBV]
	
	static mapping = {
		table 't111_t_autorizadocnbv'
		
		numeroMatricula column:'nu_matricula'
		nombreCompleto column:'tx_nombrecompleto'
		
		oficioCNBV column:'id_110_oficiocnbv'
		
		id generator: "assigned"
	}
	
    static constraints = {
		numeroMatricula unique: true
		nombreCompleto maxSize: 1000
    }
}
