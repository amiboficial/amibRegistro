<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Pendientes de autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Pendientes de autorización</a></li>
	</ul>
	<h2><strong>Pendientes de autorización</strong></h2>

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
		<div id="divCertPendAut"></div>
	</form>

	<g:render template="certificacionEnvioAutorizacion"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.certificacionEnvioAutorizacion.js" />
	<script type="text/javascript">
		var app = app || {};
		
		var resultsVM = new app.ResultsVM();
		var resultVMCollection = new app.ResultVMCollection();
		
		resultVMCollection.findAllByMatriculaUrl = '<g:createLink action="findAllByMatricula" />';
		resultVMCollection.findAllByIdSustentanteUrl = '<g:createLink action="findAllByIdSustentante" />';
		resultVMCollection.findAllUrl = '<g:createLink action="findAll" />';
		resultVMCollection.sendAllToLoteUrl = '<g:createLink action="sendAllToLote" />';
		resultVMCollection.sendToLoteUrl = '<g:createLink action="sendToLote" />';
		
		var resultVMtest1 = new app.ResultVM();
		var resultVMtest2 = new app.ResultVM();
		var resultVMtest3 = new app.ResultVM();
		resultVMtest1.set('grailsId',1);
		resultVMtest1.set('nombre','Gretel');
		resultVMtest1.set('primerApellido','Montesco');
		resultVMtest1.set('segundoApellido','De la Sierra');
		resultVMtest1.set('idFigura',1);
		resultVMtest1.set('dsFigura','Asesor de estrategías de inversión');
		resultVMtest1.set('idVarianteFigura',1);
		resultVMtest1.set('dsVarianteFigura','Asesor de estrategías de inversión Serie 1008000');
		resultVMtest1.set('yaEnLote',false);
		resultVMtest1.set('viewChecked',false);
		resultVMtest2.set('grailsId',2);
		resultVMtest2.set('nombre','Francisca');
		resultVMtest2.set('primerApellido','Capuleto');
		resultVMtest2.set('segundoApellido','De la Bosque');
		resultVMtest2.set('idFigura',1);
		resultVMtest2.set('dsFigura','Asesor de estrategías de inversión');
		resultVMtest2.set('idVarianteFigura',1);
		resultVMtest2.set('dsVarianteFigura','Asesor de estrategías de inversión Serie 2008000');
		resultVMtest2.set('yaEnLote',false);
		resultVMtest2.set('viewChecked',true);
		resultVMtest3.set('grailsId',3);
		resultVMtest3.set('nombre','Amaranta');
		resultVMtest3.set('primerApellido','Monchurresco');
		resultVMtest3.set('segundoApellido','De la Campo');
		resultVMtest3.set('idFigura',1);
		resultVMtest3.set('dsFigura','Asesor de estrategías de inversión');
		resultVMtest3.set('idVarianteFigura',1);
		resultVMtest3.set('dsVarianteFigura','Asesor de estrategías de inversión Serie 2009000');
		resultVMtest3.set('yaEnLote',true);
		resultVMtest3.set('viewChecked',true);
		resultVMCollection.add(resultVMtest1);
		resultVMCollection.add(resultVMtest2);
		resultVMCollection.add(resultVMtest3);

		var mainViewOptions = { resultsVM:resultsVM , resultVMCollection:resultVMCollection };
		var mainView = new app.CertPendAutMainView(mainViewOptions);
		
	</script>

</body>
</html>