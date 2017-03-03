package mx.amib.sistemas.registro.expediente.service

import javax.xml.soap.*;

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.certificacion.service.ValidacionTO
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTypes
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTypes
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.service.CertificacionService;
import mx.amib.sistemas.external.expediente.service.SustentanteService;
import grails.transaction.Transactional
// TODO: Implementar logging en este servicio dado que en estos métodos se hace
// llamada a múltiples servicios, si alguno falla, se rastrea inmediatamente el
// error. (cuestiones de integridad)
@Transactional
class CertificacionActualizacionAutorizacionService {

	SustentanteService sustentanteService
	CertificacionService certificacionService
	def autorizacionService
	
    def obtenerParaActualizacion(long id) {
		CertificacionTO c = certificacionService.get(id)
		boolean estaAutorizadoConPoderes
		boolean estaCertificado
		
		//revisa que este en estatus de dictaminable
		//edit1: se agrego tatusAutorizacionTypes.REVOCADA para que en la actualizacion de la autorizacion permita revocadas
		estaAutorizadoConPoderes = ( c.statusAutorizacion.id.value == StatusAutorizacionTypes.AUTORIZADO 
		|| c.statusAutorizacion.id.value == StatusAutorizacionTypes.AUTORIZADO_SIN_PODERES
		|| c.statusAutorizacion.id.value == StatusAutorizacionTypes.REVOCADA)
		estaCertificado = (c.statusCertificacion.id.value == StatusCertificacionTypes.CERTIFICADO)
		
		if(!(estaAutorizadoConPoderes && estaCertificado))
			c = null
		
		return c
    }
	
	void actualizarCertificacion(SustentanteTO sustentante, CertificacionTO certificacion, ValidacionTO validacion){
		println("actualizarCertificacion")
		sustentanteService.updateDatosPersonales(sustentante)
		println("updateDatosPersonales")
		sustentanteService.updatePuestos(sustentante)
		println("updatePuestos")
		certificacionService.updateDatosParaActualizarAutorizacion(certificacion, validacion)
		println("updateDatosParaActualizarAutorizacion")
		//no se requiere actualizar ningún estatus dado que la certificación seguirá autorizadas
	}
	
	def getPFIExamns(Long matricula){
		String responseContent = "";
		try{
		// Create SOAP Connection
		SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
		SOAPConnection soapConnection = soapConnectionFactory.createConnection();
		// Send SOAP Message to SOAP Server
		String url = "http://actualizacionamib.com.mx/SysGEMv2/index.php/services/calificaciones_WSDL/wsdl";
		SOAPMessage soapResponse = soapConnection.call(createSOAPRequest(""+matricula), url);
		// print SOAP Response
		//soapResponse.writeTo(System.out);
        SOAPPart soapPart = soapResponse.getSOAPPart();
		SOAPEnvelope env = soapPart.getEnvelope();
		SOAPBody MyBody = env.getBody();
		Iterator iterator = MyBody.getChildElements();
		while (iterator.hasNext()) {
			SOAPBodyElement bodyElement = (SOAPBodyElement)iterator.next();
			String lastPrice = bodyElement.getValue();
			Iterator iterator2 = bodyElement.getChildElements()
			while (iterator2.hasNext()) {
				SOAPBodyElement bodyElement2 = (SOAPBodyElement)iterator2.next();
				String lastPrice2 = bodyElement2.getValue();
				if(lastPrice2!=null&&!lastPrice2.equals("")){
					responseContent = lastPrice2;
				}
			}
		}
		soapConnection.close();
		}catch(Exception e){
			//e.printStackTrace();
			System.out.println(" error al intentar contactar el servicio externo ssym Mensaje: "+ e.message);
			responseContent = "";
		}
		return responseContent
	}
	
	private SOAPMessage createSOAPRequest(String matricula) throws Exception {
		MessageFactory messageFactory = MessageFactory.newInstance();
		SOAPMessage soapMessage = messageFactory.createMessage();
		SOAPPart soapPart = soapMessage.getSOAPPart();
		String serverURI = "http://actualizacionamib.com.mx/SysGEMv2/index.php/services/calificaciones_WSDL";
		// SOAP Envelope
		SOAPEnvelope envelope = soapPart.getEnvelope();
		envelope.addNamespaceDeclaration("urn", "calificaciones_WSDL");
		SOAPBody soapBody = envelope.getBody();
		SOAPElement soapBodyElem = soapBody.addChildElement("Services..calificaciones", "urn");
		SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("matricula");
		soapBodyElem1.addTextNode(matricula);
		//soapBodyElem1.addTextNode("96597");
		MimeHeaders headers = soapMessage.getMimeHeaders();
		headers.addHeader("SOAPAction", serverURI);
		soapMessage.saveChanges();
		/* Print the request message 
		System.out.println("Request SOAP Message:");*/
		//soapMessage.writeTo(System.out);
		return soapMessage;
	}
	
}
