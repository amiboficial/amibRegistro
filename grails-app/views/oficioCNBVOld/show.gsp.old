
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'oficioCNBV.label', default: 'OficioCNBV')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-oficioCNBV" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-oficioCNBV" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list oficioCNBV">
			
				<g:if test="${oficioCNBVInstance?.claveDga}">
				<li class="fieldcontain">
					<span id="claveDga-label" class="property-label"><g:message code="oficioCNBV.claveDga.label" default="Clave Dga" /></span>
					
						<span class="property-value" aria-labelledby="claveDga-label"><g:fieldValue bean="${oficioCNBVInstance}" field="claveDga"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${oficioCNBVInstance?.autorizadosCNBV}">
				<li class="fieldcontain">
					<span id="autorizadosCNBV-label" class="property-label"><g:message code="oficioCNBV.autorizadosCNBV.label" default="Autorizados CNBV" /></span>
					
						<g:each in="${oficioCNBVInstance.autorizadosCNBV}" var="a">
						<span class="property-value" aria-labelledby="autorizadosCNBV-label"><g:link controller="autorizadoCNBV" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${oficioCNBVInstance?.fechaCreacion}">
				<li class="fieldcontain">
					<span id="fechaCreacion-label" class="property-label"><g:message code="oficioCNBV.fechaCreacion.label" default="Fecha Creacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaCreacion-label"><g:formatDate date="${oficioCNBVInstance?.fechaCreacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${oficioCNBVInstance?.fechaFinVigencia}">
				<li class="fieldcontain">
					<span id="fechaFinVigencia-label" class="property-label"><g:message code="oficioCNBV.fechaFinVigencia.label" default="Fecha Fin Vigencia" /></span>
					
						<span class="property-value" aria-labelledby="fechaFinVigencia-label"><g:formatDate date="${oficioCNBVInstance?.fechaFinVigencia}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${oficioCNBVInstance?.fechaModificacion}">
				<li class="fieldcontain">
					<span id="fechaModificacion-label" class="property-label"><g:message code="oficioCNBV.fechaModificacion.label" default="Fecha Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaModificacion-label"><g:formatDate date="${oficioCNBVInstance?.fechaModificacion}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:oficioCNBVInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${oficioCNBVInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
