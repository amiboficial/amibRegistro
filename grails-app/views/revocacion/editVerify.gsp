<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'revocacion.label', default: 'Revocación')}" />
		<title>Registro 0.1 - Revisión de revocación</title>
	</head>
	<body>
		<a id="anchorForm"></a>
		<!-- INICIA: BREADCRUMB ADMIN -->
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
			<li><a href="#">Revisar revocación</a></li>
		</ul>
		<!-- FIN: BREADCRUMB ADMIN -->
	
		<h2><strong>Revisión de revocación</strong></h2>

		<g:form id="frmApp" url="[resource:revocacionInstance, action:'update']" method="PUT" class="form-horizontal" role="form">
			<g:render template="form"/>
		</g:form>
		<g:render template="formJs"/>
		
	</body>
</html>
