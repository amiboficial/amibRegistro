package mx.amib.sistemas.external.expediente.service

import org.springframework.http.HttpStatus
import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import java.text.DateFormat
import java.text.SimpleDateFormat
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.VarianteFiguraTO
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.EventoPuntosTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class CertificacionService {

	public static class ResultSet{
		List<CertificacionTO> list
		List<SustentanteTO> sustentantes
		Set<Long> idsCertLoteEnvioAutorizacion
		long count
		boolean error
		String errorDetails
	}
	
	String getAllUrl
	String getWithSustentante
	String findAllEnDictamenPrevioUrl 
	String findAllEnDictamenPrevioByMatriculaUrl
	String findAllEnDictamenPrevioByFolioUrl
	String findAllEnAutorizacionUrl
	String findAllEnAutorizacionByMatriculaUrl
	String findAllEnAutorizacionByFolioUrl
	
	String findAllCandidatoActualizacionAutorizacionUrl
	String findAllCandidatoActualizacionAutorizacionByMatriculaUrl
	String findAllCandidatoActualizacionAutorizacionByFolioUrl
	String findAllCandidatoReposicionAutorizacionUrl
	String findAllCandidatoReposicionAutorizacionByMatriculaUrl
	String findAllCandidatoReposicionAutorizacionByFolioUrl
	String findAllCandidatoCambioFiguraUrl
	String findAllCandidatoCambioFiguraByMatriculaUrl
	String findAllCandidatoCambioFiguraByFolioUrl
	
	String updateDatosParaAprobarDictamenUrl
	String updateDatosParaActualizarAutorizacionUrl
	String createReponerAutorizacionUrl
	String createCambioFiguraUrl
	
	CertificacionTO get(Long id){
		CertificacionTO c = null
		def rest = new RestBuilder()
		def resp = rest.post( this.getWithSustentante + id ){
			contentType "application/json;charset=UTF-8"
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			SustentanteTO s = SustentanteService.obtenerSustentanteFromJSON(resp.json.'sustentante')
			c = s.certificaciones.find{ it.id == id }
		}
		
		return c
	}
	
    List<CertificacionTO> getAll(List<Long> ids) {
		List<Long> idsCerts = new ArrayList<Long>()
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def rest = new RestBuilder()
		def resp = rest.post( this.getAllUrl ){
			contentType "application/json;charset=UTF-8"
			json (ids as JSON)
		}
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){					
			resp.json.'sustentantes'.each{ x -> 
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
		}
		
		return certificaciones
    }
	
	CertificacionService.ResultSet findAllEnDictamenPrevio(Integer max, Integer offset, String sort, String order, 
											String nom, String ap1, String ap2, 
											long idfig, long idvarfig){
		return this._findAll(this.findAllEnDictamenPrevioUrl, max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig)
	}
	
	CertificacionService.ResultSet findAllEnDictamenPrevioByMatricula(int numeroMatricula){
		
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnDictamenPrevioByMatriculaUrl + numeroMatricula
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
	
	CertificacionService.ResultSet findAllEnDictamenPrevioByFolio(long idSustentante){
		
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnDictamenPrevioByFolioUrl + idSustentante
		
		println "URL A SOLICITAR: " + getUrl
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
	
	CertificacionService.ResultSet findAllEnAutorizacion(Integer max, Integer offset, String sort, String order, String nom, String ap1, String ap2, Long idfig, Long idvarfig){
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
											
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnAutorizacionUrl + "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&nom=${nom}&ap1=${ap1}&ap2=${ap2}&idfig=${idfig}&idvarfig=${idvarfig}"
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
	
	CertificacionService.ResultSet findAllEnAutorizacionByMatricula(int numeroMatricula){
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnAutorizacionByMatriculaUrl + numeroMatricula
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		
		
		return rs
	}
	
	CertificacionService.ResultSet findAllEnAutorizacionByFolio(long idSustentante){
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = this.findAllEnAutorizacionByFolioUrl + idSustentante
		
		println "URL A SOLICITAR: " + getUrl
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
		
	CertificacionService.ResultSet findAllCandidatoActualizacionAutorizacion(int max, int offset, String sort, String order, String nom, String ap1, String ap2, long idfig, long idvarfig){
		return this._findAll(this.findAllCandidatoActualizacionAutorizacionUrl, max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig)
	}
	CertificacionService.ResultSet findAllCandidatoActualizacionAutorizacionByMatricula(int numeroMatricula){
		return this._findAllUsingId(this.findAllCandidatoActualizacionAutorizacionByMatriculaUrl, numeroMatricula.toString())
	}
	CertificacionService.ResultSet findAllCandidatoActualizacionAutorizacionByFolio(long idSustentante){
		return this._findAllUsingId(this.findAllCandidatoActualizacionAutorizacionByFolioUrl, idSustentante.toString())
	}
	CertificacionService.ResultSet findAllCandidatoReposicionAutorizacion(int max, int offset, String sort, String order, String nom, String ap1, String ap2, long idfig, long idvarfig){
		return this._findAll(this.findAllCandidatoReposicionAutorizacionUrl, max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig)
	}
	CertificacionService.ResultSet findAllCandidatoReposicionAutorizacionByMatricula(int numeroMatricula){
		return this._findAllUsingId(this.findAllCandidatoReposicionAutorizacionByMatriculaUrl, numeroMatricula.toString())
	}
	CertificacionService.ResultSet findAllCandidatoReposicionAutorizacionByFolio(long idSustentante){
		return this._findAllUsingId(this.findAllCandidatoReposicionAutorizacionByFolioUrl, idSustentante.toString())
	}
	CertificacionService.ResultSet findAllCandidatoCambioFigura(int max, int offset, String sort, String order, String nom, String ap1, String ap2, long idfig, long idvarfig){
		return this._findAll(this.findAllCandidatoCambioFiguraUrl, max, offset, sort, order, nom, ap1, ap2, idfig, idvarfig)
	}
	CertificacionService.ResultSet findAllCandidatoCambioFiguraByMatricula(int numeroMatricula){
		return this._findAllUsingId(this.findAllCandidatoCambioFiguraByMatriculaUrl, numeroMatricula.toString())
	}
	CertificacionService.ResultSet findAllCandidatoCambioFiguraByFolio(long idSustentante){
		return this._findAllUsingId(this.findAllCandidatoCambioFiguraByFolioUrl, idSustentante.toString())
	}
		
	private CertificacionService.ResultSet _findAll(String url, Integer max, Integer offset, String sort, String order,String nom, String ap1, String ap2, long idfig, long idvarfig){
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = url + "?max=${max}&offset=${offset}&sort=${sort}&order=${order}&nom=${nom}&ap1=${ap1}&ap2=${ap2}&idfig=${idfig}&idvarfig=${idvarfig}"
		
		println getUrl
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
	
	private CertificacionService.ResultSet _findAllUsingId(String url, String id){
		CertificacionService.ResultSet rs = new CertificacionService.ResultSet()
		
		List<SustentanteTO> sustentantes = new ArrayList<SustentanteTO>()
		List<CertificacionTO> certificaciones = new ArrayList<CertificacionTO>()
		List<Long> ids = new ArrayList<Long>()
		
		def listCertificacionesJson = null
		def listSustentantesJson = null
		
		def getUrl = url + id
		
		println "URL A SOLICITAR: " + getUrl
		
		def rest = new RestBuilder()
		def resp = rest.get( getUrl )
		
		if(resp.json instanceof JSONObject && !JSONObject.NULL.equals(resp.json)){
			
			resp.json.'list'.each{ x ->
				ids.add(x.id)
			}
			
			resp.json.'sustentantes'.each{ x ->
				SustentanteTO s = null
				s = SustentanteService.obtenerSustentanteFromJSON(x)
				sustentantes.add(s)
				s.certificaciones.each { y ->
					ids.each{ z ->
						if(z.value == y.id.value){
							certificaciones.add(y)
						}
					}
				}
			}
			rs.list = certificaciones
			rs.sustentantes = sustentantes
			rs.count = resp.json.'count'
			rs.error = false
			rs.errorDetails = ""
		}
		else{
			rs.error = true
			rs.errorDetails = "NO_JSON_RESP"
		}
		
		return rs
	}
	
	CertificacionTO updateDatosParaAprobarDictamen(CertificacionTO c){
		def rest = new RestBuilder()
		def resp = rest.post(updateDatosParaAprobarDictamenUrl){
			contentType "application/json;charset=UTF-8"
			json (c as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				c = this.obtenerCertificacionFromJSON(resp.json)
			}
		
		return c
	}
	
	CertificacionTO updateDatosParaActualizarAutorizacion(CertificacionTO c, ValidacionTO v){
		def rest = new RestBuilder()
		Map<String,Object> mapToSend = new HashMap<String,Object>()
		
		mapToSend.put('certificacion',c)
		mapToSend.put('validacion',v)
		
		println (mapToSend as JSON)
		
		def resp = rest.post(updateDatosParaActualizarAutorizacionUrl){
			contentType "application/json;charset=UTF-8"
			json (mapToSend as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				c = this.obtenerCertificacionFromJSON(resp.json)
			}
		
		return c
	}
	
	CertificacionTO createReponerAutorizacion(CertificacionTO c, ValidacionTO v){
		def rest = new RestBuilder()
		Map<String,Object> mapToSend = new HashMap<String,Object>()
		
		mapToSend.put('certificacion',c)
		mapToSend.put('validacion',v)
		
		println (mapToSend as JSON)
		
		def resp = rest.post(createReponerAutorizacionUrl){
			contentType "application/json;charset=UTF-8"
			json (mapToSend as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				c = this.obtenerCertificacionFromJSON(resp.json)
			}
		
		return c
	}
	
	CertificacionTO createCambioFigura(CertificacionTO c, ValidacionTO v){
		def rest = new RestBuilder()
		Map<String,Object> mapToSend = new HashMap<String,Object>()
		
		mapToSend.put('certificacion', c)
		mapToSend.put('validacion', v)
		
		println (createCambioFiguraUrl)
		println (mapToSend as JSON)
		println (mapToSend as JSON)
		
		def resp = rest.post(createCambioFiguraUrl){
			contentType "application/json;charset=UTF-8"
			json (mapToSend as JSON)
		}
		
		if(resp.statusCode.value() != HttpStatus.CREATED.value && resp.statusCode.value() != HttpStatus.OK.value)
			throw new Exception("STATUS CODE: " + resp.statusCode)
		else
			if(resp.json != null && resp.json instanceof JSONObject) {
				c = this.obtenerCertificacionFromJSON(resp.json)
			}
		
		return c
	}
	
	public static CertificacionTO obtenerCertificacionFromJSON(JSONObject data){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd")
		
		CertificacionTO c = new CertificacionTO()
		c.id = data.'id'
		
		if(!JSONObject.NULL.equals(data.'fechaInicio')) c.fechaInicio = df.parse(data.'fechaInicio'.substring(0,10))
		if(!JSONObject.NULL.equals(data.'fechaFin')) c.fechaFin = df.parse(data.'fechaFin'.substring(0,10))
		if(!JSONObject.NULL.equals(data.'fechaObtencion')) c.fechaObtencion = df.parse(data.'fechaObtencion'.substring(0,10))
		c.isAutorizado = data.'isAutorizado'
		c.isApoderado = data.'isApoderado'
		c.isUltima = data.'isUltima'
		
		if(!JSONObject.NULL.equals(data.'fechaCreacion')) c.fechaCreacion = df.parse(data.'fechaCreacion'.substring(0,10))
		if(!JSONObject.NULL.equals(data.'fechaModificacion')) c.fechaModificacion = df.parse(data.'fechaModificacion'.substring(0,10))
		
		
		if(!JSONObject.NULL.equals(data.'fechaAutorizacionInicio')) c.fechaAutorizacionInicio = df.parse(data.'fechaAutorizacionInicio'.substring(0,10))
		if(!JSONObject.NULL.equals(data.'fechaAutorizacionFin')) c.fechaAutorizacionFin = df.parse(data.'fechaAutorizacionFin'.substring(0,10))
		
		if(!JSONObject.NULL.equals(data.'fechaEntregaRecepcion')) c.fechaEntregaRecepcion = df.parse(data.'fechaEntregaRecepcion'.substring(0,10))
		if(!JSONObject.NULL.equals(data.'fechaEnvioComision')) c.fechaEnvioComision = df.parse(data.'fechaEnvioComision'.substring(0,10))
		
		c.varianteFigura = new VarianteFiguraTO()
		c.varianteFigura.id = data.'varianteFigura'.'id'
		c.varianteFigura.nombre = data.'varianteFigura'.'nombre'
		c.varianteFigura.vigente = data.'varianteFigura'.'vigente'
		c.varianteFigura.numeroVersion = data.'varianteFigura'.'numeroVersion'
		c.varianteFigura.idFigura = data.'varianteFigura'.'idFigura'
		c.varianteFigura.nombreFigura = data.'varianteFigura'.'nombreFigura'
		c.varianteFigura.nombreAcuseFigura = data.'varianteFigura'.'nombreAcuseFigura'
		c.varianteFigura.esAutorizableFigura = data.'varianteFigura'.'esAutorizableFigura'
		c.varianteFigura.tipoAutorizacionFigura = data.'varianteFigura'.'tipoAutorizacionFigura'
		c.varianteFigura.inicialesFigura = data.'varianteFigura'.'inicialesFigura'

		c.statusAutorizacion = new StatusAutorizacionTO()
		c.statusAutorizacion.id = data.'statusAutorizacion'.'id'
		c.statusAutorizacion.descripcion = data.'statusAutorizacion'.'descripcion'
		c.statusAutorizacion.vigente = data.'statusAutorizacion'.'vigente'
		
		c.statusCertificacion = new StatusCertificacionTO()
		c.statusCertificacion.id = data.'statusCertificacion'.'id'
		c.statusCertificacion.descripcion = data.'statusCertificacion'.'descripcion'
		c.statusCertificacion.vigente = data.'statusCertificacion'.'vigente'
		
		c.idVarianteFigura = data.'idVarianteFigura'
		c.idStatusAutorizacion = data.'idStatusAutorizacion'
		c.idStatusCertificacion = data.'idStatusCertificacion'
	
		c.statusEntHistorialInforme = data.'statusEntHistorialInforme'
		if(!JSONObject.NULL.equals(data.'obsEntHistorialInforme')) c.obsEntHistorialInforme = data.'obsEntHistorialInforme'
		c.statusEntCartaRec = data.'statusEntCartaRec'
		if(!JSONObject.NULL.equals(data.'obsEntCartaRec')) c.obsEntCartaRec = data.'obsEntCartaRec'
		c.statusConstBolVal = data.'statusConstBolVal'
		if(!JSONObject.NULL.equals(data.'obsConstBolVal')) c.obsConstBolVal = data.'obsConstBolVal'
		
		c.validaciones = new ArrayList<ValidacionTO>()
		data.'validaciones'.each{ x ->
			ValidacionTO v = new ValidacionTO()
			if(!JSONObject.NULL.equals(data.'fechaAplicacion')) v.fechaAplicacion = df.parse(x.'fechaAplicacion'.substring(0,10))
			if(!JSONObject.NULL.equals(data.'fechaInicio')) v.fechaInicio = df.parse(x.'fechaInicio'.substring(0,10))
			if(!JSONObject.NULL.equals(data.'fechaFin')) v.fechaFin = df.parse(x.'fechaFin'.substring(0,10))
			v.autorizadoPorUsuario = x.'autorizadoPorUsuario'
			
			v.eventosPuntos = new ArrayList<EventoPuntosTO>()
			//aqui van el registro de los eventos que generaron puntos
			
			v.metodoValidacion = new MetodoValidacionTO()
			if(!JSONObject.NULL.equals(x.'idMetodoValidacion')) v.idMetodoValidacion = x.'idMetodoValidacion'
			if(!JSONObject.NULL.equals(x.'metodoValidacion')){
				if(!JSONObject.NULL.equals(x.'idMetodoValidacion.id')) v.idMetodoValidacion.id = x.'idMetodoValidacion.id'
				if(!JSONObject.NULL.equals(x.'idMetodoValidacion.descripcion')) v.idMetodoValidacion.descripcion = x.'idMetodoValidacion.descripcion'
				if(!JSONObject.NULL.equals(x.'idMetodoValidacion.vigente')) v.idMetodoValidacion.vigente = x.'idMetodoValidacion.vigente'
			}
			
			if(!JSONObject.NULL.equals(data.'fechaCreacion'))  v.fechaCreacion = df.parse(x.'fechaCreacion'.substring(0,10))
			if(!JSONObject.NULL.equals(data.'fechaModificacion'))  v.fechaModificacion = df.parse(x.'fechaModificacion'.substring(0,10))
			
			v.certificacion = c
			c.validaciones.add(v)
		}
		
		return c
	}
}
