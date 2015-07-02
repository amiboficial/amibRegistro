
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'oficioCNBV.label', default: 'OficioCNBV')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-oficioCNBV" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-oficioCNBV" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="claveDga" title="${message(code: 'oficioCNBV.claveDga.label', default: 'Clave Dga')}" />
					
						<g:sortableColumn property="fechaCreacion" title="${message(code: 'oficioCNBV.fechaCreacion.label', default: 'Fecha Creacion')}" />
					
						<g:sortableColumn property="fechaFinVigencia" title="${message(code: 'oficioCNBV.fechaFinVigencia.label', default: 'Fecha Fin Vigencia')}" />
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'oficioCNBV.fechaModificacion.label', default: 'Fecha Modificacion')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${oficioCNBVInstanceList}" status="i" var="oficioCNBVInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${oficioCNBVInstance.id}">${fieldValue(bean: oficioCNBVInstance, field: "claveDga")}</g:link></td>
					
						<td><g:formatDate date="${oficioCNBVInstance.fechaCreacion}" /></td>
					
						<td><g:formatDate date="${oficioCNBVInstance.fechaFinVigencia}" /></td>
					
						<td><g:formatDate date="${oficioCNBVInstance.fechaModificacion}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${oficioCNBVInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
