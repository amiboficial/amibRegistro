package mx.amib.sistemas.external.expediente.service

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.json.JSONObject
import mx.amib.sistemas.external.expediente.certificacion.catalog.service.StatusCertificacionTO

@Transactional
class StatusCertificacionService {
    def grailsApplication

    def get(Long id){
        return StatusCertificacionCatalog.getInstance().getElement(id)
    }

    def list(){
        return StatusCertificacionCatalog.getInstance().getAllElements()
    }

    void descargarCatalogo(){
        String restUrl = grailsApplication.config.mx.amib.sistemas.expediente.resthttpURL + grailsApplication.config.mx.amib.sistemas.expediente.certificacion.StatusCertificacion.list

        def rest = new RestBuilder()
        def resp = rest.get(restUrl)
        resp.json instanceof JSONObject

        if(resp.json != null){
            resp.json.each{ objjson ->
                def newobj = new StatusCertificacionTO()
                newobj.id = objjson.'id'
                newobj.descripcion = objjson.'descripcion'
                newobj.vigente = objjson.'vigente'.toBoolean()
                StatusCertificacionCatalog.getInstance().addElement(newobj)
            }
        }
    }
}
class StatusCertificacionCatalog {
    private static StatusCertificacionCatalog _instance = null
    private TreeMap<Long,StatusCertificacionTO> _map = null

    private StatusCertificacionCatalog(){
        _map = new TreeMap<Long,StatusCertificacionTO>()
    }

    public static synchronized StatusCertificacionCatalog getInstance(){
        if(_instance == null)
        {
            _instance = new StatusCertificacionCatalog()
        }
        return _instance
    }

    public void addElement(StatusCertificacionTO obj){
        if(!_map.containsKey(obj.id))
            _map.put(obj.id, obj)
    }

    public StatusCertificacionTO getElement(Long id){
        return _map.get(id)
    }

    public Collection<StatusCertificacionTO> getAllElements(){
        return _map.values()
    }
}
