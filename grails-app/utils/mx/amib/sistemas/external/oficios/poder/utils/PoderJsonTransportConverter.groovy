package mx.amib.sistemas.external.oficios.poder.utils

import grails.converters.JSON
import java.util.Date;
import java.util.List;

import mx.amib.sistemas.external.oficios.poder.ApoderadoResultTO
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO
import mx.amib.sistemas.external.oficios.poder.PoderTO

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

public class PoderJsonTransportConverter {
	public static PoderTO fromJsonToTranport(JSONObject jsonObject){
		PoderTO p = new PoderTO()
		
		Calendar calfap = Calendar.getInstance()
		Calendar calfc = Calendar.getInstance()
		Calendar calfm = Calendar.getInstance()
		
		if(!JSONObject.NULL.equals(jsonObject.'id')) p.id = jsonObject.'id'
		if(!JSONObject.NULL.equals(jsonObject.'version')) p.version = jsonObject.'version'
		
		if(!JSONObject.NULL.equals(jsonObject.'idGrupoFinanciero')) p.idGrupoFinanciero = jsonObject.'idGrupoFinanciero'
		if(!JSONObject.NULL.equals(jsonObject.'idInstitucion')) p.idInstitucion = jsonObject.'idInstitucion'
		if(!JSONObject.NULL.equals(jsonObject.'idNotario')) p.idNotario = jsonObject.'idNotario'
		if(!JSONObject.NULL.equals(jsonObject.'numeroEscritura')) p.numeroEscritura = jsonObject.'numeroEscritura'
		if(!JSONObject.NULL.equals(jsonObject.'representanteLegalNombre')) p.representanteLegalNombre = jsonObject.'representanteLegalNombre'
		if(!JSONObject.NULL.equals(jsonObject.'representanteLegalApellido1')) p.representanteLegalApellido1 = jsonObject.'representanteLegalApellido1'
		if(!JSONObject.NULL.equals(jsonObject.'representanteLegalApellido2')) p.representanteLegalApellido2 = jsonObject.'representanteLegalApellido2'
		if(!JSONObject.NULL.equals(jsonObject.'fechaApoderamiento')){
		calfap.setTimeInMillis(jsonObject.'fechaApoderamiento')
		p.fechaApoderamiento = calfap.getTime()
		}
		if(!JSONObject.NULL.equals(jsonObject.'uuidDocumentoRespaldo')) p.uuidDocumentoRespaldo = jsonObject.'uuidDocumentoRespaldo'
		if(!JSONObject.NULL.equals(jsonObject.'apoderados')) p.apoderados = ApoderadoJsonTranportConverter.fromJsonArrayToTranport(jsonObject.'apoderados')

		if(!JSONObject.NULL.equals(jsonObject.'fechaCreacion')){
			calfc.setTimeInMillis(jsonObject.'fechaCreacion')
			p.fechaCreacion = calfc.getTime()
		}
		if(!JSONObject.NULL.equals(jsonObject.'fechaModificacion')){
		calfm.setTimeInMillis(jsonObject.'fechaModificacion')
		p.fechaModificacion = calfm.getTime()
		}
		
		return p
	}
	public static List<PoderTO> fromJsonArrayToTranport(JSONArray jsonArr){
		List<PoderTO> lp = new ArrayList<PoderTO>()
		jsonArr.each { x ->
			PoderTO p = PoderJsonTransportConverter.fromJsonToTranport(x)
			lp.add(p)
		}
		return lp
	}
}
