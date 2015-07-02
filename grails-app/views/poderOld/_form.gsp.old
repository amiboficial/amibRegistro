<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>



<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'representanteLegalNombre', 'error')} required">
	<label for="representanteLegalNombre">
		<g:message code="poder.representanteLegalNombre.label" default="Representante Legal Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="representanteLegalNombre" maxlength="100" required="" value="${poderInstance?.representanteLegalNombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'representanteLegalApellido1', 'error')} required">
	<label for="representanteLegalApellido1">
		<g:message code="poder.representanteLegalApellido1.label" default="Representante Legal Apellido1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="representanteLegalApellido1" maxlength="80" required="" value="${poderInstance?.representanteLegalApellido1}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'representanteLegalApellido2', 'error')} required">
	<label for="representanteLegalApellido2">
		<g:message code="poder.representanteLegalApellido2.label" default="Representante Legal Apellido2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="representanteLegalApellido2" maxlength="80" required="" value="${poderInstance?.representanteLegalApellido2}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'fechaCreacion', 'error')} ">
	<label for="fechaCreacion">
		<g:message code="poder.fechaCreacion.label" default="Fecha Creacion" />
		
	</label>
	<g:datePicker name="fechaCreacion" precision="day"  value="${poderInstance?.fechaCreacion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'fechaModificacion', 'error')} ">
	<label for="fechaModificacion">
		<g:message code="poder.fechaModificacion.label" default="Fecha Modificacion" />
		
	</label>
	<g:datePicker name="fechaModificacion" precision="day"  value="${poderInstance?.fechaModificacion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'apoderados', 'error')} ">
	<label for="apoderados">
		<g:message code="poder.apoderados.label" default="Apoderados" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${poderInstance?.apoderados?}" var="a">
    <li><g:link controller="apoderado" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="apoderado" action="create" params="['poder.id': poderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'apoderado.label', default: 'Apoderado')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'documentosRespaldoPoder', 'error')} ">
	<label for="documentosRespaldoPoder">
		<g:message code="poder.documentosRespaldoPoder.label" default="Documentos Respaldo Poder" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${poderInstance?.documentosRespaldoPoder?}" var="d">
    <li><g:link controller="documentoRespaldoPoder" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="documentoRespaldoPoder" action="create" params="['poder.id': poderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'documentoRespaldoPoder.label', default: 'DocumentoRespaldoPoder')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'esRegistradoPorGrupoFinanciero', 'error')} ">
	<label for="esRegistradoPorGrupoFinanciero">
		<g:message code="poder.esRegistradoPorGrupoFinanciero.label" default="Es Registrado Por Grupo Financiero" />
		
	</label>
	<g:checkBox name="esRegistradoPorGrupoFinanciero" value="${poderInstance?.esRegistradoPorGrupoFinanciero}" />

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'fechaApoderamiento', 'error')} required">
	<label for="fechaApoderamiento">
		<g:message code="poder.fechaApoderamiento.label" default="Fecha Apoderamiento" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaApoderamiento" precision="day"  value="${poderInstance?.fechaApoderamiento}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'idGrupofinanciero', 'error')} required">
	<label for="idGrupofinanciero">
		<g:message code="poder.idGrupofinanciero.label" default="Id Grupofinanciero" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="idGrupofinanciero" type="number" value="${poderInstance.idGrupofinanciero}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'idInstitucion', 'error')} required">
	<label for="idInstitucion">
		<g:message code="poder.idInstitucion.label" default="Id Institucion" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="idInstitucion" type="number" value="${poderInstance.idInstitucion}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'notario', 'error')} required">
	<label for="notario">
		<g:message code="poder.notario.label" default="Notario" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="notario" name="notario.id" from="${mx.amib.sistemas.registro.notario.model.Notario.list()}" optionKey="id" required="" value="${poderInstance?.notario?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: poderInstance, field: 'numeroEscritura', 'error')} required">
	<label for="numeroEscritura">
		<g:message code="poder.numeroEscritura.label" default="Numero Escritura" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numeroEscritura" type="number" value="${poderInstance.numeroEscritura}" required=""/>

</div>

