package mx.amib.sistemas.external.expediente.certificacion.service

import java.util.Date;

import mx.amib.sistemas.external.expediente.certificacion.catalog.service.*
import mx.amib.sistemas.external.expediente.persona.service.*

class CertificacionTO {
	Long id
	
	Date fechaInicio
	Date fechaFin
	Date fechaObtencion
	Boolean isAutorizado
	Boolean isApoderado
	Boolean isUltima
	
	Long statusEntHistorialInforme
	String obsEntHistorialInforme
	Long statusEntCartaRec
	String obsEntCartaRec
	Long statusConstBolVal
	String obsConstBolVal
	
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
	
	Date fechaAutorizacionInicio
	Date fechaAutorizacionFin
	
	Date fechaEntregaRecepcion
	Date fechaEnvioComision
	
	String dga
	Long numeroOficio
}
