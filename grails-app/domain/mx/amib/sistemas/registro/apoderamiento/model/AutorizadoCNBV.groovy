package mx.amib.sistemas.registro.apoderamiento.model

class AutorizadoCNBV {

	Integer numeroMatricula
	String nombreCompleto
	
	OficioCNBV oficioCNBV
	
	boolean toBeDeleted
	
	static transients = ['toBeDeleted']
	
	static hasMany = [apoderados: Apoderado]
	
	static belongsTo = [OficioCNBV]
	
	static mapping = {
		table 't111_t_autorizadocnbv'
		
		numeroMatricula column:'nu_matricula'
		nombreCompleto column:'tx_nombrecompleto'
		
		oficioCNBV column:'id_110_oficiocnbv'
		
		id generator: "identity"
	}
	
    static constraints = {
		nombreCompleto maxSize: 1000
    }
	
	public String toString(){
		return numeroMatricula + ":" + nombreCompleto;
	}
}
