<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Vista de expediente</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="index" />">Expedientes</a></li>
		<li><a href="#">Vista de Expediente</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Datos de expediente</strong></h2>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button id="btnEditar" type="button" onclick="btnEditar_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
		<button id="btnEliminar" type="button" onclick="btnEliminar_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
		<!-- 
		<button id="btnRevalidarPuntos" type="button" onclick="btnRevalidarPuntos_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Revalidar por puntos</button>
		<button id="btnRevalidarExp" type="button" onclick="btnRevalidarExp_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Revalidar por experiencia</button>
		 -->
	</fieldset>
	
	<fieldset>
		<legend>Expediente</legend>
		
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#divDatosPersonales" aria-controls="divDatosPersonales" role="tab" data-toggle="tab">Datos personales</a></li>
		  <li role="presentation"><a href="#divDocumentacion" aria-controls="divDocumentacion" role="tab" data-toggle="tab">Documentación</a></li>
		  <li role="presentation"><a href="#divCertifaciones" aria-controls="divCertifaciones" role="tab" data-toggle="tab">Certificaciones</a></li>
		  <li role="presentation"><a href="#divPoderVigente" aria-controls="divPoderVigente" role="tab" data-toggle="tab">Poder vigente</a></li>
		  <li role="presentation"><a href="#divHistPoder" aria-controls="divHistPoder" role="tab" data-toggle="tab">Histórico de apoderamientos</a></li>
		  <li role="presentation"><a href="#divHistRevoc" aria-controls="divHistRevoc" role="tab" data-toggle="tab">Histórico de revocaciones</a></li>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="divDatosPersonales">
				<br/>
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Género" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="CURP" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Fecha de nacimiento" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Nacionalidad" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Nivel de estudios" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="divDocumentacion">B</div>
			<div role="tabpanel" class="tab-pane" id="divCertifaciones">C</div>
			<div role="tabpanel" class="tab-pane" id="divPoderVigente">D</div>
			<div role="tabpanel" class="tab-pane" id="divHistPoder">E</div>
			<div role="tabpanel" class="tab-pane" id="divHistRevoc">F</div>
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
</body>
</html>