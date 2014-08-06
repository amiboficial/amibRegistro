package mx.amib.sistemas.registro.apoderamiento.model.catalog

import mx.amib.sistemas.registro.apoderamiento.model.DocumentoRespaldoRevocacion;

class TipoDocumentoRespaldoRevocacion {

	String clave
	String descripcion
	Boolean vigente

	//static hasMany = [t107TDocrespaldorevocs: DocumentoRespaldoRevocacion]

	static mapping = {
		table 't108_c_tpdocrespaldorevoc'
		
		id generator: "assigned"
		
		clave column:'tx_clave'
		descripcion column:'ds_tpdocrespaldo'
		vigente column:'st_vigente'
		
		version false
	}
}
