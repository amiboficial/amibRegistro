
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>
<%@ page import="mx.amib.sistemas.registro.apoderamiento.controller.PoderController" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-poder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-poder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="representanteLegalNombre" title="${message(code: 'poder.representanteLegalNombre.label', default: 'Representante Legal Nombre')}" />
					
						<g:sortableColumn property="representanteLegalApellido1" title="${message(code: 'poder.representanteLegalApellido1.label', default: 'Representante Legal Apellido1')}" />
					
						<g:sortableColumn property="representanteLegalApellido2" title="${message(code: 'poder.representanteLegalApellido2.label', default: 'Representante Legal Apellido2')}" />
					
						<g:sortableColumn property="fechaCreacion" title="${message(code: 'poder.fechaCreacion.label', default: 'Fecha Creacion')}" />
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'poder.fechaModificacion.label', default: 'Fecha Modificacion')}" />
					
						<g:sortableColumn property="esRegistradoPorGrupoFinanciero" title="${message(code: 'poder.esRegistradoPorGrupoFinanciero.label', default: 'Es Registrado Por Grupo Financiero')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${poderInstanceList}" status="i" var="poderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${poderInstance.id}">${fieldValue(bean: poderInstance, field: "representanteLegalNombre")}</g:link></td>
					
						<td>${fieldValue(bean: poderInstance, field: "representanteLegalApellido1")}</td>
					
						<td>${fieldValue(bean: poderInstance, field: "representanteLegalApellido2")}</td>
					
						<td><g:formatDate date="${poderInstance.fechaCreacion}" /></td>
					
						<td><g:formatDate date="${poderInstance.fechaModificacion}" /></td>
					
						<td><g:formatBoolean boolean="${poderInstance.esRegistradoPorGrupoFinanciero}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${poderInstanceCount?:0}" />
			</div>
		</div>
	</body>
</html>
