package mx.amib.sistemas.external.expediente.persona.service

import java.util.Date;

class PuestoTO {
	Long id

	Long idInstitucion
	Date fechaInicio
	Date fechaFin
	String nombrePuesto
	Boolean esActual
	
	Date fechaCreacion
	Date fechaModificacion
	
	SustentanteTO sustentante
}
