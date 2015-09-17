package mx.amib.sistemas.external.membership;

public class RoleTO {
	
	private long idApplication;
	private long numberRole;
	
	private String name;
	private String description;
	private boolean active;
	
	public long getIdApplication() {
		return idApplication;
	}
	public void setIdApplication(long idApplication) {
		this.idApplication = idApplication;
	}
	public long getNumberRole() {
		return numberRole;
	}
	public void setNumberRole(long numberRole) {
		this.numberRole = numberRole;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ (int) (idApplication ^ (idApplication >>> 32));
		result = prime * result + (int) (numberRole ^ (numberRole >>> 32));
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RoleTO other = (RoleTO) obj;
		if (idApplication != other.idApplication)
			return false;
		if (numberRole != other.numberRole)
			return false;
		return true;
	}
	
}
