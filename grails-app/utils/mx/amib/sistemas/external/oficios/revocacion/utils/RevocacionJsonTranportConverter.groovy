package mx.amib.sistemas.external.oficios.revocacion.utils

import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement
import org.codehaus.groovy.grails.web.json.JSONObject

public class RevocacionJsonTranportConverter {
	public static RevocacionTO fromJsonToTranport(JSONElement je){
		RevocacionTO obj = new RevocacionTO()
		if(!JSONObject.NULL.equals(je.'id')) obj.id = je.'id'
		if(!JSONObject.NULL.equals(je.'version')) obj.version = je.'version'
		
		if(!JSONObject.NULL.equals(je.'idGrupoFinanciero')) obj.idGrupoFinanciero = je.'idGrupoFinanciero'
		if(!JSONObject.NULL.equals(je.'idInstitucion')) obj.idInstitucion = je.'idInstitucion'
		if(!JSONObject.NULL.equals(je.'idNotario')) obj.idNotario = je.'idNotario'
		if(!JSONObject.NULL.equals(je.'numeroEscritura')) obj.numeroEscritura = je.'numeroEscritura'
		if(!JSONObject.NULL.equals(je.'representanteLegalNombre')) obj.representanteLegalNombre = je.'representanteLegalNombre'
		if(!JSONObject.NULL.equals(je.'representanteLegalApellido1')) obj.representanteLegalApellido1 = je.'representanteLegalApellido1'
		if(!JSONObject.NULL.equals(je.'representanteLegalApellido2')) obj.representanteLegalApellido2 = je.'representanteLegalApellido2'
		if(!JSONObject.NULL.equals(je.'fechaRevocacion')) obj.fechaRevocacion = new Date(je.'fechaRevocacion')
		if(!JSONObject.NULL.equals(je.'uuidDocumentoRespaldo')) obj.uuidDocumentoRespaldo = je.'uuidDocumentoRespaldo'
		
		if(!JSONObject.NULL.equals(je.'revocados')) obj.revocados = RevocadoJsonTransportConverter.fromJsonArrayToTranportList(je.'revocados')
		
		if(!JSONObject.NULL.equals(je.'fechaCreacion')) obj.fechaCreacion = new Date(je.'fechaCreacion')
		if(!JSONObject.NULL.equals(je.'fechaModificacion')) obj.fechaModificacion = new Date(je.'fechaModificacion')
		
		return obj
	}
	public static List<RevocacionTO> fromJsonArrayToTranportList(JSONArray ja){
		List<RevocacionTO> objlist = new ArrayList<RevocacionTO>()
		ja.each { x ->
			RevocacionTO obj = RevocacionJsonTranportConverter.fromJsonToTranport(x)
			objlist.add(obj)
		}
		return objlist
	}
	public static Set<RevocacionTO> fromJsonArrayToTranportSet(JSONArray ja){
		Set<RevocacionTO> objset = new HashSet<RevocacionTO>()
		ja.each { x ->
			RevocacionTO obj = RevocacionJsonTranportConverter.fromJsonToTranport(x)
			objset.add(obj)
		}
		return objset
	}
}
