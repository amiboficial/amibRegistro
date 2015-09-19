package mx.amib.sistemas.registro.expediente.service

import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

@Transactional
class CertificacionReposicionAutorizacionService {

	def sustentanteService
	def certificacionService
	def autorizacionService
	
    def obtenerParaReposicion(long id) {
		CertificacionTO c = certificacionService.get(id)
		boolean estaVencida
		//boolean estaCertificado
		
		//revisa que este en estatus este en vencida
		estaVencida = (c.statusAutorizacion.id.value == StatusAutorizacionTypes.VENCIDA)
		//estaCertificado = (c.statusCertificacion.id.value == StatusCertificacionTypes.CERTIFICADO)
		
		return c
    }
	
	void reponerAutorizacion(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		sustentanteService.updateDatosPersonales(sustentante)
		sustentanteService.updatePuestos(sustentante)
		certificacionService.createReponerAutorizacion(certificacion, validacion)
		//no se actualiza ningun estatus de autorización dado que se crea una nueva instancia de certificación
	}
}
