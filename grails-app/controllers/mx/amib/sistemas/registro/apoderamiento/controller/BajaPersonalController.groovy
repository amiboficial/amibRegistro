	package mx.amib.sistemas.registro.apoderamiento.controller

import java.util.Collection;

import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.InstitucionTO;
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.service.SustentanteService;

class BajaPersonalController {
	
	SustentanteService sustentanteService
	EntidadFinancieraService entidadFinancieraService
	

    def index() { }
	
	def create() {
		
		Collection<InstitucionTO> institucionesList
		institucionesList = entidadFinancieraService.obtenerInstituciones()
		render( view:'create', model:[intList:institucionesList] )
	}
	
	
	def findByNumeroMatricula(){
		int numeroMatricula = -1
		Map<String,Object> respuesta = new HashMap<String,Object>()
		SustentanteTO sustentante
		numeroMatricula = params.int('numeroMatricula')
		sustentante = sustentanteService.findByMatricula(numeroMatricula)
		
		if(sustentante != null){
			println(sustentante as JSON)
			CertificacionTO ultimacert
			if(sustentante.certificaciones !=null && sustentante.certificaciones.size()>0){
				ultimacert = sustentante.certificaciones.find{ it.isUltima == true }
			}
			if( ultimacert!=null && !ultimacert.isAutorizado && !ultimacert.isApoderado ){
				respuesta = [ 'status' : 'ERROR' , 'object' : 'SUSTENTANTE_NOT_AUT_AND_APODERATED' ]
			}
			else if(sustentante.puestos==null || sustentante.puestos.size()<=0){
				respuesta = [ 'status' : 'ERROR' , 'object' : 'SUSTENTANTE_NOT_AUT_AND_APODERATED' ]
			}
			else {
				def lastpuest = sustentante.puestos.find{ it.esActual}
				if(lastpuest.idInstitucion == 92L){
					respuesta = [ 'status' : 'ERROR' , 'object' : 'ALREADY_DISCARTED_JOB' ]
				}else{
					respuesta = [ 'status' : 'OK' , 'object' : sustentante ]
				}
			}
		}
		else{
			respuesta = [ 'status' : 'ERROR' , 'object' : 'SUSTENTANTE_NOT_FOUND' ]
		}
		
		render(respuesta as JSON)
	}
	
	def save(){
		int numeroMatricula = -1
		SustentanteTO sustentante
		numeroMatricula = params.int('bajaMatricula')
		sustentante = sustentanteService.findByMatricula(numeroMatricula)
		sustentante.puestos.each{ pue -> 
			if(pue.esActual || pue.fechaFin == null){
				pue.fechaFin = new Date()
				pue.esActual = false
				pue.fechaModificacion = new Date()
			}
		}
		PuestoTO bajapuesto = new PuestoTO()
		bajapuesto.idInstitucion = 92L
		bajapuesto.fechaCreacion = new Date()
		bajapuesto.fechaInicio = new Date()
		bajapuesto.fechaFin = null
		bajapuesto.nombrePuesto = "no aplica"
		bajapuesto.esActual = true
		bajapuesto.statusEntManifProtesta = 0
		bajapuesto.statusEntCartaInter = 0
		bajapuesto.obsEntManifProtesta = 0
		bajapuesto.obsEntCartaInter = 0
		bajapuesto.sustentante = sustentante
		sustentante.puestos.add(bajapuesto)
		
		sustentanteService.updatePuestos(sustentante)
		
		flash.successMessage = "El sustentante con matricula: " + params.int('bajaMatricula') + " ha sido retirado del puesto exitosamente"
		redirect (action: "create")
	}
	

	
}
