package mx.amib.sistemas.registro.apoderamiento.controller


import java.text.SimpleDateFormat
import java.util.Collection;
import grails.converters.JSON
import mx.amib.sistemas.external.catalogos.service.EntidadFinancieraService;
import mx.amib.sistemas.external.catalogos.service.InstitucionTO;
import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO
import mx.amib.sistemas.external.expediente.service.SustentanteService;

class AltaPersonalController {
	
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
			if(sustentante.puestos==null || sustentante.puestos.size()<=0){
				respuesta = [ 'status' : 'ERROR' , 'object' : 'SUSTENTANTE_NOT_BAJA_INST' ]
			}
			else {
				def lastpuest = sustentante.puestos.find{ it.esActual}
				if(lastpuest.idInstitucion == 336L){
					respuesta = [ 'status' : 'OK' , 'object' : sustentante ]
				}else{
					respuesta = [ 'status' : 'ERROR' , 'object' : 'ALREADY_ASIGNATED_JOB' ]
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
		int idInstitucion = -1
		int fechaInicio_day = -1
		int fechaInicio_month = -1
		int fechaInicio_year = -1
		int fechaFin_day = -1
		int fechaFin_month = -1
		int fechaFin_year = -1
		String nombrePuesto = ""
		int statusEntManifProtesta = -1
		String obsEntManifProtesta = ""
		int statusEntCartaInter = -1
		String obsEntCartaInter = ""
		
		numeroMatricula = params.int('bajaMatricula')
		idInstitucion = params.int('idInstitucion')
		nombrePuesto = params.'nombrePuesto'
		statusEntManifProtesta = params.'statusEntManifProtesta'
		obsEntManifProtesta = params.'obsEntManifProtesta'
		statusEntCartaInter = params.'statusEntCartaInter'
		obsEntCartaInter = params.'obsEntCartaInter'
		statusEntCartaInter
		SustentanteTO sustentante
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		sustentante = sustentanteService.findByMatricula(numeroMatricula)
		sustentante.puestos.each{ pue ->
			if(pue.esActual){
				pue.fechaFin = new Date()
				pue.esActual = false
				pue.fechaModificacion = new Date()
			}
		}
		PuestoTO bajapuesto = new PuestoTO()
		bajapuesto.idInstitucion = (Long)idInstitucion
		bajapuesto.fechaCreacion = new Date()
		bajapuesto.fechaModificacion = new Date()
		if(params.'fechaInicio_day'!="-1" && params.'fechaInicio_month'!="-1" && params.'fechaInicio_year'!="-1"){
			bajapuesto.fechaInicio = sdf.parse(params.'fechaInicio_day' + '-' + params.'fechaInicio_month' + '-' + params.'fechaInicio_year')
		}
		if(params.'fechaFin_day'!=null && params.'fechaFin_day'!="-1" && params.'fechaFin_month'!=null && params.'fechaFin_month'!="-1" && params.'fechaFin_year'!=null && params.'fechaFin_year'!="-1"){
			bajapuesto.fechaFin = sdf.parse(params.'fechaFin_day' + '-' + params.'fechaFin_month' + '-' + params.'fechaFin_year')
		}else{
			bajapuesto.fechaFin = null
		}
		bajapuesto.nombrePuesto = nombrePuesto
		bajapuesto.esActual = true
		bajapuesto.statusEntManifProtesta = statusEntManifProtesta
		bajapuesto.statusEntCartaInter = statusEntCartaInter
		bajapuesto.obsEntManifProtesta = obsEntManifProtesta
		bajapuesto.obsEntCartaInter = obsEntCartaInter
		bajapuesto.sustentante = sustentante
		sustentante.puestos.add(bajapuesto)
		
		println("beforesaveALTA")
		println(sustentante as JSON)
		sustentanteService.updatePuestos(sustentante)
		
		flash.successMessage = "El sustentante con matricula: " + params.int('bajaMatricula') + " ha sido asignado al puesto exitosamente"
		redirect (action: "create")
	}
}
