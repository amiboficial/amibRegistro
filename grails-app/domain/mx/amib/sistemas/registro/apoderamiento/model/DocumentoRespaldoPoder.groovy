package mx.amib.sistemas.registro.apoderamiento.model

import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder;

class DocumentoRespaldoPoder {

	Long idDocumentoRepositorio
	Poder poder
	TipoDocumentoRespaldoPoder tipoDocumentoRespaldoPoder

	static belongsTo = [Poder, TipoDocumentoRespaldoPoder]

	static mapping = {
		table 't103_t_docrespaldopoder'
		
		idDocumentoRepositorio column:'id_f_doc'
		
		poder column:'id_101_poder'
		tipoDocumentoRespaldoPoder column:'id_104_tpdocrespaldopoder'
		
		id generator: "assigned"
	}
}
