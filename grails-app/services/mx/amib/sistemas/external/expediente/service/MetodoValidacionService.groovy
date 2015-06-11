package mx.amib.sistemas.external.expediente.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoValidacionTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class MetodoValidacionService {

    def grailsApplication

    def get(Long id){
        return MetodoValidacionCatalog.getInstance().getElement(id)
    }

    def list(){
        return MetodoValidacionCatalog.getInstance().getAllElements()
    }

    void descargarCatalogo(){
        String restUrl = grailsApplication.config.mx.amib.sistemas.expediente.resthttpURL + grailsApplication.config.mx.amib.sistemas.expediente.certificacion.MetodoValidacion.list

        def rest = new RestBuilder()
        def resp = rest.get(restUrl)
        resp.json instanceof JSONObject

        if(resp.json != null){
            resp.json.each{ objjson ->
                def newobj = new MetodoValidacionTO()
                newobj.id = objjson.'id'
                newobj.descripcion = objjson.'descripcion'
                newobj.vigente = objjson.'vigente'.toBoolean()
                MetodoValidacionCatalog.getInstance().addElement(newobj)
            }
        }
    }
    
}

class MetodoValidacionCatalog {
    private static MetodoValidacionCatalog _instance = null
    private TreeMap<Long,MetodoValidacionTO> _map = null
    
    private MetodoValidacionCatalog(){
        _map = new TreeMap<Long,MetodoValidacionTO>()
    }

    public static synchronized MetodoValidacionCatalog getInstance(){
        if(_instance == null)
        {
            _instance = new MetodoValidacionCatalog()
        }
        return _instance
    }

    public void addElement(MetodoValidacionTO obj){
        if(!_map.containsKey(obj.id))
            _map.put(obj.id, obj)
    }

    public MetodoValidacionTO getElement(Long id){
        return _map.get(id)
    }

    public Collection<MetodoValidacionTO> getAllElements(){
        return _map.values()
    }
}

