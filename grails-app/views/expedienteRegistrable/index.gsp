<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Solicitud de Registro</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Solicitud de Registro</a></li>
	</ul>
	<h2><strong>Solicitud de Registro</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<div id="divErrorMsg" class="alert alert-danger" style="display: none"><span class="glyphicon glyphicon-info-sign"></span>
		Se han presentado los siguientes errores:<br/>
		<span id="spnErrorMsg"></span>
	</div>

	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="expedienteRegistrable" action="index" />" method="get">
	<input id="hdnTipoBusqueda" name="fltTipoBusqueda" type="hidden" value="T" />
	<fieldset>
		<legend>Búsqueda de autorizables</legend>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="<g:if test="${viewModelInstance?.fltTipoBusqueda == 'S' || viewModelInstance?.fltTipoBusqueda == null || viewModelInstance?.fltTipoBusqueda == ''|| viewModelInstance?.fltTipoBusqueda == 'M'}">active</g:if>" >
				<a href="#divBusqSimple" aria-controls="divBusqSimple" role="tab" data-toggle="tab">Por matrícula</a>
			</li>
			<li role="presentation" class="<g:if test="${viewModelInstance?.fltTipoBusqueda == 'A'}">active</g:if>" >
				<a href="#divBusqAv" aria-controls="divBusqAv" role="tab" data-toggle="tab">Búsqueda avanzada</a>
			</li>
		</ul>
		<br/>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane <g:if test="${viewModelInstance?.fltTipoBusqueda == 'S' || viewModelInstance?.fltTipoBusqueda == null || viewModelInstance?.fltTipoBusqueda == ''|| viewModelInstance?.fltTipoBusqueda == 'M'}">active</g:if>" id="divBusqSimple">
				<div id="divSimpMatricula" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expedienteRegistrable.matricula.label" default="Matricula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField name="fltSimpMat" id="txtSimpMatricula" class="form-control" maxlength="10"
									 value="${viewModelInstance?.fltSimpMat}" />
					</div>
				</div>
				<div id="divSimpButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnSimpLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnSimpMostrarRecientes" type="button" class="btn btn-default btn-primary">Mostrar recientes</button>
						<button id="btnSimpBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane <g:if test="${viewModelInstance?.fltTipoBusqueda == 'A'}">active</g:if>" id="divBusqAv">
			
				<div id="divAvNombre" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expedienteRegistrable.nombre.label" default="Nombre" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvNombre" maxlength="80" class="form-control" name="fltAvNombre" value="${viewModelInstance?.fltAvNombre}" />
					</div>
				</div>
				
				<div id="divAvPrimerApellido" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expedienteRegistrable.primerApellido.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvPrimerApellido" maxlength="100" class="form-control" name="fltAvPrimerApellido" value="${viewModelInstance?.fltAvPrimerApellido}" />
					</div>
				</div>
				
				<div id="divAvSegundoApellido" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expedienteRegistrable.segundoApellido.label" default="Segundo apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAvSegundoApellido" maxlength="100" class="form-control" name="fltAvSegundoApellido" value="${viewModelInstance?.fltAvSegundoApellido}" />
					</div>
				</div>
				
				<div id="divAv" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expedienteRegistrable.figura.label" default="Figura" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fltAvVarFigura' class="form-control" id="selAvIdVarFigura"
						value="${viewModelInstance?.fltAvVarFigura}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.varFiguraList}'
						optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				
				<div id="divAvButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnAvLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnAvMostrarRecientes" type="button" class="btn btn-default btn-primary">Mostrar recientes</button>
						<button id="btnAvBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			
			</div>
			
		</div>
		
	</fieldset>
	
	<fieldset>
		<legend>Resultados de búsqueda</legend>
		<div id="list-registrables" class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<th>${message(code: 'expedienteRegistrable.matricula.label', default: 'Matrícula')}</th>
						<th>${message(code: 'expedienteRegistrable.nombre.label', default: 'Nombre')}</th>
						<th>${message(code: 'expedienteRegistrable.primerApellido.label', default: 'Primer Apellido')}</th>
						<th>${message(code: 'expedienteRegistrable.segundoApellido.label', default: 'Segundo Apellido')}</th>
						<th>${message(code: 'expedienteRegistrable.fechaExamen.label', default: 'Fecha de exámen')}</th>
						<th>...</th>
					</tr>
					<g:each in="${viewModelInstance.searchResults}">
						<tr>
							<td>${it.numeroMatricula}</td>
							<td>${it.nombre}</td>
							<td>${it.primerApellido}</td>
							<td>${it.segundoApellido}</td>
							<td>${it.fechaAplicacionExamenDay}/${it.fechaAplicacionExamenMonth}/${it.fechaAplicacionExamenYear}</td>
							<td><button class="registrar btn btn-default btn-xs" data-numeroMatricula="${it.numeroMatricula}">Registrar</button></td>
						</tr>
					</g:each>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			<div class="pagination">
			</div>
		</div>
	</fieldset>
	
	</form>

	<script>

		var app = app || {};

		app.ERROR_MSG_MATRICULA = "ERROR_MSG_MATRICULA";
		app.ERROR_MSG_NO_ELEM_BUSQ_AV = "ERROR_MSG_NO_ELEM_BUSQ_AV";

		app.errorList = new Array();

		$(".registrar").click(function(e){
			e.preventDefault();
			window.location.href = '<g:createLink controller="expedienteRegistrable" action="create" />/' + $(this).attr('data-numeroMatricula')
		});

		$("#btnSimpLimpiar").click(function(e){
			e.preventDefault();
			$("#txtSimpMatricula").val("");
		});
		$("#btnSimpMostrarRecientes").click(function(e){
			e.preventDefault();

			$("#txtSimpMatricula").val("");
			$("#txtAvNombre").val("");
			$("#txtAvPrimerApellido").val("");
			$("#txtAvSegundoApellido").val("");
			$("#selAvIdVarFigura").val("-1");

			$('#hdnTipoBusqueda').val('T');
			$("#frmApp").submit();
		});
		$("#btnSimpBuscar").click(function(e){
			e.preventDefault();
			$('#hdnTipoBusqueda').val('S');
			if(validarCamposBusquedaSimple() == true){
				$("#frmApp").submit();
			}
		});
		$("#btnAvLimpiar").click(function(e){
			e.preventDefault();
			$("#txtAvNombre").val("");
			$("#txtAvPrimerApellido").val("");
			$("#txtAvSegundoApellido").val("");
			$("#selAvIdVarFigura").val("-1");
		});
		$("#btnAvMostrarRecientes").click(function(e){
			e.preventDefault();

			$("#txtSimpMatricula").val("");
			$("#txtAvNombre").val("");
			$("#txtAvPrimerApellido").val("");
			$("#txtAvSegundoApellido").val("");
			$("#selAvIdVarFigura").val("-1");

			$('#hdnTipoBusqueda').val('T');
			$("#frmApp").submit();
		});
		$("#btnAvBuscar").click(function(e){
			e.preventDefault();
			$('#hdnTipoBusqueda').val('A');
			if(validarCamposBusquedaAvanzada() == true){
				$("#frmApp").submit();
			}
		});

		function validarCamposBusquedaSimple(){
			var matricula = $.trim( $("#txtSimpMatricula").val() );
			var valid = true;

			app.errorList = new Array();

			if(matricula == "" || isNaN(matricula)){
				app.errorList.append(app.ERROR_MSG_MATRICULA);
				valid = false;
			}

			if(!valid){
				$("#spnErrorMsg").html("");
				$("#divErrorMsg").show();
				var msgText = "";
				for(var i=0;i<app.errorList.length;i++){
					msgText += app.errorList[i] + "\r\n";
				}
			}
			return valid;
		}

		function validarCamposBusquedaAvanzada(){
			var nombre = $.trim( $("#txtAvNombre").val() );
			var apellido1 = $.trim( $("#txtAvPrimerApellido").val() );
			var apellido2 = $.trim( $("#txtAvSegundoApellido").val() );
			var idFigura = $("#selAvIdVarFigura").val();
			var valid = true;

			app.errorList = new Array();
			if(nombre == "" && apellido1 == "" && idFigura == "-1"){
				console.log("el mensaje es: " + app.ERROR_MSG_NO_ELEM_BUSQ_AV);
				app.errorList.push(app.ERROR_MSG_NO_ELEM_BUSQ_AV);
				valid = false;
			}
			if(!valid){
				$("#spnErrorMsg").html("");
				$("#divErrorMsg").show();
				var msgText = "";
				for(var i=0;i<app.errorList.length;i++){
					msgText += app.errorList[i] + "<br/>";
				}
				$("#spnErrorMsg").html(msgText);
			}
			return valid;
		}

	</script>

</body>
</html>