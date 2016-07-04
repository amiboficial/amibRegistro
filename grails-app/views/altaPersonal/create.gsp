<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Actualización de la autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Movimientos de personal</a><span class="divider"></span></li>
		<li><a href="#">Baja en Institución</a></li>
		<li><a href="<g:createLink controller="bajaPersonal" action="create" />">Búsqueda de candidatos a proceso</a></li>
	</ul>
	<h2><strong>Movimientos de personal - Alta en Institución</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action='<g:createLink controller="altaPersonal" action="save"/>' method="post">
	<input type="hidden" name="bajaMatricula" value="" />
	<div class="alert-processing alert alert-info" style="display:none;"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
		
	
		<div class="tab-content">
		<legend>Datos generales</legend>
			<br/>
				<div id="divGen">
				<div class="alert alert-danger validationErrorMessage" style="display: none;">
					Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
					<div class="errorMessagesContainer">
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.matricula.label" default="Matrícula" />
					</label>
					<div class="col-md-4 col-sm-4">
						<input type="text" class="form-control numeroMatricula" maxlength="11" value=""/>
					</div>
					<div class="col-md-3 col-sm-3">
						<button type="button" class="btn btn-info btn-block btn-xs verifyNumeroMatricula"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;Buscar</button>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.nombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control nombre" maxlength="100" value=""  disabled="true"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.primerApellido.label" default="Primer apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control primerApellido" maxlength="80" value=""  disabled="true"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.segundoApellido.label" default="Segundo apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control segundoApellido" maxlength="80" value=""  disabled="true"/>
		            </div>
				</div>
				</div>
				
			<br/>
				<legend>Relaciones laborales</legend>
			<br/>
				<div class="list-group-item">
					<div class="row" style="padding-left:0.75em;">
						<button type="button" class="add btn btn-success " style="display: none;"><span class="glyphicon glyphicon-plus"></span> Alta en Institución</button>
					</div>
					<div id="newjobContainer"  style="display:none;">
					<div class="form-group div-idInstitucion">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.idInstitucion.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
		</label>
		<div class="col-md-8 col-sm-9">
				<select class="form-control" data-field="idInstitucion" name="idInstitucion">
					<option value="-1">-Seleccione-</option>
					<g:each var="x" in="${intList}">
							<option value="${x.id}">${x.nombre}</option>
					</g:each>
				</select>
		</div>
	</div>
	<div class="form-group div-fechaInicio">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.fechaInicio.label" default="Fecha a partir de la cual labora" />
		</label>
		<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaInicio_day field"
				 data-field="fechaInicio_day" name="fechaInicio_day">
							<option value="-1">-Seleccione-</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaInicio_month field" 
				data-field="fechaInicio_month" name="fechaInicio_month">
							<option value="-1">-Seleccione-</option>
							<option value="1">enero</option>
							<option value="2">febrero</option>
							<option value="3">marzo</option>
							<option value="4">abril</option>
							<option value="5">mayo</option>
							<option value="6">junio</option>
							<option value="7">julio</option>
							<option value="8">agosto</option>
							<option value="9">septiembre</option>
							<option value="10">octubre</option>
							<option value="11">noviembre</option>
							<option value="12">diciembre</option>
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaInicio_year field"
				 data-field="fechaInicio_year" name="fechaInicio_year">
					<option value="-1">-Seleccione-</option>
					<g:each var="number" in="${(1950..2050)}">
					    <option value="${number}">${number}</option>
					</g:each>
				</select>
		</div>
	</div>
	<div class="form-group div-fechaFin">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.fechaFin.label" default="Fecha fin de labores" />
		</label>
		<div class="col-md-5 col-sm-5">
			<select style="width: 28%;" class="form-control col-md-4 fechaFin_day field" data-field="fechaFin_day"
			name="fechaFin_day">
					<option value="-1">-Seleccione-</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaFin_month field" data-field="fechaFin_month"
				name="fechaFin_month">
					<option value="-1">-Seleccione-</option>
							<option value="1">enero</option>
							<option value="2">febrero</option>
							<option value="3">marzo</option>
							<option value="4">abril</option>
							<option value="5">mayo</option>
							<option value="6">junio</option>
							<option value="7">julio</option>
							<option value="8">agosto</option>
							<option value="9">septiembre</option>
							<option value="10">octubre</option>
							<option value="11">noviembre</option>
							<option value="12">diciembre</option>
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaFin_year field" data-field="fechaFin_year"
				name="fechaFin_year" >
					<option value="-1">-Seleccione-</option>
					<g:each var="number" in="${(1950..2050)}">
					    <option value="${number}">${number}</option>
					</g:each>
				</select>
		</div>
	</div>
	<div class="form-group div-nombrePuesto">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.nombrePuesto.label" default="Puesto" />
		</label>
		<div class="col-md-8 col-sm-9">
				<input type="text" class="form-control" data-field="nombrePuesto" value="" name="nombrePuesto"/>
		</div>
	</div>

	<div class="form-group div-statusEntManifProtesta">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.statusEntManifProtesta.label" default="Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB" />
		</label>
		<div class="col-md-8 col-sm-9">
				<select class="form-control " data-field="statusEntManifProtesta"
				name="statusEntManifProtesta" >
					<option value="-1">-Seleccione-</option>
					<option value="0">No aplica</option>	
					<option value="1">Entregó</option>
					<option value="2">No entregó</option>
				</select>
		</div>
	</div>
	<div class="form-group div-obsEntManifProtesta">
			<label class="col-md-2 col-sm-3 control-label">
				(Observaciones)
			</label>
			<div class="col-md-10 col-sm-9">
				<input type="text" class="obsEntManifProtesta form-control field" data-field="obsEntManifProtesta" value=""
				name="obsEntManifProtesta" >
			</div>
		</div>
	<div class="form-group div-statusEntCartaInter">
		<label class="col-md-4 col-sm-3 control-label">
			<g:message code="puesto.statusEntCartaInter.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
		</label>
		<div class="col-md-8 col-sm-9">
				<select class="form-control" data-field="statusEntCartaInter"
				name="statusEntCartaInter" >
					<option value="-1">-Seleccione-</option>
					<option value="0">No aplica</option>	
					<option value="1">Entregó</option>
					<option value="2">No entregó</option>
				</select>
		</div>
	</div>
	<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				(Observaciones)
			</label>
			<div class="col-md-10 col-sm-9">
				<input type="text" class="obsEntCartaInter form-control field" data-field="obsEntCartaInter" value=""
				name="obsEntCartaInter" >
			</div>
		</div>
					<div class="row">
						<div style="text-align:center; margin-top: 0.75em;">
							<button type="button" class="save btn btn-info"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar nuevo</button>
							<button type="button" class="cancelNew btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
						</div>
					</div>
					</div>
				</div>
			<div class="listaPuestos">
					<div class="form-group div-idInstitucion">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.idInstitucion.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
						</label>
						<div class="col-md-9 col-sm-9">
								<p class="form-control-static dsInstitucion"></p>
						</div>
					</div>
					<div class="form-group div-fechaInicio">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.fechaInicio.label" default="Fecha a partir de la cual labora" />
						</label>
						<div class="col-md-5 col-sm-5">
								<p class="form-control-static fechaInicio"></p>
						</div>
					</div>
					<div class="form-group div-fechaFin">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.fechaFin.label" default="Fecha fin de labores" />
						</label>
						<div class="col-md-5 col-sm-5">
									<p class="form-control-static fechaFin"></p>
						</div>
					</div>
					<div class="form-group div-nombrePuesto">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.nombrePuesto.label" default="Puesto" />
						</label>
						<div class="col-md-9 col-sm-9">
								<p class="form-control-static nombrePuesto"></p>
						</div>
					</div>
				
					<div class="form-group div-statusEntManifProtesta">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.statusEntManifProtesta.label" default="Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB" />
						</label>
						<div class="col-md-9 col-sm-9">
								<p class="form-control-static statusEntManifProtesta"></p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.obsEntManifProtesta.label" default="(Observaciones)" />
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static obsEntManifProtesta"></p>
						</div>
					</div>
					
					<div class="form-group div-statusEntCartaInter">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="puesto.statusEntCartaInter.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
						</label>
						<div class="col-md-9 col-sm-9">
								<p class="form-control-static statusEntCartaInter"></p>
						</div>
					</div>
							<div class="form-group">
								<label class="col-md-2 col-sm-3 control-label">
									<g:message code="puesto.obsEntCartaInter.label" default="(Observaciones)" />
								</label>
								<div class="col-md-9 col-sm-9">
									<p class="form-control-static obsEntCartaInter"></p>
								</div>
							</div>
				</div>
		</div>
	
	</form>
