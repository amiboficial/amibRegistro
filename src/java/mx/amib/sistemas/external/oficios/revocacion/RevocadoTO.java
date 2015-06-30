package mx.amib.sistemas.external.oficios.revocacion;

import java.util.Date;

/**
 * Clase para objeto de transporte de RevocadoTO
 * 
 * @author Gabriel
 * @version 1.0 - Primera versi�n (30/JUN/2015)
 * 
 */
public class RevocadoTO {
	private Long id;
	
	private Long idRevocacion;
	private Long idApoderado;
	
	private String motivo;
	private Date fechaBaja;
	
	private Date fechaCreacion;
	private Date fechaModificacion;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getIdRevocacion() {
		return idRevocacion;
	}
	public void setIdRevocacion(Long idRevocacion) {
		this.idRevocacion = idRevocacion;
	}
	public Long getIdApoderado() {
		return idApoderado;
	}
	public void setIdApoderado(Long idApoderado) {
		this.idApoderado = idApoderado;
	}
	public String getMotivo() {
		return motivo;
	}
	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}
	public Date getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(Date fechaBaja) {
		this.fechaBaja = fechaBaja;
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
