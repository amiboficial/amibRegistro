package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.notario.model.Notario;

class Poder {

	String representanteLegalNombre
	String representanteLegalApellido1
	String representanteLegalApellido2
	Boolean esRegistradoPorGrupoFinanciero
	Long idGrupofinanciero
	Long idInstitucion
	Integer numeroEscritura
	Date fechaApoderamiento
	Date fechaCreacion
	Date fechaModificacion
	Notario notario

	String nombreGrupoFinanciero
	String nombreInstitucion

	static transients = ['nombreGrupoFinanciero','nombreInstitucion']
	static hasMany = [apoderados: Apoderado,
	                  documentosRespaldoPoder: DocumentoRespaldoPoder]
	static belongsTo = [Notario]

	static mapping = {
		table 't101_t_poder'
		
		representanteLegalNombre column:'nb_nombrereplegal'
		representanteLegalApellido1 column:'nb_apellido1replegal'
		representanteLegalApellido2 column:'nb_apellido2replegal'
		esRegistradoPorGrupoFinanciero column:'st_regporgrupofin'
		idGrupofinanciero column:'id_f_grupofinanciero'
		idInstitucion column:'id_f_institucion'
		numeroEscritura column:'nu_escritura'
		fechaApoderamiento column:'fh_apoderamiento'
		fechaCreacion column:'fh_creacion'
		fechaModificacion column:'fh_modificacion'
		
		notario column:'id_201_notario'
		
		id generator: "identity"
	}

	static constraints = {
		representanteLegalNombre maxSize: 100
		representanteLegalApellido1 maxSize: 80
		representanteLegalApellido2 maxSize: 80
		idGrupofinanciero nullable: true
		idInstitucion nullable: true
		fechaCreacion nullable: true
		fechaModificacion nullable: true
	}
}
