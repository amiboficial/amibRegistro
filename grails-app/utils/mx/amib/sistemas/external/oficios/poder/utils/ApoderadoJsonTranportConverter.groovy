package mx.amib.sistemas.external.oficios.poder.utils

import java.util.List;

import mx.amib.sistemas.external.oficios.poder.ApoderadoResultTO;
import mx.amib.sistemas.external.oficios.poder.ApoderadoTO

import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject;

public class ApoderadoJsonTranportConverter {
	public static ApoderadoTO fromJsonToTranport(JSONObject jsonObject){
		ApoderadoTO ap = new ApoderadoTO()
		Calendar calfc = Calendar.getInstance()
		Calendar calfm = Calendar.getInstance()
		
		ap.id = jsonObject.'id'
		ap.idCertificacion = jsonObject.'idCertificacion'
		ap.idPoder = jsonObject.'idPoder'
		calfc.setTimeInMillis(jsonObject.'fechaCreacion')
		ap.fechaCreacion = calfc.getTime()
		calfm.setTimeInMillis(jsonObject.'fechaModificacion')
		ap.fechaModificacion = calfm.getTime()
		
		return ap
	}
	public static List<ApoderadoTO> fromJsonArrayToTranport(JSONArray jsonArr){
		List<ApoderadoTO> lar = new ArrayList<ApoderadoTO>()
		jsonArr.each { x ->
			ApoderadoTO ap = ApoderadoJsonTranportConverter.fromJsonToTranport(x)
			lar.add(ap)
		}
		return lar
	}
}
