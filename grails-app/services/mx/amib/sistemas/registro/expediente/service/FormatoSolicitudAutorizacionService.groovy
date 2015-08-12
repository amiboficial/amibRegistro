package mx.amib.sistemas.registro.expediente.service

import grails.transaction.Transactional
import java.io.ByteArrayOutputStream
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.io.IOException
import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.DataFormat
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.Color
import org.apache.poi.ss.usermodel.IndexedColors
import static org.apache.poi.ss.usermodel.IndexedColors.*
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.util.CellRangeAddress

@Transactional
class FormatoSolicitudAutorizacionService {

	static scope = "request"
	
	private static final String HEADER_SECUENCIA = "Secuencia"
	private static final String HEADER_FHENTORG = "Fecha Entrega Organismo"
	private static final String HEADER_TPINST = "Tipo de Institución"
	private static final String HEADER_CVINST = "Clave de Institución"
	private static final String HEADER_INST = "Institución"
	private static final String HEADER_FHINILAB = "Fecha de inicio de labores"
	private static final String HEADER_TPAUT = "Tipo de Autorización"
	private static final String HEADER_NUMMAT = "Matrícula"
	private static final String HEADER_FOLIO = "Folio de Registro"
	private static final String HEADER_AP1 = "Apellido Paterno"
	private static final String HEADER_AP2 = "Apellido Materno"
	private static final String HEADER_NOM = "Nombre"
	private static final String HEADER_RFC = "RFC"
	private static final String HEADER_CURP = "CURP"
	private static final String HEADER_FHNAC = "Fecha Nacimiento"
	private static final String HEADER_CALLE = "Calle"
	private static final String HEADER_NUM = "Número"
	private static final String HEADER_COL = "Colonia"
	private static final String HEADER_DEL = "Delegación"
	private static final String HEADER_CIUDAD = "Ciudad"
	private static final String HEADER_CP = "Código Postal"
	private static final String HEADER_EDO = "Estado"
	private static final String HEADER_TELCAS = "Teléfono Casa"
	private static final String HEADER_TELOFI = "Teléfono Oficina"
	private static final String HEADER_EMAIL = "Correo Electrónico"
	private static final String HEADER_NAL = "Nacionalidad"
	private static final String HEADER_CALMIG = "Calidad Migratoria"
	private static final String HEADER_ULTGRAD = "Último Grado de Estudios"
	
	private Map<String,Integer> mapHeadersIdx = [
		HEADER_SECUENCIA : 0,
		HEADER_FHENTORG : 1,
		HEADER_TPINST : 2,
		HEADER_CVINST : 3,
		HEADER_INST : 4,
		HEADER_FHINILAB : 5,
		HEADER_TPAUT : 6,
		HEADER_NUMMAT : 7,
		HEADER_FOLIO : 8,
		HEADER_AP1 : 9,
		HEADER_AP2 : 10,
		HEADER_NOM : 11,
		HEADER_RFC : 12,
		HEADER_CURP : 13,
		HEADER_FHNAC : 14,
		HEADER_CALLE : 15,
		HEADER_NUM : 16,
		HEADER_COL : 17,
		HEADER_DEL : 18,
		HEADER_CIUDAD : 19,
		HEADER_CP : 20,
		HEADER_EDO : 21,
		HEADER_TELCAS : 22,
		HEADER_TELOFI : 23,
		HEADER_EMAIL : 24,
		HEADER_NAL : 25,
		HEADER_CALMIG : 26,
		HEADER_ULTGRAD: 27
	]
	
	List<Map<String,String>> listaMapDato = new ArrayList<Map<String,String>>(); //datos almacenados en lista de mapas hash
	
	void fill(List<CertificacionTO> listCerts){
		
	}
	
	void flush(){
		
	}
	
	void renderAsXLSX(OutputStream os){
		
	}
	
}
