package mx.amib.sistemas.external.expediente.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoCertificacionTO
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class MetodoCertificacionService {

    def grailsApplication

    def get(Long id){
        return MetodoCertificacionCatalog.getInstance().getElement(id)
    }

    def list(){
        return MetodoCertificacionCatalog.getInstance().getAllElements()
    }

    void descargarCatalogo(){
        String restUrl = grailsApplication.config.mx.amib.sistemas.expediente.resthttpURL + grailsApplication.config.mx.amib.sistemas.expediente.certificacion.MetodoCertificacion.list

        def rest = new RestBuilder()
        def resp = rest.get(restUrl)
        resp.json instanceof JSONObject

        if(resp.json != null){
            resp.json.each{ objjson ->
                def newobj = new MetodoCertificacionTO()
                newobj.id = objjson.'id'
                newobj.descripcion = objjson.'descripcion'
                newobj.vigente = objjson.'vigente'.toBoolean()
                MetodoCertificacionCatalog.getInstance().addElement(newobj)
            }
        }
    }
    
}

class MetodoCertificacionCatalog {
    private static MetodoCertificacionCatalog _instance = null
    private TreeMap<Long,MetodoCertificacionTO> _map = null
    
    private MetodoCertificacionCatalog(){
        _map = new TreeMap<Long,MetodoCertificacionTO>()
    }

    public static synchronized MetodoCertificacionCatalog getInstance(){
        if(_instance == null)
        {
            _instance = new MetodoCertificacionCatalog()
        }
        return _instance
    }

    public void addElement(MetodoCertificacionTO obj){
        if(!_map.containsKey(obj.id))
            _map.put(obj.id, obj)
    }

    public MetodoCertificacionTO getElement(Long id){
        return _map.get(id)
    }

    public Collection<MetodoCertificacionTO> getAllElements(){
        return _map.values()
    }
}

