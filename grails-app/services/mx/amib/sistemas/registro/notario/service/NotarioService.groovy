package mx.amib.sistemas.registro.notario.service

import grails.transaction.Transactional

import mx.amib.sistemas.registro.notario.model.Notario

@Transactional
class NotarioService {

    Notario obtenerNotario(int idEntidadFederativa, int numeroNotario) {
		//valida si los parametros son numeros
		Notario n = Notario.findByIdEntidadFederativaAndNumeroNotarioAndVigente(idEntidadFederativa,numeroNotario,true)
		return n
    }
	
}
