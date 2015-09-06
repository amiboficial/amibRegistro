<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Actualización de la autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Actualización de la autorización</a></li>
	</ul>
	<h2><strong>Actualización de la autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal">
		<div id="divAutBrwParams"></div>
		<div id="divAutBrwRes"></div>
	</form>

	<g:render template="../common/autorizablesBrowsingParams"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.autorizablesBrowsingParamsView.js" />
	<script type="text/javascript">
		var autBrwParamsVM = new app.AutBrwParamsVM();
		var figuras = null;
		var currentVariantesFigura = null;

		figuras = new Array();
		figuras.push( {id:'-1',text:'-Seleccione-',variantesFigura:[{id:'-1',text:'-Seleccione-'}]} );
		<g:each var="x" in="${vm?.figuras.sort{ it.nombre }}">
			currentVariantesFigura = new Array();
			currentVariantesFigura.push({id:'-1',text:'-Seleccione-'});
			<g:each var="y" in="${x?.variantes.sort{ it.nombre }}">
				currentVariantesFigura.push({id:'${y?.id}',text:'${y?.nombre}'});
			</g:each>
			figuras.push( {id:'${x?.id}',text:'${x?.nombre}',variantesFigura:currentVariantesFigura} );
		</g:each>

		autBrwParamsVM.set({ figuras:figuras });
		
		new app.AutBrwParamsView({model:autBrwParamsVM});
	</script>

	<g:render template="../common/autorizablesBrowsingResults"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.autorizablesBrowsingResultsView.js" />
	<script type="text/javascript">
		var autBrwResVMCol = new app.AutBrwResVMCol([
			{grailsId: 1, expanded: false},{grailsId: 2, expanded: true},{grailsId: 3, expanded: false},{grailsId: 4, expanded: true},{grailsId: 5, expanded: false}
		]);
		new app.AutBrwResColView({collection:autBrwResVMCol});
	</script>
</body>
</html>