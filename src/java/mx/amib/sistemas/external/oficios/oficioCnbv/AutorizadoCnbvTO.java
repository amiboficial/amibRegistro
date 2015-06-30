package mx.amib.sistemas.external.oficios.oficioCnbv;

import java.util.Date;
/**
 * Clase para objeto de transporte de AutorizadoCnbv
 * 
 * @author Gabriel
 * @version 1.0 - Primera versi�n (30/JUN/2015)
 * 
 */
public class AutorizadoCnbvTO {
	Long id;
	
	Long idCertificacion;
	Long idOficioCnbv;
	
	private Date fechaCreacion;
	private Date fechaModificacion;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getIdCertificacion() {
		return idCertificacion;
	}
	public void setIdCertificacion(Long idCertificacion) {
		this.idCertificacion = idCertificacion;
	}
	public Long getIdOficioCnbv() {
		return idOficioCnbv;
	}
	public void setIdOficioCnbv(Long idOficioCnbv) {
		this.idOficioCnbv = idOficioCnbv;
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
