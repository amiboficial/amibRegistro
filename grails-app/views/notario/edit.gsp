<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
<title>Registro 0.1 - Edición de notario</title>
</head>
<body>
	<a id="anchorForm"></a>
	
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de Catálogos</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="notario" action="index" />">Notarios</a></li>
		<li><a href="#">Editar notario</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Editar notario</strong></h2>

	<g:form id="frmApp" url="[resource:notarioInstance, action:'update']" method="PUT" class="form-horizontal" role="form">
		<g:render template="form"/>
	</g:form>
	<g:render template="formJs"/>
	
</body>
</html>