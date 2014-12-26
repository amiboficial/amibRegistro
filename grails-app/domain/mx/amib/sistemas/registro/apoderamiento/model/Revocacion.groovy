package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.notario.model.Notario;

class Revocacion {

	String representanteLegalNombre
	String representanteLegalApellido1
	String representanteLegalApellido2
	Long idGrupofinanciero
	Long idInstitucion
	Integer numeroEscritura
	Date fechaRevocacion
	Date fechaCreacion
	Date fechaModificacion
	Notario notario
	Boolean verificado
	String verificadoPor
	Boolean aprobado
	String motivoRechazo
	
	String nombreGrupoFinanciero
	String nombreInstitucion

	static transients = ['nombreGrupoFinanciero','nombreInstitucion']
	static hasMany = [revocados: Revocado,
	                  documentosRespaldoRevocacion: DocumentoRespaldoRevocacion]
	static belongsTo = [Notario]

	static mapping = {
		table 't105_t_revocacion'
		
		representanteLegalNombre column:'nb_nombrereplegal'
		representanteLegalApellido1 column:'nb_apellido1replegal'
		representanteLegalApellido2 column:'nb_apellido2replegal'
		idGrupofinanciero column:'id_f_grupofinanciero'
		idInstitucion column:'id_f_institucion'
		numeroEscritura column:'nu_escritura'
		fechaRevocacion column:'fh_revocacion'
		verificado column: 'st_verificado'
		verificadoPor column: 'tx_verifico'
		aprobado column: 'st_aprobado'
		motivoRechazo column: 'tx_motivrechazo'
		fechaCreacion column:'fh_creacion'
		fechaModificacion column:'fh_modificacion'
		
		notario column:'id_201_notario'
		
		id generator: "identity"
	}

	static constraints = {
		representanteLegalNombre maxSize: 100
		representanteLegalApellido1 maxSize: 80
		representanteLegalApellido2 maxSize: 80
		verificado defaultValue: true
		verificadoPor nullable: true, maxSize: 254
		aprobado nullable: true
		motivoRechazo nullable: true, maxSize: 1000
		fechaCreacion nullable: true
		fechaModificacion nullable: true
	}
}
