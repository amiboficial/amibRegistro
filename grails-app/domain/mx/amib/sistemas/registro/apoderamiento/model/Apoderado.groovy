package mx.amib.sistemas.registro.apoderamiento.model

class Apoderado {

	Poder poder
	AutorizadoCNBV autorizado
	
	static belongsTo = [Poder, AutorizadoCNBV]

	static mapping = {
		table 't102_t_apoderado'
		
		poder column:'id_101_poder'
		autorizado column:'id_111_autorizadocnbv'
		
		id generator: "identity"
		
		version false
	}
}
