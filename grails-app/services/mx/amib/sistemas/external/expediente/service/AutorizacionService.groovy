package mx.amib.sistemas.external.expediente.service


import grails.converters.JSON
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

//	String aprobarDictamenUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/aprobarDictamen"
//	String autorizarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/autorizar"
//	String autorizarAltaOficio = "http://localhost:8084/amibExpediente/autorizacionRestful/autorizarAltaOficio"
//	String deshacerAutorizacionSinPoderesUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/deshacerAutorizacionSinPoderes"
//	String apoderarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/apoderar"
//	String deshacerApoderarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/deshacerApoderar"
//	String suspenderUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/suspender"
//	String revocarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/revocar"
//	String deshacerRevocarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/deshacerRevocar"
//	String expirarUrl = "http://localhost:8084/amibExpediente/autorizacionRestful/expirar"
	
	String aprobarDictamenUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/aprobarDictamen"
	String autorizarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/autorizar"
	String autorizarAltaOficio = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/autorizarAltaOficio"
	String deshacerAutorizacionSinPoderesUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/deshacerAutorizacionSinPoderes"
	String apoderarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/apoderar"
	String deshacerApoderarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/deshacerApoderar"
	String suspenderUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/suspender"
	String revocarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/revocar"
	String deshacerRevocarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/deshacerRevocar"
	String expirarUrl = "http://10.100.128.57:8080/amibExpediente-0.1/autorizacionRestful/expirar"
	
	def aprobarDictamen(List<Long> idCertificacionList) {
		return this.sendIdJSONArray(aprobarDictamenUrl, idCertificacionList)
	}
	
	def autorizar(List<Long> idCertificacionList) {
		return this.sendIdJSONArray(autorizarUrl, idCertificacionList)
	}
	
	def autorizarAltaOficio(List<Long> idCertificacionList,Date fechaOficio) {
		List<Long> result = new ArrayList<Long>()
		def jsonBuilder = new groovy.json.JsonBuilder()
		println("cosa que mandara en aurotizaraltaoficio"+fechaOficio)
		jsonBuilder.alta(
			ids: idCertificacionList,
			dateOficio: fechaOficio.format( 'yyyy-MM-dd' )
		)
		Map<String,String> res = new HashMap<String,String>()
		def rest = new RestBuilder()
		def resp = rest.post(autorizarAltaOficio){
			contentType "application/json;charset=UTF-8"
			json (jsonBuilder.toPrettyString())
		}
		if(resp.json){
			result = new ArrayList<Integer>( resp.json )
		}
		
		return result
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
