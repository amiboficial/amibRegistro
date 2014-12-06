<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Gestión de Oficios CNBV</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="#">Revocaciones</a></li>
	</ul>
	<h2><strong>Oficios CNBV</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="oficioCNBV" action="index" />" method="get">
		<fieldset>
			<legend>Acciones</legend>
			<button id="btnNuevo" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Alta de Oficio</button>
		</fieldset>
		
		<fieldset>
			<legend>Búsqueda de Oficios CNBV</legend>
			
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<button type="button" id="btnPorDatosOficio" class="btn btn-default">Por datos de oficio</button>
					<button type="button" id="btnPorAutorizados" class="btn btn-default">Por autorizados</button>
				</div>
			</div>
			<br/>
			
			<input type="hidden" id="hdnFltType" name="fltType" value="" />
			
			<div id="divPorDatosOficio">
				<div id="divDOClaveDga" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCNBV.claveDga.label" default="Clave DGA" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField name="fltDODga" id="txtClaveDga" class="form-control" value="" />
					</div>
				</div>
				<div id="divDOFhVigInicio" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCNBV.fechaFinDeVigenciaDel.label" default="Fecha de fin de vigencia (del)" />	
					</label>
					<div class="col-md-5 col-sm-5">
						<g:datePicker name="fltDOFhDel" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
					</div>
				</div>
				<div id="divDOFhVigFin" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCNBV.fechaFinDeVigenciaAl.label" default="Fecha de fin de vigencia (al)" />
					</label>
					<div class="col-md-5 col-sm-5">
						<g:datePicker name="fltDOFhAl" value="" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-25..5}"/>
					</div>
				</div>
				
				<div id="divDOButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnDOLimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnDOBuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
			<div id="divPorAutorizados">
			
				<div id="divAMatricula" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCNBV.autorizado.matricula.label" default="Matricula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="input-group">
							<span class="input-group-addon">
								<input type="radio" id="rbtAOpMat" name="fltAOp" value="MAT" checked>
							</span>
							<g:textField name="fltAMat" id="txtMatricula" class="form-control" value=""/>
						</div>
					</div>
				</div>
				
				<div id="divANombre" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="oficioCNBV.autorizado.nombreCompleto.label" default="Nombre" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="input-group">
							<span class="input-group-addon">
								<input type="radio" id="rbtAOpNom" name="fltAOp" value="NOM">
							</span>
							<g:textField name="fltANom" id="txtNombre" class="form-control" value=""/>
						</div>
					</div>
				</div>
				<div id="divAButtonArea" class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button id="btnALimpiar" type="button" class="btn btn-default btn-primary">Limpiar campos</button>
						<button id="btnABuscar" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			
		</fieldset>
		
		
		
		
		<fieldset>
			<legend>Resultados de búsqueda</legend>
			<div id="list-oficioCNBV" class="content scaffold-list" role="main">
			
				<table class="table">
					<thead>
						<tr>
							<g:sortableColumn property="claveDga" title="${message(code: 'oficioCNBV.claveDga.label', default: 'Clave Dga')}" params="[fltType:viewModelInstance.fltType,fltDODga:viewModelInstance.fltDODga,fltDOFhDel_day:viewModelInstance.fltDOFhDelDay,fltDOFhDel_month:viewModelInstance.fltDOFhDelMonth,fltDOFhDel_year:viewModelInstance.fltDOFhDelYear,fltDOFhAl_day:viewModelInstance.fltDOFhAlDay,fltDOFhAl_month:viewModelInstance.fltDOFhAlMonth,fltDOFhAl_year:viewModelInstance.fltDOFhAlYear,fltAMat:viewModelInstance.fltAMat,fltANom:viewModelInstance.fltANom]"/>
							<g:sortableColumn property="fechaFinVigencia" title="${message(code: 'oficioCNBV.fechaFinVigencia.label', default: 'Fecha Fin Vigencia')}" params="[fltType:viewModelInstance.fltType,fltDODga:viewModelInstance.fltDODga,fltDOFhDel_day:viewModelInstance.fltDOFhDelDay,fltDOFhDel_month:viewModelInstance.fltDOFhDelMonth,fltDOFhDel_year:viewModelInstance.fltDOFhDelYear,fltDOFhAl_day:viewModelInstance.fltDOFhAlDay,fltDOFhAl_month:viewModelInstance.fltDOFhAlMonth,fltDOFhAl_year:viewModelInstance.fltDOFhAlYear,fltAMat:viewModelInstance.fltAMat,fltANom:viewModelInstance.fltANom]"/>
							<th>${message(code: 'oficioCNBV.autorizadosCNBV.label', default: 'Autorizados CNBV')}</th>
							<th>...</th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${oficioCNBVInstanceList}" status="i" var="oficioCNBVInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td><g:link action="show" id="${oficioCNBVInstance.id}">${fieldValue(bean: oficioCNBVInstance, field: "claveDga")}</g:link></td>
							<td><g:formatDate date="${oficioCNBVInstance.fechaFinVigencia}" /></td>
							<td>
								<g:each in="${oficioCNBVInstance.autorizadosCNBV}" var="a">
									${a?.nombreCompleto}<br/>
								</g:each>
							</td>
							<td>
								<button id="btnVer" onclick="btnVer_click(${oficioCNBVInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								<button id="btnEditar" onclick="btnEditar_click(${oficioCNBVInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${oficioCNBVInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${oficioCNBVInstanceCount ?: 0}" params="[fltType:viewModelInstance.fltType,fltDODga:viewModelInstance.fltDODga,fltDOFhDel_day:viewModelInstance.fltDOFhDelDay,fltDOFhDel_month:viewModelInstance.fltDOFhDelMonth,fltDOFhDel_year:viewModelInstance.fltDOFhDelYear,fltDOFhAl_day:viewModelInstance.fltDOFhAlDay,fltDOFhAl_month:viewModelInstance.fltDOFhAlMonth,fltDOFhAl_year:viewModelInstance.fltDOFhAlYear,fltAMat:viewModelInstance.fltAMat,fltANom:viewModelInstance.fltANom]" />
				</div>
			
			</div>
		</fieldset>
		
	</form>
	
	<!-- INICIA: SCRIPT PARA FUNCIONAMIENTO DE VISTA -->
	<script>
	//callbacks para botones en lista
	function btnVer_click(id){
		window.location.href = '<g:createLink controller="oficioCNBV" action="show" />/'+id;
	}
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="oficioCNBV" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="oficioCNBV" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	//callbacks para barra de acciones
	$( "#btnNuevo" ).click(function() {
		window.location.href = '<g:createLink controller="oficioCNBV" action="create" />'
	});
	//callbacks para cambiar los radiobutton cada que se focusea el input correspondiente
	$( "#txtMatricula" ).focus(function() {
		document.getElementById('rbtAOpMat').checked = true;
	});	
	$( "#txtNombre" ).focus(function() {
		document.getElementById('rbtAOpNom').checked = true;
	});	
	//callbacks para botones de opciones de búsqueda
	$( "#btnPorDatosOficio" ).click(function() {
		$("#divPorDatosOficio").show();
		$("#divPorAutorizados").hide();

		//limpia validaciones
		limpiaValidacionDO();
		limpiaValidacionA();
		limpiarCamposDO();
		limpiarCamposA();
	});
	$( "#btnPorAutorizados" ).click(function() {
		$("#divPorDatosOficio").hide();
		$("#divPorAutorizados").show();

		//limpia validaciones
		limpiaValidacionDO();
		limpiaValidacionA();
		limpiarCamposDO();
		limpiarCamposA();
	});
	//callback al boton para limpiar - Busqueda por Datos Oficio
	$( "#btnDOLimpiar" ).click(function() {
		limpiarCamposDO();
	});
	//callback al boton para limpiar - Busqueda por Autorizado
	$( "#btnALimpiar" ).click(function() {
		limpiarCamposA();
	});
	//funcioens de limpieza de campos
	function limpiarCamposA(){
		document.getElementById('rbtAOpMat').checked = true;
		$("#txtMatricula").val('');
		$("#txtNombre").val('');
	}
	function limpiarCamposDO(){
		$( "#txtClaveDga" ).val('');
		$( "#fltDOFhDel_day" ).val('null');
		$( "#fltDOFhDel_month" ).val('null');
		$( "#fltDOFhDel_year" ).val('null');
		$( "#fltDOFhAl_day" ).val('null');
		$( "#fltDOFhAl_month" ).val('null');
		$( "#fltDOFhAl_year" ).val('null');
	}
	//callback al boton para submitear - Busqueda por Datos Oficio
	$( "#btnDOBuscar" ).click(function() {
		limpiaValidacionDO();
		var valid = validaCamposDO();
		//setea el tipo de filtro de búsqueda
		$("#hdnFltType").val("DO");
		
		if(valid)
			$( "#frmApp" ).submit();
	});
	//callback al boton para submitear - Busqueda por Autorizado
	$( "#btnABuscar" ).click(function() {
		limpiaValidacionA();
		var valid = validaCamposA();
		var checkedVal = $('input:radio[name=fltAOp]:checked').val(); //MAT O NOM
		//setea el tipo de filtro de búsqueda
		if(checkedVal == "MAT"){
			$("#hdnFltType").val("AMAT");
		}
		else if(checkedVal == "NOM"){
			$("#hdnFltType").val("ANOM");
		}
		
		if(valid)
			$( "#frmApp" ).submit();
	});
	//validaciones
	function validaCamposDO(){
		var valid = true;

		var fechaDelDia = $( "#fltDOFhDel_day" ).val();
		var fechaDelMes = $( "#fltDOFhDel_month" ).val();
		var fechaDelAnio = $( "#fltDOFhDel_year" ).val();
		var fechaAlDia = $( "#fltDOFhAl_day" ).val();
		var fechaAlMes = $( "#fltDOFhAl_month" ).val();
		var fechaAlAnio = $( "#fltDOFhAl_year" ).val();

		//valida que las fechas esten "completas"
		if( fechaDelDia!="null" && fechaDelMes=="null" && fechaDelAnio=="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes!="null" && fechaDelAnio=="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes=="null" && fechaDelAnio!="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia!="null" && fechaDelMes!="null" && fechaDelAnio=="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia!="null" && fechaDelMes=="null" && fechaDelAnio!="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}
		if( fechaDelDia=="null" && fechaDelMes!="null" && fechaDelAnio!="null" ){
			$('#divDOFhVigInicio').addClass( 'has-error' );
			valid = false;
		}

		if( fechaAlDia!="null" && fechaAlMes=="null" && fechaAlAnio=="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes!="null" && fechaAlAnio=="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes=="null" && fechaAlAnio!="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia!="null" && fechaAlMes!="null" && fechaAlAnio=="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia!="null" && fechaAlMes=="null" && fechaAlAnio!="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		if( fechaAlDia=="null" && fechaAlMes!="null" && fechaAlAnio!="null" ){
			$('#divDOFhVigFin').addClass( 'has-error' );
			valid = false;
		}
		
		return valid;
	}
	function validaCamposA(){
		var valid = true;
		var checkedVal = $('input:radio[name=fltAOp]:checked').val(); //MAT O NOM

		var matricula = $.trim($("#txtMatricula").val());
		var nombre = $.trim($("#txtNombre").val());
		
		// fltType (filtro de búsqueda)
		if(checkedVal == "MAT"){
			if(matricula == ""){
				$('#divAMatricula').addClass( 'has-error' );
				valid = false;
			}
			else if(isNaN(matricula)){
				$('#divAMatricula').addClass( 'has-error' );
				valid = false;
			}
		}
		else if(checkedVal == "NOM"){
			if(nombre == ""){
				$('#divANombre').addClass( 'has-error' );
				valid = false;
			}
		}
		
		return valid
	}
	//limpia rastro de validaciones
	function limpiaValidacionDO(){
		$('#divDOFhVigInicio').removeClass( 'has-error' );
		$('#divDOFhVigFin').removeClass( 'has-error' );
	}
	function limpiaValidacionA(){
		$('#divAMatricula').removeClass( 'has-error' );
		$('#divANombre').removeClass( 'has-error' );
	}
	
	//fixes a ejecutarse al inicio
	$(function(){

		//carga de datos de inicio en variables
		var fltType = "${viewModelInstance?.fltType}";
		var fltDODga = "${viewModelInstance?.fltDODga}";
		var fltDOFhDelDay = "${viewModelInstance?.fltDOFhDelDay}";
		var fltDOFhDelMonth = "${viewModelInstance?.fltDOFhDelMonth}";
		var fltDOFhDelYear = "${viewModelInstance?.fltDOFhDelYear}";
		var fltDOFhAlDay = "${viewModelInstance?.fltDOFhAlDay}";
		var fltDOFhAlMonth = "${viewModelInstance?.fltDOFhAlMonth}";
		var fltDOFhAlYear = "${viewModelInstance?.fltDOFhAlYear}";
		var fltAMat = "${viewModelInstance?.fltAMat}";
		var fltANom = "${viewModelInstance?.fltANom}";
		if(fltDOFhDelDay=="-1"||fltDOFhDelDay=="") fltDOFhDelDay="null";
		if(fltDOFhDelMonth=="-1"||fltDOFhDelMonth=="") fltDOFhDelMonth="null";
		if(fltDOFhDelYear=="-1"||fltDOFhDelYear=="") fltDOFhDelYear="null";
		if(fltDOFhAlDay=="-1"||fltDOFhAlDay=="") fltDOFhAlDay="null";
		if(fltDOFhAlMonth=="-1"||fltDOFhAlMonth=="") fltDOFhAlMonth="null";
		if(fltDOFhAlYear=="-1"||fltDOFhAlYear=="") fltDOFhAlYear="null";
		//carga de variables en DOM
		if(fltType=="DO"){
			$('#divPorDatosOficio').show();
			$('#divPorAutorizados').hide();
			$('#fltDOFhDel_day').val(fltDOFhDelDay);
			$('#fltDOFhDel_month').val(fltDOFhDelMonth);
			$('#fltDOFhDel_year').val(fltDOFhDelYear);
			$('#fltDOFhAl_day').val(fltDOFhAlDay);
			$('#fltDOFhAl_month').val(fltDOFhAlMonth);
			$('#fltDOFhAl_year').val(fltDOFhAlYear);
		}
		else if(fltType=="AMAT"){
			$('#divPorDatosOficio').hide();
			$('#divPorAutorizados').show();
			$('#txtMatricula').val(fltAMat);
			$('#txtNombre').val("");
			document.getElementById('rbtAOpMat').checked = true;
		}
		else if(fltType=="ANOM"){
			$('#divPorDatosOficio').hide();
			$('#divPorAutorizados').show();
			$('#txtMatricula').val("");
			$('#txtNombre').val(fltANom);
			document.getElementById('rbtAOpNom').checked = true;
		}
		else{
			$('#divPorDatosOficio').hide();
			$('#divPorAutorizados').hide();
		}
		//fixes CSS
		$('#fltDOFhDel_day').addClass( 'form-control' );
		$('#fltDOFhDel_month').addClass( 'form-control' );
		$('#fltDOFhDel_year').addClass( 'form-control' );
		$('#fltDOFhDel_day').addClass( 'col-md-4' );
		$('#fltDOFhDel_month').addClass( 'col-md-4' );
		$('#fltDOFhDel_year').addClass( 'col-md-4' );
		$('#fltDOFhDel_day').css( 'width', '28%' );
		$('#fltDOFhDel_month').css( 'width', '38%' );
		$('#fltDOFhDel_year').css( 'width', '34%' );
		$('#fltDOFhAl_day').addClass( 'form-control' );
		$('#fltDOFhAl_month').addClass( 'form-control' );
		$('#fltDOFhAl_year').addClass( 'form-control' );
		$('#fltDOFhAl_day').addClass( 'col-md-4' );
		$('#fltDOFhAl_month').addClass( 'col-md-4' );
		$('#fltDOFhAl_year').addClass( 'col-md-4' );
		$('#fltDOFhAl_day').css( 'width', '28%' );
		$('#fltDOFhAl_month').css( 'width', '38%' );
		$('#fltDOFhAl_year').css( 'width', '34%' );

	});
	</script>
	<!-- FIN: SCRIPT PARA FUNCIONAMIENTO DE VISTA -->
</body>
</html>