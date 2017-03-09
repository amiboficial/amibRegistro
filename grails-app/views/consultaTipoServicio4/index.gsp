
<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio4" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consultaTipoServicio4.label', default: 'ConsultaTipoServicio4')}" />
		<title>Servicio 4</title>
	</head>
	<body>
		
		<div id="list-consultaTipoServicio4" class="content scaffold-list" role="main">
			<h1>Solicitudes aprobadas para este servicio</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'consultaTipoServicio4.fechaModificacion.label', default: 'Fecha Dictamen')}" />
					
						<g:sortableColumn property="fechaSolicitud" title="${message(code: 'consultaTipoServicio4.fechaSolicitud.label', default: 'Fecha Solicitud')}" />
					
						<g:sortableColumn property="folioPortal" title="${message(code: 'consultaTipoServicio4.folioPortal.label', default: 'Folio Portal')}" />
					
						<g:sortableColumn property="matricula" title="${message(code: 'consultaTipoServicio4.matricula.label', default: 'Matricula')}" />
					
						<g:sortableColumn property="tipoServicio" title="${message(code: 'consultaTipoServicio4.tipoServicio.label', default: 'Tipo Servicio')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${consultaTipoServicio4InstanceList}" status="i" var="consultaTipoServicio4Instance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: consultaTipoServicio4Instance, field: "fechaModificacion")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio4Instance, field: "fechaSolicitud")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio4Instance, field: "folioPortal")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio4Instance, field: "matricula")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio4Instance, field: "tipoServicio")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${consultaTipoServicio4InstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
