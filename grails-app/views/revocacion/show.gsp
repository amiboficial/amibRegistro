<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Detalle de revocación</title>
</head>
<body>

	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
		<li><a href="#">Detalle de revocación</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Detalle de revocación</strong></h2>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button id="btnExpandir" type="button" class="expand-all btn btn-default"><span class="glyphicon glyphicon-plus-sign"></span> Expander todos</button>
		<button id="btnContraer" type="button" class="collapse-all btn btn-default"><span class="glyphicon glyphicon-minus-sign"></span> Contraer todos</button>
	</fieldset>


	<fieldset class="form-horizontal">
		<legend>Oficio de revocación</legend>
	
		<fieldset>
			<legend><span class="toggle-0 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="0"></span>&nbsp;<i>Datos de entidad financiera</i></legend>
			<div class="section-0">
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.grupoFinanciero.label" default="Grupo financiero" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.nombreGrupoFinanciero}</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.institucion.label" default="Institucion" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.nombreInstitucion}</p>
					</div>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><span class="toggle-1 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="1"></span>&nbsp;<i>Datos del representante legal</i></legend>
			<div class="section-1">
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.representanteLegalNombre.label" default="Nombre" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.revocacion?.representanteLegalNombre}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Primer apellido" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.revocacion?.representanteLegalApellido1}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Segundo Apellido" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.revocacion?.representanteLegalApellido2}</p>
					</div>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><span class="toggle-2 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="2"></span>&nbsp;<i>Notario</i></legend>
			<div class="section-2">
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.notario.numero.label" default="Número de notaria" />
					</label>
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.notario?.numeroNotaria}</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.notario.entidadFederativa.label" default="Entidad Federativa" />
					</label>
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.notario?.idEntidadFederativa}</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.notario.nombre.label" default="Nombre completo" />
					</label>
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.notario?.nombreCompleto}</p>
					</div>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><span class="toggle-3 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="3"></span>&nbsp;<i>Datos de oficio</i></legend>
			<div class="section-3">
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.numeroEscritura.label" default="Numero de Escritura" />
					</label>
					
					<div class="col-md-8 col-sm-8">						
						<p class="form-control-static">${vm?.revocacion?.numeroEscritura}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
						<g:message code="revocacion.fechaRevocacion.label" default="Fecha de revocación" />
					</label>
					<div class="col-md-8 col-sm-8">
						<p class="form-control-static">${vm?.revocacion?.fechaRevocacion}</p>
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset>
			<legend><span class="toggle-4 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="4"></span>&nbsp;<i>Revocados</i></legend>
			<div id="revocados72cbc179" class="section-4">
			</div>
		</fieldset>
		
		<fieldset>
			<legend><span class="toggle-5 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="5"></span>&nbsp;<i>Documentos de respaldo</i></legend>
		
			<div class="section-5">
				<div class="list-group-item">
					<div class="div-nombreArchivo row">
						<label class="col-sm-2 control-label">Nombre</label>
						<div class="col-sm-9"><p>${vm?.docRespaldo?.nombre}</p></div>
					</div>
					<div class="div-tipoDocumento row">
						<label class="col-sm-2 control-label">UUID</label>
						<div class="col-sm-9"><p>${vm?.docRespaldo?.uuid}</p></div>
					</div>
					<div class="div-fecha row">
						<label class="col-sm-2 control-label">Fecha</label>
						<div class="col-sm-9"><p>${vm?.docRespaldo?.fechaCreacion}</p></div>
					</div>
					
					<div class="row">
						<div class="col-sm-9">
							&nbsp;
						</div>
						<div class="col-sm-2">
							<button type="button" class="download btn btn-sm btn-block btn-default btn-primary" data-uuid='${vm?.docRespaldo?.uuid}' data-url='<g:createLink action="download" controller="documento" />'>
								<span class="glyphicon glyphicon-save" aria-hidden="true"></span> Descargar
							</button>
						</div>
					</div>
				</div>
			</div>
		
		</fieldset>
	</fieldset>

	<g:javascript src="mx.amib.sistemas.utils.addon.TogglableShowView.js" />
	<script>
		new app.TogglableShowView();
	</script>

	<g:render template="show"/>
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.revocacion.show.revocados.js" />
	<script>
		var showUrl = '<g:createLink action="show" />';
		new app.ResRevShwColView({
			showUrl: showUrl,
			collection: new app.ResRevShwCol([
				{ idSustentante: 1, numeroMatricula:1, nombre:'Azucena', primerApellido:'García',segundoApellido:'Galicia' },
				{ idSustentante: 2, numeroMatricula:2, nombre:'Yuridia', primerApellido:'Pérez',segundoApellido:'Fuentes' },
				{ idSustentante: 3, numeroMatricula:3, nombre:'Gloria', primerApellido:'Rocha',segundoApellido:'Verduzco' },
				{ idSustentante: 4, numeroMatricula:4, nombre:'María del Sol', primerApellido:'Reyes',segundoApellido:'Sanroman' }
			])
		});
	</script>

	<script>
	$(document).ready(function(){
		$('.download').click(function(e){
			e.preventDefault();
			var url = $(e.currentTarget).data("url");
			var uuid = $(e.currentTarget).data("uuid");

			window.open(url + '/' + uuid);
		});
	});
	</script>
	
</body>
</html>