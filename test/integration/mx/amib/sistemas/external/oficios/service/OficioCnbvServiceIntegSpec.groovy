package mx.amib.sistemas.external.oficios.service



import grails.converters.JSON
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO;
import mx.amib.sistemas.utils.SearchResult;
import spock.lang.*

/**
 *
 */
class OficioCnbvServiceIntegSpec extends Specification {

	def oficioCnbvService
	
    def setup() {
    }

    def cleanup() {
    }
/*
    void "probando llamada a \"list\""() {
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			SearchResult<OficioCnbvTO> sr = null
		when:
			sr = oficioCnbvService.list(max,offset,sort,order)
			
			println ("Resultado de llamada a servicio -> ")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
    }*/
	
	/*void "probando llamada a findAllByMultipleIdCertificacionInAutorizados"(){
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			SearchResult<OficioCnbvTO> sr = null
		when:
			sr = oficioCnbvService.findAllByMultipleIdCertificacionInAutorizados(max,offset,sort,order, [12] )
			
			println ("Resultado de llamada a servicio -> ")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
	}*/
	/*
	void "probando llamada a findAllByNumeroOficio"(){
		given:
			SearchResult<OficioCnbvTO> sr = null
			Integer numeroOficio = 2
		when:
			sr = oficioCnbvService.findAllByNumeroOficio(numeroOficio)
			
			println ("*** Resultado de llamada a servicio -> findAllByNumeroOficio ->")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
	}
	
	void "probando llamada a findAllByClaveDga"(){
		given:
			SearchResult<OficioCnbvTO> sr = null
			String claveDga = "DGA-66334455"
		when:
			sr = oficioCnbvService.findAllByClaveDga(claveDga)
			
			println ("*** Resultado de llamada a servicio -> findAllByClaveDga ->")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
	}
	
	void "probando llamada a findAllByFechaOficio"(){
		given:
			Integer max = 10
			Integer offset = 0
			String sort = "id"
			String order = "asc"
			SearchResult<OficioCnbvTO> sr = null
			
			Calendar cFechaDel = Calendar.getInstance()
			Calendar cFechaAl = Calendar.getInstance()
			
			cFechaDel.setTimeInMillis(1313470800000L)
			cFechaAl.setTimeInMillis(1471323600000L)
			
		when:
			sr = oficioCnbvService.findAllByFechaOficio(max,offset,sort,order,cFechaDel.getTime(),cFechaAl.getTime())
			
			println ("*** Resultado de llamada a servicio -> findAllByFechaOficio ->")
			println (sr as JSON)
			
		then:
			sr.list.size() > 0
	}*/
	
	void "probando llamada a checkUniqueClaveDga"(){
		given:
			String claveDga1 = 'DGA-906090'
			String claveDga2 = 'DGA-334455'
			boolean result1
			boolean result2
		when:
			result1 = oficioCnbvService.checkUniqueClaveDga(claveDga1)
			result2 = oficioCnbvService.checkUniqueClaveDga(claveDga2)
		then:
			(result1 == true && result2 == false) 
	}
	
	void "probando llamada a checkUniqueNumeroOficio"(){
		given:
			int numeroOficio1 = 666
			int numeroOficio2 = 1
			boolean result1
			boolean result2
		when:
			result1 = oficioCnbvService.checkUniqueNumeroOficio(numeroOficio1)
			result2 = oficioCnbvService.checkUniqueNumeroOficio(numeroOficio2)
		then:
			(result1 == true && result2 == false) 
	}
}
