package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder;

class DocumentoRespaldoPoder {

	String uuidDocumentoRepositorio
	Poder poder
	TipoDocumentoRespaldoPoder tipoDocumentoRespaldoPoder

	String nombreDeArchivo
	boolean toBeUpdated
	
	static transients = ['nombreDeArchivo','toBeUpdated']
	static belongsTo = [Poder, TipoDocumentoRespaldoPoder]

	static mapping = {
		table 't103_t_docrespaldopoder'
		
		uuidDocumentoRepositorio column:'id_f_doc'
		
		poder column:'id_101_poder'
		tipoDocumentoRespaldoPoder column:'id_104_tpdocrespaldopoder'
		
		id generator: "identity"
	}
}
