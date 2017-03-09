package mx.amib.sistemas.registro.portal.model

class ConsultaTipoServicio4 {

	String folioPortal
	String fechaSolicitud
	String tipoServicio
	String matricula
	String fechaModificacion
	
	static mapping = {
		datasource 'portalamib'
		
		table 'servicio4'
		
		folioPortal column:'folio'
		fechaSolicitud column:'fh_solicitud'
		tipoServicio column:'id_406_tiposervicio'
		fechaModificacion column:'fh_modificacion'
		matricula column:'tx_matriculaamib'
		
		version false
				
	}
	
	
	
	
    static constraints = {
    }
}
