package mx.amib.sistemas.utils

/**
 * Created by Gabriel on 19/05/2015.
 *
 * Convierte clases de objetos de tranporte de catalogos
 * cuando 2 sistemas o más lo definen.
 *
 */
class CatalogConvertUtils {
    public static mx.amib.sistemas.external.expediente.persona.catalog.service.NacionalidadTO fromCatalogosToExpediente(mx.amib.sistemas.external.catalogos.service.NacionalidadTO oldObj){
        mx.amib.sistemas.external.expediente.persona.catalog.service.NacionalidadTO newObj = new mx.amib.sistemas.external.expediente.persona.catalog.service.NacionalidadTO()
        newObj.id = oldObj.id
        newObj.descripcion = oldObj.descripcion
        newObj.vigente = oldObj.vigente
        return newObj
    }
    public static mx.amib.sistemas.external.expediente.persona.catalog.service.NivelEstudiosTO fromCatalogosToExpediente(mx.amib.sistemas.external.catalogos.service.NivelEstudiosTO oldObj){
        mx.amib.sistemas.external.expediente.persona.catalog.service.NivelEstudiosTO newObj = new mx.amib.sistemas.external.expediente.persona.catalog.service.NivelEstudiosTO()
        newObj.id = oldObj.id
        newObj.descripcion = oldObj.descripcion
        newObj.vigente = oldObj.vigente
        return newObj
    }
    public static mx.amib.sistemas.external.expediente.persona.catalog.service.EstadoCivilTO fromCatalogosToExpediente(mx.amib.sistemas.external.catalogos.service.EstadoCivilTO oldObj){
        mx.amib.sistemas.external.expediente.persona.catalog.service.EstadoCivilTO newObj = new mx.amib.sistemas.external.expediente.persona.catalog.service.EstadoCivilTO()
        newObj.id = oldObj.id
        newObj.descripcion = oldObj.descripcion
        newObj.vigente = oldObj.vigente
        return newObj
    }
    public static mx.amib.sistemas.external.expediente.persona.catalog.service.TipoTelefonoTO fromCatalogosToExpediente(mx.amib.sistemas.external.catalogos.service.TipoTelefonoTO oldObj){
        mx.amib.sistemas.external.expediente.persona.catalog.service.TipoTelefonoTO newObj = new mx.amib.sistemas.external.expediente.persona.catalog.service.TipoTelefonoTO()
        newObj.id = oldObj.id
        newObj.descripcion = oldObj.descripcion
        newObj.vigente = oldObj.vigente
        return newObj
    }
}
