package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional
import mx.amib.sistemas.registro.apoderamiento.model.view.PoderVigente

@Transactional
class PoderVigenteService {
	class SearchResult {
		def list
		def count
		boolean error
		String errorDetails
	}
	
    def searchByMatricula(Integer max, Integer offset, String sort, String order, Integer numeroMatricula) {
		SearchResult sr = new SearchResult()
		
		if(max == null || max <= 0){
			max = 10
		}
		if(offset == null || offset <= 0){
			offset = 0
		}
		if(sort == null || sort == ""){
			sort = "id"
		}
		else if(["id","numeroMatricula","nombreCompleto","idGrupofinanciero","idInstitucion","numeroEscritura"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		
		//try{
			sr.count = PoderVigente.executeQuery("select count(pv) from PoderVigente as pv where pv.numeroMatricula = :numeroMatricula", [numeroMatricula:numeroMatricula] )
			sr.list = PoderVigente.findAllByNumeroMatricula(numeroMatricula, [max:max, offset:offset, sort:sort, order:order] )
		//}
		//catch(Exception e){
		//	sr.error = true
		//	sr.errorDetails = e.message
		//}
		
		return sr
    }
	
	def searchByPalabraNombreApellido(Integer max, Integer offset, String sort, String order, String nombreKeyword) {
		SearchResult sr = new SearchResult()
		
		if(max == null || max <= 0){
			max = 10
		}
		if(offset == null || offset <= 0){
			offset = 0
		}
		if(sort == null || sort == ""){
			sort = "id"
		}
		else if(["id","numeroMatricula","nombreCompleto","idGrupofinanciero","idInstitucion","numeroEscritura"].find{ sort == it } == null){
			sort = "id"
		}
		if(order == null || order == ""){
			order = "asc"
		}
		else if(order != "desc" && order != "asc"){
			order = "asc"
		}
		//try{
			sr.count = PoderVigente.executeQuery("select count(pv) from PoderVigente as pv where pv.nombreCompleto like %:nombreKeyword%", [nombreKeyword:nombreKeyword] )
			sr.list = PoderVigente.findAllByNombreCompletoIlike("%"+nombreKeyword+"%", [max:max, offset:offset, sort:sort, order:order] )
		//}
		//catch(Exception e){
		//	sr.error = true
		//	sr.errorDetails = e.message
		//}
		
		return sr
	}
}
