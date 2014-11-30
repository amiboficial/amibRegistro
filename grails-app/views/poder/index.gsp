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
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="poder" action="index" />" method="get">
		<fieldset>
			<legend>Acciones</legend>
			<button id="btnNuevoPoder" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo poder</button>
		</fieldset>
		<fieldset>
			<legend>Búsqueda de poderes</legend>
			
			<div id="divNumEscritura" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.numeroEscritura.label" default="Número de escritura" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:textField name="filterNumEscritura" id="txtNumEscritura" maxlength="10" class="form-control" value="" />
				</div>
			</div>
						
			<div id="divFhApodInicio" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoInicio.label" default="Fecha de aporderamiento (del)" /><span class="required-indicator">*</span>						
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="filterFechaApoderamientoInicio" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			
			<div id="divFhApodFin" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoFin.label" default="Fecha de aporderamiento (al)" /><span class="required-indicator">*</span>						
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="filterFechaApoderamientoFin" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			
			<div id="divAdmGrupoFinanciero" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" /><span class="required-indicator">*</span>
				</label>
	            <div class="col-md-9 col-sm-9">
					<g:select name='filterIdGrupofinanciero' class="form-control" id="selAdmIdGrupoFinanciero" value="${poderInstance?.idGrupofinanciero}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${gruposFinancierosList}'
					optionKey="id" optionValue="nombre"></g:select>
	            </div>
			</div>
			
			<div id="divAdmInstitucion" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.institucion.label" default="Institución" /><span class="required-indicator">*</span>
				</label>
				<div class="col-md-9 col-sm-9">
					<select id="filterIdInstitucion" class="form-control" name="poder.idInstitucion" value="${poderInstance?.idInstitucion}">
						<option value="-1">-Seleccione-</option>
					</select>
				</div>
			</div>
			
			<div id="divButtonArea" class="form-group">
				<div class="col-md-3 col-sm-3">
					&nbsp;
				</div>
				<div class="col-md-6 col-sm-6" style="text-align: center">
					<button id="btnLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
					<button id="btnBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
				</div>
				<div class="col-md-3 col-sm-3">
					&nbsp;
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
						
							<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'poder.fechaApoderamiento.label', default: 'Fec. Apoderamiento')}" />
							
							<g:sortableColumn property="numeroEscritura" title="${message(code: 'poder.numeroEscritura.label', default: 'Num. Escritura')}" />
						
							<th>...</th>
							
						</tr>
					</thead>
					<tbody>
					<g:each in="${poderInstanceList}" status="i" var="poderInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${poderInstance.id}">${poderInstance.id}</g:link></td>
						
							<td><g:formatDate date="${poderInstance.fechaApoderamiento}" /></td>
						
							<td>${fieldValue(bean: poderInstance, field: "numeroEscritura")}</td>
							
							<td>
								<button id="btnEditar" onclick="btnEditar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${poderInstanceCount?:0}" />
				</div>
			</div>
			
		</fieldset>
	</form>
	<script>
	
	//callbacks para botones en lista
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="poder" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="poder" action="delete" />/'+id
		//var r = confirm("¿Desea eliminar el elemento seleccionado?");
		//if(r == true)
			window.location.href = url;
	}
	
	//btnNuevoPoder
	$( "#btnNuevoPoder" ).click(function() {
		window.location.href = '<g:createLink controller="poder" action="create" />'
	});
	//fixes a ejecutarse al inicio
	$(function(){
		//cleanValidationMsgs();
		$('#filterFechaApoderamientoInicio_day').addClass( 'form-control' );
		$('#filterFechaApoderamientoInicio_month').addClass( 'form-control' );
		$('#filterFechaApoderamientoInicio_year').addClass( 'form-control' );
		$('#filterFechaApoderamientoInicio_day').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoInicio_month').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoInicio_year').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoInicio_day').css( 'width', '28%' );
		$('#filterFechaApoderamientoInicio_month').css( 'width', '38%' );
		$('#filterFechaApoderamientoInicio_year').css( 'width', '34%' );

		$('#filterFechaApoderamientoFin_day').addClass( 'form-control' );
		$('#filterFechaApoderamientoFin_month').addClass( 'form-control' );
		$('#filterFechaApoderamientoFin_year').addClass( 'form-control' );
		$('#filterFechaApoderamientoFin_day').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoFin_month').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoFin_year').addClass( 'col-md-4' );
		$('#filterFechaApoderamientoFin_day').css( 'width', '28%' );
		$('#filterFechaApoderamientoFin_month').css( 'width', '38%' );
		$('#filterFechaApoderamientoFin_year').css( 'width', '34%' );
	});
	
	</script>
</body>
</html>