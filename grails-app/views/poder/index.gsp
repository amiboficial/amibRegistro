<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Gestión de poderes</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="#">Poderes</a></li>
	</ul>
	<h2><strong>Poderes</strong></h2>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevoPoder" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo poder</button>
	</fieldset>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="poder" action="index" />" method="get">
		
		<fieldset>
			<legend>Búsqueda de poderes</legend>
			<div id="divBusquedaPoderes">
				
				<div id="divNumEscritura" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.numeroEscritura.label" default="Número de escritura" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:if test="${viewModelInstance?.fne > 0}">
							<g:textField name="fne" id="txtNumEscritura" maxlength="10" class="form-control" value="${viewModelInstance?.fne}" />
						</g:if>
						<g:else>
							<g:textField name="fne" id="txtNumEscritura" maxlength="10" class="form-control" value="" />
						</g:else>
						
					</div>
				</div>
				<div id="divFhApodInicio" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.fechaApoderamientoInicio.label" default="Fecha de aporderamiento (del)" />	
					</label>
					<div class="col-md-5 col-sm-5">
						<g:datePicker name="ffpd" value="${viewModelInstance?.ffpd}" default="none" noSelection="${['-1':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
					</div>
				</div>
				<div id="divFhApodFin" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.fechaApoderamientoFin.label" default="Fecha de aporderamiento (al)" />
					</label>
					<div class="col-md-5 col-sm-5">
						<g:datePicker name="ffpa" value="${viewModelInstance?.ffpa}" default="none" noSelection="${['-1':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
					</div>
				</div>
				<div id="divAdmGrupoFinanciero" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fgf' class="form-control" id="selAdmIdGrupoFinanciero" 
						value="${viewModelInstance?.fgf}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.gruposFinancieroList}'
						optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				<div id="divAdmInstitucion" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.institucion.label" default="Institución" />
					</label>
					<div class="col-md-9 col-sm-9">					
						<g:select name='fi' class="form-control" id="selAdmIdInstitucion" 
						value="${viewModelInstance?.fi}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.institucionList}'
						optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				<div id="divButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnLimpiar" type="button" class="limpiar btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnBuscar" type="button" class="buscar btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
		</fieldset>
		
		<fieldset>
			<legend>Resultados de búsqueda</legend>
			
			<div id="list-poder" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<tr>
							<g:sortableColumn property="id" title="${message(code: 'poder.id.label', default: 'ID')}" />
							<g:sortableColumn property="numeroEscritura" title="${message(code: 'poder.numeroEscritura.label', default: 'Número de escritura')}" />
							<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'poder.fechaApoderamiento.label', default: 'Fecha de apoderamiento')}" />
							<th>Notario</th>
							<th>...</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${viewModelInstance?.poderResults}" status="i" var="poderInstance">
							<tr>
								<td><g:link action="show" id="${poderInstance.id}">${poderInstance.id}</g:link></td>
								<td>${poderInstance.numeroEscritura}</td>
								<td><g:formatDate date="${poderInstance.fechaApoderamiento}" /></td>
								<td>${ viewModelInstance?.notariosMap?.get(poderInstance.idNotario.asType(Long))?.nombreCompleto }</td>
								<td></td>
							</tr>
						</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${viewModelInstance?.count?:0}"  />
				</div>
			</div>
			
		</fieldset>
		
	</form>
	
	<script type="text/javascript">

	var app = app || {}

	app.PODER_CREATE_URL = '<g:createLink action="create" />';
	app.INSTITUCIONES_URL = '<g:createLink action="getInstituciones" />';

	$("#btnNuevoPoder").click(function(e){
		e.preventDefault();

		window.open(app.PODER_CREATE_URL,"_self");
	});
	
	$("#selAdmIdGrupoFinanciero").change(function(){
		var selectOptionsHtml = "<option value='-1'>-Seleccione-</option>";

		if($("#selAdmIdGrupoFinanciero").val() > 0){
			$.ajax({
				url: app.INSTITUCIONES_URL, 
				data: { idGrupoFinanciero: $("#selAdmIdGrupoFinanciero").val() }
			}).done(function( data ){
				if(data.status == "OK"){
					if(data.object.length > 0){
						//rellena el select con instituciones de la entidad federativa
						for(var i=0; i<data.object.length; i++){
							selectOptionsHtml += "<option value='" + data.object[i].id + "'>" + data.object[i].nombre + "</option>";
						}
					}
				}
				$("#selAdmIdInstitucion").html(selectOptionsHtml);
			});			
		}
		else{
			$("#selAdmIdInstitucion").html(selectOptionsHtml);
		}
		
	});

	$("#btnLimpiar").click(function(e){
		e.preventDefault();
		$("#txtNumEscritura").val("");
		$("#ffpd_day").val("-1");
		$("#ffpd_month").val("-1");
		$("#ffpd_year").val("-1");
		$("#ffpa_day").val("-1");
		$("#ffpa_month").val("-1");
		$("#ffpa_year").val("-1");
		$("#selAdmIdGrupoFinanciero").val("-1");
		$("#selAdmIdInstitucion").val("-1");
		$("#selAdmIdInstitucion").html("<option value='-1'>-Seleccione-</option>")
	});

	$("#btnBuscar").click(function(e){
		e.preventDefault();
		var valid = true;
		
		//valida si es que si introdujo el campo número de escritura que este sea numerico
		var numericRegEx = /^[0-9]{1,10}$/;
		var numeroEscritura = $("#txtNumEscritura").val().trim();
		if(numeroEscritura != "" && !numericRegEx.test(numeroEscritura)){
			alert("Introduzca dato numerico en 'Numero de Escritura'");
			valid = false;
		}
		
		if(valid){
			$("#frmApp").submit();
		}
		
	});

	//fixes para selects de fechas con boostrap
	$("#ffpd_day").addClass( 'form-control' );
	$("#ffpd_month").addClass( 'form-control' );
	$("#ffpd_year").addClass( 'form-control' );
	$("#ffpa_day").addClass( 'form-control' );
	$("#ffpa_month").addClass( 'form-control' );
	$("#ffpa_year").addClass( 'form-control' );

	$("#ffpd_day").addClass( 'col-md-4' );
	$("#ffpd_month").addClass( 'col-md-4' );
	$("#ffpd_year").addClass( 'col-md-4' );
	$("#ffpa_day").addClass( 'col-md-4' );
	$("#ffpa_month").addClass( 'col-md-4' );
	$("#ffpa_year").addClass( 'col-md-4' );

	$("#ffpd_day").css( 'width', '28%' );
	$("#ffpd_month").css( 'width', '38%' );
	$("#ffpd_year").css( 'width', '34%' );
	$("#ffpa_day").css( 'width', '28%' );
	$("#ffpa_month").css( 'width', '38%' );
	$("#ffpa_year").css( 'width', '34%' );
	</script>
	
</body>
</html>