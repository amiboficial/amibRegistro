<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Nueva revocacion</title>
</head>
<body>
	<a id="anchorForm"></a>

	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="#">Revocaciones</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	
	<h2><strong>Revocaciones</strong></h2>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevoPoder" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Alta de revocación</button>
	</fieldset>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="revocacion" action="index" />" method="get">
		<div id="divRevocacionIndex">
		</div>
	</form>
	
	<g:render template="index"/>
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.revocacion.index.js" />
	<script type="text/javascript">
		var app = app || {};
		var revocacionIndexView;
		var revocacionSearchVM;
		var gruposFinancieros;
		var institucionesGruposFinancieros;

		gruposFinancieros = new Array();
		gruposFinancieros.push({id:'-1',text:'-Seleccione-', instituciones: [ {id:'-1',text:'-Seleccione-'} ] });
		<g:each var="x" in="${viewModelInstance.gfins}" >
			institucionesGruposFinancieros = new Array();
			institucionesGruposFinancieros.push({id:'-1',text:'-Seleccione-'});
			<g:each var="y" in="${x.instituciones.sort{ it.nombre } }">
				institucionesGruposFinancieros.push({id:'${y.id}',text:'${y.nombre}'});
			</g:each>
			gruposFinancieros.push({id:'${x.id}',text:'${x.nombre}', instituciones:institucionesGruposFinancieros});
		</g:each>
		revocacionSearchVM = new app.RevocacionSearchVM();
		revocacionSearchVM.set({ gruposFinancieros:gruposFinancieros });

		revocacionIndexView = new app.RevocacionIndexView( { 
			searchVM : revocacionSearchVM,
			searchResultVMCollection : new app.RevocacionSearchResultVMCollection()
		} );

	</script>
	
</body>
</html>