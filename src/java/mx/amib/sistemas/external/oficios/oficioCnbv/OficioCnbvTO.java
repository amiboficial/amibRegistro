package mx.amib.sistemas.external.oficios.oficioCnbv;

import java.util.Date;
import java.util.List;

/**
 * Clase para objeto de transporte de OficioCnbvTO
 * 
 * @author Gabriel
 * @version 1.0 - Primera versi�n (30/JUN/2015)
 * 
 */
public class OficioCnbvTO {
	
	private Long id;
	
	private String claveDga;
	private Date fechaInicioVigencia;
	private String uuidDocumentoRespaldo;
	
	private List<AutorizadoCnbvTO> autorizados;
	
	private Date fechaCreacion;
	private Date fechaModificacion;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getClaveDga() {
		return claveDga;
	}
	public void setClaveDga(String claveDga) {
		this.claveDga = claveDga;
	}
	public Date getFechaInicioVigencia() {
		return fechaInicioVigencia;
	}
	public void setFechaInicioVigencia(Date fechaInicioVigencia) {
		this.fechaInicioVigencia = fechaInicioVigencia;
	}
	public String getUuidDocumentoRespaldo() {
		return uuidDocumentoRespaldo;
	}
	public void setUuidDocumentoRespaldo(String uuidDocumentoRespaldo) {
		this.uuidDocumentoRespaldo = uuidDocumentoRespaldo;
	}
	public List<AutorizadoCnbvTO> getAutorizados() {
		return autorizados;
	}
	public void setAutorizados(List<AutorizadoCnbvTO> autorizados) {
		this.autorizados = autorizados;
	}
	public Date getFechaCreacion() {
		return fechaCreacion;
	}
	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}
	public Date getFechaModificacion() {
		return fechaModificacion;
	}
	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}
	
}
