package mx.amib.sistemas.external.expediente.persona.service

import java.util.Date;
import mx.amib.sistemas.external.expediente.persona.catalog.service.*
import mx.amib.sistemas.external.expediente.certificacion.service.*

class SustentanteTO {
	Long id
	Integer numeroMatricula
	String nombre
	String primerApellido
	String segundoApellido
	String genero
	String rfc
	String curp
	Date fechaNacimiento

	String correoElectronico
	String calidadMigratoria
	String profesion
	String calle
	String numero
	Long idSepomex

	Date fechaCreacion
	Date fechaModificacion

	NacionalidadTO nacionalidad
	NivelEstudiosTO nivelEstudios
	EstadoCivilTO estadoCivil
	
	List<TelefonoSustentanteTO> telefonos
	List<DocumentoSustentanteTO> documentos
	List<PuestoTO> puestos
	
	List<CertificacionTO> certificaciones
	
}
