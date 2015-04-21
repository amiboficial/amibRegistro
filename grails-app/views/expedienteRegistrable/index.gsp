<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Solicitud de Registro</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Solicitud de Registro</a></li>
	</ul>
	<h2><strong>Solicitud de Registro</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="expedienteRegistrable" action="index" />" method="get">
	
	<fieldset>
		<legend>Búsqueda de autorizables</legend>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#divBusqSimple" aria-controls="divBusqSimple" role="tab" data-toggle="tab">Por matrícula</a></li>
			<li role="presentation"><a href="#divBusqAv" aria-controls="divBusqAv" role="tab" data-toggle="tab">Búsqueda avanzada</a></li>
		</ul>
		<br/>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="divBusqSimple">
				<div id="divSimpMatricula" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.matricula.label" default="Matricula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField name="fltSimpMat" id="txtSimpMatricula" class="form-control" maxlength="10" value="" />
					</div>
				</div>
				<div id="divSimpButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnSimpLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnSimpMostrarTodos" type="button" class="btn btn-default btn-primary">Mostrar todos</button>
						<button id="btnSimpBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divBusqAv">
			
				<div id="divAvNombre" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.nombre.label" default="Nombre" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvNombre" maxlength="80" class="form-control" name="fltAvNombre" value="" />
					</div>
				</div>
				
				<div id="divAvApellido1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.apellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvApellido1" maxlength="100" class="form-control" name="fltAvApellido1" value="" />
					</div>
				</div>
				
				<div id="divAvApellido2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.apellido1.label" default="Segundo apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvApellido2" maxlength="100" class="form-control" name="fltAvApellido2" value="" />
					</div>
				</div>
				
				<div id="divAv" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.figura.label" default="Figura" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fltAvFigura' class="form-control" id="selAvIdFigura" 
						value="${viewModelInstance?.fltAvFigura}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.figuraList}'
						optionKey="id" optionValue="descripcion"></g:select>
					</div>
				</div>
				
				<div id="divAvButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnAvLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnSimpMostrarTodos" type="button" class="btn btn-default btn-primary">Mostrar todos</button>
						<button id="btnAvBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			
			</div>
			
		</div>
		
	</fieldset>
	
	<fieldset>
		<legend>Resultados de búsqueda</legend>
		<div id="list-registrables" class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<g:sortableColumn property="matricula" title="${message(code: 'registrable.matricula.label', default: 'Matrícula')}" />
						<g:sortableColumn property="nombre" title="${message(code: 'registrable.nombre.label', default: 'Nombre')}" />
						<g:sortableColumn property="apellido1" title="${message(code: 'registrable.apellido1.label', default: 'Primer Apellido')}" />
						<g:sortableColumn property="apellido2" title="${message(code: 'registrable.apellido2.label', default: 'Segundo Apellido')}" />
						<th>...</th>
					</tr>
					<tr>
						<td>123456</td>
						<td>Daniel</td>
						<td>López</td>
						<td>Pérez</td>
						<td><button class="btn btn-default btn-xs">Registrar</button></td>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			<div class="pagination">
			</div>
		</div>
	</fieldset>
	
	</form>


</body>
</html>