<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Edición de poder</title>
	</head>
	<body>
		<a id="anchorForm"></a>
	
		<!-- INICIA: BREADCRUMB ADMIN -->
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="poder" action="index" />">Poderes</a></li>
			<li><a href="#">Editar poder</a></li>
		</ul>
		<!-- FIN: BREADCRUMB ADMIN -->
	
		<h2><strong>Editar poder</strong></h2>

		<g:form id="frmApp" url="[resource:poderInstance, action:'update']" method="PUT" class="form-horizontal" role="form">
			<g:render template="form"/>
		</g:form>
		<g:render template="formJs"/>
		
	</body>
</html>
