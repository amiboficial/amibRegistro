package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion;

class DocumentoRespaldoRevocacion {

	Long idDocumentoRepositorio
	Revocacion revocacion
	TipoDocumentoRespaldoRevocacion tipoDocumentoRespaldoRevocacion

	static belongsTo = [Revocacion, TipoDocumentoRespaldoRevocacion]

	static mapping = {
		table 't107_t_docrespaldorevoc'
		
		idDocumentoRepositorio column:'id_f_doc'
		
		revocacion column:'id_105_revocacion'
		tipoDocumentoRespaldoRevocacion column:'id_108_tpdocrespaldorevocacion'
		
		id generator: "assigned"
	}
}
