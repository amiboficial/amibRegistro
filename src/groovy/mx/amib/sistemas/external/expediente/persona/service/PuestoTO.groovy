package mx.amib.sistemas.external.expediente.persona.service

import java.util.Date;

class PuestoTO {
	Long id

	Long idInstitucion
	Date fechaInicio
	Date fechaFin
	String nombrePuesto
	Boolean esActual
	
	Long statusEntHistorialInforme
	String obsEntHistorialInforme
	Long statusEntCartaRec
	String obsEntCartaRec
	Long statusConstBolVal
	String obsConstBolVal
	
	Date fechaCreacion
	Date fechaModificacion
	
	SustentanteTO sustentante
}
