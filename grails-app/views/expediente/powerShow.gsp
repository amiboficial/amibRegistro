<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Vista de expediente</title>
<script type="text/javascript">
var xmlResponsecontentstring = "${viewModelInstance?.PFIResult}";

function showPFI(){
	this.$('#opcionPFI').show();
	if(xmlResponsecontentstring == undefined || xmlResponsecontentstring == "" ){
		this.$('#clasicPFIrevalidation').html('<div class="form-group"><label class="col-md-2 col-sm-3 control-label">No se pudo contactar el servicio intentelo mas tarde</label></div>');
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
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="poderes" />">Expedientes</a></li>
		<li><a href="#">Vista de expediente</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	
	<h2><strong>Datos de expediente</strong></h2>
	<h4>${raw(viewModelInstance?.nombreCompleto)} (Matricula: ${viewModelInstance?.sustentanteInstance?.numeroMatricula}, Folio: ${viewModelInstance?.sustentanteInstance?.id})</h4>
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<fieldset class="form-horizontal">
		<legend>Expediente</legend>
		
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#tabDatosPersonales" aria-controls="tabDatosPersonales" role="tab" data-toggle="tab">Datos personales</a></li>
		  <li role="presentation"><a href="#tabCertifaciones" aria-controls="tabCertifaciones" role="tab" data-toggle="tab">Certificaciones</a></li>
<%--		  <li role="presentation"><a href="#tabPoderVigente" aria-controls="tabPoderVigente" role="tab" data-toggle="tab">Poder vigente</a></li>--%>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tabDatosPersonales">
				<br/>
				
				<legend><i>Información personal</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.Matricula.label" default="Matricula" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroMatricula}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.Folio.label" default="Folio" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.id}&nbsp;</p>
		            </div>
				</div>
				
				
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
						<g:message code="sustentante.nacionalidad.label" default="Nacionalidad" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nacionalidad?.descripcion}&nbsp;</p>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.GrupoFinanciero.label" default="Grupo financiero" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroExterior}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.Institución.label" default="Institución" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroInterior}&nbsp;</p>
		            </div>
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
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Estatus de certificación</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.statusCertificacion?.descripcion}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaInicio}"/>&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaFin}"/>&nbsp;</p></div>
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
						</div>
					</g:each>
				
				</div>
				
				<fieldset id="opcionPFI">
					<legend>Lista de exámenes PFI</legend>
					<ul class="list-group" id="clasicPFIrevalidation">
							
					</ul>
				</fieldset>
				
			</div>
			
<!--
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
								<p class="form-control-static">${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).grupoFinanciero?.nombre}</p>
				            </div>
						</div>
						
						<div id="divAdmInstitucion" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.institucion.label" default="Institución" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).nombre}</p>
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
						
						<div id="divNumNotario" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.numero.label" default="Número" />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">${viewModelInstance?.notarioPoder?.numeroNotaria}</p>
				            </div>
						</div>
						
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
				
				</g:if>
				<g:else>
					<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> No hay datos respecto a algún apoderamiento vigente</div>
				</g:else>
				
			</div>
-->
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<script type="text/javascript">
	$("#divAffixSidebar").parent().remove();
	$(".nav.navbar-nav.pull-right").parent().remove();
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
	
	
	
	</script>
	
	<g:render template="showHistoricoApoderados" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.historicoApoderados.js" />
	<script type="text/javascript" >
	var app = app || {};

	var elementsArray = new Array();
	var poderUrl;
	var historioPoderView;
	
	<g:each var="x" in="${viewModelInstance?.historicoPoderes}" >
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
	
</body>
</html>