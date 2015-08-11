<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Lote de envío a autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="certificacionEnvioAutorizacion" action="index" />">Pendientes de autorización</a></li>
		<li><a href="#">Lote de envío a autorización</a></li>
	</ul>
	<h2><strong>Lote de envío a autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form">
		<div id="divLoteEnvAut"></div>
	</form>

	<g:render template="loteEnvioAutorizacion"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.loteEnvioAutorizacion.js" />
	<script type="text/javascript">

	var app = app || {};

	var leaview = new app.LoteEnvioAutorizacionMainView({
		getAllCompleteResultUrl: '<g:createLink controller="loteEnvioAutorizacion" action="getAllCompleteResult" />',
		removeUrl: '<g:createLink controller="loteEnvioAutorizacion" action="remove" />',
		removeAllUrl: '<g:createLink controller="loteEnvioAutorizacion" action="removeAll" />'
	});

	</script>
</body>
</html>