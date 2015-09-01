package mx.amib.sistemas.external.oficios.revocacion.utils

import java.util.List

import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.revocacion.RevocadoTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject

class RevocadoJsonTransportConverter {
	public static RevocadoTO fromJsonToTranport(JSONElement je){
		Calendar calFecBaja = Calendar.getInstance()
		Calendar calFecCreacion = Calendar.getInstance()
		Calendar calFecModificacion = Calendar.getInstance()
		
		RevocadoTO revocado = new RevocadoTO()
		revocado.id = je.'id'
		revocado.idRevocacion = je.'idRevocacion'
		revocado.idApoderado = je.'idApoderado'
		revocado.motivo = je.'motivo'
		
		if(JSONObject.NULL.equals(je.'fechaBaja')){
			revocado.fechaBaja = null
		}
		else{
			calFecBaja.setTimeInMillis(je.'fechaBaja')
			revocado.fechaBaja = calFecBaja.getTime()
		}
			
		if(JSONObject.NULL.equals(je.'fechaCreacion')){
			revocado.fechaCreacion = null
		}
		else{
			calFecBaja.setTimeInMillis(je.'fechaCreacion')
			revocado.fechaCreacion = calFecCreacion.getTime()
		}
		
		if(JSONObject.NULL.equals(je.'fechaModificacion')){
			revocado.fechaModificacion = null
		}
		else{
			calFecBaja.setTimeInMillis(je.'fechaModificacion')
			revocado.fechaModificacion = calFecModificacion.getTime()
		}
		
		return revocado
	}
	public static List<RevocadoTO> fromJsonArrayToTranportList(JSONArray ja){
		List<RevocadoTO> objlist = new ArrayList<RevocadoTO>()
		ja.each { x ->
			RevocadoTO obj = RevocadoJsonTransportConverter.fromJsonToTranport(x)
			objlist.add(obj)
		}
		return objlist
	}
}
