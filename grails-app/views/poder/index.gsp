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
					<g:textField name="fltNumEsc" id="txtNumEscritura" maxlength="10" class="form-control" value="" />
				</div>
			</div>
						
			<div id="divFhApodInicio" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoInicio.label" default="Fecha de aporderamiento (del)" />	
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="fltFecIni" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			
			<div id="divFhApodFin" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="poder.fechaApoderamientoFin.label" default="Fecha de aporderamiento (al)" />
				</label>
				<div class="col-md-5 col-sm-5">
					<g:datePicker name="fltFecFn" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
				</div>
			</div>
			
			<div id="divAdmGrupoFinanciero" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
				</label>
	            <div class="col-md-9 col-sm-9">
					<g:select name='filterIdGrupofinanciero' class="form-control" id="selAdmIdGrupoFinanciero" 
					value="${viewModelInstance?.filterIdGrupoFinanciero}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance?.gruposFinancierosList}'
					optionKey="id" optionValue="nombre"></g:select>
	            </div>
			</div>
			
			<div id="divAdmInstitucion" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="poder.institucion.label" default="Institución" />
				</label>
				<div class="col-md-9 col-sm-9">					
					<g:select name='filterIdInstitucion' class="form-control" id="selAdmIdInstitucion" 
					value="${viewModelInstance?.filterIdInstitucion}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance?.institucionesGpoFinList}'
					optionKey="id" optionValue="nombre"></g:select>
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
						
							<g:sortableColumn property="id" title="${message(code: 'poder.id.label', default: 'ID')}" params="[fltNumEsc:viewModelInstance.fltNumEsc, fltFecIni_day:viewModelInstance.fltFecIniDay,fltFecIni_month:viewModelInstance.fltFecIniMonth, fltFecIni_year:viewModelInstance.fltFecIniYear, fltFecFn_day:viewModelInstance.fltFecFnDay, fltFecFn_month:viewModelInstance.fltFecFnMonth, fltFecFn_year:viewModelInstance.fltFecFnYear, filterIdGrupoFinanciero:viewModelInstance.filterIdGrupoFinanciero, filterIdInstitucion:viewModelInstance.filterIdInstitucion]" />
						
							<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'poder.fechaApoderamiento.label', default: 'Fec. Apoderamiento')}" params="[fltNumEsc:viewModelInstance.fltNumEsc, fltFecIni_day:viewModelInstance.fltFecIniDay,fltFecIni_month:viewModelInstance.fltFecIniMonth, fltFecIni_year:viewModelInstance.fltFecIniYear, fltFecFn_day:viewModelInstance.fltFecFnDay, fltFecFn_month:viewModelInstance.fltFecFnMonth, fltFecFn_year:viewModelInstance.fltFecFnYear, filterIdGrupoFinanciero:viewModelInstance.filterIdGrupoFinanciero, filterIdInstitucion:viewModelInstance.filterIdInstitucion]"/>
							
							<g:sortableColumn property="numeroEscritura" title="${message(code: 'poder.numeroEscritura.label', default: 'Num. Escritura')}" params="[fltNumEsc:viewModelInstance.fltNumEsc, fltFecIni_day:viewModelInstance.fltFecIniDay,fltFecIni_month:viewModelInstance.fltFecIniMonth, fltFecIni_year:viewModelInstance.fltFecIniYear, fltFecFn_day:viewModelInstance.fltFecFnDay, fltFecFn_month:viewModelInstance.fltFecFnMonth, fltFecFn_year:viewModelInstance.fltFecFnYear, filterIdGrupoFinanciero:viewModelInstance.filterIdGrupoFinanciero, filterIdInstitucion:viewModelInstance.filterIdInstitucion]"/>
						
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
								<button id="btnVer" onclick="btnVer_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								<button id="btnEditar" onclick="btnEditar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${poderInstanceCount?:0}" params="[fltNumEsc:viewModelInstance.fltNumEsc, fltFecIni_day:viewModelInstance.fltFecIniDay,fltFecIni_month:viewModelInstance.fltFecIniMonth, fltFecIni_year:viewModelInstance.fltFecIniYear, fltFecFn_day:viewModelInstance.fltFecFnDay, fltFecFn_month:viewModelInstance.fltFecFnMonth, fltFecFn_year:viewModelInstance.fltFecFnYear, filterIdGrupoFinanciero:viewModelInstance.filterIdGrupoFinanciero, filterIdInstitucion:viewModelInstance.filterIdInstitucion]"  />
				</div>
			</div>
			
		</fieldset>
	</form>
	
	<!-- INICIA: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
	<script type="text/javascript">
		var institAjaxUrl = '<g:createLink action="obtenerInstituciones"/>';
		<g:if test="${viewModelInstance.filterIdInstitucion != null && viewModelInstance.filterIdInstitucion != -1}">
			var precargadoIdInstitucion = ${viewModelInstance.filterIdInstitucion};
		</g:if>
	</script>
	<g:javascript src="mx.amib.sistemas.registro.form.entidadFinanciera.js" />
	<script type="text/javascript">
		$("#selAdmIdGrupoFinanciero").trigger("change");
	</script>
	<!-- FIN: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
	
	<script>
	
	//callbacks para botones en lista
	function btnVer_click(id){
		window.location.href = '<g:createLink controller="poder" action="show" />/'+id;
	}
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="poder" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="poder" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	//btnNuevoPoder
	$( "#btnNuevoPoder" ).click(function() {
		window.location.href = '<g:createLink controller="poder" action="create" />'
	});
	//callback al boton para limpiar
	$( "#btnLimpiar" ).click(function() {
		$( "#txtNumEscritura" ).val('');
		$( "#fltFecIni_day" ).val('null');
		$( "#fltFecIni_month" ).val('null');
		$( "#fltFecIni_year" ).val('null');
		$( "#fltFecFn_day" ).val('null');
		$( "#fltFecFn_month" ).val('null');
		$( "#fltFecFn_year" ).val('null');
		$( "#selAdmIdGrupoFinanciero" ).val('-1');
		$( "#selAdmIdInstitucion" ).html( htmlSelectRestaurado() );
		$( "#selAdmIdInstitucion" ).val('-1');
	});
	//callback al boton para submitear
	$( "#btnBuscar" ).click(function() {
		limpiaValidacion();
		var valid = validaCampos();
		
		if(valid)
			$( "#frmApp" ).submit();
	});
	//fixes a ejecutarse al inicio
	$(function(){

		var fltNumEsc = ${viewModelInstance?.fltNumEsc};
		var fltFecIniDay = ${viewModelInstance.fltFecIniDay};
		var fltFecIniMonth = ${viewModelInstance.fltFecIniMonth};
		var fltFecIniYear = ${viewModelInstance.fltFecIniYear};
		var fltFecFnDay = ${viewModelInstance.fltFecFnDay};
		var fltFecFnMonth = ${viewModelInstance.fltFecFnMonth};
		var fltFecFnYear = ${viewModelInstance.fltFecFnYear};

		if(fltNumEsc==-1) fltNumEsc="";
		if(fltFecIniDay==-1) fltFecIniDay="null";
		if(fltFecIniMonth==-1) fltFecIniMonth="null";
		if(fltFecIniYear==-1) fltFecIniYear="null";
		if(fltFecFnDay==-1) fltFecFnDay="null";
		if(fltFecFnMonth==-1) fltFecFnMonth="null";
		if(fltFecFnYear==-1) fltFecFnYear="null";

		$('#txtNumEscritura').val(fltNumEsc);
		$('#fltFecIni_day').val(fltFecIniDay);
		$('#fltFecIni_month').val(fltFecIniMonth);
		$('#fltFecIni_year').val(fltFecIniYear);
		$('#fltFecFn_day').val(fltFecFnDay);
		$('#fltFecFn_month').val(fltFecFnMonth);
		$('#fltFecFn_year').val(fltFecFnYear);
		
		$('#fltFecIni_day').addClass( 'form-control' );
		$('#fltFecIni_month').addClass( 'form-control' );
		$('#fltFecIni_year').addClass( 'form-control' );
		$('#fltFecIni_day').addClass( 'col-md-4' );
		$('#fltFecIni_month').addClass( 'col-md-4' );
		$('#fltFecIni_year').addClass( 'col-md-4' );
		$('#fltFecIni_day').css( 'width', '28%' );
		$('#fltFecIni_month').css( 'width', '38%' );
		$('#fltFecIni_year').css( 'width', '34%' );

		$('#fltFecFn_day').addClass( 'form-control' );
		$('#fltFecFn_month').addClass( 'form-control' );
		$('#fltFecFn_year').addClass( 'form-control' );
		$('#fltFecFn_day').addClass( 'col-md-4' );
		$('#fltFecFn_month').addClass( 'col-md-4' );
		$('#fltFecFn_year').addClass( 'col-md-4' );
		$('#fltFecFn_day').css( 'width', '28%' );
		$('#fltFecFn_month').css( 'width', '38%' );
		$('#fltFecFn_year').css( 'width', '34%' );
	});

	//funciones para validación
	//limpia rastros de validación
	function limpiaValidacion(){
		$('#divNumEscritura').removeClass( 'has-error' );
		$('#divFhApodInicio').removeClass( 'has-error' );
		$('#divFhApodFin').removeClass( 'has-error' );
	}
	//valida el submit e indica posibles errores
	function validaCampos(){
		var valid = true;
		
		var numeroEscritura = $.trim($( "#txtNumEscritura" ).val());
		var fechaDelDia = $( "#fltFecIni_day" ).val();
		var fechaDelMes = $( "#fltFecIni_month" ).val();
		var fechaDelAnio = $( "#fltFecIni_year" ).val();
		var fechaAlDia = $( "#fltFecFn_day" ).val();
		var fechaAlMes = $( "#fltFecFn_month" ).val();
		var fechaAlAnio = $( "#fltFecFn_year" ).val();

		//trimea y valida que el numero de escritura sea numérico
		if( isNaN(numeroEscritura) ){
			$('#divNumEscritura').addClass( 'has-error' );
			valid = false;
		}

		//valida que las fechas esten "completas"
		if( fechaDelDia!="null" && fechaDelMes=="null" && fechaDelAnio=="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes!="null" && fechaDelAnio=="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes=="null" && fechaDelAnio!="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia!="null" && fechaDelMes!="null" && fechaDelAnio=="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia!="null" && fechaDelMes=="null" && fechaDelAnio!="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes!="null" && fechaDelAnio!="null" ){
			$('#divFhApodInicio').addClass( 'has-error' );
			valid = false;
		}

		if( fechaAlDia!="null" && fechaAlMes=="null" && fechaAlAnio=="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes!="null" && fechaAlAnio=="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes=="null" && fechaAlAnio!="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia!="null" && fechaAlMes!="null" && fechaAlAnio=="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia!="null" && fechaAlMes=="null" && fechaAlAnio!="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes!="null" && fechaAlAnio!="null" ){
			$('#divFhApodFin').addClass( 'has-error' );
			valid = false;
		}

		return valid;
	}
	
	//funciones "de utilidad"
	function htmlSelectRestaurado(){
		var htmlString = '<option value="-1">-Seleccione-</option>';
		return htmlString
	}
	
	</script>
</body>
</html>