<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Alta de poder</title>
	</head>
	<body>
	
		<ul class="breadcrumb">
	           <li><a href="#">Servicios</a><span class="divider"></span></li>
	           <li><a href="#">Alta de poder</a></li>
		</ul>
	
		<h1><strong>Alta de poder</strong></h1>
	
		<form class="form-horizontal" role="form">

			<fieldset>
				<legend>Datos del representante legal</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
		            </div>
				</div>
				
			</fieldset>
	
			<fieldset>
				<legend>Datos de la institución o grupo financiero</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.nombreGrupoFinancieroOrInstituto.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del poder</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Numero de escritura" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Fecha de aporderamiento" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
		            </div>
				</div>
				
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del notario</legend>
			</fieldset>
			
			<fieldset>
				<legend>Datos de apoderados</legend>
			</fieldset>
	
			<fieldset>
				<legend>Documentos de respaldo</legend>
			</fieldset>
	
		</form>
		
	</body>
</html>
