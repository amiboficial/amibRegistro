package mx.amib.sistemas.external.expediente.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusAutorizacionTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class StatusAutorizacionService {
    def grailsApplication

    def get(Long id){
        return StatusAutorizacionCatalog.getInstance().getElement(id)
    }

    def list(){
        return StatusAutorizacionCatalog.getInstance().getAllElements()
    }

    void descargarCatalogo(){
        String restUrl = grailsApplication.config.mx.amib.sistemas.expediente.resthttpURL + grailsApplication.config.mx.amib.sistemas.expediente.certificacion.StatusAutorizacion.list

        def rest = new RestBuilder()
        def resp = rest.get(restUrl)
        resp.json instanceof JSONObject

        if(resp.json != null){
            resp.json.each{ objjson ->
                def newobj = new StatusAutorizacionTO()
                newobj.id = objjson.'id'
                newobj.descripcion = objjson.'descripcion'
                newobj.vigente = objjson.'vigente'.toBoolean()
                StatusAutorizacionCatalog.getInstance().addElement(newobj)
            }
        }
    }
}

class StatusAutorizacionCatalog {
    private static StatusAutorizacionCatalog _instance = null
    private TreeMap<Long,StatusAutorizacionTO> _map = null

    private StatusAutorizacionCatalog(){
        _map = new TreeMap<Long,StatusAutorizacionTO>()
    }

    public static synchronized StatusAutorizacionCatalog getInstance(){
        if(_instance == null)
        {
            _instance = new StatusAutorizacionCatalog()
        }
        return _instance
    }

    public void addElement(StatusAutorizacionTO obj){
        if(!_map.containsKey(obj.id))
            _map.put(obj.id, obj)
    }

    public StatusAutorizacionTO getElement(Long id){
        return _map.get(id)
    }

    public Collection<StatusAutorizacionTO> getAllElements(){
        return _map.values()
    }
}
