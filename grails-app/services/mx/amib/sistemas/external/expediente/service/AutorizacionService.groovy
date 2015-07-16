package mx.amib.sistemas.external.expediente.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

/**
 * Este servicio nos permite gestionar la autorizacion de una o varias certificaciones,
 * haciendo uso de llamados a servicios REST a amibExpediente.
 *
 * @author Gabriel
 * @version 1.0 - 01/07/2015
 */
@Transactional
class AutorizacionService {

	String aprobarDictamenUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/aprobarDictamen"
	String autorizarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/autorizar"
	String deshacerAutorizacionSinPoderesUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/deshacerAutorizacionSinPoderes"
	String apoderarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/apoderar"
	String deshacerApoderarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/deshacerApoderar"
	String suspenderUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/suspender"
	String revocarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/revocar"
	String deshacerRevocarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/deshacerRevocar"
	String expirarUrl = "http://bimalatrop.no-ip.biz:8080/amibExpediente-0.1/autorizacionRestful/expirar"
	
	def aprobarDictamen(List<Long> idCertificacionList) {
		return this.sendIdJSONArray(aprobarDictamenUrl, idCertificacionList)
	}
	
	def autorizar(List<Long> idCertificacionList) {
		return this.sendIdJSONArray(autorizarUrl, idCertificacionList)
	}
	
	def deshacerAutorizacionSinPoderes(List<Long> idCertificacionList){
		return this.sendIdJSONArray(deshacerAutorizacionSinPoderesUrl, idCertificacionList)
	}
	
	def apoderar(List<Long> idCertificacionList) {
		return this.sendIdJSONArray(apoderarUrl, idCertificacionList)
	}
	
	def deshacerApoderar(List<Long> idCertificacionList){
		return this.sendIdJSONArray(deshacerApoderarUrl, idCertificacionList)
	}
	
	def suspender(List<Long> idCertificacionList){
		return this.sendIdJSONArray(suspenderUrl, idCertificacionList)
	}
	
	def revocar(List<Long> idCertificacionList){
		return this.sendIdJSONArray(revocarUrl, idCertificacionList)
	}
	
	def deshacerRevocar(List<Long> idCertificacionList){
		return this.sendIdJSONArray(deshacerRevocarUrl, idCertificacionList)
	}
	
	def expirar(List<Long> idCertificacionList){
		return this.sendIdJSONArray(expirarUrl, idCertificacionList)
	}
	
	private List<Long> sendIdJSONArray(String methodUrl, List<Long> idCertificacionList){
		List<Long> result = new ArrayList<Long>()
		def rest = new RestBuilder()
		def resp = rest.post(methodUrl){
			json {
				idCertificacionList
			}
		}
		if(resp.json){
			result = new ArrayList<Integer>( resp.json )
		}
		return result
	}
	
}
