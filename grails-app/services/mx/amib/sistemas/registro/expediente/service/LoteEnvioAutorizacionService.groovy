package mx.amib.sistemas.registro.expediente.service

import java.util.List;
import java.util.Map;

import org.springframework.aop.aspectj.RuntimeTestWalker.ThisInstanceOfResidueTestVisitor;

import grails.transaction.Transactional

@Transactional
class LoteEnvioAutorizacionService {

	static scope = "singleton"
	
	//private static final int MAX = 254 
	private Map<String, Set<Long>> _lotes = new HashMap<String, Set<Long>>()
	
	private Set<Long> getSessionSet(String sessionId){
		Set<Long> mySet = null
		if(!_lotes.containsKey(sessionId)){
			mySet = new TreeSet<Long>()
			_lotes.put(sessionId, mySet)
		}
		else{
			mySet = _lotes.get(sessionId)
		}
		return mySet
	}
	
	void add(String sessionId, long idCert){
		Set<Long> mySet = this.getSessionSet(sessionId)
		Long wIdCert = idCert
				
		mySet.add(wIdCert)
	}
	
	void addAll(String sessionId, Collection<Long> idsCert){
		Set<Long> mySet = this.getSessionSet(sessionId)
		
		mySet.addAll(idsCert)
	}
	
	void remove(String sessionId, long idCert){
		Set<Long> mySet = this.getSessionSet(sessionId)
		Long wIdCert = idCert
		
		mySet.remove(wIdCert)
	}
	
	void removeAll(String sessionId, Collection<Long> idsCert){
		Set<Long> mySet = this.getSessionSet(sessionId)
		
		mySet.removeAll(idsCert)
	}
	
	void clear(String sessionId){
		Set<Long> mySet = this.getSessionSet(sessionId)
		mySet.clear()
	}
	
	Set<Long> getSet(String sessionId){
		Set<Long> mySet = new TreeSet<Long>(this.getSessionSet(sessionId))
		return mySet
	}
	
}
