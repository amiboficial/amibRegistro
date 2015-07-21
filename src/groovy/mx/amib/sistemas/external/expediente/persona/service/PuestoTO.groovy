package mx.amib.sistemas.external.expediente.persona.service

import java.util.Date;

class PuestoTO {
	Long id

	Long idInstitucion
	Date fechaInicio
	Date fechaFin
	String nombrePuesto
	Boolean esActual
	
	Long statusEntManifProtesta
	String obsEntManifProtesta
	Long statusEntCartaInter
	String obsEntCartaInter
	
	Date fechaCreacion
	Date fechaModificacion
	
	SustentanteTO sustentante
}
