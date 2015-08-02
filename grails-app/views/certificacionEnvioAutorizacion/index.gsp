<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Pendientes de autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Pendientes de autorización</a></li>
	</ul>
	<h2><strong>Pendientes de autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form">
		<fieldset>
			<legend>Búsqueda de expedientes con certificación pendiente de autorización</legend>
			
			<div class="tab-content">
			
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active" >
						<a href="#bmat" aria-controls="bmat" role="tab" data-toggle="tab">Por matrícula</a>
					</li>
					<li role="presentation">
						<a href="#bid" aria-controls="bid" role="tab" data-toggle="tab">Por folio</a>
					</li>
					<li role="presentation">
						<a href="#bav" aria-controls="bav" role="tab" data-toggle="tab">Búsqueda avanzada</a>
					</li>
					<li role="presentation">
						<a href="#bactions" aria-controls="bactions" role="tab" data-toggle="tab">Acciones</a>
					</li>
				</ul>
				<br/>
				
				<div role="tabpanel" id="bmat" class="tab-pane active" >
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
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
				</div>
				<div role="tabpanel" id="bid" class="tab-pane">
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
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="F" >Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="F" ><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
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
										
					<div id="divFltFig" class="form-group">
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
					
					<div id="divFltVFig" class="form-group">
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
					
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="A">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="A"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
					
				</div>
				<div role="tabpanel" id="bactions" class="tab-pane" >
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
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
			
			<div class="form-group">
				<div class="col-md-12 col-sm-12">
					<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Seleccionar todo</button>
					<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">De-seleccionar todo</button>
					<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Enviar seleccionados a lote de envio</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Ver lote de envio (X)</button>
				</div>
			</div>
			
		</fieldset>
		
	</form>

</body>
</html>