<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Nuevo poder</title>
	</head>
	<body>
		<a id="anchorForm"></a>
		
		<!-- INICIA: BREADCRUMB ADMIN -->
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="poder" action="index" />">Poderes</a></li>
			<li><a href="#">Nuevo poder</a></li>
		</ul>
		<!-- FIN: BREADCRUMB ADMIN -->
	
		<h2><strong>Nuevo poder</strong></h2>
		
		<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
		
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tabPoder" aria-controls="tabPoder" role="tab" data-toggle="tab">Datos del poder</a></li>
				<li role="presentation"><a href="#tabApoderados" aria-controls="tabApoderados" role="tab" data-toggle="tab">Datos de los apoderados</a></li>
				<li role="presentation"><a href="#tabDoc" aria-controls="tabDoc" role="tab" data-toggle="tab">Documento(s) de respaldo</a></li>
				<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Alta de información</a></li>
			</ul>
			
			<div class="tab-content">
				<br/>
				<div role="tabpanel" class="tab-pane active" id="tabPoder">
					<div id="divPoder"></div>
				</div>
				<div role="tabpanel" class="tab-pane" id="tabApoderados">
					<div id="divApoderados"></div>
				</div>
				<div role="tabpanel" class="tab-pane" id="tabDoc">
					<div id="divDoc">
					
						<fieldset>
							<legend>Documentos de respaldo</legend>
						</fieldset>
					
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
					<div id="divCheckSubmit" class="panel panel-default">
						<span id="spnHdnPostData">
						</span>
						<div class="panel-heading">Checklist de validación de información</div>
						<div class="panel-body">
							<ul style="list-style-type:none">
								<li><span id="spnCheckPoder" class="glyphicon glyphicon-unchecked"></span> Datos de poder</li>
								<li><span id="spnCheckApoderados" class="glyphicon glyphicon-unchecked"></span> Datos de apoderados</li>
								<li><span id="spnCheckDocs" class="glyphicon glyphicon-unchecked"></span> Documento(s) de respaldo</li>
							</ul>
						</div>
						<div class="form-group">
							<div class="col-md-3 col-sm-3">
								&nbsp;
							</div>
							<div class="col-md-6 col-sm-6" style="text-align: center">
								<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Crear nuevo poder</button>
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
		
	<g:render template="formPoder"/>
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.poder.js" />
	<script type="text/javascript">
		var app = app || {};
		
		var poderModel = new app.Poder();
		var poderView = new app.PoderView(poderModel);
		
		poderView.setNotarioFindUrl('<g:createLink action="getNotario" />');
		poderView.setGrupoFinancieroGetUrl('<g:createLink action="getInstituciones" />');
		
	</script>
	
	<!-- INICIA: SCRIPT PARA DOCUMENTOS -->
	<g:render template="../common/multiDocs"/>
	<g:javascript src="mx.amib.sistemas.registro.form.docsMultiWidget.js" />
	<!--<g:javascript src="mx.amib.sistemas.registro.revocacion.form.docsValidator.js" />-->
	<script type="text/javascript">

		var app = app || {};
		
		var docs = []
		var docsView = new app.DocsView(docs);
		docsView.validator = app.DocsValidator;

		docsView.viewModel.set('urlUpload','<g:createLink controller="documento" action="upload" />');
		docsView.viewModel.set('urlDownloadNew','<g:createLink controller="documento" action="downloadNew"/>');
		docsView.viewModel.set('urlDeleteNew','<g:createLink controller="documento" action="delete"/>');

	</script>
	<!-- FIN: SCRIPT PARA DOCUMENTOS  -->
	
	
	</body>
</html>