<Script>
Institucion = function(id,nombre){
	this.id = id;
	this.nombre = nombre;
}
var instituciones = new Array();
<g:each var="x" in="${intList}">
	instituciones.push( (new Institucion(${x?.id},"${x?.nombre}")) );
</g:each>

function clearPuesto(){

	$('.nombre').val("");
	$('.primerApellido').val("");
	$('.segundoApellido').val("");
	
	$('.dsInstitucion').html("");
	$('.fechaInicio').html("");
	$('.fechaFin').html("");
	$('.nombrePuesto').html("");
	$('.statusEntManifProtesta').html("");
	$('.obsEntManifProtesta').html("");
	$('.statusEntCartaInter').html("");
	$('.obsEntCartaInter').html("");
}

$(".verifyNumeroMatricula").click(function(e){
	//expresion regular
	var num10CarExp = /^[0-9]{1,10}$/;
	//variable de validacion incial
	var valid = true;
	//obtencion de valores a validar
	var numeroMatricula = $(".numeroMatricula").val();
	$("[name='bajaMatricula']").val(numeroMatricula);
	//booleanos de validacion
	var isBlank;
	var isNumeric;
	var isAlreadyInList;

	$(".validationErrorMessage").hide();
	$(".errorMessagesContainer").html("");
	clearPuesto();
	$(".add.btn.btn-success").hide();
	$("#newjobContainer").hide();
	
	
	isBlank = ($.trim(numeroMatricula) == '');
	isNumeric = num10CarExp.test($.trim(numeroMatricula));
	
	if(isBlank){
		valid = false;
		$(".validationErrorMessage").show();
		$(".errorMessagesContainer").html("<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"Introduzca un <strong>Número de matrícula</strong> válido."
				 +"</div>");
	}
	else if(!isNumeric){
		valid = false;
		$(".validationErrorMessage").hide();
		$(".errorMessagesContainer").html($(".errorMessagesContainer").html()+
				"<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"El dato proporcionado no es numérico."
				 +"</div>");
	}
	
	if(valid){
		$.ajax({
			url:  '<g:createLink controller="altaPersonal" action="findByNumeroMatricula" />',
			beforeSend: function(xhr){
				$('.alert-processing').show();
				clearPuesto();
			},
			type: 'GET',
			data: { numeroMatricula:numeroMatricula }
		}).done( function(data){
			$('.alert-processing').hide();
			if(data.status == "OK"){


				$(".add.btn.btn-success").show();
				$('.nombre').val(data.object.nombre);
				$('.primerApellido').val(data.object.primerApellido);
				$('.segundoApellido').val(data.object.segundoApellido);

				var puestoCout = 0;
				for(puestoCout = 0; puestoCout < data.object.puestos.length;puestoCout++){
					if(data.object.puestos[puestoCout]!= null && data.object.puestos[puestoCout].esActual){
						for(var i=0; i<instituciones.length; i++){
							if(instituciones[i].id == data.object.puestos[puestoCout].idInstitucion){
								$('.dsInstitucion').html(instituciones[i].nombre);
								break;
							}
						}
						$('.fechaInicio').html(data.object.puestos[puestoCout].fechaInicio);
						$('.fechaFin').html(data.object.puestos[puestoCout].fechaFin);
						$('.nombrePuesto').html(data.object.puestos[puestoCout].nombrePuesto);
						if(data.object.puestos[puestoCout].statusEntManifProtesta == 0){
							$('.statusEntManifProtesta').html("No aplica");
						}else if(data.object.puestos[puestoCout].statusEntManifProtesta == 1){
							$('.statusEntManifProtesta').html("Entregó");
						}else if(data.object.puestos[puestoCout].statusEntManifProtesta == 2){
							$('.statusEntManifProtesta').html("No entregó");
						}else{
							$('.statusEntManifProtesta').html("");
						}
						if(data.object.puestos[puestoCout].statusEntCartaInter == 0){
							$('.statusEntCartaInter').html("No aplica");
						}else if(data.object.puestos[puestoCout].statusEntCartaInter == 1){
							$('.statusEntCartaInter').html("Entregó");
						}else if(data.object.puestos[puestoCout].statusEntCartaInter == 2){
							$('.statusEntCartaInter').html("No entregó");
						}else{
							$('.statusEntCartaInter').html("");
						}
						$('.obsEntManifProtesta').html(data.object.puestos[puestoCout].obsEntManifProtesta);
						$('.obsEntCartaInter').html(data.object.puestos[puestoCout].obsEntCartaInter);
					}
				}//end for puestos	
			}
			else{
				if(data.object == "ALREADY_ASIGNATED_JOB"){
					$(".validationErrorMessage").show();
					$(".errorMessagesContainer").html("<div class='alert alert-danger' role='alert'>"
							+"<span class='glyphicon glyphicon-info-sign'></span>"
							 +"el sustentante ya cuenta con una intitución en su puesto actual."
							 +"</div>");
					}else{
						$(".validationErrorMessage").show();
						$(".errorMessagesContainer").html("<div class='alert alert-danger' role='alert'>"
								+"<span class='glyphicon glyphicon-info-sign'></span>"
								 +"El sustentante no cuenta con un puesto asociado."
								 +"</div>");
					}
			}
		});
	}//end si es valido
});



