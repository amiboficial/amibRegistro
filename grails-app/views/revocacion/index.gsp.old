
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Revocacion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'revocacion.label', default: 'Revocacion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-revocacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-revocacion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="representanteLegalNombre" title="${message(code: 'revocacion.representanteLegalNombre.label', default: 'Representante Legal Nombre')}" />
					
						<g:sortableColumn property="representanteLegalApellido1" title="${message(code: 'revocacion.representanteLegalApellido1.label', default: 'Representante Legal Apellido1')}" />
					
						<g:sortableColumn property="representanteLegalApellido2" title="${message(code: 'revocacion.representanteLegalApellido2.label', default: 'Representante Legal Apellido2')}" />
					
						<g:sortableColumn property="fechaCreacion" title="${message(code: 'revocacion.fechaCreacion.label', default: 'Fecha Creacion')}" />
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'revocacion.fechaModificacion.label', default: 'Fecha Modificacion')}" />
					
						<g:sortableColumn property="esRegistradoPorGrupoFinanciero" title="${message(code: 'revocacion.esRegistradoPorGrupoFinanciero.label', default: 'Es Registrado Por Grupo Financiero')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${revocacionInstanceList}" status="i" var="revocacionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${revocacionInstance.id}">${fieldValue(bean: revocacionInstance, field: "representanteLegalNombre")}</g:link></td>
					
						<td>${fieldValue(bean: revocacionInstance, field: "representanteLegalApellido1")}</td>
					
						<td>${fieldValue(bean: revocacionInstance, field: "representanteLegalApellido2")}</td>
					
						<td><g:formatDate date="${revocacionInstance.fechaCreacion}" /></td>
					
						<td><g:formatDate date="${revocacionInstance.fechaModificacion}" /></td>
					
						<td><g:formatBoolean boolean="${revocacionInstance.esRegistradoPorGrupoFinanciero}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${revocacionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
