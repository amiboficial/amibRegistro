<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 -Personal apoderado</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Información</a><span class="divider"></span></li>
		<li><a href="#">Personal apoderado</a></li>
	</ul>
	<h2><strong>Personal apoderado</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="poder" action="index" />" method="get">
	
	<fieldset>
		<legend>Búsqueda de personal</legend>
		
		<div id="divMatricula" class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poderVigente.matricula.label" default="Matricula" />
			</label>
			<div class="col-md-9 col-sm-9">
				<div class="input-group">
					<span class="input-group-addon">
						<input type="radio" id="rbtSimpOpMat" name="fltOp" value="MAT" checked>
					</span>
					<g:textField name="fltMat" id="txtMatricula" class="form-control" maxlength="10" value=""/>
				</div>
			</div>
		</div>
		
		<div id="divPalabra" class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poderVigente.palabra.label" default="Palabra en Nombre y/o Apellido(s)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<div class="input-group">
					<span class="input-group-addon">
						<input type="radio" id="rbtOpPalabra" name="fltOp" value="PAL">
					</span>
					<g:textField name="fltPal" id="txtPalabra" class="form-control" maxlength="80" value=""/>
				</div>
				<span class="help-block"><i>Ejemplo: Carlos Cano Sosa, Cano Sosa, Cano, Sosa, Carlos, etc.; NO: Cano Sosa Carlos, Sosa Carlos Cano, Sosa Carlos, etc.</i></span>
			</div>
		</div>
		
		<div id="divButtonArea" class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-6 col-sm-6" style="text-align: center">
				<button id="btnLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
				<button id="btnBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
				&nbsp;&nbsp;&nbsp;
				<button id="btnTodos" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-list-alt"></span> Mostrar todos</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
		
	</fieldset>
	
	<fieldset>
		<legend>Resultados de búsqueda</legend>
		<div id="list-poderVigente" class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<g:sortableColumn property="numeroMatricula" title="${message(code: 'poderVigente.numeroMatricula.label', default: '# Mat.')}" />
						<g:sortableColumn property="nombreCompleto" title="${message(code: 'poderVigente.nombreCompleto.label', default: 'Nombre Completo')}" />
						<g:sortableColumn property="idGrupofinanciero" title="${message(code: 'poderVigente.grupofinanciero.label', default: 'Gpo. Financiero')}" />
						<g:sortableColumn property="idInstitucion" title="${message(code: 'poderVigente.institucion.label', default: 'Institución')}" />
						<g:sortableColumn property="numeroEscritura" title="${message(code: 'poderVigente.numeroEscritura.label', default: '# Esc.')}" />
					</tr>
				</thead>
					<g:each in="${poderVigenteInstanceList}" status="i" var="poderVigenteInstance">
						<tr>
							<td>${fieldValue(bean: poderVigenteInstance, field: "numeroMatricula")}</td>
							<td>${fieldValue(bean: poderVigenteInstance, field: "nombreCompleto")}</td>
							<td>${fieldValue(bean: poderVigenteInstance, field: "idGrupofinanciero")}</td>
							<td>${fieldValue(bean: poderVigenteInstance, field: "idInstitucion")}</td>
							<td>${fieldValue(bean: poderVigenteInstance, field: "numeroEscritura")}</td>
						</tr>
					</g:each>
				<tbody>
					
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${poderInstanceCount?:0}" />
			</div>
		</div>
	</fieldset>
	
	</form>
	
	<script>
	$( "#btnLimpiar" ).click(function() {
		limpiaCampos();
	}
	$( "#btnBuscar" ).click(function() {
		limpiaValidacion();
		var valid = validaCampos();
		
		if(valid)
			$( "#frmApp" ).submit();
	}
	$( "#btnTodos" ).click(function() {
		window.location.href = '<g:createLink controller="poderVigente" action="index" />'
	}

	function limpiaCampos(){
		return false
	}

	function validaCampos(){
		return false
	}

	function limpiaValidacion(){
		return false
	}
	
	</script>
	
</body>
</html>