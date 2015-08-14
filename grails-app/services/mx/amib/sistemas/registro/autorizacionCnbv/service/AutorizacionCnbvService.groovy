package mx.amib.sistemas.registro.autorizacionCnbv.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.oficios.oficioCnbv.AutorizadoCnbvTO
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO

@Transactional
class AutorizacionCnbvService {

	def oficioCnbvService
	def autorizacionService
	
    OficioCnbvTO altaOficioCnbv(OficioCnbvTO oficioCnbv){
		autorizacionService.autorizar(oficioCnbv.autorizados.collect{ it.idCertificacion })
		return oficioCnbvService.save(oficioCnbv)
	}
	OficioCnbvTO editarDatosOficioCnbv(OficioCnbvTO oficioCnbv){
		OficioCnbvTO modobj = oficioCnbvService.get(oficioCnbv.id)
		
		modobj.claveDga = oficioCnbv.claveDga
		modobj.numeroOficio = oficioCnbv.numeroOficio
		modobj.fechaOficio = oficioCnbv.fechaOficio
		modobj.uuidDocumentoRespaldo = oficioCnbv.uuidDocumentoRespaldo
		
		return oficioCnbvService.update(modobj)
	}
	OficioCnbvTO quitarAutorizadosCnbv(Long idOficioCnbv, List<Long> multipleIdAutorizado){
		OficioCnbvTO modobj = oficioCnbvService.get(idOficioCnbv)
		List<AutorizadoCnbvTO> toDelete = new ArrayList<AutorizadoCnbvTO>()
		modobj.autorizados.each {
			if( multipleIdAutorizado.contains(it.id) )
				toDelete.add(it)
		}
		toDelete.each{
			modobj.autorizados.remove(it)
		}
		
		//deshace status
		autorizacionService.deshacerAutorizacionSinPoderes( modobj.autorizados.collect{ it.idCertificacion } )
		//elimina en el oficio
		return oficioCnbvService.update(modobj)
	}
	OficioCnbvTO agregarAutorizadosCnbv(Long idOficioCnbv, List<AutorizadoCnbvTO> autorizados){
		OficioCnbvTO modobj = oficioCnbvService.get(idOficioCnbv)
		modobj.autorizados.addAll(autorizados)
		
		//guarda el oficio
		def newAut = autorizacionService.update(modobj)
		//ya teniendo ids, aplica el status si es posible
		autorizacionService.autorizar(autorizados.collect{ it.idCertificacion })
		
		return newAut
	}
	
}
