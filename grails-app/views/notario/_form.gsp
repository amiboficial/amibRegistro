<%@ page import="mx.amib.sistemas.registro.notario.model.Notario" %>



<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'idEntidadFederativa', 'error')} required">
	<label for="idEntidadFederativa">
		<g:message code="notario.idEntidadFederativa.label" default="Id Entidad Federativa" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="idEntidadFederativa" type="number" value="${notarioInstance.idEntidadFederativa}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="notario.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="100" required="" value="${notarioInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'apellido1', 'error')} required">
	<label for="apellido1">
		<g:message code="notario.apellido1.label" default="Apellido1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido1" maxlength="80" required="" value="${notarioInstance?.apellido1}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'apellido2', 'error')} required">
	<label for="apellido2">
		<g:message code="notario.apellido2.label" default="Apellido2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido2" maxlength="80" required="" value="${notarioInstance?.apellido2}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'fechaCreacion', 'error')} ">
	<label for="fechaCreacion">
		<g:message code="notario.fechaCreacion.label" default="Fecha Creacion" />
		
	</label>
	<g:datePicker name="fechaCreacion" precision="day"  value="${notarioInstance?.fechaCreacion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'fechaModificacion', 'error')} ">
	<label for="fechaModificacion">
		<g:message code="notario.fechaModificacion.label" default="Fecha Modificacion" />
		
	</label>
	<g:datePicker name="fechaModificacion" precision="day"  value="${notarioInstance?.fechaModificacion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'numeroNotario', 'error')} required">
	<label for="numeroNotario">
		<g:message code="notario.numeroNotario.label" default="Numero Notario" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numeroNotario" type="number" value="${notarioInstance.numeroNotario}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'poderes', 'error')} ">
	<label for="poderes">
		<g:message code="notario.poderes.label" default="Poderes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${notarioInstance?.poderes?}" var="p">
    <li><g:link controller="poder" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="poder" action="create" params="['notario.id': notarioInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'poder.label', default: 'Poder')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'revocaciones', 'error')} ">
	<label for="revocaciones">
		<g:message code="notario.revocaciones.label" default="Revocaciones" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${notarioInstance?.revocaciones?}" var="r">
    <li><g:link controller="revocacion" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="revocacion" action="create" params="['notario.id': notarioInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'revocacion.label', default: 'Revocacion')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'seqNotario', 'error')} required">
	<label for="seqNotario">
		<g:message code="notario.seqNotario.label" default="Seq Notario" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="seqNotario" type="number" value="${notarioInstance.seqNotario}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: notarioInstance, field: 'vigente', 'error')} ">
	<label for="vigente">
		<g:message code="notario.vigente.label" default="Vigente" />
		
	</label>
	<g:checkBox name="vigente" value="${notarioInstance?.vigente}" />

</div>

