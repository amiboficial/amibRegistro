package mx.amib.sistemas.registro.apoderado.service

import java.util.Date;

import mx.amib.sistemas.registro.apoderamiento.model.Revocacion;
import grails.transaction.Transactional

@Transactional
class RevocacionService {

    def serviceMethod() {

    }
}

class RevocadoTO {
	long id
	int numeroMatricula
	String nombreCompleto
	int numeroEscritura
	String motivo
	Date fechaBaja
	long revocacionId
}