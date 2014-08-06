package mx.amib.sistemas.registro.apoderamiento.model.mview

class PoderVigente {

	Integer numeroMatricula
	Boolean esRegistradoPorGrupoFinanciero
	Long idGrupofinanciero
	Long idInstitucion
	String claveDga
	Date fechaModificacion

	static mapping = {
		table 't109_vm_podervigente'
		
		id generator: "assigned"
		
		numeroMatricula column:'nu_matricula'
		esRegistradoPorGrupoFinanciero column:'st_regporgrupofin'
		idGrupofinanciero column:'id_f_grupofinanciero'
		idInstitucion column:'id_f_institucion'
		claveDga column:'tx_dga'
		fechaModificacion column:'fh_modificacion'
		
		version false
	}

	static constraints = {
		idGrupofinanciero nullable: true
		idInstitucion nullable: true
		claveDga nullable: true, maxSize: 16
		fechaModificacion nullable: true
	}
}
