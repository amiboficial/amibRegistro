package mx.amib.sistemas.registro.expediente.controller

import mx.amib.sistemas.external.expediente.certificacion.service.CertificacionTO
import mx.amib.sistemas.external.expediente.persona.service.DocumentoSustentanteTO
import mx.amib.sistemas.external.expediente.persona.service.PuestoTO
import mx.amib.sistemas.external.expediente.persona.service.TelefonoSustentanteTO
import mx.amib.sistemas.utils.CatalogConvertUtils
import org.codehaus.groovy.grails.web.json.JSONArray

import java.text.SimpleDateFormat
import grails.converters.JSON
import mx.amib.sistemas.external.expediente.persona.service.SustentanteTO

class ExpedienteRegistrableController {

	def entidadFinancieraService
	def estadoCivilService
	def nacionalidadService
	def nivelEstudiosService
	def figuraService
	def tipoTelefonoService
	
    def index() { }
	
	def create() {
		def estadoCivilList = estadoCivilService.list()
		def institucionesList = entidadFinancieraService.obtenerInstituciones()
		def nacionalidadList = nacionalidadService.list()
		def nivelEstudiosList = nivelEstudiosService.list()
		def tipoTelefonoList = tipoTelefonoService.list()
		
		def institutoInstance = entidadFinancieraService.obtenerInstitucion(4) //<-se obtiene del elemento "registrable"
		def varianteFiguraInstance = figuraService.getVariante(195) //<-se obtiene del elemento "registrable"

		respond new Object(), model:[institutoInstance: institutoInstance, varianteFiguraInstance: varianteFiguraInstance, 
										estadoCivilList:estadoCivilList, institucionesList: institucionesList, nacionalidadList:nacionalidadList, 
										nivelEstudiosList:nivelEstudiosList, tipoTelefonoList: tipoTelefonoList]
	}

	def save(SustentanteTO sustentante) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy")
		def telefonosJsonElement = JSON.parse(params.'sustentante.telefonos_json')

		//bindings manuales
		sustentante.fechaNacimiento = sdf.parse(params.'sustentante.fechaNacimiento_day' + '-' + params.'sustentante.fechaNacimiento_month' + '-' + params.'sustentante.fechaNacimiento_year')
		sustentante.nacionalidad = CatalogConvertUtils.fromCatalogosToExpediente(nacionalidadService.get(Long.parseLong(params.'sustentante.nacionalidad_id')));
		sustentante.nivelEstudios = CatalogConvertUtils.fromCatalogosToExpediente(nivelEstudiosService.get(Long.parseLong(params.'sustentante.nivelEstudios_id')));
		sustentante.estadoCivil = CatalogConvertUtils.fromCatalogosToExpediente(estadoCivilService.get(Long.parseLong(params.'sustentante.estadoCivil_id')));
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		if(telefonosJsonElement != null && telefonosJsonElement instanceof JSONArray){
			def telefonosJsonArray = (JSONArray)telefonosJsonElement
			telefonosJsonArray.each{
				TelefonoSustentanteTO t = new TelefonoSustentanteTO()
				t.lada = it.'lada'
				t.telefono = it.'telefono'
				t.extension = it.'extension'
				t.tipoTelefonoSustentante = CatalogConvertUtils.fromCatalogosToExpediente( tipoTelefonoService.get(Long.parseLong(it.'idTipoTelefono')) )
				sustentante.telefonos.add(t)
			}
		}
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		sustentante.puestos = new ArrayList<PuestoTO>()
		PuestoTO p = new PuestoTO()
		p.idInstitucion = Long.parseLong(params.'registro.idInstitucion')
		p.fechaInicio = sdf.parse(params.'registro.fechaInicio_day' + '-' + params.'registro.fechaInicio_month' + '-' + params.'registro.fechaInicio_year')
		p.nombrePuesto = params.'registro.nombrePuesto'
		p.esActual = true
		sustentante.puestos.add(p)
		sustentante.certificaciones = new ArrayList<CertificacionTO>()
		CertificacionTO c = new CertificacionTO()
		c.fechaInicio = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		c.fechaFin = null
		c.fechaObtencion = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		c.nombreUsuarioActualizo = "USUARIO_QUE_ACTUALIZO"
		c.esLaActual = true
		c.fechaUltimoCambioStatusEsLaActual = new Date()
		sustentante.certificaciones.add(c)

		println "Se obtuvo la siguiente información"
		println "* " + sustentante.nombre
		println "* " + sustentante.primerApellido
		println "* " + sustentante.segundoApellido
		println "* " + sustentante.genero
		println "(de params): " + params.'sustentante.fechaNacimiento_year'
		println "* " + sustentante.fechaNacimiento.toString()
		println (sustentante as JSON)

		respond new Object()
	}
}