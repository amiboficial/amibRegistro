<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Nueva revocacion</title>
</head>
<body>
	<a id="anchorForm"></a>

	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
		<li><a href="#">Alta de revocación</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Alta de revocación</strong></h2>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
	
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabRevocacion" aria-controls="tabRevocacion" role="tab" data-toggle="tab">Datos del oficio</a></li>
			<li role="presentation"><a href="#tabNotario" aria-controls="tabNotario" role="tab" data-toggle="tab">Datos del notario</a></li>
			<li role="presentation"><a href="#tabRevocados" aria-controls="tabRevocados" role="tab" data-toggle="tab">Datos de los revocados</a></li>
			<li role="presentation"><a href="#tabDoc" aria-controls="tabDoc" role="tab" data-toggle="tab">Documento(s) de respaldo</a></li>
			<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Alta de información</a></li>
		</ul>
	
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabRevocacion">
				<div id="divRevocacion">A</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabNotario">
				<div id="divNotario">B</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabRevocados">
				<div id="divRevocados">C</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabDoc">
				<div id="divDocumentos">D</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckOficioCnbv" class="glyphicon glyphicon-unchecked"></span> Datos del oficio</li>
							<li><span id="spnCheckNotario" class="glyphicon glyphicon-unchecked"></span> Datos del notario</li>
							<li><span id="spnCheckRevocados" class="glyphicon glyphicon-unchecked"></span> Datos de los revocados</li>
							<li><span id="spnCheckDocs" class="glyphicon glyphicon-unchecked"></span> Documento(s) de respaldo</li>
						</ul>
					</div>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Dar de alta revocación</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
					<br/>
				</div>
			</div>
		</div>
	
	</form>
	
	
	
	<g:render template="./formNotario"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.revocacion.form.notario.js" />
	<script type="text/javascript">
		var notarioView;
		var notarioViewModel;
		var entidadesFederativas;
		var fnturl; //findNotarioByNumeroNotariaAndIdEntidadFederativaUrl
		
		entidadesFederativas = new Array();
		entidadesFederativas.push({ id:-1,text:"-Seleccione-" });
		<g:each in="${viewModelInstance?.entidadesFed}">
			entidadesFederativas.push({ id:${it.id},text:"${it.nombre}" });
		</g:each>
		fnturl = '<g:createLink action="findNotarioByNumeroNotariaAndIdEntidadFederativa" />';
		
		notarioViewModel = new app.NotarioVM({
			entidadesFederativas:entidadesFederativas,
			findNotarioByNumeroNotariaAndIdEntidadFederativaUrl:fnturl
		});
		notarioView = new app.NotarioView({model:notarioViewModel});
	</script>

	<g:render template="./formRevocados"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.revocacion.form.revocados.js" />
	<script type="text/javascript">
		var revocadosTabView;
		var findByNumeroMatriculaUrl;

		findByNumeroMatriculaUrl = '<g:createLink action="findByNumeroMatricula" />'
		
		revocadosTabView = new app.RevocadosTabView({
			collection : new app.RevocadoVMCollection(), 
			findByNumeroMatriculaUrl : findByNumeroMatriculaUrl
		});
	</script>

	<g:render template="../common/docMultiples.v2"/>
	<g:javascript src="mx.amib.sistemas.registro.form.docMultiples.v2.js" />
	<script type="text/javascript">
		var app = app || {};
		
		/*
		EJEMPLO DE INSTANCIAMIENTO
		var documentosView = new app.DocumentosView({
			tiposDocumento: [
				{
					grailsId: 1,
					descripcion: "Documento de respaldo de poder 1",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 1,
					manejaVigencia: false
				},
				{
					grailsId: 2,
					descripcion: "Documento de respaldo de poder 2",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 3,
					manejaVigencia: true
				},
			],
			manejaVigencia: true,
			initialDocumentos: new app.Documentos()
		});
		*/
		
		var documentosView = new app.DocumentosView({
			tiposDocumento: [
				{
					grailsId: 1,
					descripcion: "Oficio de revocación",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 1,
					manejaVigencia: false
				},
			],
			manejaVigencia: true,
			initialDocumentos: new app.Documentos()
		});
		
		documentosView.setUploadUrl('<g:createLink controller="documento" action="upload" />');
		documentosView.setDownloadNewUrl('<g:createLink controller="documento" action="downloadNew" />');
		documentosView.setDownloadUrl('<g:createLink controller="documento" action="download" />');
		documentosView.setDeleteNewUrl('<g:createLink controller="documento" action="delete" />');
	</script>

</body>
</html>