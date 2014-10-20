<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Alta de poder</title>
	</head>
	<body>
		<a id="anchorForm"></a>
		<ul class="breadcrumb">
			<li><a href="#">Servicios</a><span class="divider"></span></li>
			<li><a href="#">Alta de poder</a></li>
		</ul>
	
		<h2><strong>Alta de poder</strong></h2>

		<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
			<g:render template="form"/>
		</form>
		<g:render template="formJs"/>
		
	</body>
</html>
