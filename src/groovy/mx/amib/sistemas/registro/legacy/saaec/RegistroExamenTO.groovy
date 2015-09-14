package mx.amib.sistemas.registro.legacy.saaec

/**
 * Created by Gabriel on 24/05/2015.
 */
class RegistroExamenTO {
	int idExamenReservacion
	
    Integer numeroMatricula
    Long idFigura
    String descripcionFigura
    Integer fechaAplicacionExamenDay
    Integer fechaAplicacionExamenMonth
    Integer fechaAplicacionExamenYear
	Date fechaAplicacion
    String nombre
    String primerApellido
    String segundoApellido
    String genero
    String rfc
    String curp
    String domicilio
    String codigoPostal
    String ciudad
    Long entidadFederativa
    String telefonoCasa
    String telefonoOficina
    String extensionOficina
    String correoElectronico
    Long idEstadoCivil
    Long idNivelEstudios
    Long idNacionalidad
    String oldNacionalidad

    Long idInstitucion
    String puesto
	
	//campos "calculados"
	int fechaNacimientoDay = -1
	int fechaNacimientoMonth = -1
	int fechaNacimientoYear = -1
}
