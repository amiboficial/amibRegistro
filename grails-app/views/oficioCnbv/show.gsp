<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Detalle de oficio de autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="oficioCnbv" action="index" />">Oficios de Autorización (CNBV)</a></li>
		<li><a href="#">Detalle de oficio</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Detalle de oficio de autorización</strong></h2>

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
		<legend>Oficio de autorización de la CNBV</legend>
	
		<fieldset>
			<legend><span class="toggle-0 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="0"></span>&nbsp;<i>Datos de oficio</i></legend>
			<div class="section-0">
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCnbv.numeroOficio.label" default="Numero de Oficio" />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.oficioCnbv?.numeroOficio}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCnbv.claveDga.label" default="Clave DGA" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.oficioCnbv?.claveDga}</p>
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset>
			<legend><span class="toggle-1 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="1"></span>&nbsp;<i>Autorizados</i></legend>
			<div id="485b227985f34dfcadf8369d1525f925" class="section-1">
			</div>
		</fieldset>
		
		<fieldset>
			<legend><span class="toggle-2 toggle glyphicon glyphicon-plus-sign handCursor" data-toggle-idx="2"></span>&nbsp;<i>Documentos de respaldo</i></legend>
		
			<div class="section-2">
				<div class="list-group-item">
					<div class="div-nombreArchivo row">
						<label class="col-sm-2 control-label">Nombre</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.nombre}</p></div>
					</div>
					<div class="div-tipoDocumento row">
						<label class="col-sm-2 control-label">UUID</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.uuid}</p></div>
					</div>
					<div class="div-fecha row">
						<label class="col-sm-2 control-label">Fecha</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.fechaCreacion}</p></div>
					</div>
					
					<div class="row">
						<div class="col-sm-9">
							&nbsp;
						</div>
						<div class="col-sm-2">
							<button type="button" class="download btn btn-sm btn-block btn-default btn-primary" data-uuid='${viewModelInstance?.documentoRespaldo?.uuid}' data-url='<g:createLink action="download" controller="documento" />'>
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

	<g:render template="./oficioCnbvShow"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.form.datosAutorizados.viewModels.js" />
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.show.list.autorizados.js" />
	<script>
		var autCol = new app.AutorizadoVMCollection([
			<g:each status="i" in="${viewModelInstance?.certAutList}" var="item">
			{
				idCertificacion: ${item?.id},
				idSustentante: ${item?.sustentante?.id},
				numeroMatricula: '${item?.sustentante?.numeroMatricula}',
				nombreCompleto: '${item?.sustentante?.nombre} ${item?.sustentante?.primerApellido} ${item?.sustentante?.segundoApellido}',
				nombre: '${item?.sustentante?.nombre}',
				primerApellido: '${item?.sustentante?.primerApellido}',
				segundoApellido: '${item?.sustentante?.segundoApellido}',
				dsFigura: '${item?.varianteFigura?.nombreFigura}',
				dsVarianteFigura: '${item?.varianteFigura?.nombre}',
				dsTipoAutorizacion: '${item?.varianteFigura?.tipoAutorizacionFigura}'
			}<g:if test="${i != viewModelInstance?.certAutList.size() - 1}">,</g:if>
			</g:each>
		]);
		var showExpedienteUrl = '<g:createLink action="show" controller="expediente" />';
		new app.AutorizadoResultsView({ collection:autCol , showExpedienteUrl:showExpedienteUrl});
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