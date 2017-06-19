package mx.amib.sistemas.registro.legacy.saaec.service

import grails.converters.JSON
import grails.transaction.Transactional
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import mx.amib.sistemas.registro.comprobante.model.ComprobantePuntos
import mx.amib.sistemas.registro.legacy.saaec.RegistroExamenTO
import mx.amib.sistemas.solicitud.SolicitudesOnlineTO
import mx.amib.sistemas.utils.StringUtils

@Transactional
class SolicitudesOnlineDataService {

    private static final Integer MAX_RESULTS = 100

    def sustentanteService

    def dataSource_solicitudOnline
    static datasource = 'solicitudOnline'

    /**
     * Busca en la BD del SAEEC a un registro que haya aprobado su exámen y
     * que no se encuentre ya en registro
     */
    def findAllRegistrableByNumeroMatricula(Integer numeroMatricula) {
        Sql sql = new Sql(dataSource_solicitudOnline)
        List<GroovyRowResult> saecRowRegs = null
        List<SolicitudesOnlineTO> registros = new ArrayList<SolicitudesOnlineTO>()

        //ER.IDE_EST_EXAMEN = 3 significa que ha Aprobado el exámen OR ER.IDE_EST_EXAMEN = 7 lo aprobó por experiencia
        String baseSqlQuery = """SELECT  a.id as solicitudId
      ,a.id_301_solicitante as solicitanteId
	  ,b.ds_statussolicitud as statusSolicitud
	        ,a.nu_matriculaamib as matriculaAmib
		,c.nm_nombrepila as nombre
		,c.nm_apaterno as apaterno
		,c.nm_amaterno as amaterno
		,c.tx_rfc as rfc
		,c.tx_curp as curp
		,c.tx_idestex as idEstudianteExtranjero
		,c.tx_correopersonal as correo
		,d.nu_telefono as particular
		,e.nu_telefono telefonoCelular 
		,f.nu_telefono telefonoOficina 
		,c.tx_lugarnacimiento as lugarNacimiento
		,c.fh_fechanacimiento as fechaNacimiento
		,c.st_estadocivil as estadoCivil
		,g.nm_entidadfed as entidadFed
		,h.nm_municipio as municipio
		,j.cve_codigopostal as codigoPostal
		,c.tx_calle as calle
		,i.nm_asentamiento as asentamiento
		,k.nm_ciudad as ciudad
		,c.tx_numext as numExterior
		,l.ds_nacionalidad as nacionalidad
		,m.ds_nivelestudios as nivelEstudios
		,n.ds_tiposervicio as tipoServicio
      ,a.nu_folioacredetica as folioEtica
      ,o.ds_formapago as formaPago
	  ,p.nm_institucion as nombreInstitucion
	  ,a.tx_di_puesto as puesto
	  ,a.fh_di_iniciolaborles as inicioLabores
	  ,a.fh_di_consulrepcredesp as consultaReporte
	  ,q.ds_figura as figura
	  ,r.ds_modalcapacitacion as capacitacion
	  ,s.ds_modalactcert as modoActualizacionCert
	  ,a.tx_modactcerti as valorActualizacionCert
	  ,a.tx_otroinstcapac as otroInstitutoCap
	  ,t.nm_institutocapacitador as institutoCapacitador
	  ,v.ds_tipoexamen as tipoExamen
	  ,x.nm_entidadfed as sedeExamen
	  ,w.ds_horarioexamen as horarioExamen
	  ,a.fh_examen as fechaExamen
	  
  FROM dbo.t401_t_solicitud a
  left join dbo.t404_c_statussolicitud b on a.id_404_statussolicitud=b.id
  left join  dbo.t301_t_solicitante c on a.id_301_solicitante=c.id
  left join dbo.t306_t_telefonosolicitante d on a.id_301_solicitante=d.id_301_solicitante and d.id_307_tipotelefono=1
left join dbo.t306_t_telefonosolicitante e on a.id_301_solicitante=e.id_301_solicitante and e.id_307_tipotelefono=2
left join dbo.t306_t_telefonosolicitante f on a.id_301_solicitante=f.id_301_solicitante and f.id_307_tipotelefono=3
left join dbo.t205_c_sepomex j on j.id=c.id_205_sepomex
left join dbo.t204_c_ciudad k on k.cve_ciudad=j.id_204_ciudad
left join dbo.t203_c_asentamiento i on i.cve_asentamiento=j.id_203_asentamiento
left join dbo.t202_c_municipio h on i.id_202_municipio=h.id
left join dbo.t201_c_entidadfed g on h.id_201_entidadfed=g.cve_entidadfed
left join dbo.t304_c_nacionalidad l on c.id_304_nacionalidad=l.id
left join dbo.t305_c_nivelestudios m on c.id_305_nivelestudios=m.id
left join dbo.t406_c_tiposervicio n on a.id_406_tiposervicio=n.id
left join dbo.t407_c_formapago o on a.id_407_formapago=o.id
left join dbo.t501_t_institucion p on a.id_501_institucion=p.id
left join dbo.t408_c_figura q on a.id_408_figura=q.id
left join dbo.t410_c_modalcapacitacion r on a.id_410_modalcapacitacion=r.id
left join dbo.t412_c_modalactcert s on a.id_412_modalactcert=s.id
left join dbo.t413_c_institutocapacitador t on a.id_413_institutocapacitador=t.id
left join dbo.t409_c_tipoexamen v on a.id_409_tipoexamen=v.id
left join dbo.t411_c_horarioexamen w on a.id_411_horarioexamen=w.id
left join dbo.t201_c_entidadfed x on a.id_201_entidadfedsede=x.id

where a.tx_matriculaamib = '?'"""
        Object[] params = new Object[1]
		
            params[0] = numeroMatricula
            saecRowRegs = sql.rows(baseSqlQuery,params)
            saecRowRegs.each {
                SolicitudesOnlineTO registro = (SolicitudesOnlineTO) it
                //println "R -> " + (registro as JSON)
                registros.add(registro)
            }
        return registros
    }
	

