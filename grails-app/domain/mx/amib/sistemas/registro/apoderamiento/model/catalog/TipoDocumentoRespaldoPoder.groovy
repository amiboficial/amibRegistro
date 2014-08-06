package mx.amib.sistemas.registro.apoderamiento.model.catalog

import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoPoder;

class TipoDocumentoRespaldoPoder {

	String clave
	String descripcion
	Boolean vigente

	//static hasMany = [documentosRespaldoPoder: DocumentoRespaldoPoder]

	static mapping = {
		table 't104_c_tpdocrespaldopoder'
		
		id generator: "assigned"
		
		clave column:'tx_clave'
		descripcion column:'ds_tpdocrespaldo'
		vigente column:'st_vigente'
		
		version false
	}
}
