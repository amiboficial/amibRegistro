<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>

<title>Registro 0.1 - Gestión de notarios</title>

</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de catálogos</a><span class="divider"></span></li>
		<li><a href="#">Notarios</a></li>
	</ul>
	
	<h2><strong>Notarios</strong></h2>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="notario" action="index" />" method="get">
		<fieldset>
			<legend>Acciones</legend>
			
			<button id="btnNuevo" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo notario</button>
			
		</fieldset>
		<fieldset>
			<legend>Búsqueda de notarios</legend>
			
			<div id="divEntidadFederativa" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.entidadFederativa.label" default="Entidad Federativa" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:select id="selNotarioEntidadFederativa" class="form-control" name='filterIdEntidadFederativa' value="${viewModelInstance.filterIdEntidadFederativa}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.entidadesFederativasList}'
						optionKey="id" optionValue="nombre"></g:select>
				</div>
			</div>
			
			<div id="divNombre" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.nombre.label" default="Nombre" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField id="txtNombre" maxlength="80" class="form-control" name="filterNombre" value="${viewModelInstance.filterNombre}" />
				</div>
			</div>
			
			<div id="divApellido1" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.apellido1.label" default="Primer apellido" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField id="txtApellido1" maxlength="100" class="form-control" name="filterApellido1" value="${viewModelInstance.filterApellido1}" />
				</div>
			</div>
			
			<div id="divApellido2" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.apellido1.label" default="Segundo apellido" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField id="txtApellido2" maxlength="100" class="form-control" name="filterApellido2" value="${viewModelInstance.filterApellido2}" />
				</div>
			</div>
			
			<div id="divNumero" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="notario.numero.label" default="Numero" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField id="txtNumero" maxlength="80" class="form-control" name="filterNumero" value="${viewModelInstance.filterNumero}" />
				</div>
			</div>
			
			<div id="divButtonArea" class="form-group">
				<div class="col-md-3 col-sm-3">
					&nbsp;
				</div>
				<div class="col-md-6 col-sm-6" style="text-align: center">
					<button id="btnLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
					<button id="btnBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
				</div>
				<div class="col-md-3 col-sm-3">
					&nbsp;
				</div>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend>Resultados de búsqueda</legend>
			
			<div id="list-notario" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table class="table">
				<thead>
						<tr>
						
							<g:sortableColumn property="idEntidadFederativa" title="${message(code: 'notario.idEntidadFederativa.label', default: 'Entidad Federativa')}" params="[filterIdEntidadFederativa:viewModelInstance.filterIdEntidadFederativa, filterNumero:viewModelInstance.filterNumero, filterNombre:viewModelInstance.filterNombre, filterApellido1:viewModelInstance.filterApellido1,filterApellido2:viewModelInstance.filterApellido2]"/>
							<g:sortableColumn property="numeroNotario" title="${message(code: 'notario.numeroNotario.label', default: 'Num.')}" params="[filterIdEntidadFederativa:viewModelInstance.filterIdEntidadFederativa, filterNumero:viewModelInstance.filterNumero, filterNombre:viewModelInstance.filterNombre, filterApellido1:viewModelInstance.filterApellido1,filterApellido2:viewModelInstance.filterApellido2]"/>
							<g:sortableColumn property="nombre" title="${message(code: 'notario.nombre.label', default: 'Nombre')}" params="[filterIdEntidadFederativa:viewModelInstance.filterIdEntidadFederativa, filterNumero:viewModelInstance.filterNumero, filterNombre:viewModelInstance.filterNombre, filterApellido1:viewModelInstance.filterApellido1,filterApellido2:viewModelInstance.filterApellido2]"/>
							<th>Vigente</th>
							<th>...</th>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${notarioInstanceList}" status="i" var="notarioInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td>${viewModelInstance.entidadesFederativasNombresMap.get(notarioInstance.idEntidadFederativa)}</td>
							<td>${fieldValue(bean: notarioInstance, field: "numeroNotario")}</td>
							<td>${fieldValue(bean: notarioInstance, field: "nombre")} ${fieldValue(bean: notarioInstance, field: "apellido1")} ${fieldValue(bean: notarioInstance, field: "apellido2")}</td>
							<td>
								<g:if test="${notarioInstance.vigente == true}">
									<span class="glyphicon glyphicon-ok"></span>
								</g:if>
							</td>
							<td>
								<button id="btnVer" onclick="btnVer_click(${notarioInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								<button id="btnEditar" onclick="btnEditar_click(${notarioInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${notarioInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${notarioInstanceCount ?: 0}" params="[filterIdEntidadFederativa:viewModelInstance.filterIdEntidadFederativa, filterNumero:viewModelInstance.filterNumero, filterNombre:viewModelInstance.filterNombre, filterApellido1:viewModelInstance.filterApellido1,filterApellido2:viewModelInstance.filterApellido2]"/>
				</div>
			</div>
			
		</fieldset>
		
	</form>
	<script>

	//callbacks para botones en lista
	function btnVer_click(id){
		window.location.href = '<g:createLink controller="notario" action="show" />/'+id;
	}
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="notario" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="notario" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	//callbacks para barra de acciones
	$( "#btnNuevo" ).click(function() {
		window.location.href = '<g:createLink controller="notario" action="create" />'
	});
	
	$( "#btnLimpiar" ).click(function() {
		$( "#selNotarioEntidadFederativa" ).val('-1');
		$( "#txtNombre" ).val('');
		$( "#txtApellido1" ).val('');
		$( "#txtApellido2" ).val('');
		$( "#txtNumero" ).val('');
	});
	//callback al boton para submitear
	$( "#btnBuscar" ).click(function() {
		$( "#frmApp" ).submit();
	});
	
	</script>
</body>
</html>