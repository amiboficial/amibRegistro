package mx.amib.sistemas.external.oficios.oficioCnbv;

import java.util.Date;
import java.util.List;


public class OficioCnbvTO {
	
	private Long id;
	private Long version;
	
	private String claveDga;
	private Integer numeroOficio;
	private Date fechaOficio;
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
	public Long getVersion() {
		return version;
	}
	public void setVersion(Long version) {
		this.version = version;
	}
	
	public String getClaveDga() {
		return claveDga;
	}
	public void setClaveDga(String claveDga) {
		this.claveDga = claveDga;
	}
	public Integer getNumeroOficio() {
		return numeroOficio;
	}
	public void setNumeroOficio(Integer numeroOficio) {
		this.numeroOficio = numeroOficio;
	}
	public Date getFechaOficio() {
		return fechaOficio;
	}
	public void setFechaOficio(Date fechaOficio) {
		this.fechaOficio = fechaOficio;
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
