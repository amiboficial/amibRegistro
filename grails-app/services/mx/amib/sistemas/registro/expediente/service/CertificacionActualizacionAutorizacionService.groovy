package mx.amib.sistemas.registro.expediente.service

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import grails.transaction.Transactional
// TODO: Implementar logging en este servicio dado que en estos métodos se hace
// llamada a múltiples servicios, si alguno falla, se rastrea inmediatamente el
// error. (cuestiones de integridad)
@Transactional
class CertificacionActualizacionAutorizacionService {

	def sustentanteService
	def certificacionService
	def autorizacionService
	
    def obtenerParaActualizacion(long id) {
		CertificacionTO c = certificacionService.get(id)
		boolean estaAutorizadoConPoderes
		boolean estaCertificado
		
		//revisa que este en estatus de dictaminable
		estaAutorizadoConPoderes = (c.statusAutorizacion.id.value == StatusAutorizacionTypes.AUTORIZADO)
		estaCertificado = (c.statusCertificacion.id.value == StatusCertificacionTypes.CERTIFICADO)
		
		if(!(estaAutorizadoConPoderes && estaCertificado))
			c = null
		
		return c
    }
	
	void actualizarCertificacion(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		sustentanteService.updateDatosPersonales(sustentante)
		sustentanteService.updatePuestos(sustentante)
		certificacionService.updateDatosParaActualizarAutorizacion(certificacion, validacion)
		//no se requiere actualizar ningún estatus dado que la certificación seguirá autorizadas
	}
	
}
