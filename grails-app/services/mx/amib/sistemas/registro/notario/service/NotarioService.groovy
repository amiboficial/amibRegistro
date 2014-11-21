package mx.amib.sistemas.registro.notario.service

import grails.transaction.Transactional

import mx.amib.sistemas.registro.notario.model.Notario

@Transactional
class NotarioService {

    Notario obtenerNotario(int idEntidadFederativa, int numeroNotario) {
		//valida si los parametros son numeros
		Notario n = Notario.findByIdEntidadFederativaAndNumeroNotarioAndVigente(idEntidadFederativa,numeroNotario,true)
		return n
    }
	
	def search(Integer max, Integer offset, String sort, String order, String filterIdEntidadFederativa, String filterNombre, String filterApellido1, String filterApellido2, String filterNumero){
		List<String> hqlFilters = new ArrayList<String>();
		String whereKeyword = "where ";
		Boolean whereKeywordNeeded = false;
		StringBuilder sbHql = new StringBuilder()
		Map<String,String> namedParameters = new HashMap<String,String>()
		
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
			
		if(filterNumero != null && filterNumero != ""){
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
					sbHql.append(it).append("or ")
				else
					sbHql.append(it)
			}
		}
		sbHql.append("order by n.").append(sort).append(" ").append(order)
		
		def results = Notario.findAll(sbHql.toString(),namedParameters,[max: max, offset: offset])
		return results
	}
	
}
