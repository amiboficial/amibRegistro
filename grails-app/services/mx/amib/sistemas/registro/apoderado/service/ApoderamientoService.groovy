package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional

import mx.amib.sistemas.external.oficios.oficioCnbv.OficioCnbvTO
import mx.amib.sistemas.external.oficios.poder.PoderTO
import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO

@Transactional
class ApoderamientoService {

	def autorizacionService
	def poderService
	
    def altaPoder(PoderTO poder) {
		def listIdCerts = poder.apoderados.collect{ it.idCertificacion }
		autorizacionService.apoderar(listIdCerts)
		poderService.save(poder)
    }
	def editarDatosPoder(PoderTO poder) {
		def modobj = poderService.get(poder.id)
		//Edita solo los datos relevantes
		modobj.idGrupoFinanciero = poder.idGrupoFinanciero
		modobj.idInstitucion = poder.idInstitucion
		modobj.idNotario = poder.idNotario
		modobj.numeroEscritura = poder.numeroEscritura
		modobj.representanteLegalNombre = poder.representanteLegalNombre
		modobj.representanteLegalApellido1 = poder.representanteLegalApellido1
		modobj.representanteLegalApellido2 = poder.representanteLegalApellido2
		modobj.fechaApoderamiento = poder.fechaApoderamiento
		modobj.uuidDocumentoRespaldo = poder.uuidDocumentoRespaldo
		
		poderService.update(modobj)
	}
	def quitarApoderados(Long idPoder, List<Long> multipleIdApoderado){
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
		poderService.update(modobj)
	}
	def agregarApoderados(Long idPoder, List<ApoderadoTO> apoderados){
		def modobj = poderService.get(idPoder)
		modobj.apoderados.addAll(apoderados)
		
		autorizacionService.apoderar( modobj.apoderados.collect{ it.idCertificacion } )
		poderService.update(modobj)
	}
	
	/*
	def altaRevocacion(RevocacionTO revocacion){
		
	}
	def editarDatosRevocacion(RevocacionTO revocacion){
		
	}
	def quitarRevocados(List<Long> multipleIdRevocado){
	
	}
	def agregarRevocados(List<RevocadoTO> revocados){
		
	}
	
	def altaOficioCnbv(OficioCnbvTO oficioCnbv){
		
	}
	def editarDatosOficioCnbv(OficioCnbvTO oficioCnbv){
		
	}
	def quitarAutorizadosCnbv(List<Long> multipleIdAutorizado){
		
	}
	def agregarAutorizadosCnbv(List<OficioCnbvTO> revocados){
		
	}
	*/
}
