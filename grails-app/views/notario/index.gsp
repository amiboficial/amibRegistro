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
		<li><a href="#">Gestión de notarios</a></li>
	</ul>
	<ul class="breadcrumb">
		<li><a href="#">Información</a><span class="divider"></span></li>
		<li><a href="#">Catálogo de notarios</a></li>
	</ul>
	
	<h2><strong>Gestión de notarios</strong></h2>
	<h2><strong>Catálogo de notarios</strong></h2>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="notario" action="index" />" method="get">
		<fieldset>
			<legend>Acciones</legend>
			
			<button type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo notario</button>
			<button type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-info-sign"></span> Sugerir cambio</button>
			<button type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-list"></span> Ver sugerencias</button>
			
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
						
							<g:sortableColumn property="idEntidadFederativa" title="${message(code: 'notario.idEntidadFederativa.label', default: 'Entidad Federativa')}" />
							<g:sortableColumn property="numeroNotario" title="${message(code: 'notario.numeroNotario.label', default: 'Num.')}" />
							<g:sortableColumn property="nombre" title="${message(code: 'notario.nombre.label', default: 'Nombre')}" />
							<th>...</th>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${notarioInstanceList}" status="i" var="notarioInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${notarioInstance.id}">${viewModelInstance.entidadesFederativasNombresMap.get(notarioInstance.idEntidadFederativa)}</g:link></td>
							<td>${fieldValue(bean: notarioInstance, field: "numeroNotario")}</td>
							<td>${fieldValue(bean: notarioInstance, field: "nombre")} ${fieldValue(bean: notarioInstance, field: "apellido1")} ${fieldValue(bean: notarioInstance, field: "apellido2")}</td>
							<td>
								<button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${notarioInstanceCount ?: 0}" />
				</div>
			</div>
			
		</fieldset>
		
	</form>
	<script>

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