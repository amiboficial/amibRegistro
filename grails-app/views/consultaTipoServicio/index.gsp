
<%@ page import="mx.amib.sistemas.registro.portal.model.ConsultaTipoServicio" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consultaTipoServicio.label', default: 'ConsultaTipoServicio')}" />
		<title>Servicio 3 </title>
	</head>
	<body>
		
		<div id="list-consultaTipoServicio" class="content scaffold-list" role="main">
			<h1>Solicitudes aprobadas para este proceso</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="fechaModificacion" title="${message(code: 'consultaTipoServicio.fechaModificacion.label', default: 'Fecha Dictamen')}" />
					<br>
						<g:sortableColumn property="fechaSolicitud" title="${message(code: 'consultaTipoServicio.fechaSolicitud.label', default: 'Fecha Solicitud')}" />
					
						<g:sortableColumn property="folioPortal" title="${message(code: 'consultaTipoServicio.folioPörtal.label', default: 'Folio Portal')}" />
					
						<g:sortableColumn property="matricula" title="${message(code: 'consultaTipoServicio.matricula.label', default: 'Matricula')}" />
					
						<g:sortableColumn property="tipoServicio" title="${message(code: 'consultaTipoServicio.tipoServicio.label', default: 'Tipo Servicio')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${consultaTipoServicioInstanceList}" status="i" var="consultaTipoServicioInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: consultaTipoServicioInstance, field: "fechaModificacion")}</td>
					<br>
						<td>${fieldValue(bean: consultaTipoServicioInstance, field: "fechaSolicitud")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicioInstance, field: "folioPortal")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicioInstance, field: "matricula")}</td>
					
						<td>${fieldValue(bean: consultaTipoServicioInstance, field: "tipoServicio")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${consultaTipoServicioInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
