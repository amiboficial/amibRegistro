package mx.amib.sistemas.external.expediente.persona.service

import mx.amib.sistemas.external.expediente.persona.catalog.service.TipoDocumentoTO

class DocumentoSustentanteTO {
	String uuid
	Boolean vigente
	
	SustentanteTO sustentante
	
	TipoDocumentoTO tipoDocumentoSustentate
	long idTipoDocumentoSustentate
}
