package mx.amib.sistemas.registro.legacy.saaec.service

import grails.converters.JSON
import grails.transaction.Transactional
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO
import mx.amib.sistemas.utils.StringUtils

@Transactional
class RegistroExamenService {

    private static final Integer MAX_RESULTS = 100

    static HashMap<String,Long> tablaNacionalidades = new HashMap<String,Long>()

    def sustentanteService

    def dataSource_legacySaeec
    static datasource = 'legacySaeec'

    /**
     * Busca en la BD del SAEEC a un registro que haya aprobado su exámen y
     * que no se encuentre ya en registro
     */
    def findAllRegistrableByNumeroMatricula(Integer numeroMatricula) {
        Sql sql = new Sql(dataSource_legacySaeec)
        List<GroovyRowResult> saecRowRegs = null
        List<RegistroExamenTO> registros = new ArrayList<RegistroExamenTO>()

        //ER.IDE_EST_EXAMEN = 3 significa que ha Aprobado el exámen OR ER.IDE_EST_EXAMEN = 7 lo aprobó por experiencia
        String baseSqlQuery = """SELECT
                                    U.IDE_USUARIO,
                                    CF.IDE_FIGURA,
                                    day(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_DAY,
                                    month(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_MONTH,
                                    year(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_YEAR,
                                    F.FIG_DESCRIPCION,
                                    USU_NOMBRE,
                                    USU_APE_PATERNO,
                                    USU_APE_MATERNO,
                                    USU_SEXO,
                                    USU_RFC,
                                    USU_CURP,
                                    USU_DOMICILIO1,
                                    USU_DOMICILIO2,
                                    USU_COD_POSTAL,
                                    USU_CIUDAD,
                                    IDE_ESTADO,
                                    USU_TEL_CASA,
                                    USU_TEL_OFICINA,
                                    USU_EXTENSION,
                                    USU_EMAIL,
                                    IDE_EST_CIVIL,
                                    IDE_NIV_ESTUDIO,
                                    USU_NACIONALIDAD,
                                    ER.EXA_RES_INS_TRABAJA,
                                    USU_PUESTO
                                FROM USUARIO U
                                    JOIN EXAMEN_RESERVACION ER ON U.IDE_USUARIO = ER.IDE_USUARIO
                                    JOIN EXAMEN_CALENDARIO EC ON ER.IDE_EXA_CALENDARIO = EC.IDE_EXA_CALENDARIO
                                    JOIN CONFIGURACION_FIGURA CF ON ER.IDE_CON_FIGURA = CF.IDE_CON_FIGURA
                                    JOIN FIGURA F ON CF.IDE_FIGURA = F.IDE_FIGURA
                                WHERE  (ER.IDE_EST_EXAMEN = 3 OR ER.IDE_EST_EXAMEN = 7) AND U.IDE_USUARIO = ?
                                ORDER BY EC.EXA_CAL_FEC_APLICACION"""
        Object[] params = new Object[1]

        //Revisa si el registro de la matrícula se encuentra ya en expediente
        def sustentante = sustentanteService.obtenerPorMatricula(numeroMatricula)
        //Si no encuentra ningun registro, entonces busca el registro en la BD del SAAEC
        if (sustentante == null){
            params[0] = numeroMatricula
            saecRowRegs = sql.rows(baseSqlQuery,params)
            saecRowRegs.each {
                RegistroExamenTO registro = this.groovyRowResultToRegistroExamenTO(it)
                //println "R -> " + (registro as JSON)
                registros.add(registro)
            }
        }
        return registros
    }

