package mx.amib.sistemas.registro.apoderamiento.model.view

class PoderVigente {

	Integer id
	Integer numeroMatricula
	String nombreCompleto
	Long idGrupofinanciero
	Long idInstitucion
	Integer numeroEscritura

	static mapping = {
		table 't109_v_podervigente'
		
		id generator: "assigned"
		
		numeroMatricula column:'nu_matricula'
		nombreCompleto column:'tx_nombrecompleto'
		idGrupofinanciero column:'id_f_grupofinanciero'
		idInstitucion column:'id_f_institucion'
		numeroEscritura column:'nu_escritura'
		
		version false
	}

}
