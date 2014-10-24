
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Revocacion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'revocacion.label', default: 'Revocacion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-revocacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-revocacion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list revocacion">
			
				<g:if test="${revocacionInstance?.representanteLegalNombre}">
				<li class="fieldcontain">
					<span id="representanteLegalNombre-label" class="property-label"><g:message code="revocacion.representanteLegalNombre.label" default="Representante Legal Nombre" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalNombre-label"><g:fieldValue bean="${revocacionInstance}" field="representanteLegalNombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.representanteLegalApellido1}">
				<li class="fieldcontain">
					<span id="representanteLegalApellido1-label" class="property-label"><g:message code="revocacion.representanteLegalApellido1.label" default="Representante Legal Apellido1" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalApellido1-label"><g:fieldValue bean="${revocacionInstance}" field="representanteLegalApellido1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.representanteLegalApellido2}">
				<li class="fieldcontain">
					<span id="representanteLegalApellido2-label" class="property-label"><g:message code="revocacion.representanteLegalApellido2.label" default="Representante Legal Apellido2" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalApellido2-label"><g:fieldValue bean="${revocacionInstance}" field="representanteLegalApellido2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.fechaCreacion}">
				<li class="fieldcontain">
					<span id="fechaCreacion-label" class="property-label"><g:message code="revocacion.fechaCreacion.label" default="Fecha Creacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaCreacion-label"><g:formatDate date="${revocacionInstance?.fechaCreacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.fechaModificacion}">
				<li class="fieldcontain">
					<span id="fechaModificacion-label" class="property-label"><g:message code="revocacion.fechaModificacion.label" default="Fecha Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaModificacion-label"><g:formatDate date="${revocacionInstance?.fechaModificacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.documentosRespaldoRevocacion}">
				<li class="fieldcontain">
					<span id="documentosRespaldoRevocacion-label" class="property-label"><g:message code="revocacion.documentosRespaldoRevocacion.label" default="Documentos Respaldo Revocacion" /></span>
					
						<g:each in="${revocacionInstance.documentosRespaldoRevocacion}" var="d">
						<span class="property-value" aria-labelledby="documentosRespaldoRevocacion-label"><g:link controller="documentoRespaldoRevocacion" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.esRegistradoPorGrupoFinanciero}">
				<li class="fieldcontain">
					<span id="esRegistradoPorGrupoFinanciero-label" class="property-label"><g:message code="revocacion.esRegistradoPorGrupoFinanciero.label" default="Es Registrado Por Grupo Financiero" /></span>
					
						<span class="property-value" aria-labelledby="esRegistradoPorGrupoFinanciero-label"><g:formatBoolean boolean="${revocacionInstance?.esRegistradoPorGrupoFinanciero}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.fechaApoderamiento}">
				<li class="fieldcontain">
					<span id="fechaApoderamiento-label" class="property-label"><g:message code="revocacion.fechaApoderamiento.label" default="Fecha Apoderamiento" /></span>
					
						<span class="property-value" aria-labelledby="fechaApoderamiento-label"><g:formatDate date="${revocacionInstance?.fechaApoderamiento}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.idGrupofinanciero}">
				<li class="fieldcontain">
					<span id="idGrupofinanciero-label" class="property-label"><g:message code="revocacion.idGrupofinanciero.label" default="Id Grupofinanciero" /></span>
					
						<span class="property-value" aria-labelledby="idGrupofinanciero-label"><g:fieldValue bean="${revocacionInstance}" field="idGrupofinanciero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.idInstitucion}">
				<li class="fieldcontain">
					<span id="idInstitucion-label" class="property-label"><g:message code="revocacion.idInstitucion.label" default="Id Institucion" /></span>
					
						<span class="property-value" aria-labelledby="idInstitucion-label"><g:fieldValue bean="${revocacionInstance}" field="idInstitucion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.notario}">
				<li class="fieldcontain">
					<span id="notario-label" class="property-label"><g:message code="revocacion.notario.label" default="Notario" /></span>
					
						<span class="property-value" aria-labelledby="notario-label"><g:link controller="notario" action="show" id="${revocacionInstance?.notario?.id}">${revocacionInstance?.notario?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.numeroEscritura}">
				<li class="fieldcontain">
					<span id="numeroEscritura-label" class="property-label"><g:message code="revocacion.numeroEscritura.label" default="Numero Escritura" /></span>
					
						<span class="property-value" aria-labelledby="numeroEscritura-label"><g:fieldValue bean="${revocacionInstance}" field="numeroEscritura"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${revocacionInstance?.revocados}">
				<li class="fieldcontain">
					<span id="revocados-label" class="property-label"><g:message code="revocacion.revocados.label" default="Revocados" /></span>
					
						<g:each in="${revocacionInstance.revocados}" var="r">
						<span class="property-value" aria-labelledby="revocados-label"><g:link controller="revocado" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:revocacionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${revocacionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
