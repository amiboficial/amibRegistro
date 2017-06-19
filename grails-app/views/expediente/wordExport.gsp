<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Constancias</title>
</head>

<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de constancias por puntos</a><span class="divider"></span></li>
	</ul>
	<h2><strong>Constancias por puntos</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="expediente" action="descargarCocaFullDocx" />" method="get">
	
	
		<fieldset>
			<legend>Búsqueda de expediente</legend>
			
			<div class="tab-content">
			
				<div role="tabpanel" id="bmat" class="tab-pane active" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.matricula.label" default="Matricula" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField name="numeroMatricula" id="txtMat" class="form-control" maxlength="12" value=""/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
				</div>
			
				
			</div>
			
		</fieldset>
	
	</form>

	<script type="text/javascript">
	var app = app || {};
	
	$('.limpiar').click(function(e){
		e.preventDefault();
			//Limpiar campos por matricula
			$("[name='txtMat']").val("");
	});
	$('.buscar').click(function(e){
		e.preventDefault();
			$("#frmApp").submit() //checkar submit
	});

	</script>
	
	<script type="text/javascript">
	$("#divAffixSidebar").parent().remove();
	$(".nav.navbar-nav.pull-right").parent().remove();
	
	</script>

</body>
</html>