package mx.amib.sistemas.external.membership;

public class PathTO {
	
	private long idApplication;
	private long numberPath;
	
	private String path;
	private String pathLowercase;
	
	
	public long getIdApplication() {
		return idApplication;
	}
	public void setIdApplication(long idApplication) {
		this.idApplication = idApplication;
	}
	public long getNumberPath() {
		return numberPath;
	}
	public void setNumberPath(long numberPath) {
		this.numberPath = numberPath;
	}
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getPathLowercase() {
		return pathLowercase;
	}
	public void setPathLowercase(String pathLowercase) {
		this.pathLowercase = pathLowercase;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ (int) (idApplication ^ (idApplication >>> 32));
		result = prime * result + (int) (numberPath ^ (numberPath >>> 32));
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
		PathTO other = (PathTO) obj;
		if (idApplication != other.idApplication)
			return false;
		if (numberPath != other.numberPath)
			return false;
		return true;
	}
}
