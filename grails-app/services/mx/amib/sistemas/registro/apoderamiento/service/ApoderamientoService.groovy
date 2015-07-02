package mx.amib.sistemas.registro.apoderamiento.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.registro.apoderado.service.ApoderadoTO;
import mx.amib.sistemas.registro.apoderado.service.RevocadoTO;

@Transactional
class ApoderamientoService {

	def autorizacionService
	def poderService
	def revocacionService
	def revocadoService
	
    PoderTO altaPoder(PoderTO poder) {
		def listIdCerts = poder.apoderados.collect{ it.idCertificacion }
		autorizacionService.apoderar(listIdCerts)
		return poderService.save(poder)
    }
	PoderTO editarDatosPoder(PoderTO poder) {
		def modobj = poderService.get(poder.id)
		//Edita solo los datos de poder y no sus apoderados
		modobj.idGrupoFinanciero = poder.idGrupoFinanciero
		modobj.idInstitucion = poder.idInstitucion
		modobj.idNotario = poder.idNotario
		modobj.numeroEscritura = poder.numeroEscritura
		modobj.representanteLegalNombre = poder.representanteLegalNombre
		modobj.representanteLegalApellido1 = poder.representanteLegalApellido1
		modobj.representanteLegalApellido2 = poder.representanteLegalApellido2
		modobj.fechaApoderamiento = poder.fechaApoderamiento
		modobj.uuidDocumentoRespaldo = poder.uuidDocumentoRespaldo
		
		return poderService.update(modobj)
	}
	PoderTO quitarApoderados(Long idPoder, List<Long> multipleIdApoderado){
		def modobj = poderService.get(idPoder)
		List<ApoderadoTO> toDelete = new ArrayList<ApoderadoTO>()
		modobj.apoderados.each{
			if( multipleIdApoderado.contains(it.id) )
				toDelete.add(it)
		}
		toDelete.each {
			modobj.apoderados.remove(it)
		}
		
		autorizacionService.deshacerApoderar( modobj.apoderados.collect{ it.idCertificacion }  )
		return poderService.update(modobj)
	}
	PoderTO agregarApoderados(Long idPoder, List<ApoderadoTO> apoderados){
		def modobj = poderService.get(idPoder)
		modobj.apoderados.addAll(apoderados)
		
		autorizacionService.apoderar( modobj.apoderados.collect{ it.idCertificacion } )
		return poderService.update(modobj)
	}
	
	
	RevocacionTO altaRevocacion(RevocacionTO revocacion){
		//guarda el oficio
		RevocacionTO r = revocacionService.save(revocacion)
		//aplica el status
		def listIdCerts = revocadoService.getIdsCertificacion(r.revocados.collect{it.id})
		autorizacionService.revocar(listIdCerts)
		return r
	}
	RevocacionTO editarDatosRevocacion(RevocacionTO revocacion){
		def modobj = revocacionService.get(revocacion.id)
		
		//Edita solo los datos de poder y no sus revocados
		modobj.idGrupoFinanciero = revocacion.idGrupoFinanciero
		modobj.idInstitucion = revocacion.idInstitucion
		modobj.idNotario = revocacion.idNotario
		modobj.numeroEscritura = revocacion.numeroEscritura
		modobj.representanteLegalNombre = revocacion.representanteLegalNombre
		modobj.representanteLegalApellido1 = revocacion.representanteLegalApellido1
		modobj.representanteLegalApellido2 = revocacion.representanteLegalApellido2
		modobj.fechaRevocacion = revocacion.fechaRevocacion
		modobj.uuidDocumentoRespaldo = revocacion.uuidDocumentoRespaldo
		//guarda el oficio
		return revocacionService.update(revocacion)
	}
	RevocacionTO quitarRevocados(Long idRevocacion, List<Long> multipleIdRevocado){
		def modobj = revocacionService.get(idRevocacion)
		List<RevocadoTO> toDelete = new ArrayList<RevocadoTO>()
		modobj.revocados.each{
			if( multipleIdRevocado.contains(it.id) )
				toDelete.add(it)
		}
		toDelete.each {
			modobj.revocados.remove(it)
		}
		//deshace el status si es posible, antes de que los ids se eliminen
		def listIdCerts = revocadoService.getIdsCertificacion(multipleIdRevocado)
		autorizacionService.deshacerRevocar(listIdCerts)
		//guarda el oficio
		return revocacionService.update(modobj)
	}
	RevocacionTO agregarRevocados(Long idRevocacion, List<RevocadoTO> revocados){
		def modobj = revocacionService.get(idRevocacion)
		modobj.revocados.addAll(revocados)
		
		//guarda el oficio
		def newRevocacion = revocacionService.update(modobj)
		//ya teniendo ids, aplica el status si es posible
		def listIdCerts = revocadoService.getIdsCertificacion(newRevocacion.revocados.collect{it.id})
		autorizacionService.revocar(listIdCerts)
		
		return newRevocacion
	}
}
