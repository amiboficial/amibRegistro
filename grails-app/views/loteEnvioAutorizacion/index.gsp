<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Lote de envío a autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Pendientes de autorización</a></li>
		<li><a href="#"> Lote de envío a autorización</a></li>
	</ul>
	<h2><strong>Lote de envío a autorización</strong></h2>

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
		
			<div class="form-group">
				<div class="col-md-12 col-sm-12">
					<div class="btn-group">
						<button type="button" class="selectAll btn btn-primary" data-tab="M"><span class="glyphicon glyphicon-check"></span>&nbsp;Seleccionar todo</button>
						<button type="button" class="selectNone btn btn-primary" data-tab="M"><span class="glyphicon glyphicon glyphicon-unchecked"></span>&nbsp;De-seleccionar todo</button>
						<button type="button" class="removeSelected btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-share"></span>&nbsp;Eliminar seleccionados</button>
					</div>
					&nbsp;&nbsp;&nbsp;
					<div class="btn-group">
						<button type="button" class="empty btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-trash"></span>&nbsp;Vaciar lote</button>
						<button type="button" class="exportxls btn btn-info" data-tab="M"><img src="${assetPath(src: 'excel_icon_16.png')}"/>&nbsp;Exportar a archivo de excel</button>
					</div>
					
				</div>
			</div>
			
		</fieldset>
	</form>

</body>
</html>