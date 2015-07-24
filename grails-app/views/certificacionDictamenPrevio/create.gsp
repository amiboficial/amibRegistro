<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Emitir dictamen</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="certificacionDictamenPrevio" action="index" />">Dictamen Previo</a></li>
		<li><a href="#">Emitir dictamen</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	
	<h2><strong>Emitir dictamen para autorización</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action=<g:createLink controller="certificacionDictamenPrevio" action="save"/> method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Revise y, en caso de ser necesario, rectifique la información del solicitante del cual solicitará autorización. Una vez que toda la información proporcionada este completa, revisando la pestaña "Emitir Dictamen", podrá proceder a emitir el dictamen y enviarlo a autorización.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Domicilio</a></li>
			<li role="presentation"><a href="#tabCert" aria-controls="tabCert" role="tab" data-toggle="tab">Figura</a></li>
			<li role="presentation"><a href="#tabPues" aria-controls="tabPues" role="tab" data-toggle="tab">Relaciones laborales</a></li>
			 <li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Emitir dictamen</a></li>
		</ul>
		
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabGen">
				<div id="divGen"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabTels">
				<div id="divTelefonos"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabDom">
				<div id="divDom"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCert">
				<div id="divCert"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabPues">
				<div id="divPues"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
			
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
							<li><span id="spnCheckTels" class="glyphicon glyphicon-unchecked"></span> Datos de teléfonos</li>
							<li><span id="spnCheckSepomex" class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
							<li><span id="spnCheckFigura" class="glyphicon glyphicon-unchecked"></span> Datos de figura</li>
							<li><span id="spnCheckPuestos" class="glyphicon glyphicon-unchecked"></span> Datos de relaciones laborales con institución</li>
						</ul>
					</div>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Agregar solicitud</button>
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
	
	<g:render template="../common/expedientePuestos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.puestos.js" />
	<script>
		var app = app || {};
		
		var puestosArray = new Array();
		
		app.instituciones = new Array();
		<g:each var="x" in="${viewModelInstance?.institucionesList}">
			app.instituciones.push( (new app.Institucion(${x?.id},"${x?.nombre}")) );
		</g:each>
		
		var puestosView = new app.PuestosView(puestosArray);
	</script>
		
	
</body>
</html>