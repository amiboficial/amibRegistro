<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Gestión de poderes</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="#">Poderes</a></li>
	</ul>
	<h2><strong>Poderes</strong></h2>
	<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Mensaje de algo satisfactorio</div>
	<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Mensaje de algo erroneo</div>
	
	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevoPoder" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo poder</button>
	</fieldset>
	
	<fieldset class="form-horizontal" role="form">
		<legend>Búsqueda de poderes</legend>
		<div id="divBusquedaPoderes">
			
			<div id="divNumEscritura" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.numeroEscritura.label" default="Número de escritura" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField name="fltNumEsc" id="txtNumEscritura" maxlength="10" class="form-control" value="" />
				</div>
			</div>
			<div id="divFhApodInicio" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoInicio.label" default="Fecha de aporderamiento (del)" />	
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="fltFecIni" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			<div id="divFhApodFin" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoFin.label" default="Fecha de aporderamiento (al)" />
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="fltFecFn" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			<div id="divAdmGrupoFinanciero" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
				</label>
	            <div class="col-md-9 col-sm-9">
					<g:select name='filterIdGrupoFinanciero' class="form-control" id="selAdmIdGrupoFinanciero" 
					value="${viewModelInstance?.filterIdGrupoFinanciero}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance?.gruposFinancierosList}'
					optionKey="id" optionValue="nombre"></g:select>
	            </div>
			</div>
			<div id="divAdmInstitucion" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.institucion.label" default="Institución" />
				</label>
				<div class="col-md-9 col-sm-9">					
					<g:select name='filterIdInstitucion' class="form-control" id="selAdmIdInstitucion" 
					value="${viewModelInstance?.filterIdInstitucion}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance?.institucionesGpoFinList}'
					optionKey="id" optionValue="nombre"></g:select>
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
			
		</div>
	</fieldset>
	
	<fieldset>
		<legend>Resultados de búsqueda</legend>
		
		<div id="list-poder" class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
					
						<th>A</th>
						<th>B</th>
						<th>C</th>
						<th>...</th>
						
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<div class="pagination">

			</div>
		</div>
		
	</fieldset>
	
</body>
</html>