$(".add.btn.btn-success").click(function(e){
	$("#newjobContainer").show();
	$(".add.btn.btn-success").hide();
});

$(".cancelNew.btn.btn-danger").click(function(e){
	location.reload();
});

$(".save.btn.btn-info").click(function(e){
var valid = true;

//clean errors
	$(".validationErrorMessage").hide();
	$(".errorMessagesContainer").html("");

if($("[data-field='idInstitucion']").val()=="-1"){
$(".validationErrorMessage").show();
		$(".errorMessagesContainer").html("<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"Debe seleccionar un valor en el campo 'Intermediario del mercado de valores o asesor de inversión contratante en que labora'"
				 +"</div>");
valid = false;
}
if($("[data-field='fechaInicio_day']").val()=="-1" || $("[data-field='fechaInicio_month']").val()=="-1"  || $("[data-field='fechaInicio_year']").val()=="-1"){
$(".validationErrorMessage").show();
		$(".errorMessagesContainer").html($(".errorMessagesContainer").html()+"<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"Debe seleccionar un valor en el campo 'Fecha a partir de la cual labora'"
				 +"</div>");
valid = false;
}
if($("[data-field='statusEntManifProtesta']").val()=="-1"){
$(".validationErrorMessage").show();
		$(".errorMessagesContainer").html($(".errorMessagesContainer").html()+"<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"Debe seleccionar un valor en el campo 'Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB'"
				 +"</div>");
valid = false;
}
if($("[data-field='statusEntCartaInter']").val()=="-1"){
$(".validationErrorMessage").show();
		$(".errorMessagesContainer").html($(".errorMessagesContainer").html()+"<div class='alert alert-danger' role='alert'>"
				+"<span class='glyphicon glyphicon-info-sign'></span>"
				 +"Debe seleccionar un valor en el campo 'Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación'"
				 +"</div>");
valid = false;
}
if(valid){
	$("form").submit();
	}
	else{
	return;
	}
});

</Script>

</body>
</html>