<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
<title>Registro 0.1 - Nuevo notario</title>
</head>
<body>
	<a id="anchorForm"></a>
	
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de Catálogos</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="notario" action="index" />">Notarios</a></li>
		<li><a href="#">Nuevo notario</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Nuevo notario</strong></h2>

	<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
		<g:render template="form"/>
	</form>
	<g:render template="formJs"/>
	
</body>
</html>