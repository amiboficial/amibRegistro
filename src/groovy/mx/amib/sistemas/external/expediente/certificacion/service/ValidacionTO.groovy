package mx.amib.sistemas.external.expediente.certificacion.service

import mx.amib.sistemas.external.expediente.certificacion.catalog.service.MetodoValidacionTO

class ValidacionTO {
    Date fechaAplicacion
    Date fechaInicio
    Date fechaFin
    String autorizadoPorUsuario
    List<EventoPuntosTO> eventosPuntos
    MetodoValidacionTO metodoValidacion
    Long idMetodoValidacion

    CertificacionTO certificacion

    Date fechaCreacion
    Date fechaModificacion
}
