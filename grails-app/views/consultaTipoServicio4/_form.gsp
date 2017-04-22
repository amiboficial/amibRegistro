<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio4" %>



<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio4Instance, field: 'fechaModificacion', 'error')} required">
	<label for="fechaModificacion">
		<g:message code="consultaTipoServicio4.fechaModificacion.label" default="Fecha Modificacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaModificacion" required="" value="${consultaTipoServicio4Instance?.fechaModificacion}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio4Instance, field: 'fechaSolicitud', 'error')} required">
	<label for="fechaSolicitud">
		<g:message code="consultaTipoServicio4.fechaSolicitud.label" default="Fecha Solicitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaSolicitud" required="" value="${consultaTipoServicio4Instance?.fechaSolicitud}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio4Instance, field: 'folioPortal', 'error')} required">
	<label for="folioPortal">
		<g:message code="consultaTipoServicio4.folioPortal.label" default="Folio Portal" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="folioPortal" required="" value="${consultaTipoServicio4Instance?.folioPortal}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio4Instance, field: 'matricula', 'error')} required">
	<label for="matricula">
		<g:message code="consultaTipoServicio4.matricula.label" default="Matricula" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="matricula" required="" value="${consultaTipoServicio4Instance?.matricula}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio4Instance, field: 'tipoServicio', 'error')} required">
	<label for="tipoServicio">
		<g:message code="consultaTipoServicio4.tipoServicio.label" default="Tipo Servicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tipoServicio" required="" value="${consultaTipoServicio4Instance?.tipoServicio}"/>

</div>

