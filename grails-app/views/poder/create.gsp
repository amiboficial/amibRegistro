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
					<div id="divApoderados">
					
					<div class="errorValidacion alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" ></span><br/>
						<ul class="validationErrorMsgs">
						</ul>
					</div>
					
					<fieldset>
						<legend>Búsqueda de apoderable</legend>
					
						<div class="procNumeroMatriculaBuscar alert alert-info">
							<asset:image src="spinner_alert_info.gif"/><strong>Procesando datos, espere un momento</strong>.
						</div>
						<div class="errorNumeroMatriculaBuscar alert alert-danger">
							<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorNumeroMatriculaBuscar" ></span>
						</div>
					
						<div class="div-numeroMatriculaBuscar form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="apoderados.numeroMatriculaBuscar.label" default="Matrícula" /><span class="required-indicator">*</span>
							</label>
							<div class="col-md-2 col-sm-2">
								<input type="text" data-field="numeroMatriculaBuscar" maxlength="10" class="field numeroMatriculaBuscar form-control" name="apoderados.numeroMatriculaBuscar" />
							</div>
						</div>
						
						<div class="div-nombreCompletoBuscar form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="apoderados.nombreCompletoBuscar.label" default="Nombre completo" /><span class="required-indicator">*</span>
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" data-field="nombreCompletoBuscar" maxlength="10" class="field nombreCompletoBuscar form-control" name="apoderados.nombreCompletoBuscar" disabled/>
							</div>
						</div>
						
						<div class="div-nombreFiguraBuscar form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="apoderados.nombreFiguraBuscar.label" default="Figura" /><span class="required-indicator">*</span>
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" data-field="nombreFiguraBuscar" maxlength="10" class="field nombreFiguraBuscar form-control" name="apoderados.nombreFiguraBuscar" disabled/>
							</div>
						</div>
						
						<div class="div-nombreVarianteFiguraBuscar form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="apoderados.nombreVarianteFiguraBuscar.label" default="Variante" /><span class="required-indicator">*</span>
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" data-field="nombreVarianteFiguraBuscar" maxlength="10" class="field nombreVarianteFiguraBuscar form-control" name="apoderados.nombreVarianteFiguraBuscar" disabled/>
							</div>
						</div>
						
					</fieldset>
					
					<fieldset>
						<legend>Listado de apoderados</legend>
						<div class="list-group">
							<div class="list-group-item">
								<div class="div-numeroMatricula div-nombreCompleto row">
									<label class="col-sm-2 control-label">Matrícula</label>
									<div class="col-sm-2"><p>24455</p></div>
									<label class="col-sm-3 control-label">Nombre completo</label>
									<div class="col-sm-5"><p>AAAAAAAAAAA BBBBBBB CCCCCCCC EEEEEEEEEEE</p></div>
								</div>
								<div class="div-nombreFigura row">
									<label class="col-sm-2 control-label">Figura</label>
									<div class="col-sm-9"><p>24455</p></div>
								</div>
								<div class="div-nombreVarianteFigura row">
									<label class="col-sm-2 control-label">Variante de figura</label>
									<div class="col-sm-9"><p>24455</p></div>
								</div>
							</div>
							<div class="list-group-item">
								<div class="div-numeroMatricula div-nombreCompleto row">
									<label class="col-sm-2 control-label">Matrícula</label>
									<div class="col-sm-2"><p>24455</p></div>
									<label class="col-sm-3 control-label">Nombre completo</label>
									<div class="col-sm-5"><p>AAAAAAAAAAA BBBBBBB CCCCCCCC EEEEEEEEEEE</p></div>
								</div>
								<div class="div-nombreFigura row">
									<label class="col-sm-2 control-label">Figura</label>
									<div class="col-sm-9"><p>24455</p></div>
								</div>
								<div class="div-nombreVarianteFigura row">
									<label class="col-sm-2 control-label">Variante de figura</label>
									<div class="col-sm-9"><p>24455</p></div>
								</div>
							</div>
						</div>
					</fieldset>
					
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-3 col-sm-3">
							<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar datos de apoderados</button>
						</div>
						<div class="col-md-3 col-sm-3">
							<button type="button" class="btn btn-primary btn-block edit">Editar datos de apoderados</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
					
					</div>
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
	
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.poder.create.checklist.js" />
	<script type="text/javascript">
		
		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.PODER_CREATE_CHKIDX_PODER,poderView);
		/*

		Ejemplo de instanciamineto en el GSP,JSP,etc..-

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_SEPOMEX,sepomexView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_REGISTRO,registroView);

		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});
		*/
	</script>
	
	</body>
</html>