    private SolicitudesOnlineTO groovyRowResultToSolicitudesOnlineTO(GroovyRowResult grr){
        SolicitudesOnlineTO re = new SolicitudesOnlineTO()
		int rfcYear = 0
		Calendar calfechaAplicacion = Calendar.getInstance()
		
		re.solicitanteId = ((Integer)grr.get("solicitanteId"))
		re.matriculaAmib = ((Integer)grr.get("matriculaAmib"))
		re.nombre = ((Integer)grr.get("nombre"))
		re.apaterno = ((Integer)grr.get("apaterno"))
		re.amaterno = ((Integer)grr.get("amaterno"))
		re.rfc = ((Integer)grr.get("rfc"))
		re.curp = ((Integer)grr.get("curp"))
		re.idEstudianteExtranjero = ((Integer)grr.get("idEstudianteExtranjero"))
		re.correo = ((Integer)grr.get("correo"))
		re.particular = ((Integer)grr.get("particular"))
		re.telefonoCelular = ((Integer)grr.get("telefonoCelular"))
		re.telefonoOficina = ((Integer)grr.get("telefonoOficina"))
		re.lugarNacimiento = ((Integer)grr.get("lugarNacimiento"))
		re.fechaNacimiento = ((Integer)grr.get("fechaNacimiento"))
		re.estadoCivil = ((Integer)grr.get("estadoCivil"))
		re.entidadFed = ((Integer)grr.get("entidadFed"))
		re.municipio = ((Integer)grr.get("municipio"))
		re.codigoPostal = ((Integer)grr.get("codigoPostal"))
		re.calle = ((Integer)grr.get("calle"))
		re.asentamiento = ((Integer)grr.get("asentamiento"))
		re.ciudad = ((Integer)grr.get("ciudad"))
		re.numExterior = ((Integer)grr.get("numExterior"))
		re.asentamiento = ((Integer)grr.get("asentamiento"))
		re.ciudad = ((Integer)grr.get("ciudad"))
		re.numExterior = ((Integer)grr.get("numExterior"))
		re.nacionalidad = ((Integer)grr.get("nacionalidad"))
		re.nivelEstudios = ((Integer)grr.get("nivelEstudios"))
		re.tipoServicio = ((Integer)grr.get("tipoServicio"))
		re.folioEtica = ((Integer)grr.get("folioEtica"))
		re.formaPago = ((Integer)grr.get("formaPago"))
		re.nombreInstitucion = ((Integer)grr.get("nombreInstitucion"))
		re.puesto = ((Integer)grr.get("puesto"))
		re.inicioLabores = ((Integer)grr.get("inicioLabores"))
		re.consultaReporte = ((Integer)grr.get("consultaReporte"))
		re.figura = ((Integer)grr.get("figura"))
		re.capacitacion = ((Integer)grr.get("capacitacion"))
		re.modoActualizacionCert = ((Integer)grr.get("modoActualizacionCert"))
		re.valorActualizacionCert = ((Integer)grr.get("valorActualizacionCert"))
		re.otroInstitutoCap = ((Integer)grr.get("otroInstitutoCap"))
		re.institutoCapacitador = ((Integer)grr.get("institutoCapacitador"))
		re.tipoExamen = ((Integer)grr.get("tipoExamen"))
		re.sedeExamen = ((Integer)grr.get("sedeExamen"))
		re.horarioExamen = ((Integer)grr.get("horarioExamen"))
		re.fechaExamen = ((Integer)grr.get("fechaExamen"))
        return re
    }
	
	
	
