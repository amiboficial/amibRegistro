package mx.amib.sistemas.external.oficios.revocacion.utils

import mx.amib.sistemas.external.oficios.revocacion.RevocacionTO
import mx.amib.sistemas.utils.SearchResult

import org.codehaus.groovy.grails.web.json.JSONElement

class SearchResultJsonTranportConverter {
	public static SearchResult<RevocacionTO> fromJsonToTranport(JSONElement je){
		SearchResult<RevocacionTO> sr = new SearchResult<RevocacionTO>()
		sr.count = je.'count'
		sr.error = je.'error'
		sr.list = RevocacionJsonTranportConverter.fromJsonArrayToTranportList(je.'list')
		return sr
	}
}
