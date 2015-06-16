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
			
			<div class="tab-content">
			
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'M' || viewModelInstance?.fltTB == null || viewModelInstance?.fltTB == ''|| viewModelInstance?.fltTB == 'T'}">active</g:if>" >
						<a href="#bmat" aria-controls="bmat" role="tab" data-toggle="tab">Por matrícula</a>
					</li>
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'F'}">active</g:if>" >
						<a href="#bid" aria-controls="bid" role="tab" data-toggle="tab">Por folio</a>
					</li>
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'A'}">active</g:if>" >
						<a href="#bav" aria-controls="bav" role="tab" data-toggle="tab">Búsqueda avanzada</a>
					</li>
				</ul>
				
				<br/>
			
				<div role="tabpanel" id="bmat" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'M' || viewModelInstance?.fltTB == null || viewModelInstance?.fltTB == ''|| viewModelInstance?.fltTB == 'T'}">active</g:if>" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.matricula.label" default="Matricula" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField name="fltMat" id="txtFltMat" class="form-control" maxlength="10" value="${viewModelInstance?.fltMat}"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
				</div>
			
				<div role="tabpanel" id="bid" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'F'}">active</g:if>">
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.id.label" default="Folio" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField name="fltFol" id="txtFltFol" class="form-control" maxlength="10" value="${viewModelInstance?.fltFol}"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
				</div>
			
				<div role="tabpanel" id="bav" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'A'}">active</g:if>">
					
					<div id="divFltNom" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.nombre.label" default="Nombre" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltNom" maxlength="80" class="form-control" name="fltNom" value="${viewModelInstance?.fltNom}" />
						</div>
					</div>
					
					<div id="divFltAp1" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.apellido1.label" default="Primer apellido" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltAp1" maxlength="100" class="form-control" name="fltAp1" value="${viewModelInstance?.fltAp1}" />
						</div>
					</div>
					
					<div id="divFltAp2" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.apellido1.label" default="Segundo apellido" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltAp2" maxlength="100" class="form-control" name="fltAp2" value="${viewModelInstance?.fltAp2}" />
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Figura" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltFig' class="form-control" id="selFltFig" 
							value="${viewModelInstance?.fltFig}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.figuraList}'
							optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.varianteFigura.label" default="Variante de Figura" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltVFig' class="form-control" id="selFltVFig" 
							value="${viewModelInstance?.fltVFig}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.varianteFiguraList}'
							optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Estatus de certificación" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltStCt' class="form-control" id="selFltStCt" 
							value="${viewModelInstance?.fltStCt}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.statusCertificacionList}'
							optionKey="id" optionValue="descripcion"></g:select>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Estatus de autorización" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltStAt' class="form-control" id="selFltStAt" 
							value="${viewModelInstance?.fltStAt}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.statusAutorizacionList}'
							optionKey="id" optionValue="descripcion"></g:select>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div id="divBusqAv">
				
				
				
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