	def dataSource_unificada

	/**
	 * Busca en la BD del SAEEC a un registro que haya aprobado su exámen y
	 * que no se encuentre ya en registro
	 */
	def findAllComprobantesPuntos(Integer numeroMatricula) {
		Sql sql = new Sql(dataSource_unificada)
		List<GroovyRowResult> saecRowRegs = null
		List<ComprobantePuntos> registros = new ArrayList<ComprobantePuntos>()

		String baseSqlQuery = """SELECT [Matricula]
		,[Nombre]
		,[Apellido Paterno] as Apellido_Paterno
      ,[Apellido Materno] as Apellido_Materno
      ,[Figura Certificada] as Figura_Certificada
      ,[Inicio de Vigencia Anterior] as Inicio_de_Vigencia_Anterior
      ,[Fin de Vigencia Anterior] as Fin_de_Vigencia_Anterior
      ,[Inicio Nueva Vigencia] as Inicio_Nueva_Vigencia
      ,[Fin Nueva Vigencia] as Fin_Nueva_Vigencia
      ,[Fecha de Emisión] as Fecha_de_Emisión
      ,[Fecha de Recepción] as Fecha_de_Recepción
      ,[INSTITUCIÓN EN LA QUE LABORA] as INSTITUCIÓN_EN_LA_QUE_LABORA
      ,[Tipo de Insitución] as Tipo_de_Insitución
      ,[Estatus]
      ,[Opción 1] as Opción_1
      ,[Instituto 1] as Instituto_1
      ,[Puntos]
      ,[No# Evento] as No_Evento
      ,[Opción 2] as Opción_2
      ,[Instituto 2] as Instituto_2
      ,[Puntos2]
      ,[No# Evento1] as No_Evento1
      ,[Opción 3] as Opción_3
      ,[Instituto 3] as Instituto_3
      ,[Puntos3]
      ,[No# Evento2] as No_Evento2
      ,[Opción 4] as Opción_4
      ,[Instituto 4] as Instituto_4
      ,[Puntos4]
      ,[No# Evento3] as No_Evento3
      ,[Opción 5] as Opción_5
      ,[Instituto 5] as Instituto_5
      ,[Puntos5]
      ,[No# Evento4] as No_Evento4
      ,[Opción 6] as Opción_6
      ,[Instituto 6] as Instituto_6
      ,[Puntos6]
      ,[No# Evento5] as No_Evento5
      ,[Opción 7] as Opción_7
      ,[Instituto 7] as Instituto_7
      ,[Puntos7]
      ,[No# Evento6] as No_Evento6
      ,[Opción 8] as Opción_8
      ,[Instituto 8] as Instituto_8
      ,[Puntos 8] as Puntos_8
      ,[No# Evento7] as No_Evento7
      ,[Opción 9] as Opción_9
      ,[Instituto 9] as Instituto_9
      ,[Puntos 9] as Puntos_9
      ,[No# Evento8] as No_Evento8
      ,[Opción 10] as Opción_10
      ,[Instituto 10] as Instituto_10
      ,[Puntos 10] as Puntos_10
      ,[No# Evento9] as No_Evento9
      ,[TOTAL DE PUNTOS] as TOTAL_DE_PUNTOS
      ,[DIAS DE ENTREGA VS NUEVA VIGENCIA] as DIAS_DE_ENTREGA_VS_NUEVA_VIGENCIA 
	FROM dbo.constancia where Matricula = """+numeroMatricula.toString()+"""  order by [Inicio de Vigencia Anterior] desc """
		
		
//		String baseSqlQuery = """SELECT [Matricula]
//      ,[Nombre]
//      ,[Apellido Paterno] as Apellido_Paterno
//      ,[Apellido Materno] as Apellido_Materno
//      ,[Figura Certificada] as Figura_Certificada
//      ,[Inicio de Vigencia Anterior] as Inicio_de_Vigencia_Anterior
//      ,[Fin de Vigencia Anterior] as Fin_de_Vigencia_Anterior
//      ,[Inicio Nueva Vigencia] as Inicio_Nueva_Vigencia
//      ,[Fin Nueva Vigencia] as Fin_Nueva_Vigencia
//      ,[Fecha de Emisión] as Fecha_de_Emisión
//      ,[Fecha de Recepción] as Fecha_de_Recepción
//      ,[INSTITUCIÓN EN LA QUE LABORA] as INSTITUCIÓN_EN_LA_QUE_LABORA
//      ,[Tipo de Insitución] as Tipo_de_Insitución
//      ,[Estatus]
//      ,[Opción 1] as Opción_1
//      ,[Instituto 1] as Instituto_1
//      ,[Puntos]
//      ,[No# Evento] as No_Evento
//      ,[Opción 2] as Opción_2
//      ,[Instituto 2] as Instituto_2
//      ,[Puntos2]
//      ,[No# Evento1] as No_Evento1
//      ,[Opción 3] as Opción_3
//      ,[Instituto 3] as Instituto_3
//      ,[Puntos3]
//      ,[No# Evento2] as No_Evento2
//      ,[Opción 4] as Opción_4
//      ,[Instituto 4] as Instituto_4
//      ,[Puntos4]
//      ,[No# Evento3] as No_Evento3
//      ,[Opción 5] as Opción_5
//      ,[Instituto 5] as Instituto_5
//      ,[Puntos5]
//      ,[No# Evento4] as No_Evento4
//      ,[Opción 6] as Opción_6
//      ,[Instituto 6] as Instituto_6
//      ,[Puntos6]
//      ,[No# Evento5] as No_Evento5
//      ,[Opción 7] as Opción_7
//      ,[Instituto 7] as Instituto_7
//      ,[Puntos7]
//      ,[No# Evento6] as No_Evento6
//      ,[Opción 8] as Opción_8
//      ,[Instituto 8] as Instituto_8
//      ,[Puntos 8] as Puntos_8
//      ,[No# Evento7] as No_Evento7
//      ,[Opción 9] as Opción_9
//      ,[Instituto 9] as Instituto_9
//      ,[Puntos 9] as Puntos_9
//      ,[No# Evento8] as No_Evento8
//      ,[Opción 10] as Opción_10
//      ,[Instituto 10] as Instituto_10
//      ,[Puntos 10] as Puntos_10
//      ,[No# Evento9] as No_Evento9
//      ,[TOTAL DE PUNTOS] as TOTAL_DE_PUNTOS
//      ,[DIAS DE ENTREGA VS NUEVA VIGENCIA] as DIAS_DE_ENTREGA_VS_NUEVA_VIGENCIA  
//		 FROM dbo.constancia where Matricula = 7850 """
		Object[] params = new Object[1]
		
		//Si no encuentra ningun registro, entonces busca el registro en la BD del SAAEC
//			params[0] = numeroMatricula
//			saecRowRegs = sql.rows(baseSqlQuery,params)
			saecRowRegs = sql.rows(baseSqlQuery)
			saecRowRegs.each {
				ComprobantePuntos registro = (ComprobantePuntos) it
				//println "R -> " + (registro as JSON)
				registros.add(registro)
			}
		return registros
	}
	
	
}
