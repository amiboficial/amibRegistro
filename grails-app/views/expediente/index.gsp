<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Expedientes</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Expedientes</a></li>
	</ul>
	<h2><strong>Expedientes</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="expediente" action="index" />" method="get">
	
		<input type="hidden" name="fltTB" value="${viewModelInstance?.fltTB}" />
	
		<fieldset>
			<legend>Acciones</legend>
			<button id="btnNuevo" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo expediente</button>
		</fieldset>
	
		<fieldset>
			<legend>Búsqueda de expediente</legend>
			
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
					
					<div id="divFltAp2" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.apellido1.label" default="Certificado" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:radioGroup name="fltCrt" labels="['Si','No']" values="[true,false]" value="${viewModelInstance?.fltCrt}">
								${it.label} ${it.radio} &nbsp;&nbsp;
							</g:radioGroup>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
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
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.varianteFigura.label" default="Variante de Figura" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltVFig' class="form-control" id="selFltVFig" 
							value="${viewModelInstance?.fltVFig}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.varianteFiguraList}'
							optionKey="id" optionValue="nombre"></g:select>
							<g:each in="${viewModelInstance.variantesFiguraMap}">
								<input type="hidden" id="${it.key}_vfigs" value='${it.value}' />
							</g:each>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Estatus de certificación" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltStCt' class="form-control" id="selFltStCt" 
							value="${viewModelInstance?.fltStCt}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.statusCertificacionList}'
							optionKey="id" optionValue="descripcion"></g:select>
						</div>
					</div>
					
					<div id="divAv" class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="expediente.figura.label" default="Estatus de autorización" />
						</label>
						<div class="col-md-9 col-sm-9">
							<g:select name='fltStAt' class="form-control" id="selFltStAt" 
							value="${viewModelInstance?.fltStAt}"
							noSelection="${['-1':'-Seleccione-']}"
							from='${viewModelInstance?.statusAutorizacionList}'
							optionKey="id" optionValue="descripcion"></g:select>
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
			<div id="list-expediente" class="content scaffold-list" role="main">
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
								<td>${it.id}</td>
								<td>${it.numeroMatricula}</td>
								<td>${it.nombre}</td>
								<td>${it.primerApellido}</td>
								<td>${it.segundoApellido}</td>
								<td><button class="revisar btn btn-default btn-xs" data-id="${it.id}">Revisar expediente</button></td>
							</tr>
						</g:each>
					</tbody>
					
				</table>
				<div class="pagination">
					<g:paginate total="${viewModelInstance.count?:0}" params="[fltTB:viewModelInstance.fltTB,fltMat:viewModelInstance.fltMat,fltFol:viewModelInstance.fltFol,fltNom:viewModelInstance.fltNom,fltAp1:viewModelInstance.fltAp1,fltAp2:viewModelInstance.fltAp2,fltCrt:viewModelInstance.fltCrt,fltFig:viewModelInstance.fltFig,fltVFig:viewModelInstance.fltVFig,fltStCt:viewModelInstance.fltStCt,fltStAt:viewModelInstance.fltStAt,sort:viewModelInstance.sort,max:viewModelInstance.max,order:viewModelInstance.order,offset:viewModelInstance.offset]"/>
				</div>
			</div>
		</fieldset>
	
	</form>

	<script type="text/javascript">
	var app = app || {};

	$('.limpiar').click(function(e){
		e.preventDefault();
		var tipoBusqueda = $(this).attr("data-tab")
		if(tipoBusqueda == 'M'){
			//Limpiar campos por matricula
		}
		else if(tipoBusqueda == 'F'){
			//Limpiar campos por folio
		}
		else if(tipoBusqueda == 'A'){
			//Limpiar campos avanzados
		}
		alert("limpiar:" + $(this).attr("data-tab"));
	});
	$('.buscar').click(function(e){
		e.preventDefault();
		var tipoBusqueda = $(this).attr("data-tab")
		
		$("[name='fltTB']").val(tipoBusqueda) //es del atributo
		$("#frmApp").submit() //checkar submit
		
		/*if(tipoBusqueda == 'M'){
			
		}
		else if(tipoBusqueda == 'F'){
			
		}
		else if(tipoBusqueda == 'A'){
			
		}*/
		//alert("buscar:" + $(this).attr("data-tab"));
	});
	$("[name='fltFig']").change(function(e){
		var idFigura = $("[name='fltFig']").val();
		if(idFigura != "-1"){
			var strJsonVFig = $("#" + idFigura + "_vfigs").val();
			console.log(strJsonVFig)
			var parsedArray = JSON.parse(strJsonVFig);
			$("[name='fltVFig']").html("")
			for(var i = 0; i<parsedArray.length ;i++){
				$("[name='fltVFig']").append("<option value='"+ parsedArray[i].id +"'>"+ parsedArray[i].nombre +"</option>")
			}
		}
		$("[name='fltVFig']").prepend("<option value='-1' selected>-Seleccione-</option>")
	});
	$("[name='fltCrt']").click(function(){
		if($( "[name='fltCrt']:checked" ).val() == "false"){
			disableCamposCertificacion();
		}
		else{
			enableCamposCertificacion();
		}
	});

	function disableCamposCertificacion(){
		$("[name='fltFig']").attr("disabled","disabled");
		$("[name='fltVFig']").attr("disabled","disabled");
		$("[name='fltStCt']").attr("disabled","disabled");
		$("[name='fltStAt']").attr("disabled","disabled");
	}
	function enableCamposCertificacion(){
		$("[name='fltFig']").removeAttr("disabled");
		$("[name='fltVFig']").removeAttr("disabled");
		$("[name='fltStCt']").removeAttr("disabled");
		$("[name='fltStAt']").removeAttr("disabled");
	}

	//A ejectuar en cuento se muestre le página
	$(window).bind("pageshow", function(){
		if($( "[name='fltCrt']:checked" ).val() == "false"){
			disableCamposCertificacion();
		}
		else{
			enableCamposCertificacion();
		}
	});
	
	</script>

</body>
</html>