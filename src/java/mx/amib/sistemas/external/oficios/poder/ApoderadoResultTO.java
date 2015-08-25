package mx.amib.sistemas.external.oficios.poder;

import java.util.List;

public class ApoderadoResultTO {
	private List<ApoderadoTO> apoderados;
	public List<ApoderadoTO> getApoderados() {
		return apoderados;
	}
	public void setApoderados(List<ApoderadoTO> apoderados) {
		this.apoderados = apoderados;
	}
	public List<PoderTO> getPoderes() {
		return poderes;
	}
	public void setPoderes(List<PoderTO> poderes) {
		this.poderes = poderes;
	}
	private List<PoderTO> poderes;
}
