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
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="tabDoc">
					<div id="divDoc">
					
						<fieldset>
							<legend>Carga de documentos</legend>
						
					
							<div class="errorValidacion alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" >error de validacion</span><br/>
								<ul class="validationErrorMsgs">
								</ul>
							</div>
							<div class="errorUpload alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorUpload" >error en upload</span><br/>
							</div>
						
							<div class="div-archivo form-group">
								<label class="col-md-2 col-sm-3 control-label">
									<g:message code="archivo.label" default="Archivo" /><span class="required-indicator">*</span>
								</label>
								<div class="col-md-2 col-sm-2">
									<input type="file" data-field="archivo" class="field archivo" name="archivo" />
								</div>
							</div>
							
							<div class="div-idTipoDocumento form-group">
								<label class="col-md-2 col-sm-3 control-label">
									<g:message code="idTipoDocumento.label" default="Tipo de documento" /><span class="required-indicator">*</span>
								</label>
								<div class="col-md-9 col-sm-9" >
									<select class="idTipoDocumento form-control field" data-field="idTipoDocumento">
										<option>-Seleccione-</option>
										<option>Tipo AAA</option>
										<option>Tipo BBB</option>
										<option>Tipo CCC</option>
									</select>
								</div>
							</div>
					
							<div class="form-group">
								<div class="col-md-3 col-sm-3">
									&nbsp;
								</div>
								<div class="col-md-6 col-sm-6" style="text-align: center">
									<button disabled id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Cargar archivo</button>
								</div>
								<div class="col-md-3 col-sm-3">
									&nbsp;
								</div>
							</div>
					
						</fieldset>
						
						<fieldset>
							<legend>Listado de archivos</legend>
							<div class="errorManejoVigencia alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorManejoVigencia" >error en manejo de vigencia</span><br/>
								<ul class="validationErrorMsgs">
								</ul>
							</div>
							<div class="listaArchivos list-group">
								<div class="list-group-item">
									<div class="div-nombreArchivo row">
										<label class="col-sm-2 control-label">Nombre</label>
										<div class="col-sm-9"><p>{{=nombreArchivo}}</p></div>
									</div>
									<div class="div-tipoDocumento row">
										<label class="col-sm-2 control-label">Tipo</label>
										<div class="col-sm-9"><p>{{=tipoDocumento.get("descripcion")}}</p></div>
									</div>
									<div class="div-fecha row">
										<label class="col-sm-2 control-label">Fecha</label>
										<div class="col-sm-9"><p>{{=fecha}}</p></div>
									</div>
									<div class="div-vigente row">
										<label class="col-sm-2 control-label">Vigente</label>
										<div class="col-sm-9"><p>{{=vigente}}</p></div>
									</div>
									<div class="row">
										<div class="col-sm-5">
											&nbsp;
										</div>
										<div class="col-sm-2">
											<button type="button" class="download btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> Descargar</button>
										</div>
										<div class="col-sm-2">
											<button type="button" class="setVigenciaTrue btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Hacer vigente</button>
										</div>
										<!-- <div class="col-sm-2">
											<button type="button" class="setVigenciaFalse btn btn-default btn-primary"><span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span> Quitar vigencia</button>
										</div>  -->
										<div class="col-sm-2">
											<button type="button" class="delete btn btn-sm btn-block btn-default btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Quitar de la lista</button>
										</div>
									</div>
								</div>
								<div class="list-group-item">
									
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-md-3 col-sm-3">
									&nbsp;
								</div>
								<div class="col-md-3 col-sm-3">
									<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar archivos</button>
								</div>
								<div class="col-md-3 col-sm-3">
									<button type="button" class="btn btn-primary btn-block edit">Editar archivos</button>
								</div>
								<div class="col-md-3 col-sm-3">
									&nbsp;
								</div>
							</div>
							
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
	
	<g:render template="formApoderados"/>
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.apoderados.js" />
	<script type="text/javascript">
		var app = app || {};
		var apoderadoCollection = new app.Apoderados();
		//Como se trata de un nuevo poder, aun no hay poderados
		var apoderadosView = new app.ApoderadosView(apoderadoCollection);
		apoderadosView.setApoderableGetUrl('<g:createLink action="getApoderable" />');
	</script>
	
	
	<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.poder.create.checklist.js" />
	<script type="text/javascript">
		
		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.PODER_CREATE_CHKIDX_PODER,poderView);
		checkSubmitView.setViewInstance(app.PODER_CREATE_CHKIDX_APODERADOS,apoderadosView);
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