package mx.amib.sistemas.external.expediente.certificacion.service

import mx.amib.sistemas.external.expediente.certificacion.catalog.service.*
import mx.amib.sistemas.external.expediente.persona.service.*

class CertificacionTO {
	Date fechaInicio
	Date fechaFin
	Date fechaObtencion
	Boolean isAutorizado
	Boolean isApoderado
	Boolean isUltima
	
	Date fechaCreacion
	Date fechaModificacion
	
	VarianteFiguraTO varianteFigura
	StatusAutorizacionTO statusAutorizacion
	StatusCertificacionTO statusCertificacion
	Long idVarianteFigura
	Long idStatusAutorizacion
	Long idStatusCertificacion

	SustentanteTO sustentante
	List<ValidacionTO> validaciones
}
