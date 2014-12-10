package mx.amib.sistemas.registro.notario.service

import grails.converters.JSON
import grails.transaction.Transactional
import org.springframework.transaction.annotation.Isolation

import mx.amib.sistemas.registro.notario.model.Notario


class NotarioService {
	class SearchResult {
		def list
		def count
	}
	
	@Transactional
    Notario obtenerNotario(int idEntidadFederativa, int numeroNotario) {
		//valida si los parametros son numeros
		Notario n = Notario.findByIdEntidadFederativaAndNumeroNotarioAndVigente(idEntidadFederativa,numeroNotario,true)
		return n
    }
	
	@Transactional
	def search(Integer max, Integer offset, String sort, String order, Integer filterIdEntidadFederativa, String filterNombre, String filterApellido1, String filterApellido2, Integer filterNumero){
		List<String> hqlFilters = new ArrayList<String>();
		String whereKeyword = "where ";
		Boolean whereKeywordNeeded = false;
		StringBuilder sbHql = new StringBuilder()
		StringBuilder sbHqlCount = new StringBuilder()
		Map<String,Object> namedParameters = new HashMap<String,Object>()
		
		if(max == null || max <= 0){
			max = 10
		}
		if(offset == null || offset <= 0){
			offset = 0
		}
		if(sort == null || sort == ""){
			sort = "id"
		}
		else if(["id","idEntidadFederativa","numeroNotario","nombre","apellido1","apellido2"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		
		if(filterIdEntidadFederativa != null && filterIdEntidadFederativa != -1 && filterIdEntidadFederativa != ""){
			hqlFilters.add("n.idEntidadFederativa like :idEntidadFederativa ");
			whereKeywordNeeded = true
			namedParameters.put("idEntidadFederativa",filterIdEntidadFederativa)
		}
		else
			filterIdEntidadFederativa = -1
		if(filterNombre != null && filterNombre != ""){
			hqlFilters.add("n.nombre like :nombre ");
			whereKeywordNeeded = true
			namedParameters.put("nombre",filterNombre.concat("%"))
		}
		else
			filterNombre = ""
			
		if(filterApellido1 != null && filterApellido1 != ""){
			hqlFilters.add("n.apellido1 like :apellido1 ");
			whereKeywordNeeded = true
			namedParameters.put("apellido1",filterApellido1.concat("%"))
		}
		else
			filterApellido1 = ""
			
		if(filterApellido2 != null && filterApellido2 != ""){
			hqlFilters.add("n.apellido2 like :apellido2 ");
			whereKeywordNeeded = true
			namedParameters.put("apellido2",filterApellido2.concat("%"))
		}
		else
			filterApellido2 = ""
			
		if(filterNumero != null && filterNumero != -1 && filterNumero != ""){
			hqlFilters.add("n.numeroNotario like :numeroNotario ");
			whereKeywordNeeded = true
			namedParameters.put("numeroNotario",filterNumero)
		}
		else
			filterNumero = -1
			
		sbHql.append("from Notario as n ")
		if(whereKeywordNeeded){
			sbHql.append(whereKeyword)
			hqlFilters.each{
				if(it != hqlFilters.last())
					sbHql.append(it).append("and ")
				else
					sbHql.append(it)
			}
		}
		sbHqlCount.append("select count(n) ").append(sbHql.toString())
		sbHql.append("order by n.").append(sort).append(" ").append(order)
		
		def searchResult = new SearchResult()
		searchResult.count = Notario.executeQuery(sbHqlCount.toString(), namedParameters)[0]
		searchResult.list = Notario.findAll(sbHql.toString(),namedParameters,[max: max, offset: offset])
		return searchResult
	}
	
	@Transactional(isolation=Isolation.SERIALIZABLE)
	def save(Notario notario){
		long actualCount = this.getCurrentSequenceNotario(notario.numeroNotario, notario.idEntidadFederativa);
		notario.seqNotario = actualCount + 1
		
		notario.fechaCreacion = new Date()
		notario.fechaModificacion = new Date()
		
		notario.save (flush:true, failOnError:true)
	}
	private long getCurrentSequenceNotario(Integer numeroNotario, Integer idEntidadFederativa){
		long _count
		def result = Notario.executeQuery("select max(n.seqNotario) from Notario as n where n.numeroNotario = :numeroNotario and n.idEntidadFederativa = :idEntidadFederativa", [numeroNotario:numeroNotario, idEntidadFederativa:idEntidadFederativa])
		
		if(result == null || result[0] == null)
			_count = 0
		else
			_count = result[0]
			
		return _count
	}
	
	@Transactional
	def update(Notario notario){
		notario.fechaModificacion = new Date()
		notario.save (flush:true, failOnError:true)
	}
	
}
