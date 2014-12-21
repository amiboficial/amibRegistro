<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'oficioCNBV.label', default: 'Oficio CNBV')}" />
		<title>Registro 0.1 - Edición de Oficio CNBV</title>
	</head>
	<body>
		<a id="anchorForm"></a>
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="oficioCNBV" action="index" />">Oficios CNBV</a><span class="divider"></span></li>
			<li><a href="#">Edición de Oficio CNBV</a></li>
		</ul>
	
		<h2><strong>Edición de datos de Oficio CNBV</strong></h2>

		<g:form id="frmApp" url="[resource:oficioCNBVInstance, action:'update']" method="PUT" class="form-horizontal" role="form">
			<g:render template="form"/>
		</g:form>
		<g:render template="formJs"/>
		
	</body>
</html>
