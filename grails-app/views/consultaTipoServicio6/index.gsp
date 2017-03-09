
<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio6" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consultaTipoServicio6.label', default: 'ConsultaTipoServicio6')}" />
		<title>Servicio 6</title>
	</head>
	<body>
		
		<div id="list-consultaTipoServicio6" class="content scaffold-list" role="main">
			<h1>Solicitudes aprobadas para este proceso</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'consultaTipoServicio6.fechaModificacion.label', default: 'Fecha Dictamen')}" />
					
						<g:sortableColumn property="fechaSolicitud" title="${message(code: 'consultaTipoServicio6.fechaSolicitud.label', default: 'Fecha Solicitud')}" />
					
						<g:sortableColumn property="folioPortal" title="${message(code: 'consultaTipoServicio6.folioPortal.label', default: 'Folio Portal')}" />
					
						<g:sortableColumn property="matricula" title="${message(code: 'consultaTipoServicio6.matricula.label', default: 'Matricula')}" />
					
						<g:sortableColumn property="tipoServicio" title="${message(code: 'consultaTipoServicio6.tipoServicio.label', default: 'Tipo Servicio')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${consultaTipoServicio6InstanceList}" status="i" var="consultaTipoServicio6Instance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: consultaTipoServicio6Instance, field: "fechaModificacion")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio6Instance, field: "fechaSolicitud")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio6Instance, field: "folioPortal")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio6Instance, field: "matricula")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio6Instance, field: "tipoServicio")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${consultaTipoServicio6InstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
