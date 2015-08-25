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
		
		p.id = jsonObject.'id'
		p.version = jsonObject.'version'
		
		p.idGrupoFinanciero = jsonObject.'idGrupoFinanciero'
		p.idInstitucion = jsonObject.'idInstitucion'
		p.idNotario = jsonObject.'idNotario'
		p.numeroEscritura = jsonObject.'numeroEscritura'
		p.representanteLegalNombre = jsonObject.'representanteLegalNombre'
		p.representanteLegalApellido1 = jsonObject.'representanteLegalApellido1'
		p.representanteLegalApellido2 = jsonObject.'representanteLegalApellido2'
		calfap.setTimeInMillis(jsonObject.'fechaApoderamiento')
		p.fechaApoderamiento = calfap.getTime()
		p.uuidDocumentoRespaldo = jsonObject.'uuidDocumentoRespaldo'
		p.apoderados = ApoderadoJsonTranportConverter.fromJsonArrayToTranport(jsonObject.'apoderados')

		calfc.setTimeInMillis(jsonObject.'fechaCreacion')
		p.fechaCreacion = calfc.getTime()
		calfm.setTimeInMillis(jsonObject.'fechaModificacion')
		p.fechaModificacion = calfm.getTime()
		
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
