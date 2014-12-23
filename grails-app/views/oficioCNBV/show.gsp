<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'oficioCNBV.label', default: 'OficioCNBV')}" />
	<title>Registro 0.1 - Datos del Oficio CNBV</title>
</head>
<body>

	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="oficioCNBV" action="index" />">Oficios CNBV</a></li>
		<li><a href="#">Datos del Oficio CNBV</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Datos del Oficio CNBV</strong></h2>

	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevo" type="button" onclick="btnNuevo_click()" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo</button>
		&nbsp;&nbsp;&nbsp;
		<button id="btnEditar" type="button" onclick="btnEditar_click(${oficioCNBVInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
		<button id="btnEliminar" type="button" onclick="btnEliminar_click(${oficioCNBVInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
	</fieldset>

	<fieldset class="form-horizontal">
		<legend>Oficio CNBV</legend>
		
		<fieldset>
			<legend><i>Datos del oficio</i></legend>
			<div id="divClaveDga" class="form-group">
				<label class="col-md-3 col-sm-4 control-label">
	            	<g:message code="oficioCNBV.claveDga.label" default="Clave DGA" />
				</label>
				<div class="col-md-4 col-sm-4">
					<p class="form-control-static">${oficioCNBVInstance?.claveDga}</p>
	            </div>
			</div>
			<div id="divFechaFinVigencia" class="form-group">
				<label class="col-md-3 col-sm-4 control-label">
	            	<g:message code="oficioCNBV.fechaFinVigencia.label" default="Fecha de fin de vigencia" /><span class="required-indicator">*</span>
				</label>
				<div class="col-md-4 col-sm-8">
					<p class="form-control-static">${oficioCNBVInstance?.fechaFinVigencia}<p/>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><i>Datos de autorizados</i></legend>
			
			<table class="table">
				<thead>
					<tr>
						<th style='width:20%;'>Matrícula</th>
						<th>Nombre completo</th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${oficioCNBVInstance?.autorizadosCNBV}">
						<tr>
							<td>${it.numeroMatricula}</td>
							<td>${it.nombreCompleto}</td>
						</tr>
					</g:each>
				</tbody>
			</table>
			
		</fieldset>
		
	</fieldset>
	
	<!-- INCIA: SCRIPTS ESPECIFICOS DE VISTA -->
	<script>
	function btnNuevo_click(){
		window.location.href = "<g:createLink controller="oficioCNBV" action="create" />";
	}
	function btnEditar_click(id){
		window.location.href = "<g:createLink controller="oficioCNBV" action="edit" />/"+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="oficioCNBV" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	</script>
	<!-- FIN: SCRIPTS ESPECIFICOS DE VISTA -->
	
</body>
</html>