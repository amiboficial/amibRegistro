package mx.amib.sistemas.utils;

import java.util.List;

public class SearchResult<T> {
	private List<T> list;
	Long count;
	Boolean error;
	
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public Boolean getError() {
		return error;
	}
	public void setError(Boolean error) {
		this.error = error;
	}
	
}
