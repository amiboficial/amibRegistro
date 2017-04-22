<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio" %>



<div class="fieldcontain ${hasErrors(bean: consultaTipoServicioInstance, field: 'fechaModificacion', 'error')} required">
	<label for="fechaModificacion">
		<g:message code="consultaTipoServicio.fechaModificacion.label" default="Fecha Modificacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaModificacion" required="" value="${consultaTipoServicioInstance?.fechaModificacion}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicioInstance, field: 'fechaSolicitud', 'error')} required">
	<label for="fechaSolicitud">
		<g:message code="consultaTipoServicio.fechaSolicitud.label" default="Fecha Solicitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaSolicitud" required="" value="${consultaTipoServicioInstance?.fechaSolicitud}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicioInstance, field: 'folio', 'error')} required">
	<label for="folio">
		<g:message code="consultaTipoServicio.folio.label" default="Folio de solicitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="folio" required="" value="${consultaTipoServicioInstance?.folio}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicioInstance, field: 'matricula', 'error')} required">
	<label for="matricula">
		<g:message code="consultaTipoServicio.matricula.label" default="Matricula" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="matricula" required="" value="${consultaTipoServicioInstance?.matricula}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicioInstance, field: 'tipoServicio', 'error')} required">
	<label for="tipoServicio">
		<g:message code="consultaTipoServicio.tipoServicio.label" default="Tipo Servicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tipoServicio" required="" value="${consultaTipoServicioInstance?.tipoServicio}"/>

</div>

