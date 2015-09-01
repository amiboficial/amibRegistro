package mx.amib.sistemas.external.oficios.revocacion.utils

import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONElement

public class RevocacionJsonTranportConverter {
	public static RevocacionTO fromJsonToTranport(JSONElement je){
		RevocacionTO obj = new RevocacionTO()
		obj.id = je.'id'
		obj.version = je.'version'
		
		obj.idGrupoFinanciero = je.'idGrupoFinanciero'
		obj.idInstitucion = je.'idInstitucion'
		obj.idNotario = je.'idNotario'
		obj.numeroEscritura = je.'numeroEscritura'
		obj.representanteLegalNombre = je.'representanteLegalNombre'
		obj.representanteLegalApellido1 = je.'representanteLegalApellido1'
		obj.representanteLegalApellido2 = je.'representanteLegalApellido2'
		obj.fechaRevocacion = new Date(je.'fechaRevocacion')
		obj.uuidDocumentoRespaldo = je.'uuidDocumentoRespaldo'
		
		obj.revocados = RevocadoJsonTransportConverter.fromJsonArrayToTranportList(je.'revocados')
		
		obj.fechaCreacion = new Date(je.'fechaCreacion')
		obj.fechaModificacion = new Date(je.'fechaModificacion')
		
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
}
