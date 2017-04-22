
<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio5" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consultaTipoServicio5.label', default: 'ConsultaTipoServicio5')}" />
		<title>Servicio5</title>
	</head>
	<body>
		
		<div id="list-consultaTipoServicio5" class="content scaffold-list" role="main">
			<h1>Solicitudes aprobadas para este proceso</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'consultaTipoServicio5.fechaModificacion.label', default: 'Fecha Dictamen')}" />
					
						<g:sortableColumn property="fechaSolicitud" title="${message(code: 'consultaTipoServicio5.fechaSolicitud.label', default: 'Fecha Solicitud')}" />
					
						<g:sortableColumn property="folioPortal" title="${message(code: 'consultaTipoServicio5.folioPortal.label', default: 'Folio Portal')}" />
					
						<g:sortableColumn property="matricula" title="${message(code: 'consultaTipoServicio5.matricula.label', default: 'Matricula')}" />
					
						<g:sortableColumn property="tipoServicio" title="${message(code: 'consultaTipoServicio5.tipoServicio.label', default: 'Tipo Servicio')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${consultaTipoServicio5InstanceList}" status="i" var="consultaTipoServicio5Instance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: consultaTipoServicio5Instance, field: "fechaModificacion")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio5Instance, field: "fechaSolicitud")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio5Instance, field: "folioPortal")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio5Instance, field: "matricula")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicio5Instance, field: "tipoServicio")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${consultaTipoServicio5InstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
