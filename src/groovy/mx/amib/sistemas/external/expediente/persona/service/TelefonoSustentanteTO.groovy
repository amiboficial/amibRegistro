package mx.amib.sistemas.external.expediente.persona.service

import mx.amib.sistemas.external.expediente.persona.catalog.service.*

class TelefonoSustentanteTO {
	String lada
	String telefono
	String extension

	TipoTelefonoTO tipoTelefonoSustentante
	Long idTipoTelefonoSustentante

	SustentanteTO sustentante
}
