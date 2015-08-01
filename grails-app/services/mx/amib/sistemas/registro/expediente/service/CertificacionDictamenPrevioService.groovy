package mx.amib.sistemas.registro.expediente.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

// TODO: Implementar logging en este servicio dado que en estos métodos se hace
// llamada a múltiples servicios, si alguno falla, se rastrea inmediatamente el
// error. (cuestiones de integridad en "transacciones distribuidas")
@Transactional
class CertificacionDictamenPrevioService {

	def sustentanteService
	def certificacionService
	def autorizacionService
	
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
	
	void enviarAAutorizacion(SustentanteTO sustentante, CertificacionTO certificacion){
		sustentanteService.updateDatosPersonales(sustentante)
		sustentanteService.updatePuestos(sustentante)
		certificacionService.updateDatosParaAprobarDictamen(certificacion)
		autorizacionService.aprobarDictamen( [certificacion.id] )
	}
	
}
