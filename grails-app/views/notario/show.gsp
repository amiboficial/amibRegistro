<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
	<title>Registro 0.1 - Notario</title>
</head>
<body>

<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de catálogos</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="notario" action="index" />">Notarios</a></li>
		<li><a href="#">Datos del Notario</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Datos del Notario</strong></h2>
	
	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevo" type="button" onclick="btnNuevo_click()" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo</button>
		&nbsp;&nbsp;&nbsp;
		<button id="btnEditar" type="button" onclick="btnEditar_click(${notarioInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
		<button id="btnEliminar" type="button" onclick="btnEliminar_click(${notarioInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
	</fieldset>
	
	<fieldset class="form-horizontal">
		<legend>Notario</legend>
	
		<fieldset>
			<legend><i>Datos personales</i></legend>
			
			<div id="divNom" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
			          	<g:message code="notario.nombre.label" default="Nombre" />
				</label>
		          <div class="col-md-9 col-sm-9">
					<p class="form-control-static">${notarioInstance?.nombre}</p>
		          </div>
			</div>
			<div id="divAp1" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.apellido1.label" default="Primer apellido" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${notarioInstance?.apellido1}</p>
				</div>
			</div>
			<div id="divAp2" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.apellido2.label" default="Segundo apellido" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${notarioInstance?.apellido2}</p>
				</div>
			</div>
		</fieldset>
		<fieldset>
			<legend><i>Datos de identificación</i></legend>
			
			<div id="divNotario" class="form-group">
				<div id="divNumNotario">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.numeroNotario.label" default="Número de notaría" />
					</label>
					<div class="col-md-2 col-sm-2">
						<p class="form-control-static">${notarioInstance?.numeroNotario}</p>
					</div>
				</div>
				<div id="divNotarioEntidadFederativa">
					<label class="col-md-3 col-sm-3 control-label">
						<g:message code="notario.entidadFederativa.label" default="Entidad Federativa" />
					</label>
					<div class="col-md-4 col-sm-4">
						<p class="form-control-static">${notarioInstance?.nombreEntidadFederativa}</p>
					</div>
				</div>
			</div>
			
		</fieldset>
		<fieldset>
			<legend><i>Vigencia actual</i></legend>
			
			<div id="divVigencia" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.vigente.label" default="Estatus de vigencia" />						
				</label>
				<div class="col-md-9 col-sm-9">
					<g:if test="${notarioInstance?.vigente}">
						<p class="form-control-static">Vigente</p>
					</g:if>
					<g:else>
						<p class="form-control-static">No vigente</p>
					</g:else>
				</div>
			</div>
			
		</fieldset>
	</fieldset>
	
	<!-- INCIA: SCRIPTS ESPECIFICOS DE VISTA -->
	<script>
	function btnNuevo_click(){
		window.location.href = "<g:createLink controller="notario" action="create" />";
	}
	function btnEditar_click(id){
		window.location.href = "<g:createLink controller="notario" action="edit" />/"+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="notario" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	</script>
	<!-- FIN: SCRIPTS ESPECIFICOS DE VISTA -->
	
</body>
</html>