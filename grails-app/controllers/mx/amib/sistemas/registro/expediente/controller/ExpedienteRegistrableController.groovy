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
	def sustentanteService

	def metodoCertificacionService
	def statusAutorizacionService
	def statusCertificacionService

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
		//sustentante.nacionalidad = CatalogConvertUtils.fromCatalogosToExpediente(nacionalidadService.get(Long.parseLong(params.'sustentante.nacionalidad_id')))
		//sustentante.nivelEstudios = CatalogConvertUtils.fromCatalogosToExpediente(nivelEstudiosService.get(Long.parseLong(params.'sustentante.nivelEstudios_id')))
		//sustentante.estadoCivil = CatalogConvertUtils.fromCatalogosToExpediente(estadoCivilService.get(Long.parseLong(params.'sustentante.estadoCivil_id')))
		sustentante.telefonos = new ArrayList<TelefonoSustentanteTO>()
		if(telefonosJsonElement != null && telefonosJsonElement instanceof JSONArray){
			def telefonosJsonArray = (JSONArray)telefonosJsonElement
			telefonosJsonArray.each{
				TelefonoSustentanteTO t = new TelefonoSustentanteTO()
				t.lada = it.'lada'
				t.telefono = it.'telefono'
				t.extension = it.'extension'
				t.idTipoTelefonoSustentante = Long.parseLong(it.'idTipoTelefono')
				//t.tipoTelefonoSustentante = CatalogConvertUtils.fromCatalogosToExpediente( tipoTelefonoService.get() )
				sustentante.telefonos.add(t)
			}
		}
		sustentante.documentos = new ArrayList<DocumentoSustentanteTO>()
		sustentante.puestos = new ArrayList<PuestoTO>()
		PuestoTO p = new PuestoTO()
		p.idInstitucion = Long.parseLong(params.'registro.idInstitucion')
		p.fechaInicio = sdf.parse(params.'registro.fechaInicio_day' + '-' + params.'registro.fechaInicio_month' + '-' + params.'registro.fechaInicio_year')
		p.fechaFin = null
		p.nombrePuesto = params.'registro.nombrePuesto'
		p.esActual = true
		sustentante.puestos.add(p)
		sustentante.certificaciones = new ArrayList<CertificacionTO>()

		CertificacionTO c = new CertificacionTO()
		c.fechaInicio = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		def fechaFinCalendar = Calendar.getInstance()
		fechaFinCalendar.setTime(c.fechaInicio)
		fechaFinCalendar.add(Calendar.YEAR,3)
		c.fechaFin = fechaFinCalendar.getTime()
		c.fechaObtencion = sdf.parse(params.'registro.fechaObtencion_day' + '-' + params.'registro.fechaObtencion_month' + '-' + params.'registro.fechaObtencion_year')
		c.nombreUsuarioActualizo = "USUARIO_QUE_ACTUALIZO"
		c.esLaActual = true
		c.fechaUltimoCambioStatusEsLaActual = new Date()
		c.varianteFigura = CatalogConvertUtils.fromCatalogosToExpediente( figuraService.getVariante(Long.parseLong(params.'registro.idVarianteFigura')) ) //TODO: Importar catálogo
		//c.statusAutorizacion = statusAutorizacionService.get(2)
		//c.statusCertificacion = statusCertificacionService.get(2)
		//c.metodoCertificacion = metodoCertificacionService.get(1)
		c.idStatusAutorizacion = 2 //En dictamen previo
		c.idStatusCertificacion = 2 //Certificado
		c.idMetodoCertificacion = 1 //Exámen
		c.fechaCreacion = new Date()
		c.fechaModificacion = new Date()
		sustentante.certificaciones.add(c)

		sustentante.fechaCreacion = new Date()
		sustentante.fechaModificacion = new Date()

		println "Se enviará el siguiente JSON: "
		println (sustentante as JSON)

		//se guarda el sustentante con todos los datos bindeados
		//sustentanteService.guardarNuevo(sustentante)

		respond new Object()
	}
}