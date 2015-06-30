package mx.amib.sistemas.external.oficios.poder;

import java.util.Date;

/**
 * Clase para objeto de transporte de ApoderadoTO
 * 
 * @author Gabriel
 * @version 1.0 - Primera versi�n (30/JUN/2015)
 * 
 */
public class ApoderadoTO {

	Long id;
	
	Long idCertificacion;
	Long idPoder;

	Date fechaCreacion;
	Date fechaModificacion;
	
	public ApoderadoTO(){}
	
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
	public Long getIdPoder() {
		return idPoder;
	}
	public void setIdPoder(Long idPoder) {
		this.idPoder = idPoder;
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
