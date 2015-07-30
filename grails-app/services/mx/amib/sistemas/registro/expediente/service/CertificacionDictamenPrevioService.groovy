package mx.amib.sistemas.registro.expediente.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes

@Transactional
class CertificacionDictamenPrevioService {

	def certificacionService
	
    def obtenerParaEmisionDictamen(Long id) {
		CertificacionTO c = certificacionService.get(id)
		boolean enDictamenPrevio
		boolean estaCertificado
		
		//revisa que este en estatus de dictaminable
		enDictamenPrevio = (c.statusAutorizacion.id.value == StatusAutorizacionTypes.DICTAMEN_PREVIO)
		estaCertificado = (c.statusCertificacion.id.value == StatusCertificacionTypes.CERTIFICADO)
		
		if(!(enDictamenPrevio && estaCertificado))
			c = null
		
		return c
    }
	
}
