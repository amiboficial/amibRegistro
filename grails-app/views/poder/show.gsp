
<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-poder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-poder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list poder">
			
				<g:if test="${poderInstance?.representanteLegalNombre}">
				<li class="fieldcontain">
					<span id="representanteLegalNombre-label" class="property-label"><g:message code="poder.representanteLegalNombre.label" default="Representante Legal Nombre" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalNombre-label"><g:fieldValue bean="${poderInstance}" field="representanteLegalNombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.representanteLegalApellido1}">
				<li class="fieldcontain">
					<span id="representanteLegalApellido1-label" class="property-label"><g:message code="poder.representanteLegalApellido1.label" default="Representante Legal Apellido1" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalApellido1-label"><g:fieldValue bean="${poderInstance}" field="representanteLegalApellido1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.representanteLegalApellido2}">
				<li class="fieldcontain">
					<span id="representanteLegalApellido2-label" class="property-label"><g:message code="poder.representanteLegalApellido2.label" default="Representante Legal Apellido2" /></span>
					
						<span class="property-value" aria-labelledby="representanteLegalApellido2-label"><g:fieldValue bean="${poderInstance}" field="representanteLegalApellido2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.fechaCreacion}">
				<li class="fieldcontain">
					<span id="fechaCreacion-label" class="property-label"><g:message code="poder.fechaCreacion.label" default="Fecha Creacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaCreacion-label"><g:formatDate date="${poderInstance?.fechaCreacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.fechaModificacion}">
				<li class="fieldcontain">
					<span id="fechaModificacion-label" class="property-label"><g:message code="poder.fechaModificacion.label" default="Fecha Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaModificacion-label"><g:formatDate date="${poderInstance?.fechaModificacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.apoderados}">
				<li class="fieldcontain">
					<span id="apoderados-label" class="property-label"><g:message code="poder.apoderados.label" default="Apoderados" /></span>
					
						<g:each in="${poderInstance.apoderados}" var="a">
						<span class="property-value" aria-labelledby="apoderados-label"><g:link controller="apoderado" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.documentosRespaldoPoder}">
				<li class="fieldcontain">
					<span id="documentosRespaldoPoder-label" class="property-label"><g:message code="poder.documentosRespaldoPoder.label" default="Documentos Respaldo Poder" /></span>
					
						<g:each in="${poderInstance.documentosRespaldoPoder}" var="d">
						<span class="property-value" aria-labelledby="documentosRespaldoPoder-label"><g:link controller="documentoRespaldoPoder" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.esRegistradoPorGrupoFinanciero}">
				<li class="fieldcontain">
					<span id="esRegistradoPorGrupoFinanciero-label" class="property-label"><g:message code="poder.esRegistradoPorGrupoFinanciero.label" default="Es Registrado Por Grupo Financiero" /></span>
					
						<span class="property-value" aria-labelledby="esRegistradoPorGrupoFinanciero-label"><g:formatBoolean boolean="${poderInstance?.esRegistradoPorGrupoFinanciero}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.fechaApoderamiento}">
				<li class="fieldcontain">
					<span id="fechaApoderamiento-label" class="property-label"><g:message code="poder.fechaApoderamiento.label" default="Fecha Apoderamiento" /></span>
					
						<span class="property-value" aria-labelledby="fechaApoderamiento-label"><g:formatDate date="${poderInstance?.fechaApoderamiento}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.idGrupofinanciero}">
				<li class="fieldcontain">
					<span id="idGrupofinanciero-label" class="property-label"><g:message code="poder.idGrupofinanciero.label" default="Id Grupofinanciero" /></span>
					
						<span class="property-value" aria-labelledby="idGrupofinanciero-label"><g:fieldValue bean="${poderInstance}" field="idGrupofinanciero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.idInstitucion}">
				<li class="fieldcontain">
					<span id="idInstitucion-label" class="property-label"><g:message code="poder.idInstitucion.label" default="Id Institucion" /></span>
					
						<span class="property-value" aria-labelledby="idInstitucion-label"><g:fieldValue bean="${poderInstance}" field="idInstitucion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.notario}">
				<li class="fieldcontain">
					<span id="notario-label" class="property-label"><g:message code="poder.notario.label" default="Notario" /></span>
					
						<span class="property-value" aria-labelledby="notario-label"><g:link controller="notario" action="show" id="${poderInstance?.notario?.id}">${poderInstance?.notario?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${poderInstance?.numeroEscritura}">
				<li class="fieldcontain">
					<span id="numeroEscritura-label" class="property-label"><g:message code="poder.numeroEscritura.label" default="Numero Escritura" /></span>
					
						<span class="property-value" aria-labelledby="numeroEscritura-label"><g:fieldValue bean="${poderInstance}" field="numeroEscritura"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:poderInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${poderInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
