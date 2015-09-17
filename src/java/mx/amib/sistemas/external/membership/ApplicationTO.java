package mx.amib.sistemas.external.membership;

public class ApplicationTO {
	private long id;
	private String uuid;
	
	private String name;
	private String nameLowercase;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameLowercase() {
		return nameLowercase;
	}
	public void setNameLowercase(String nameLowercase) {
		this.nameLowercase = nameLowercase;
	}
	
	
}
