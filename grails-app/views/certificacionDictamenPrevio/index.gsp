<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Dictamen Previo</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Dictamen Previo</a></li>
	</ul>
	<h2><strong>Dictamen Previo</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="certificacionDictamenPrevio" action="index" />" method="get">
		<input id="hdnTipoBusqueda" name="fltTB" type="hidden" value="T" />
		<g:each in="${viewModelInstance?.variantesFiguraMap}">
			<input type="hidden" id="${it.key}_vfigs" value='${it.value}' />
		</g:each>
		<fieldset>
			<legend>Búsqueda de expedientes con figura en dictamen previo</legend>
			
			<div class="tab-content">
			
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'M' || viewModelInstance?.fltTB == null || viewModelInstance?.fltTB == ''|| viewModelInstance?.fltTB == 'T'}">active</g:if>" >
						<a href="#bmat" aria-controls="bmat" role="tab" data-toggle="tab">Por matrícula</a>
					</li>
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'F'}">active</g:if>" >
						<a href="#bid" aria-controls="bid" role="tab" data-toggle="tab">Por folio</a>
					</li>
					<li role="presentation" class="<g:if test="${viewModelInstance?.fltTB == 'A'}">active</g:if>" >
						<a href="#bav" aria-controls="bav" role="tab" data-toggle="tab">Búsqueda avanzada</a>
					</li>
				</ul>
				<br/>
				<div role="tabpanel" id="bmat" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'M' || viewModelInstance?.fltTB == null || viewModelInstance?.fltTB == ''|| viewModelInstance?.fltTB == 'T'}">active</g:if>" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.matricula.label" default="Matricula" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField name="fltMat" id="txtFltMat" class="form-control" maxlength="10" value="${viewModelInstance?.fltMat}"/>
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
			
				<div role="tabpanel" id="bid" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'F'}">active</g:if>">
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.id.label" default="Folio" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField name="fltFol" id="txtFltFol" class="form-control" maxlength="10" value="${viewModelInstance?.fltFol}"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="F" >Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="F" ><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
				</div>
			
				<div role="tabpanel" id="bav" class="tab-pane <g:if test="${viewModelInstance?.fltTB == 'A'}">active</g:if>">
					
					<div id="divFltNom" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.nombre.label" default="Nombre" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltNom" maxlength="80" class="form-control" name="fltNom" value="${viewModelInstance?.fltNom}" />
						</div>
					</div>
					
					<div id="divFltAp1" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.apellido1.label" default="Primer apellido" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltAp1" maxlength="100" class="form-control" name="fltAp1" value="${viewModelInstance?.fltAp1}" />
						</div>
					</div>
					
					<div id="divFltAp2" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.apellido1.label" default="Segundo apellido" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:textField id="txtFltAp2" maxlength="100" class="form-control" name="fltAp2" value="${viewModelInstance?.fltAp2}" />
						</div>
					</div>
										
					<div id="divFltFig" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Figura" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltFig' class="form-control" id="selFltFig" 
							value="${viewModelInstance?.fltFig}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.figuraList}'
							optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
					
					<div id="divFltVFig" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.varianteFigura.label" default="Variante de Figura" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltVFig' class="form-control" id="selFltVFig" 
							value="${viewModelInstance?.fltVFig}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.varianteFiguraList}'
							optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
					
					<br/>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button type="button" class="limpiar btn btn-default btn-primary" data-tab="A">Limpiar campos</button>
							<button type="button" class="buscar btn btn-default btn-primary" data-tab="A"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
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
			<div id="list-dictamenPrevio" class="content scaffold-list" role="main">
				<table class="table">
				
					<thead>
						<tr>
							<th>${message(code: 'expediente.folio.label', default: 'Folio')}</th>
							<th>${message(code: 'expediente.matricula.label', default: 'Matrícula')}</th>
							<th>${message(code: 'expediente.nombre.label', default: 'Nombre')}</th>
							<th>${message(code: 'expediente.primerApellido.label', default: '1er Apellido')}</th>
							<th>${message(code: 'expediente.segundoApellido.label', default: '2do Apellido')}</th>
							<th>...</th>
						</tr>
					</thead>
					
					<tbody>
						<g:each in="${viewModelInstance?.resultList}">
							<tr>
								<td>${it?.sustentante?.id}</td>
								<td>${it?.sustentante?.numeroMatricula}</td>
								<td>${it?.sustentante?.nombre}</td>
								<td>${it?.sustentante?.primerApellido}</td>
								<td>${it?.sustentante?.segundoApellido}</td>
								<td><button class="edictamen btn btn-default btn-xs" data-id="${it?.id}">Emitir dictamen</button></td>
							</tr>
						</g:each>
					</tbody>
				
				</table>
				<div class="pagination">
					<g:paginate total="${viewModelInstance.count?:0}" 
						params="[fltTB:viewModelInstance.fltTB,fltMat:viewModelInstance.fltMat,fltFol:viewModelInstance.fltFol,fltNom:viewModelInstance.fltNom,
								fltAp1:viewModelInstance.fltAp1,fltAp2:viewModelInstance.fltAp2,fltFig:viewModelInstance.fltFig,
								fltVFig:viewModelInstance.fltVFig,
								sort:viewModelInstance.sort,max:viewModelInstance.max,order:viewModelInstance.order,offset:viewModelInstance.offset]"/>
				</div>
			</div>
		</fieldset>
	</form>
	<script type="text/javascript">

	var app = app || {};
	app.CERTDICTPREV_EDICTAMEN_URL = '<g:createLink controller="certificacionDictamenPrevio" action="create"/>/';
	
	$(".edictamen").click(function(e){ 
		e.preventDefault();
		var folio = $(this).attr("data-id");
		window.location.href = app.CERTDICTPREV_EDICTAMEN_URL + folio;
	});

	$('.limpiar').click(function(e){
		e.preventDefault();
		var tipoBusqueda = $(this).attr("data-tab");
		if(tipoBusqueda == 'M'){
			//Limpiar campos por matricula
			$("[name='fltMat']").val("");
		}
		else if(tipoBusqueda == 'F'){
			//Limpiar campos por folio
			$("[name='fltFol']").val("");
		}
		else if(tipoBusqueda == 'A'){
			//Limpiar campos avanzados
			$("[name='fltNom']").val("");
			$("[name='fltAp1']").val("");
			$("[name='fltAp2']").val("");
			
			$("[name='fltFig']").val("-1");
			$("[name='fltVFig']").val("-1");
		}
	});

	$('.buscar').click(function(e){
		e.preventDefault();
		var tipoBusqueda = $(this).attr("data-tab");
		var valido = true;
		$("[name='fltTB']").val(tipoBusqueda) //es del atributo

		if(tipoBusqueda != 'M'){
			//Limpiar campos por matricula
			$("[name='fltMat']").val("");
		}
		else if(tipoBusqueda != 'F'){
			//Limpiar campos por folio
			$("[name='fltFol']").val("");
		}
		else if(tipoBusqueda != 'A'){
			//Limpiar campos avanzados
			$("[name='fltNom']").val("");
			$("[name='fltAp1']").val("");
			$("[name='fltAp2']").val("");
			$("[name='fltFig']").val("-1");
			$("[name='fltVFig']").val("-1");
		}

		//si el tipo de búsqueda es 'M' valida que haya matricula
		if(tipoBusqueda == 'M' && $.trim($("[name='fltMat']").val()) == ""){
			valido = false;
		}
		else if(tipoBusqueda == 'F' && $.trim($("[name='fltFol']").val()) == ""){
			valido = false;
		}
		//si el tipo de búsqueda  es 'F' valida que haya folio
		if(valido)
			$("#frmApp").submit() //checkar submit
	});

	//cada que cambia el valor en figura, carga las variantes que se cargaron previamente en hiddens
	$("[name='fltFig']").change(function(e){
		var idFigura = $("[name='fltFig']").val();

		$("[name='fltVFig']").html("");
		if(idFigura != "-1"){
			var strJsonVFig = $("#" + idFigura + "_vfigs").val();
			console.log(strJsonVFig)
			var parsedArray = JSON.parse(strJsonVFig);	
			for(var i = 0; i<parsedArray.length ;i++){
				$("[name='fltVFig']").append("<option value='"+ parsedArray[i].id +"'>"+ parsedArray[i].nombre +"</option>")
			}
		}
		$("[name='fltVFig']").prepend("<option value='-1' selected>-Seleccione-</option>")
	});
	
	</script>
</body>
</html>