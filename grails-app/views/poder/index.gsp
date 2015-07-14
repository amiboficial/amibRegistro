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
	<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Mensaje de algo satisfactorio</div>
	<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Mensaje de algo erroneo</div>
	
	<fieldset>
		<legend>Acciones</legend>
		<button id="btnNuevoPoder" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo poder</button>
	</fieldset>
	
	<fieldset class="form-horizontal" role="form">
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

			</div>
		</div>
		
	</fieldset>
	
	<script type="text/javascript">

	var app = app || {}

	app.INSTITUCIONES_URL = '<g:createLink action="getInstituciones" />';
	
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
		alert("Aqui va a hacer submit");
	});
	
	</script>
	
</body>
</html>