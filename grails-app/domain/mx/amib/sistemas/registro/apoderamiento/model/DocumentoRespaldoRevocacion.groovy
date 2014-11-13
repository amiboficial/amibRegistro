package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoRevocacion;

class DocumentoRespaldoRevocacion {

	String uuidDocumentoRepositorio
	Revocacion revocacion
	TipoDocumentoRespaldoRevocacion tipoDocumentoRespaldoRevocacion

	String nombreDeArchivo
	boolean toBeUpdated
	
	static transients = ['nombreDeArchivo','toBeUpdated']
	static belongsTo = [Revocacion, TipoDocumentoRespaldoRevocacion]

	static mapping = {
		table 't107_t_docrespaldorevoc'
		
		uuidDocumentoRepositorio column:'id_f_doc'
		
		revocacion column:'id_105_revocacion'
		tipoDocumentoRespaldoRevocacion column:'id_108_tpdocrespaldorevocacion'
		
		id generator: "identity"
	}
}