    /**
     * Busca en la BD del SAEEC a registros que hayan aprobado su exámen y
     * que no se encuentren ya en registro. Solo se listan los primeros 25
     * resultados.
     */
    def findAllRegistrable(String nombre, String primerApellido, String segundoApellido, Long idFigura){
        Sql sql = new Sql(dataSource_legacySaeec)
        List<GroovyRowResult> saecRowRegs = null
        List<RegistroExamenTO> registros = new ArrayList<RegistroExamenTO>()
        List<String> dynFilters = new ArrayList<String>()
        StringBuilder dynFiltersStr = new StringBuilder()
        StringBuilder baseSqlQuery = new StringBuilder()
        Map<String,Object> namedParameters = new HashMap<String,Object>()
        List<Integer> matriculasEnSaaec = new ArrayList<Integer>()
        List<Integer> matriculasNoEnExpediente = new ArrayList<Integer>()

        //Añade el filtro
        if(nombre != null && nombre.trim().compareToIgnoreCase("") != 0){
            dynFilters.add(" UPPER(USU_NOMBRE) LIKE :nombre ")
            namedParameters.put("nombre",nombre.toUpperCase()+"%")
        }
        if(primerApellido != null && primerApellido.trim().compareToIgnoreCase("") != 0){
            dynFilters.add(" UPPER(USU_APE_PATERNO) LIKE :primerApellido ")
            namedParameters.put("primerApellido",primerApellido.toUpperCase()+"%")
        }
        if(segundoApellido != null && segundoApellido.trim().compareToIgnoreCase("") != 0){
            dynFilters.add(" UPPER(USU_APE_MATERNO) LIKE :segundoApellido ")
            namedParameters.put("segundoApellido",segundoApellido.toUpperCase()+"%")
        }
        if(idFigura != null && idFigura > 0){
            dynFilters.add(" ER.IDE_CON_FIGURA = :idFigura ")
            namedParameters.put("idFigura",idFigura)
        }
        if(dynFilters.size() > 0){
            dynFiltersStr.append(" AND ")
            int iteracion = 0, total = dynFilters.size()
            dynFilters.each {
                iteracion++
                if(iteracion == total)
                    dynFiltersStr.append(it)
                else
                    dynFiltersStr.append(it).append(" AND ")
            }
        }
        //ER.IDE_EST_EXAMEN = 3 significa que ha Aprobado el exámen OR ER.IDE_EST_EXAMEN = 7 lo aprobó por experiencia
        baseSqlQuery.append("SELECT TOP ").append(MAX_RESULTS).append("""
                                    U.IDE_USUARIO,
                                    CF.IDE_FIGURA,
                                    day(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_DAY,
                                    month(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_MONTH,
                                    year(EC.EXA_CAL_FEC_APLICACION) as EXA_CAL_FEC_APL_YEAR,
                                    F.FIG_DESCRIPCION,
                                    USU_NOMBRE,
                                    USU_APE_PATERNO,
                                    USU_APE_MATERNO,
                                    USU_SEXO,
                                    USU_RFC,
                                    USU_CURP,
                                    USU_DOMICILIO1,
                                    USU_DOMICILIO2,
                                    USU_COD_POSTAL,
                                    USU_CIUDAD,
                                    IDE_ESTADO,
                                    USU_TEL_CASA,
                                    USU_TEL_OFICINA,
                                    USU_EXTENSION,
                                    USU_EMAIL,
                                    IDE_EST_CIVIL,
                                    IDE_NIV_ESTUDIO,
                                    USU_NACIONALIDAD,
                                    ER.EXA_RES_INS_TRABAJA,
                                    USU_PUESTO
                                FROM USUARIO U
                                    JOIN EXAMEN_RESERVACION ER ON U.IDE_USUARIO = ER.IDE_USUARIO
                                    JOIN EXAMEN_CALENDARIO EC ON ER.IDE_EXA_CALENDARIO = EC.IDE_EXA_CALENDARIO
                                    JOIN CONFIGURACION_FIGURA CF ON ER.IDE_CON_FIGURA = CF.IDE_CON_FIGURA
                                    JOIN FIGURA F ON CF.IDE_FIGURA = F.IDE_FIGURA
                                WHERE  (ER.IDE_EST_EXAMEN = 3 OR ER.IDE_EST_EXAMEN = 7) """)
        baseSqlQuery.append(dynFiltersStr.toString())
        baseSqlQuery.append(" ORDER BY EC.EXA_CAL_FEC_APLICACION DESC, USU_NOMBRE, USU_APE_PATERNO, USU_APE_MATERNO")

        if(namedParameters.size() > 0)
            saecRowRegs = sql.rows(namedParameters,baseSqlQuery.toString())
        else
            saecRowRegs = sql.rows(baseSqlQuery.toString())

        //Revisa si las matriculas recuperadas ya se encuentran en expediente
        saecRowRegs.each { row ->
            matriculasEnSaaec.add((Integer)row.get("IDE_USUARIO"))
        }
        matriculasNoEnExpediente = sustentanteService.comprobarMatriculasNotIn(matriculasEnSaaec)

        //Descarta el registro si la matricula ya se encuentra en expediente
        saecRowRegs.each { row ->
            Integer matriculaReg = (Integer)row.get("IDE_USUARIO")
            if( matriculasNoEnExpediente.contains(matriculaReg) ){
                registros.add( this.groovyRowResultToRegistroExamenTO(row) )
            }
        }
        return registros
    }

