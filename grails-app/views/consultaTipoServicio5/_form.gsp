<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio5" %>



<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio5Instance, field: 'fechaModificacion', 'error')} required">
	<label for="fechaModificacion">
		<g:message code="consultaTipoServicio5.fechaModificacion.label" default="Fecha Modificacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaModificacion" required="" value="${consultaTipoServicio5Instance?.fechaModificacion}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio5Instance, field: 'fechaSolicitud', 'error')} required">
	<label for="fechaSolicitud">
		<g:message code="consultaTipoServicio5.fechaSolicitud.label" default="Fecha Solicitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaSolicitud" required="" value="${consultaTipoServicio5Instance?.fechaSolicitud}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio5Instance, field: 'folioPortal', 'error')} required">
	<label for="folioPortal">
		<g:message code="consultaTipoServicio5.folioPortal.label" default="Folio Portal" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="folioPortal" required="" value="${consultaTipoServicio5Instance?.folioPortal}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio5Instance, field: 'matricula', 'error')} required">
	<label for="matricula">
		<g:message code="consultaTipoServicio5.matricula.label" default="Matricula" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="matricula" required="" value="${consultaTipoServicio5Instance?.matricula}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: consultaTipoServicio5Instance, field: 'tipoServicio', 'error')} required">
	<label for="tipoServicio">
		<g:message code="consultaTipoServicio5.tipoServicio.label" default="Tipo Servicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tipoServicio" required="" value="${consultaTipoServicio5Instance?.tipoServicio}"/>

</div>

