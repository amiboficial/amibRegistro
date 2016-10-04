<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Vista de expediente</title>

<script type="text/javascript">
	function enableCertificationEditDates(idCertificacion, idSustentante){
		$(".div-fhIniCert"+idCertificacion).show();
		$(".div-fhFinCert"+idCertificacion).show();
		$("#enableEditCert"+idCertificacion).hide();
		$("#finishEditCert"+idCertificacion).show();
		$("#cancelEditCert"+idCertificacion).show();
		}

	function finishCertificationEditDates(idCertificacion, idSustentante){
		var tieneErrores = false;
		var ErrorsString = "<div class='errorValidacion alert alert-danger' style='display: block;'><span class='glyphicon glyphicon-ban-circle'></span>&nbsp;<span class='msgErrorValidacion'>Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.</span><br><ul class='validationErrorMsgs'>"
		if($("[data-field='dayFhIniCert"+idCertificacion+"']").val()==undefined || $("[data-field='dayFhIniCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo dia en Fecha de inicio de vigencia</li>";
			}
		if($("[data-field='monthFhIniCert"+idCertificacion+"']").val()==undefined || $("[data-field='monthFhIniCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo mes en Fecha de inicio de vigencia</li>";
			}
		if($("[data-field='yearFhIniCert"+idCertificacion+"']").val()==undefined || $("[data-field='yearFhIniCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo año en Fecha de inicio de vigencia</li>";
			}
		if($("[data-field='dayFhFinCert"+idCertificacion+"']").val()==undefined || $("[data-field='dayFhFinCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo dia en Fecha de fin de vigencia</li>";
			}
		if($("[data-field='monthFhFinCert"+idCertificacion+"']").val()==undefined || $("[data-field='monthFhFinCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo mes en Fecha de fin de vigencia</li>";
			}
		if($("[data-field='yearFhFinCert"+idCertificacion+"']").val()==undefined || $("[data-field='yearFhFinCert"+idCertificacion+"']").val()=="-1"){
			tieneErrores = true;
				ErrorsString += "<li>Debe seleccionar un valor en el campo año en Fecha de fin de vigencia</li>";
			}
		ErrorsString += "</ul></div>";
		$("#errorMessagesCertificationEditDates"+idCertificacion).html("");
		if(tieneErrores){
				$("#errorMessagesCertificationEditDates"+idCertificacion).html(ErrorsString);
				return;
			}

		$.ajax({
			url: "<g:createLink controller="expediente" action="updateDatesCertificationExpedient" />", 
			//beforeSend: function(xhr){
			
				//En lo que se carga el apoderado, muetra el número de matricula
				//a buscar, dado que este modelo es rendereado cuando se cambia
				//al estado de processing
				//view.model = new app.Apoderado();
				//view.model.set("numeroMatricula",numeroMatricula);
				
				//view.clearErrorBusqueda();
				//view.setProcessing();
			//},
			data: { idCertificacion:idCertificacion,
					dayFhIniCert:$("[data-field='dayFhIniCert"+idCertificacion+"']").val(),
					monthFhIniCert:$("[data-field='monthFhIniCert"+idCertificacion+"']").val(),
					yearFhIniCert:$("[data-field='yearFhIniCert"+idCertificacion+"']").val(),
					dayFhFinCert:$("[data-field='dayFhFinCert"+idCertificacion+"']").val(),
					monthFhFinCert:$("[data-field='monthFhFinCert"+idCertificacion+"']").val(),
					yearFhFinCert:$("[data-field='yearFhFinCert"+idCertificacion+"']").val()
					}
		}).done( function(data){
			if(data.status == "OK"){
				$("#fhIniCert"+idCertificacion+" p:first").html($("[data-field='dayFhIniCert"+idCertificacion+"']").val()+"-"+$("[data-field='monthFhIniCert"+idCertificacion+"']").val()+"-"+$("[data-field='yearFhIniCert"+idCertificacion+"']").val());
				$("#fhFinCert"+idCertificacion+" p:first").html($("[data-field='dayFhFinCert"+idCertificacion+"']").val()+"-"+$("[data-field='monthFhFinCert"+idCertificacion+"']").val()+"-"+$("[data-field='yearFhFinCert"+idCertificacion+"']").val());
				$("#errorMessagesCertificationEditDates"+idCertificacion).html("<div class='alert alert-success'><span class='glyphicon glyphicon-info-sign'>Se actualizaron exitosamente las fechas de Certificación.</span></div>");
			}
			else{
				//error alguno
				$("#errorMessagesCertificationEditDates"+idCertificacion).html(ErrorsString);
			}
		} );
		
		
		}

	function cancelCertificationEditDates(idCertificacion, idSustentante){
		$(".div-fhIniCert"+idCertificacion).hide();
		$(".div-fhFinCert"+idCertificacion).hide();
		$("#enableEditCert"+idCertificacion).show();
		$("#finishEditCert"+idCertificacion).hide();
		$("#cancelEditCert"+idCertificacion).hide();

		$("#errorMessagesCertificationEditDates"+idCertificacion).html("");

		$("[data-field='dayFhIniCert"+idCertificacion+"']").val("-1");
		$("[data-field='monthFhIniCert"+idCertificacion+"']").val("-1");
		$("[data-field='yearFhIniCert"+idCertificacion+"']").val("-1");

		$("[data-field='dayFhFinCert"+idCertificacion+"']").val("-1");
		$("[data-field='monthFhFinCert"+idCertificacion+"']").val("-1");
		$("[data-field='yearFhFinCert"+idCertificacion+"']").val("-1");
	}

	var xmlResponsecontentstring = "${viewModelInstance?.PFIResult}";

	function showPFI(){
		this.$('#opcionPFI').show();
		if(xmlResponsecontentstring == undefined || xmlResponsecontentstring == "" ){
			this.$('#clasicPFIrevalidation').html('<div class="form-group"><label class="col-md-2 col-sm-3 control-label">No se pudo contactar el sericio intentelo mas tarde</label></div>');
		}else{
			if(xmlResponsecontentstring=="FALSE"){
				this.$('#clasicPFIrevalidation').html('<div class="form-group"><label class="col-md-2 col-sm-3 control-label">No se encontro la matricula </label></div>');
			}
			else{
				var ENDRESULTHTML = "";
				var multiplesExamenes = xmlResponsecontentstring.split("*|");
				var coutinuacion = 0;
				var elementos = [];
				var elementCont = "";
				for(coutinuacion = 0; coutinuacion < multiplesExamenes.length ; coutinuacion++){
					elementCont = multiplesExamenes[coutinuacion];
					elementos = elementCont.split('-}');
					
					if(elementos.length >=6 ){
							var aproved;
							var validTargeting = "";
							if(elementos[5] == "APROBADO"){
								aproved = true;
							}else{
								aproved = false;
								validTargeting = "style='cursor: not-allowed;'";
							}
							var htmlcontentPFIexam = '<a  href="#" class="list-group-item seleccionarPFI" '+validTargeting+'  data-field="'+aproved+'" >'
							+'<div class="form-group">'
							+'<label class="col-md-2 col-sm-3 control-static">'+elementos[0]+'</label>'
							+'<div class="col-md-9 col-sm-9"><p class="form-control-static">'+elementos[3]+'</p></div></div>'
							+'<div class="form-group">'
							+'	<label class="col-md-2 col-sm-3 control-static">'
							+elementos[4]
							+'	</label>'
							+'	<div class="col-md-9 col-sm-9">'
							+'		<p class="form-control-static">'+elementos[5]+'</p>'
							+'	</div>'
							+'</div>'
							+'</a><br />';
							
							ENDRESULTHTML += htmlcontentPFIexam;
					}
				}
				this.$('#clasicPFIrevalidation').html(ENDRESULTHTML);
			}
		}
	}

	$( document ).ready(function() {
		showPFI();
	});
	
	</script>
</head>
<body>
	<a id="anchorForm"></a>
	
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="index" />">Expedientes</a></li>
		<li><a href="#">Vista de expediente</a></li>
	</ul>

	
	<h2><strong>Datos de expediente</strong></h2>
	<h4>${raw(viewModelInstance?.nombreCompleto)} (Matricula: ${viewModelInstance?.sustentanteInstance?.numeroMatricula}, Folio: ${viewModelInstance?.sustentanteInstance?.id})</h4>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="edit" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="editar btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar datos personales</button>
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="editDoc" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="editarDoc btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Gestión de documentación</button>
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="remove" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="eliminar btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
		
	</fieldset>
	
	<fieldset class="form-horizontal">
		<legend>Expediente</legend>
		
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#tabDatosPersonales" aria-controls="tabDatosPersonales" role="tab" data-toggle="tab">Datos personales</a></li>
		  <li role="presentation"><a href="#tabDocumentacion" aria-controls="tabDocumentacion" role="tab" data-toggle="tab">Documentación</a></li>
		  <li role="presentation"><a href="#tabCertifaciones" aria-controls="tabCertifaciones" role="tab" data-toggle="tab">Certificaciones</a></li>
		  <li role="presentation"><a href="#tabPoderVigente" aria-controls="tabPoderVigente" role="tab" data-toggle="tab">Poder vigente</a></li>
		  <li role="presentation"><a href="#tabHistPoder" aria-controls="tabHistPoder" role="tab" data-toggle="tab">Histórico de apoderamientos</a></li>
		  <li role="presentation"><a href="#tabHistRevoc" aria-controls="tabHistRevoc" role="tab" data-toggle="tab">Histórico de revocaciones</a></li>
		  <li role="presentation"><a href="#tabPues" aria-controls="tabPues" role="tab" data-toggle="tab">Relaciones laborales</a></li>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tabDatosPersonales">
				<br/>
				
				<legend><i>Información personal</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.nombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nombre}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.primerApellido.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.primerApellido}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.segundoApellido.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<g:if test="${viewModelInstance?.sustentanteInstance?.segundoApellido != null}" >
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.segundoApellido}&nbsp;</p>
						</g:if>
						<g:else>
							<p class="form-control-static">&nbsp;</p>
						</g:else>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.genero.label" default="Género" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.genero}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.rfc.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.rfc}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.curp.label" default="CURP" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.curp}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.fechaNacimiento.label" default="Fecha de nacimiento" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${viewModelInstance?.sustentanteInstance?.fechaNacimiento}"/>&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.nacionalidad.label" default="Nacionalidad" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nacionalidad?.descripcion}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.nivelEstudios.label" default="Nivel de estudios" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nivelEstudios?.descripcion}&nbsp;</p>
					</div>
				</div>
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.calidadMigratoria != null && viewModelInstance?.sustentanteInstance?.calidadMigratoria?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.calidadMigratoria.label" default="Calidad Migratoria" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.calidadMigratoria?.descripcion}&nbsp;</p>
						</div>
					</div>
				</g:if>
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.calidadMigratoria != null && viewModelInstance?.sustentanteInstance?.calidadMigratoria?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.profesion.label" default="Profesión" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.profesion?.descripcion}&nbsp;</p>
						</div>
					</div>
				</g:if>
				
				<legend><i>Domicilio</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.codigoPostal.label" default="C.P." />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.codigoPostal}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.entidadFederativa.label" default="Entidad Federativa" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.municipio?.entidadFederativa?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.municipio.label" default="Delegación o Municipio" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.municipio?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.asentamiento.label" default="Asentamiento (Colonia)" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.calle.label" default="Calle" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.calle}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.numeroExterior.label" default="Numero Exterior" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroExterior}&nbsp;</p>
					</div>
				</div>
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.numeroInterior != null && viewModelInstance?.sustentanteInstance?.numeroInterior?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.numeroInterior.label" default="Numero Interior" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">&nbsp;</p>
						</div>
					</div>
				</g:if>
				
				
				<legend><i>Contacto</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.correoElectronico.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.correoElectronico}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.telefonos.label" default="Teléfono(s)" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">
							<g:each in="${viewModelInstance?.sustentanteInstance?.telefonos.sort{it?.tipoTelefonoSustentante}}">
								<g:if test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('CASA') == 0}">
									<span class="glyphicon glyphicon-home"></span>
								</g:if>
								<g:elseif test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('TRABAJO') == 0}">
									<span class="glyphicon glyphicon-briefcase"></span>
								</g:elseif>
								<g:elseif test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('MÓVIL') == 0 || it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('MOVIL') == 0}">
									<span class="glyphicon glyphicon-phone"></span>
								</g:elseif>
								${it?.lada}&nbsp;${it?.telefono}&nbsp;
								<g:if test="${it.extension != null && it.extension.trim() != ''}">
									Ext. ${it?.extension}&nbsp;
								</g:if>
								(${it?.tipoTelefonoSustentante?.descripcion})
								<br/>
							</g:each>
						</p>
					</div>
				</div>
				
			</div>
			

			<div role="tabpanel" class="tab-pane" id="tabDocumentacion">
			
				<div id="divDocumentosSustentante">
				</div>
			
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabCertifaciones">
				<br/>
				<div class="list-group">
				
					<g:each var="x" in="${viewModelInstance?.sustentanteInstance?.certificaciones}">
						<div class="list-group-item">
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Figura</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.varianteFigura?.nombre}&nbsp;</p></div>
							</div>
							<legend><i>Autorización</i></legend>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Estatus de  autorización </label>
								<div class="col-sm-4"><p class="form-control-static">${x?.statusAutorizacion?.descripcion}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Tipo de autorización</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.varianteFigura?.tipoAutorizacionFigura}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">DGA </label>
								<div class="col-sm-4"><p class="form-control-static">${x?.dga}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Numero de Oficio </label>
								<div class="col-sm-4"><p class="form-control-static">${x?.numeroOficio}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de obtención</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaObtencion}"/>&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de inicio de autorización</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaAutorizacionInicio}"/>&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de fin de autorización</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaAutorizacionFin}"/>&nbsp;</p></div>
							</div>
							<legend><i>Certificación</i></legend>
							<div id="errorMessagesCertificationEditDates${x?.id}">&nbsp;</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Estatus de certificación</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.statusCertificacion?.descripcion}&nbsp;</p></div>
							</div>
							<div class="figuraRow row" id="fhIniCert${x?.id}">
								<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaInicio}"/>&nbsp;</p></div>
							</div>
							<div class="form-group div-fhIniCert${x?.id}" style="display:none;">
								<label class="col-md-4 col-sm-3 control-label">
									<span class="glyphicon glyphicon-import"></span><g:message code="puesto.fechaEditInicio.label" default="Fecha de inicio de vigencia" />
								</label>
								<div class="col-md-5 col-sm-5">
										<select style="width: 28%;" class="form-control col-md-4"
										 data-field="dayFhIniCert${x?.id}">
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
										data-field="monthFhIniCert${x?.id}" >
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
										 data-field="yearFhIniCert${x?.id}">
											<option value="-1">-Seleccione-</option>
											<g:each var="number" in="${(1950..2050)}">
											    <option value="${number}">${number}</option>
											</g:each>
										</select>
								</div>
							</div>
							<div class="figuraRow row" id="fhFinCert${x?.id}">
								<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaFin}"/>&nbsp;</p></div>
							</div>
							<div class="form-group div-fhFinCert${x?.id}" style="display:none;">
								<label class="col-md-4 col-sm-3 control-label">
									<span class="glyphicon glyphicon-import"></span><g:message code="puesto.fechaEditFin.label" default="Fecha de fin de vigencia" />
								</label>
								<div class="col-md-5 col-sm-5">
										<select style="width: 28%;" class="form-control col-md-4"
										 data-field="dayFhFinCert${x?.id}">
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
										data-field="monthFhFinCert${x?.id}" >
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
										 data-field="yearFhFinCert${x?.id}">
											<option value="-1">-Seleccione-</option>
											<g:each var="number" in="${(1950..2050)}">
											    <option value="${number}">${number}</option>
											</g:each>
										</select>
								</div>
							</div>
							
							
							
							
							<g:if test="${x?.validaciones.size() > 0}">
							<g:each in="${x?.validaciones[0].metodoValidacion}" var="vali">
        						<div class="figuraRow row">
									<label class="col-sm-3 control-label">Metodo de validación</label>
									<div class="col-sm-4"><p class="form-control-static">${vali?.descripcion}&nbsp;</p></div>
								</div>
      						</g:each>
							</g:if>
							<g:else>
							   <div class="figuraRow row">
									<label class="col-sm-3 control-label">Metodo de validación</label>
									<div class="col-sm-4"><p class="form-control-static">&nbsp;</p></div>
								</div>
							</g:else>
							<div class="row">
								<div style="text-align:center; margin-top: 0.75em;">
									<button type="button" class="edit btn btn-primary" onclick="enableCertificationEditDates(${x?.id},${viewModelInstance?.sustentanteInstance?.id});" id="enableEditCert${x?.id}" ><span class="glyphicon glyphicon-pencil"></span> Editar</button>
									<button type="button" class="update btn btn-info"  onclick="finishCertificationEditDates(${x?.id},${viewModelInstance?.sustentanteInstance?.id});"  id="finishEditCert${x?.id}" style="display:none;"><span class="glyphicon glyphicon-floppy-disk"></span> Finalizar edición</button>
									<button type="button" class="cancelEdit btn btn-danger"  onclick="cancelCertificationEditDates(${x?.id},${viewModelInstance?.sustentanteInstance?.id});"  id="cancelEditCert${x?.id}" style="display:none;"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
									<%--<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>  --%>
								</div>
							</div>
							
						</div>
					</g:each>
				
				</div>
				
				<fieldset id="opcionPFI">
					<legend>Lista de exámenes PFI</legend>
					<ul class="list-group" id="clasicPFIrevalidation">
							
					</ul>
				</fieldset>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabPoderVigente">
				<br/>
				<g:if test="${viewModelInstance?.poderInstance != null}">
				
					<fieldset>
						<legend><i>Datos del representante legal</i></legend>
						
						<div id="divRepLegalNom" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" />
							</label>
				            <div class="col-md-9 col-sm-9">
				            	<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalNombre}</p>
				            </div>
						</div>
		
						<div id="divAp1" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalApellido1}</p>
							</div>
						</div>
						
						<div id="divAp2" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" />					
							</label>
							<div class="col-md-9 col-sm-9">
								<g:if test="${viewModelInstance.poderInstance.representanteLegalApellido2.toString().compareToIgnoreCase('null') != 0}" >
									<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalApellido2}</p>
								</g:if>
								<g:else>
									<p class="form-control-static">&nbsp;</p>
								</g:else>
							</div>
						</div>
						
					</fieldset>
					
					
					<fieldset>
						<legend><i>Datos de la institución o grupo financiero</i></legend>
						
						<div id="divAdmGrupoFinanciero" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">
									<g:if test="${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ) != null}">
										${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).grupoFinanciero?.nombre}
									</g:if>
								</p>
				            </div>
						</div>
						
						<div id="divAdmInstitucion" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.institucion.label" default="Institución" />
							</label>
							<div class="col-md-9 col-sm-9">
									<g:if test="${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ) != null}">
										<p class="form-control-static">${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).nombre}</p>
									</g:if>
							</div>
						</div>
						
					</fieldset>
					
					<fieldset>
						<legend><i>Datos del poder</i></legend>
						
						<div id="divPdrNumEscrit" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.numeroEscritura.label" default="Numero de escritura" />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">${viewModelInstance?.poderInstance?.numeroEscritura}</p>
				            </div>
						</div>
						
						<div id="divFhApod" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.poderInstance?.fechaApoderamiento}</p>
							</div>
						</div>
						
					</fieldset>
					
					<fieldset>
						<legend><i>Datos del notario</i></legend>
						
						<%--<div id="divNumNotario" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.numero.label" default="Número" />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">${viewModelInstance?.notarioPoder?.numeroNotaria}</p>
				            </div>
						</div>--%>
						
						<div id="divNotarioEntidadFederativa" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa"  />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">${viewModelInstance?.entidadFederativaNotarioPoder?.nombre}</p>
				            </div>
						</div>
						
						<div id="divNombreCompleto" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.nombreCompletro.label" default="Nombre" />
							</label>
							
				            <div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.notarioPoder?.nombreCompleto}</p>
				            </div>
						</div>
						
					</fieldset>
					
					<fieldset>
						<legend><i>Documentos de respaldo</i></legend>
						
						<table class="table">
							<thead>
								<tr>
									<th style='width:32%;'>Tipo de documento</th>
									<th>Nombre de archivo</th>
									<th style='width:18%'>...</th>
								</tr>
							</thead>
							
							<tbody id="tbdyDocs">
									<tr>
										<td>Documento de respaldo poder</td>
										<td>${viewModelInstance?.documentoPoderRespaldo?.nombre}</td>
										<td>
											<button type="button" data-uuid="${viewModelInstance?.poderInstance?.uuidDocumentoRespaldo}" class="download btn btn-info btn-xs">Descargar</button>
										</td>
									</tr>
							</tbody>
						</table>
						
					</fieldset>
				
				</g:if>
				<g:else>
					<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> No hay datos respecto a algún apoderamiento vigente</div>
				</g:else>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabHistPoder">
				<br/>	
				<div id="divHistoricoPoderSustentante"></div>			
			</div>
			<div role="tabpanel" class="tab-pane" id="tabHistRevoc">
				<br/>
				<div id="divHistoricoRevocacionSustentante"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabPues">
				<div id="divPues"></div>
			</div>
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<g:render template="showDocumentos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.documentos.js" />
	<script>

	var app = app || {};

	var documentosView;
	var docsArray = new Array();
	var downloadUrl;

	<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.documentos}">
		docsArray.push({
			grailsId: ${i+1},
			uuid: '${x?.uuid}',
			vigente:  ${x?.vigente},
			nombre: "${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.nombre}",
			dsTipo: " ${x?.tipoDocumentoSustentate?.descripcion}",
			manejaVigenciaTipoDocumento: true,
			fechaCarga: '<g:formatDate format="dd-MM-yyyy" date="${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.fechaCreacion}"/> ',
			
			<g:if test="${i < 10}">
				visible: true
			</g:if>
		})
	</g:each>
	downloadUrl = '<g:createLink controller="documento" action="download" />';
	
	documentosView = new app.DocumentoSustentanteCollectionView({
		docsArray: docsArray,
		downloadUrl: downloadUrl
	});
	
	</script>
	
	<g:render template="showHistoricoApoderados" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.historicoApoderados.js" />
	<script>
	var app = app || {};

	var elementsArray = new Array();
	var poderUrl;
	var historioPoderView;
	
	<g:each var="x" in="${viewModelInstance?.historicoPoderes}">
		elementsArray.push({
			grailsId: ${x.id},
			numeroEscritura: ${x.numeroEscritura},
			nombreCompletoNotario: "${x.idNotario}",
			fechaApoderamiento: "<g:formatDate format="dd-MM-yyyy" date="${x.fechaApoderamiento}"/>",
			fechaApoderamientoUnixEpoch: ${x.fechaApoderamiento.getTime()/1000},
			grupoFinancieroNombre: "${x.idGrupoFinanciero}",
			institucionNombre: "${x.idInstitucion}",
			visible: true
		});
	</g:each>
	
	poderUrl = '<g:createLink controller="poder" action="show" />';
	historioPoderView = new app.HPoderVMCollectionView({elementsArray:elementsArray,poderUrl:poderUrl}); 
	
	</script>
	
	<g:render template="showHistoricoRevocados" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.historicoRevocados.js" />
	<script type="text/javascript">

	var app = app || {};

	var elementsArray = new Array();
	var revocacionUrl;
	var historioRevocacionesView;
	
	<g:each var="x" in="${viewModelInstance?.historioRevocaciones}">
		elementsArray.push({
			grailsId: ${x.id},
			numeroEscritura: ${x.numeroEscritura},
			nombreCompletoNotario: "${x.idNotario}",
			fechaRevocacion: "<g:formatDate format="dd-MM-yyyy" date="${x.fechaRevocacion}"/>",
			fechaRevocacionUnixEpoch: ${x.fechaRevocacion.getTime()/1000},
			grupoFinancieroNombre: "${x.idGrupoFinanciero}",
			institucionNombre: "${x.idInstitucion}",
			visible: true
		});
	</g:each>

	revocacionUrl = '<g:createLink controller="revocacion" action="show" />';
	historioRevocacionesView = new app.HRevocacionVMCollectionView({elementsArray:elementsArray, revocacionUrl:revocacionUrl}); 
	
	</script>
	
	<script type="text/javascript">
	
	$(".editar").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	$(".editarDoc").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	$(".eliminar").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	
	</script>
	
	<g:render template="../common/expedienteShowPuestos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.puestos.js" />
	<script type="text/javascript">
		var puestosArray = [];
		app.instituciones = [];
		<g:each var="x" in="${viewModelInstance?.institucionesList}">
			app.instituciones.push( (new app.Institucion(${x?.id},"${x?.nombre}")) );
		</g:each>

		puestosArray = [
		    			<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.puestos}">
		    				{
		    					grailsId: ${x?.id},
		    					idInstitucion: ${x?.idInstitucion},
		    					dsInstitucion: app.getInstitucionById(${x?.idInstitucion}).nombre,
		    					<g:if test="${x?.fechaInicio != null}">
		    					fechaInicio_day: ${x?.fechaInicio[Calendar.DATE]},
		    					fechaInicio_month: ${x?.fechaInicio[Calendar.MONTH]+1},
		    					fechaInicio_year: ${x?.fechaInicio[Calendar.YEAR]},
		    					</g:if>
		    					<g:if test="${x?.fechaFin != null}">
		    						fechaFin_day: ${x.fechaFin[Calendar.DATE]},
		    						fechaFin_month: ${x.fechaFin[Calendar.MONTH]+1},
		    						fechaFin_year: ${x.fechaFin[Calendar.YEAR]},
		    					</g:if>
		    					nombrePuesto: "${x?.nombrePuesto}",
		    					statusEntManifProtesta:  ${x?.statusEntManifProtesta},
		    					obsEntManifProtesta: "${x?.obsEntManifProtesta?:''}",
		    					statusEntCartaInter:  ${x?.statusEntCartaInter},
		    					obsEntCartaInter: "${x?.obsEntCartaInter?:''}",

		    					viewStatus: app.EXP_PUES_ST_VALIDATED,
		    					viewMode: app.EXP_PUES_MODE_NONEDIT

		    					<g:if test="${x!=null && x?.esActual}" >
		    						,esActual: "esActual"
		    					</g:if>
		    				}
		    				<g:if test="${i <= viewModelInstance?.sustentanteInstance?.puestos?.size() - 1 }" >
		    				,
		    				</g:if>
		    			</g:each>
		    			]
		
		var puestosView = new app.PuestosView(puestosArray);

		<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.puestos}">
			<g:if test="${x?.esActual}" >
				$("<style type='text/css'> div.esActual{ background-color:#eee; font-weight:bold;}</style>").appendTo("head");
			</g:if>
		</g:each>
	</script>
	
	
	
</body>
</html>