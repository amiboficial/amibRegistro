package mx.amib.sistemas.external.expediente.persona.service

import java.util.Date;

class PuestoTO {
	String empresa
	Date fechaInicio
	Date fechaFin
	String nombrePuesto
	Boolean esActual
	
	Date fechaCreacion
	Date fechaModificacion
	
	SustentanteTO sustentante
}
