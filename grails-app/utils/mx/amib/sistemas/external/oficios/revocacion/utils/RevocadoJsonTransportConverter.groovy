package mx.amib.sistemas.external.oficios.revocacion.utils

import java.util.List

import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.external.oficios.revocacion.RevocadoTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject

class RevocadoJsonTransportConverter {
	public static RevocadoTO fromJsonToTranport(JSONElement je){
		RevocadoTO revocado = new RevocadoTO()
		revocado.id = je.'id'
		revocado.idRevocacion = je.'idRevocacion'
		revocado.idApoderado = je.'idApoderado'
		revocado.motivo = je.'motivo'
		revocado.fechaBaja = new Date(je.'fechaBaja')
		revocado.fechaCreacion = new Date(je.'fechaCreacion')
		revocado.fechaCreacion = new Date(je.'fechaModificacion')
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
