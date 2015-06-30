package mx.amib.sistemas.external.oficios.poder;

import java.util.Date;
import java.util.List;

/**
 * Clase para objeto de transporte de PoderTO
 * 
 * @author Gabriel
 * @version 1.0 - Primera versi�n (30/JUN/2015)
 * 
 */
public class PoderTO {

	private Long id;
	private Long version;
	
	private Long idGrupoFinanciero;
	private Long idInstitucion;
	private Long idNotario;
	private Integer numeroEscritura;
	private String representanteLegalNombre;
	private String representanteLegalApellido1;
	private String representanteLegalApellido2;
	private Date fechaApoderamiento;
	private String uuidDocumentoRespaldo;
	
	private List<ApoderadoTO> apoderados;
	
	//"yyyy-MM-dd'T'HH:mm:ssZ"
	private Date fechaCreacion;
	private Date fechaModificacion;
	
	public PoderTO(){}
	
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
	public Long getIdGrupoFinanciero() {
		return idGrupoFinanciero;
	}
	public void setIdGrupoFinanciero(Long idGrupoFinanciero) {
		this.idGrupoFinanciero = idGrupoFinanciero;
	}
	public Long getIdInstitucion() {
		return idInstitucion;
	}
	public void setIdInstitucion(Long idInstitucion) {
		this.idInstitucion = idInstitucion;
	}
	public Long getIdNotario() {
		return idNotario;
	}
	public void setIdNotario(Long idNotario) {
		this.idNotario = idNotario;
	}
	public Integer getNumeroEscritura() {
		return numeroEscritura;
	}
	public void setNumeroEscritura(Integer numeroEscritura) {
		this.numeroEscritura = numeroEscritura;
	}
	public String getRepresentanteLegalNombre() {
		return representanteLegalNombre;
	}
	public void setRepresentanteLegalNombre(String representanteLegalNombre) {
		this.representanteLegalNombre = representanteLegalNombre;
	}
	public String getRepresentanteLegalApellido1() {
		return representanteLegalApellido1;
	}
	public void setRepresentanteLegalApellido1(String representanteLegalApellido1) {
		this.representanteLegalApellido1 = representanteLegalApellido1;
	}
	public String getRepresentanteLegalApellido2() {
		return representanteLegalApellido2;
	}
	public void setRepresentanteLegalApellido2(String representanteLegalApellido2) {
		this.representanteLegalApellido2 = representanteLegalApellido2;
	}
	public Date getFechaApoderamiento() {
		return fechaApoderamiento;
	}
	public void setFechaApoderamiento(Date fechaApoderamiento) {
		this.fechaApoderamiento = fechaApoderamiento;
	}
	public String getUuidDocumentoRespaldo() {
		return uuidDocumentoRespaldo;
	}
	public void setUuidDocumentoRespaldo(String uuidDocumentoRespaldo) {
		this.uuidDocumentoRespaldo = uuidDocumentoRespaldo;
	}
	public List<ApoderadoTO> getApoderados() {
		return apoderados;
	}
	public void setApoderados(List<ApoderadoTO> apoderados) {
		this.apoderados = apoderados;
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