    /***
     *
     * Obtiene el id correspondiente al nuevo catálogo de nacionalidades
     *
     * @param oldNacionalidad
     */
    private Integer oldNacionalidadToNewIdNacionalidad(String oldNacionalidad){
        //llena la tabla de nacionalidad si esta vacía
        if(this.tablaNacionalidades.size() == 0){
            tablaNacionalidades.put("Aleman",3)
            tablaNacionalidades.put("Alemana",3)
            tablaNacionalidades.put("Argentina",9)
            tablaNacionalidades.put("Belga",18)
            tablaNacionalidades.put("Boliviana",23)
            tablaNacionalidades.put("Brasileña",26)
            tablaNacionalidades.put("Brasileño",26)
            tablaNacionalidades.put("Britanico",142)
            tablaNacionalidades.put("Británico",142)
            tablaNacionalidades.put("Chilena",38)
            tablaNacionalidades.put("Chileno",38)
            tablaNacionalidades.put("Colombia",42)
            tablaNacionalidades.put("Colombiana",42)
            tablaNacionalidades.put("Costarrisence",47)
            tablaNacionalidades.put("Dominicano",51)
            tablaNacionalidades.put("Ecuatoriano",52)
            tablaNacionalidades.put("España",59)
            tablaNacionalidades.put("Español",59)
            tablaNacionalidades.put("Española",59)
            tablaNacionalidades.put("Española FM2",59)
            tablaNacionalidades.put("Estadounidense",60)
            tablaNacionalidades.put("Estadunidense",60)
            tablaNacionalidades.put("Francesa",66)
            tablaNacionalidades.put("Guatemala",73)
            tablaNacionalidades.put("Italiano",90)
            tablaNacionalidades.put("Mexicana",117)
            tablaNacionalidades.put("Mexicano",117)
            tablaNacionalidades.put("Peruano",139)
            tablaNacionalidades.put("Suiza",171)
            tablaNacionalidades.put("Uruguaya",186)
            tablaNacionalidades.put("Venezolana",189)
            tablaNacionalidades.put("Venezolano",189)
        }
        return tablaNacionalidades.get(oldNacionalidad)
    }

    private RegistroExamenTO groovyRowResultToRegistroExamenTO(GroovyRowResult grr){
        RegistroExamenTO re = new RegistroExamenTO()
        re.numeroMatricula = (Integer)grr.get("IDE_USUARIO")
        re.idFigura = (Long)grr.get("IDE_FIGURA")
        re.descripcionFigura = grr.get("FIG_DESCRIPCION")
        re.fechaAplicacionExamenDay = (Integer)grr.get("EXA_CAL_FEC_APL_DAY")
        re.fechaAplicacionExamenMonth = (Integer)grr.get("EXA_CAL_FEC_APL_MONTH")
        re.fechaAplicacionExamenYear = (Integer)grr.get("EXA_CAL_FEC_APL_YEAR")
        re.nombre = grr.get("USU_NOMBRE")
        re.primerApellido = grr.get("USU_APE_PATERNO")
        re.segundoApellido = grr.get("USU_APE_MATERNO")
        re.genero = ( grr.get("USU_SEXO") == true )?'M':'F'
        re.rfc = grr.get("USU_RFC")
        re.curp = ((String)grr.get("USU_CURP"))
		if(re.curp != null && re.curp.length() > 18){
			re.curp = re.curp.substring(0, 18)
		}
        re.domicilio = grr.get("USU_DOMICILIO1") + " " + grr.get("USU_DOMICILIO2")
        re.codigoPostal = StringUtils.padLeft('0' as char,grr.get("USU_COD_POSTAL").toString(),5)
        re.ciudad = grr.get("USU_CIUDAD")
        re.entidadFederativa = (Long)grr.get("IDE_ESTADO")
        re.telefonoCasa = grr.get("USU_TEL_CASA")
        re.telefonoOficina = grr.get("USU_TEL_OFICINA")
        re.extensionOficina = grr.get("USU_EXTENSION")
        re.correoElectronico = grr.get("USU_EMAIL")
        re.idEstadoCivil = (Long)grr.get("IDE_EST_CIVIL")
        re.idNivelEstudios = (Long)grr.get("IDE_NIV_ESTUDIO")
        re.idNacionalidad = this.oldNacionalidadToNewIdNacionalidad( grr.get("USU_NACIONALIDAD")?:"Mexicana" )
        re.oldNacionalidad = grr.get("USU_NACIONALIDAD")
        re.idInstitucion = grr.get("EXA_RES_INS_TRABAJA")
        re.puesto = grr.get("USU_PUESTO")
        return re
    }

}
