package mx.amib.sistemas.registro.expediente.service

import grails.converters.JSON
import grails.transaction.Transactional
import java.io.ByteArrayOutputStream
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import mx.amib.sistemas.external.catalogos.service.InstitucionTO
import mx.amib.sistemas.external.catalogos.service.SepomexTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO
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

	def entidadFinancieraService
	def sepomexService
	
	static scope = "prototype"
	
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
		(HEADER_SECUENCIA) : 0,
		(HEADER_FHENTORG) : 1,
		(HEADER_TPINST) : 2,
		(HEADER_CVINST) : 3,
		(HEADER_INST) : 4,
		(HEADER_FHINILAB) : 5,
		(HEADER_TPAUT) : 6,
		(HEADER_NUMMAT) : 7,
		(HEADER_FOLIO) : 8,
		(HEADER_AP1) : 9,
		(HEADER_AP2) : 10,
		(HEADER_NOM) : 11,
		(HEADER_RFC) : 12,
		(HEADER_CURP) : 13,
		(HEADER_FHNAC) : 14,
		(HEADER_CALLE) : 15,
		(HEADER_NUM) : 16,
		(HEADER_COL) : 17,
		(HEADER_DEL) : 18,
		(HEADER_CIUDAD) : 19,
		(HEADER_CP) : 20,
		(HEADER_EDO) : 21,
		(HEADER_TELCAS) : 22,
		(HEADER_TELOFI) : 23,
		(HEADER_EMAIL) : 24,
		(HEADER_NAL) : 25,
		(HEADER_CALMIG) : 26,
		(HEADER_ULTGRAD) : 27
	]
	
	List<Map<String,String>> listaMapDato; //datos almacenados en lista de mapas hash
	
	public void fill(List<CertificacionTO> listCerts){
		Map<String,String> refMap = null
		int nuseq = System.currentTimeMillis()/1000000;
		
		println 'SE LLAMA A FILL'
		this.listaMapDato = new ArrayList<Map<String,String>>();
		listCerts.each { x ->
			
			//obtiene el puesto actual
			PuestoTO puestoActual = x.sustentante.puestos.find{ it.fechaFin == null }
			//obtiene la institucion del puesto actual
			InstitucionTO institucionPuestoActual = entidadFinancieraService.obtenerInstitucion(puestoActual.idInstitucion)
			//obtiene el elemento sepomex del sustentante
			SepomexTO sepomexSust = sepomexService.get(x.sustentante.idSepomex) 
			//obtiene un telefono de casa y oficina
			TelefonoSustentanteTO telCasa = x.sustentante.telefonos.find{ it.tipoTelefonoSustentante.descripcion == "Casa" }
			TelefonoSustentanteTO telOficina = x.sustentante.telefonos.find{ it.tipoTelefonoSustentante.descripcion == "Oficina" }
			
			String output;
			output = puestoActual.fechaInicio.format( 'yyyyMMdd' )
			String fechaNac;
			fechaNac = x.sustentante.fechaNacimiento.format( 'yyyyMMdd' )
			
			
			String fechaOrg;
			
			fechaOrg = x.fechaEntregaRecepcion.format('yyyyMMdd')
			
			
			String nacionalidad;
			
			if(x.sustentante.nacionalidad.descripcion == 'Mexicano/a'){
			  nacionalidad = 'M'}else{
			  'E'}
			
			
			refMap = new HashMap<String,String>()
			refMap.put(this.HEADER_SECUENCIA, nuseq++)
			//fecha de entrega que se le asigno en dictament previo
//			refMap.put(this.HEADER_FHENTORG, "yyyyMMdd")
			if(x.fechaEntregaRecepcion != null)
			refMap.put(this.HEADER_FHENTORG, fechaOrg)			
			refMap.put(this.HEADER_TPINST, institucionPuestoActual.idTipoInstitucion)
			refMap.put(this.HEADER_CVINST, institucionPuestoActual.id)
			refMap.put(this.HEADER_INST, institucionPuestoActual.nombre)
			refMap.put(this.HEADER_FHINILAB, output )
//			refMap.put(this.HEADER_FHINILAB, puestoActual.fechaInicio.getAt(Calendar.DAY_OF_MONTH) + "" + (puestoActual.fechaInicio.getAt(Calendar.MONTH)+1) + "" + puestoActual.fechaInicio.getAt(Calendar.YEAR) )
			refMap.put(this.HEADER_TPAUT, x.varianteFigura.idFigura)
			//refMap.put(this.HEADER_TPAUT, x.varianteFigura.tipoAutorizacionFigura)
			refMap.put(this.HEADER_NUMMAT, x.sustentante.numeroMatricula)
			refMap.put(this.HEADER_FOLIO, x.sustentante.id)
			refMap.put(this.HEADER_AP1, x.sustentante.primerApellido)
			refMap.put(this.HEADER_AP2, x.sustentante.segundoApellido?:'')
			refMap.put(this.HEADER_NOM, x.sustentante.nombre)
			refMap.put(this.HEADER_RFC, x.sustentante.rfc)
			refMap.put(this.HEADER_CURP, x.sustentante.curp)
			refMap.put(this.HEADER_FHNAC, fechaNac)
			//refMap.put(this.HEADER_FHNAC, x.sustentante.fechaNacimiento.getAt(Calendar.DAY_OF_MONTH) + "" + (x.sustentante.fechaNacimiento.getAt(Calendar.MONTH)+1) + "" + x.sustentante.fechaNacimiento.getAt(Calendar.YEAR))
			refMap.put(this.HEADER_CALLE, x.sustentante.calle)
			refMap.put(this.HEADER_NUM, x.sustentante.numeroExterior?:'' + ' ' + x.sustentante.numeroInterior?:'')
			refMap.put(this.HEADER_COL, sepomexSust.asentamiento.nombre)
			refMap.put(this.HEADER_DEL, sepomexSust.asentamiento.municipio.nombre)
			refMap.put(this.HEADER_CIUDAD, sepomexSust.ciudad.nombre)
			refMap.put(this.HEADER_CP, sepomexSust.codigoPostal)
			refMap.put(this.HEADER_EDO, sepomexSust.ciudad.municipio.entidadFederativa.id)
			if(telCasa != null)
				refMap.put(this.HEADER_TELCAS, telCasa.lada?:'' + ' ' + telCasa.telefono?:'' + ' ' + telCasa.extension?:'')
			if(telOficina != null)
				refMap.put(this.HEADER_TELOFI, telOficina.lada?:'' + ' ' + telOficina.telefono?:'' + ' ' + telOficina.extension?:'')
			refMap.put(this.HEADER_EMAIL, x.sustentante.correoElectronico)
			refMap.put(this.HEADER_NAL, nacionalidad)
			refMap.put(this.HEADER_CALMIG, x.sustentante.calidadMigratoria)
			refMap.put(this.HEADER_ULTGRAD, x.sustentante.nivelEstudios.descripcion)
			this.listaMapDato.add(refMap)
		}
	}
	
	public void flush(){
		listaMapDato.clear()
	}
	
	public void renderAsXLSX(OutputStream os) throws IOException{
		
		//imprimir 
		//println "llamando a render as xlsx"
		//println (listaMapDato as JSON)
		//aqui es donde va a renderear el excel
		//Preparación de variables y referencias
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		Workbook wb = new XSSFWorkbook();  //create a new workbook
		Sheet s = wb.createSheet();  // create a new sheet
		Row row = null; //row reference
		Cell cell = null; //cell reference
		Font fuenteTitulo = null;
		Font fuenteDato = null;
		CellStyle csTitulo = null;
		CellStyle csCabecera = null;
		CellStyle csDato = null;
		Map<String,String> mapDato = null;
		int totalAtributos = 0;
		int i,j;
		
		//Prepeparar formato
		// seteo de fuentes
		fuenteTitulo = wb.createFont();
		fuenteDato = wb.createFont();
		fuenteTitulo.setBold(true);
		fuenteTitulo.setFontHeightInPoints((short)12);
		fuenteDato.setBold(false);
		fuenteDato.setFontHeightInPoints((short)12);
		// setedo de celdas unidas
		//s.addMergedRegion(new CellRangeAddress(0,0,0,9)); //el rango es de A1 a J1
		// seteo de estilo de celda de cabecera
		csTitulo = wb.createCellStyle();
		csTitulo.setFont(fuenteTitulo);
		csCabecera = wb.createCellStyle();
		csCabecera.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		csCabecera.setFillPattern((short) CellStyle.SOLID_FOREGROUND);
		csCabecera.setFont(fuenteDato);
		csDato = wb.createCellStyle();
		csDato.setFont(fuenteDato);
		
		//crea el titulo
		//row = s.createRow(0); //instancia a la primera fila
//		cell = row.createCell(0); //instance a la primer celda (la que hicimos "merge"
//		cell.setCellValue("Formato de Solicitud de Autorización");
//		cell.setCellStyle(csTitulo);
		//crea las cabeceras
//		row = s.createRow(2);
//		i = 2;
//		for(String nombreCabecera : mapHeadersIdx.keySet()){
//			cell = row.createCell( mapHeadersIdx.get(nombreCabecera) );
//			cell.setCellStyle(csCabecera);
//			cell.setCellValue(nombreCabecera);
//			i++;
//		}
		
		//llena los datos recibidos en el fill
//		i = 3; //inicia a partir de la fila 3 (indice desde 0)
		
		
		i = 0; //inicia a partir de la fila 3 (indice desde 0)
		totalAtributos = mapHeadersIdx.size();
		
		println "aqui llego 1, con el listaMapDato cuyo tamanio es: " + listaMapDato.size()
		for(Map<String,String> curMap : listaMapDato ){
			row = s.createRow(i);
			//println "leyendo una tupla"
			Iterator<String> keySetIterator = curMap.keySet().iterator();
			while(keySetIterator.hasNext()){
				String curKey = keySetIterator.next();
				//println "leyendo map por tupla cuyo key es " + curKey
				j = mapHeadersIdx.get(curKey);
				cell = row.createCell(j);
				cell.setCellValue(curMap.get(curKey));
			}
			
			i++;
		}
		//println "aqui llego 2"
		//escribe en el byteOutputArray
		wb.write(bout);
		//bout.close();
		//println "aqui llego 3"
		//escribe en el OutputStream que se paso como parametro
		os.write( bout.toByteArray() );
	}
	
}
