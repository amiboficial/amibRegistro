<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Expedientes</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Expedientes</a></li>
	</ul>
	<h2><strong>Expedientes</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="expediente" action="index" />" method="get">
	
		<fieldset>
			<legend>Acciones</legend>
			<button id="btnNuevo" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo expediente</button>
		</fieldset>
	
		<fieldset>
			<legend>Búsqueda de expediente</legend>
			
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<button type="button" id="btnBusqSimple" class="btn btn-default">Búsqueda simple</button>
					<button type="button" id="btnBusqAvanzada" class="btn btn-default">Búsqueda avanzada</button>
				</div>
			</div>
			<br/>
			
			
			<div id="divBusqSimple">
			
				<div id="divSimpMatricula" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.matricula.label" default="Matricula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="input-group">
							<span class="input-group-addon">
								<input type="radio" id="rbtSimpOpMat" name="fltSimpOp" value="MAT" checked>
							</span>
							<g:textField name="fltSimpMat" id="txtSimpMatricula" class="form-control" maxlength="10" value=""/>
						</div>
					</div>
				</div>
				
				<div id="divSimpFolio" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.folio.label" default="Folio" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="input-group">
							<span class="input-group-addon">
								<input type="radio" id="rbtSimpOpFolio" name="fltSimpOp" value="FOL">
							</span>
							<g:textField name="fltSimpFolio" id="txtSimpFolio" class="form-control" maxlength="10" value=""/>
						</div>
					</div>
				</div>
				
				<div id="divSimpPalabra" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.palabra.label" default="Palabra en Nombre y/o Apellido(s)" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="input-group">
							<span class="input-group-addon">
								<input type="radio" id="rbtSimpOpPalabra" name="fltSimpOp" value="PAL">
							</span>
							<g:textField name="fltSimpPalabra" id="txtSimpPalabra" class="form-control" maxlength="80" value=""/>
						</div>
						<span class="help-block"><i>Ejemplo: Carlos Cano Sosa, Cano Sosa, Cano, Sosa, Carlos, etc.; NO: Cano Sosa Carlos, Sosa Carlos Cano, Sosa Carlos, etc.</i></span>
					</div>
				</div>
				
				<div id="divSimpButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnSimpLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnSimpBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			
			<br/>
			
			<div id="divBusqAv">
				
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
				
				<div id="divAv" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.figura.label" default="Estatus de certificación" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fltAvFigura' class="form-control" id="selAvIdFigura" 
						value="${viewModelInstance?.fltAvFigura}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.figuraList}'
						optionKey="id" optionValue="descripcion"></g:select>
					</div>
				</div>
				
				<div id="divAv" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="notario.figura.label" default="Estatus de autorización" />
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
						<button id="btnAvBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
		</fieldset>
	
		<fieldset>
			<legend>Resultados de búsqueda</legend>
			<div id="list-expediente" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<tr>
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