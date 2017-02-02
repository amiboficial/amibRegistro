package mx.amib.sistemas.registro.expediente.service

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import grails.transaction.Transactional

@Transactional
class CertificacionCambioFiguraService {

	def sustentanteService
	def certificacionService
	def autorizacionService
	
    def obtenerParaCambioFigura(long id) {
		CertificacionTO c = certificacionService.get(id)
		boolean estaAutorizadoConPoderes
		boolean estaCertificado
		
		//revisa que este en estatus de autorizado y certificado
		estaAutorizadoConPoderes = (c.statusAutorizacion.id.value == StatusAutorizacionTypes.AUTORIZADO ||
			c.statusAutorizacion.id.value == StatusAutorizacionTypes.VENCIDA )
		estaCertificado = (c.statusCertificacion.id.value == StatusCertificacionTypes.CERTIFICADO)
		
		if(!(estaAutorizadoConPoderes && estaCertificado))
			c = null
		
		return c
    }
	
	void hacerCambioFigura(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		sustentanteService.updateDatosPersonales(sustentante)
		sustentanteService.updatePuestos(sustentante)
		certificacionService.createCambioFigura(certificacion, validacion)
	}
	
}
