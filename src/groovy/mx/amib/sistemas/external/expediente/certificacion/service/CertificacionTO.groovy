package mx.amib.sistemas.external.expediente.certificacion.service

import java.util.Date
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.*
import mx.amib.sistemas.external.expediente.persona.service.*

class CertificacionTO {

	Date fechaInicio
	Date fechaFin
	Date fechaObtencion
	String nombreUsuarioActualizo
	
	Boolean esLaActual
	Date fechaUltimoCambioStatusEsLaActual
	
	Date fechaCreacion
	Date fechaModificacion
	
	VarianteFiguraTO varianteFigura
	StatusAutorizacionTO statusAutorizacion
	StatusCertificacionTO statusCertificacion
	MetodoCertificacionTO metodoCertificacion
	
	SustentanteTO sustentante
	CambioStatusTO cambioStatus
	EventoPuntosTO eventoPuntos
	
}
