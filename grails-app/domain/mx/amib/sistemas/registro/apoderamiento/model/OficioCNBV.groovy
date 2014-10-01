package mx.amib.sistemas.registro.apoderamiento.model

class OficioCNBV {

	String claveDga
	Date fechaFinVigencia
	Date fechaCreacion
	Date fechaModificacion
	
	static hasMany = [autorizadosCNBV: AutorizadoCNBV]
	
	static mapping = {
		table 't110_t_oficiocnbv'
		
		claveDga column:'tx_dga'
		fechaFinVigencia column:'fh_finvigencia'
		fechaCreacion column:'fh_creacion'
		fechaModificacion column:'fh_modificacion'
		
		id generator: "assigned"
	}
	
    static constraints = {
		claveDga unique: true, maxSize: 16
    }
}
