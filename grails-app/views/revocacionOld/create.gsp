<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Solicitud de revocación</title>
	</head>
	<body>
		<a id="anchorForm"></a>
				
		<!-- INICIA: BREADCRUMB ADMIN -->
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
			<li><a href="#">Nueva revocación</a></li>
		</ul>
		<!-- FIN: BREADCRUMB ADMIN -->
		<h2><strong>Nueva revocación</strong></h2>
		
		<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
			<g:render template="form"/>
		</form>
		<g:render template="formJs"/>
		
	</body>
</html>
