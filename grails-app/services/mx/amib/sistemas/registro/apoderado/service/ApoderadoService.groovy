package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional

import mx.amib.sistemas.registro.apoderamiento.model.AutorizadoCNBV

import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class ApoderadoService {

	def grailsApplication
	
    ApoderadoTO obtenerDatosMatriculaDgaValido(int numeroMatricula) {
		String sustentanteRestUrl = grailsApplication.config.mx.amib.sistemas.expediente.resthttpURL + grailsApplication.config.mx.amib.sistemas.expediente.Sustentante.obtenerSustentantePorMatricula
		String sustentanteClassName = grailsApplication.config.mx.amib.sistemas.expediente.Sustentante.classname
				
		ApoderadoTO apoderado = null
		
		def autorizadosCNBV = null
		def todayDate = new Date()
		
		def rest = new RestBuilder()
		
		
		//solicita los datos del sustentante al sistema de EXPEDIENTE de acuerdo a su matricula
		def resp = rest.get(sustentanteRestUrl + numeroMatricula)
		resp.json instanceof JSONObject
		
		//println sustentanteRestUrl + numeroMatricula
		//println sustentanteClassName
		//println resp.json.'class'
		
		if(resp.json == null){
			return null
			//throw new Exception("JSON_NULL") //No fue posible obtener la matricula
		}
		if(resp.json.'class' == sustentanteClassName){
			apoderado = new ApoderadoTO()
			apoderado.numeroMatricula = resp.json.'numeroMatricula'
			apoderado.nombreCompleto = resp.json.'nombre' + ' ' + resp.json.'primerApellido'  + ' ' +  resp.json.'segundoApellido'
			apoderado.autorizacionesCNBV = new ArrayList<AutorizacionCnbvTO>()
			
			//busca los datos de oficioCNBV de acuerdo a la matricuka
			autorizadosCNBV = AutorizadoCNBV.findAllByNumeroMatricula(apoderado.numeroMatricula)
			autorizadosCNBV.each{ AutorizadoCNBV a ->
				if(a.oficioCNBV.fechaFinVigencia > todayDate){
					def ato = new AutorizacionCnbvTO()
					ato.idAutorizadoCNBV = a.id
					ato.idOficioCNBV = a.oficioCNBV.id
					ato.claveDga = a.oficioCNBV.claveDga
					apoderado.autorizacionesCNBV.add(ato)
				}
			}

		}
		
		println (new grails.converters.JSON(apoderado)).toString()
		
		return apoderado
    }
	
}

//Clases de transporte de objeto

class ApoderadoTO {
	int numeroMatricula
	String nombreCompleto
	List<AutorizacionCnbvTO> autorizacionesCNBV
}

class AutorizacionCnbvTO {
	int idAutorizadoCNBV
	int idOficioCNBV
	String claveDga
}