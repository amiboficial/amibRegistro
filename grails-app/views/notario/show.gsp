
<%@ page import="mx.amib.sistemas.registro.notario.model.Notario" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-notario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-notario" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list notario">
			
				<g:if test="${notarioInstance?.idEntidadFederativa}">
				<li class="fieldcontain">
					<span id="idEntidadFederativa-label" class="property-label"><g:message code="notario.idEntidadFederativa.label" default="Id Entidad Federativa" /></span>
					
						<span class="property-value" aria-labelledby="idEntidadFederativa-label"><g:fieldValue bean="${notarioInstance}" field="idEntidadFederativa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="notario.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${notarioInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.apellido1}">
				<li class="fieldcontain">
					<span id="apellido1-label" class="property-label"><g:message code="notario.apellido1.label" default="Apellido1" /></span>
					
						<span class="property-value" aria-labelledby="apellido1-label"><g:fieldValue bean="${notarioInstance}" field="apellido1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.apellido2}">
				<li class="fieldcontain">
					<span id="apellido2-label" class="property-label"><g:message code="notario.apellido2.label" default="Apellido2" /></span>
					
						<span class="property-value" aria-labelledby="apellido2-label"><g:fieldValue bean="${notarioInstance}" field="apellido2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.fechaCreacion}">
				<li class="fieldcontain">
					<span id="fechaCreacion-label" class="property-label"><g:message code="notario.fechaCreacion.label" default="Fecha Creacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaCreacion-label"><g:formatDate date="${notarioInstance?.fechaCreacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.fechaModificacion}">
				<li class="fieldcontain">
					<span id="fechaModificacion-label" class="property-label"><g:message code="notario.fechaModificacion.label" default="Fecha Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaModificacion-label"><g:formatDate date="${notarioInstance?.fechaModificacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.numeroNotario}">
				<li class="fieldcontain">
					<span id="numeroNotario-label" class="property-label"><g:message code="notario.numeroNotario.label" default="Numero Notario" /></span>
					
						<span class="property-value" aria-labelledby="numeroNotario-label"><g:fieldValue bean="${notarioInstance}" field="numeroNotario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.poderes}">
				<li class="fieldcontain">
					<span id="poderes-label" class="property-label"><g:message code="notario.poderes.label" default="Poderes" /></span>
					
						<g:each in="${notarioInstance.poderes}" var="p">
						<span class="property-value" aria-labelledby="poderes-label"><g:link controller="poder" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.revocaciones}">
				<li class="fieldcontain">
					<span id="revocaciones-label" class="property-label"><g:message code="notario.revocaciones.label" default="Revocaciones" /></span>
					
						<g:each in="${notarioInstance.revocaciones}" var="r">
						<span class="property-value" aria-labelledby="revocaciones-label"><g:link controller="revocacion" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.seqNotario}">
				<li class="fieldcontain">
					<span id="seqNotario-label" class="property-label"><g:message code="notario.seqNotario.label" default="Seq Notario" /></span>
					
						<span class="property-value" aria-labelledby="seqNotario-label"><g:fieldValue bean="${notarioInstance}" field="seqNotario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${notarioInstance?.vigente}">
				<li class="fieldcontain">
					<span id="vigente-label" class="property-label"><g:message code="notario.vigente.label" default="Vigente" /></span>
					
						<span class="property-value" aria-labelledby="vigente-label"><g:formatBoolean boolean="${notarioInstance?.vigente}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:notarioInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${notarioInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
