package mx.amib.sistemas.registro.apoderado.service

import grails.transaction.Transactional

import grails.plugins.rest.client.RestBuilder
import mx.amib.sistemas.registro.apoderamiento.model.catalog.TipoDocumentoRespaldoPoder

@Transactional
class PoderService {

    def nuevoPoderPorGrupoFinanciero(long idGrupoFinanciero) {
		
    }
	
	def nuevoPoderPorInstitucion(long idInstitucion) {
		
	}
	
	Collection<TipoDocumentoRespaldoPoder> obtenerListadoTipoDocumentoRespaldoPoder() {
		return TipoDocumentoRespaldoPoder.findAllByVigente(true)
	}
	
}
