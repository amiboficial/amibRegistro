<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Gestión de oficios de autorización</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="#">Oficios de Autorización (CNBV)</a></li>
	</ul>
	<h2><strong>Oficios de Autorización (CNBV)</strong></h2>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form">
		<div id="divOficioCnbvIndexView"></div>
	</form>
	
	<g:render template="oficioCnbvIndex"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.form.index.js" />
	<script type="text/javascript">
		var app = app || {};
		
		var resultVMCollection = new app.OficioCnbvResultVMCollection();
		resultVMCollection.findAllByNumeroOficioUrl= '<g:createLink action="findAllByNumeroOficio" />';
		resultVMCollection.findAllByClaveDgaUrl= '<g:createLink action="findAllByClaveDga" />';
		resultVMCollection.findAllByFechaOficioUrl= '<g:createLink action="findAllByFechaOficio" />';
		resultVMCollection.findAllByNumeroMatriculaUrl= '<g:createLink action="findAllByNumeroMatricula" />';
		resultVMCollection.findAllByIdSustentanteUrl= '<g:createLink action="findAllByIdSustentante" />';
		resultVMCollection.findAllByNombreApellidosUrl= '<g:createLink action="findAllByNombreApellidos" />';
		
		var mainView = new app.OficioCnbvIndexView({
			resultVMCollection: resultVMCollection,
			createUrl : '<g:createLink action="create" />',
			showUrl : '<g:createLink action="show" />',
			editionUrl : '<g:createLink action="edit" />'
		});
	</script>
	
</body>
</html>