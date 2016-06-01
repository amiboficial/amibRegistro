<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Reposición de la autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Reposición de la autorización</a></li>
		<li><a href="<g:createLink controller="certificacionActualizacionAutorizacion" action="index" />">Búsqueda de candidatos a proceso</a></li>
		<li><a href="#">Proceso de reposición de autorización</a></li>
	</ul>

	<h2><strong>Proceso de reposición de autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action='<g:createLink controller="certificacionReposicionAutorizacion" action="save"/>' method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Revise y, en caso de ser necesario, rectifique la información del solicitante del cual solicitará autorización. Una vez que toda la información proporcionada este completa, vaya la pestaña "Aplicar proceso" y seleccione confirmar para completar.</div>
	
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabRepCert" aria-controls="tabRepCert" role="tab" data-toggle="tab">Certificación para reposición</a></li>
			<li role="presentation"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Domicilio</a></li>
			<li role="presentation"><a href="#tabCert" aria-controls="tabCert" role="tab" data-toggle="tab">Figura</a></li>
			<li role="presentation"><a href="#tabPues" aria-controls="tabPues" role="tab" data-toggle="tab">Relaciones laborales</a></li>
			<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Aplicar proceso</a></li>
		</ul>
	
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabRepCert">
				<!-- <div id="divRepAutCert">
				</div> -->
				<div id="divRevCert">
				<!-- AQUI SE RENDEREA RevCertAutVM -->
				</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabGen">
				<div id="divGen"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabTels">
				<div id="divTelefonos"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabDom">
				<div id="divDom"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCert">
				<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Es necesario que se capturen nuevamente las fechas de obtención de certificación, así como el rango de fechas sobre el cual aplicará la autorización a reponer.</div>
				<div id="divCert"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabPues">
				<div id="divPues"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
			
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckRevCert" class="glyphicon glyphicon-unchecked"></span> Datos de exámen para reposición</li>
							<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
							<li><span id="spnCheckTels" class="glyphicon glyphicon-unchecked"></span> Datos de teléfonos</li>
							<li><span id="spnCheckSepomex" class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
							<li><span id="spnCheckFigura" class="glyphicon glyphicon-unchecked"></span> Datos de figura</li>
							<li><span id="spnCheckPuestos" class="glyphicon glyphicon-unchecked"></span> Datos de relaciones laborales con institución</li>
						</ul>
					</div>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Agregar solicitud</button>
						</div>
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
					</div>
					<br/>
				</div>
				
			</div>
			
		</div>
	
	</form>

	<!-- 
	<g:render template="../common/reposicionAutorizacionCertificacion"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.opcionExamen.js" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.reposicionAutorizacionCertificacion.js" />
	<script type="text/javascript">
		var repCertAutView = null;
		var examenVMCollection = new app.ExamenVMCollection();

		<g:each var="x" in="${viewModelInstance?.examanesList?}">
			examenVMCollection.add( new app.ExamenVM({
				grailsId:${x?.idExamenReservacion},
				numeroMatricula:${x?.numeroMatricula},
				fechaAplicacionExamen:'${x?.fechaAplicacionExamen?.toString()}',
				fechaAplicacionExamenUnixEpoch:${x?.fechaAplicacionExamen?.getTime()/1000},
				descripcionFigura:'${x?.descripcionFigura}'
			}) );
		</g:each>

		repCertAutView = new app.RepAutCertView( { examenVMCollection:examenVMCollection } );
	</script>
	-->
			
	<g:render template="../common/revalidacionCertificacionAlAutorizar"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.opcionExamen.js" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.js" />
	<script type="text/javascript">
		var revCertAutView = null;
		var examenVMCollection = new app.ExamenVMCollection();

		<g:each var="x" in="${viewModelInstance?.examanesList?}">
			examenVMCollection.add( new app.ExamenVM({
				grailsId:${x?.idExamenReservacion},
				numeroMatricula:${x?.numeroMatricula},
				fechaAplicacionExamen:'${x?.fechaAplicacionExamen?.toString()}',
				fechaAplicacionExamenUnixEpoch:${x?.fechaAplicacionExamen?.getTime()/1000},
				descripcionFigura:'${x?.descripcionFigura}'
			}) );
		</g:each>

		var xmlResponsecontentstring = "${viewModelInstance?.PFIResult}";

		revCertAutView = new app.RevCertAutView( { examenVMCollection:examenVMCollection } );
	</script>
	

	<!-- INICIA: COMPONENTE DATOS GENERALES -->
	<g:render template="../common/expedienteGenerales"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.generales.js" />
	<script>
		var app = app || {};
		
		var generalesModel = new app.Generales();

		generalesModel.set("grailsId",${viewModelInstance?.sustentanteInstance?.id}-0);
		generalesModel.set("numeroMatricula",${viewModelInstance?.sustentanteInstance?.numeroMatricula}-0);
		generalesModel.set("nombre","${raw(viewModelInstance?.sustentanteInstance?.nombre)}");
		generalesModel.set("primerApellido","${raw(viewModelInstance?.sustentanteInstance?.primerApellido)}");
		generalesModel.set("segundoApellido","${raw(viewModelInstance?.sustentanteInstance?.segundoApellido)}");
		
		generalesModel.set("fechaNacimientoDay", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento[Calendar.DATE]});
		generalesModel.set("fechaNacimientoMonth", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento[Calendar.MONTH]+1});
		generalesModel.set("fechaNacimientoYear", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento[Calendar.YEAR]});
		
		generalesModel.set("genero","${viewModelInstance?.sustentanteInstance?.genero}");
		generalesModel.set("rfc","${viewModelInstance?.sustentanteInstance?.rfc}");
		generalesModel.set("curp","${viewModelInstance?.sustentanteInstance?.curp}");
		generalesModel.set("correoElectronico","${viewModelInstance?.sustentanteInstance?.correoElectronico}");

		generalesModel.set("estadoCivil",${viewModelInstance?.sustentanteInstance?.idEstadoCivil}-0);
		generalesModel.set("nivelEstudios",${viewModelInstance?.sustentanteInstance?.idNivelEstudios}-0);
		generalesModel.set("nacionalidad",${viewModelInstance?.sustentanteInstance?.idNacionalidad}-0);

		generalesModel.set("calidadMigratoria","${viewModelInstance?.sustentanteInstance?.calidadMigratoria}");
		generalesModel.set("profesion","${viewModelInstance?.sustentanteInstance?.profesion}");
		
		var generalesView = new app.GeneralesView(generalesModel);
	</script>
	<!-- FIN: COMPONENTE DATOS GENERALES -->

	<g:render template="../common/expedienteTelefonos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.telefonos.js" />
	<script>
		var app = app || {};
	
		var telefonosModel = new Array();

		<g:if test="${viewModelInstance?.sustentanteInstance?.telefonos != null && viewModelInstance?.sustentanteInstance?.telefonos?.size() > 0}">
			<g:each var="x" in="${viewModelInstance?.sustentanteInstance?.telefonos}">
			telefonosModel.push({ grailsId: ${x.id} ,lada:'${x.lada}',telefono:'${x.telefono}',extension:'${x.extension}', idTipoTelefono:${x.idTipoTelefonoSustentante},dsTipoTelefono:'${x.tipoTelefonoSustentante?.descripcion}' })
			</g:each>
		</g:if>
		
		var telefonosView = new app.TelefonosView(telefonosModel);
	</script>


	<g:render template="../common/expedienteDomicilio"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.domicilio.js" />
	<script>
		var domicilioModel = new app.Domicilio()
		var sepomexArray = new Array()
		<g:if test="${viewModelInstance?.sustentanteInstance?.idSepomex != null}">
			domicilioModel.set("codigoPostal","${viewModelInstance?.codigoPostal}");
			domicilioModel.set("idSepomex",${viewModelInstance?.sustentanteInstance?.idSepomex});
			domicilioModel.set("calle","${raw(viewModelInstance?.sustentanteInstance?.calle)}");
			domicilioModel.set("numeroInterior","${raw(viewModelInstance?.sustentanteInstance?.numeroInterior)}");
			domicilioModel.set("numeroExterior","${raw(viewModelInstance?.sustentanteInstance?.numeroExterior)}");
			sepomexArray = ${raw(viewModelInstance?.sepomexJsonList)};
		</g:if>
		var sepomexView = new app.SepomexView(sepomexArray, domicilioModel, '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>


	<g:render template="../common/expedientePuestos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.puestos.js" />
	<script>
		var app = app || {};

		var puestosArray = new Array();
		app.instituciones = new Array();
		<g:each var="x" in="${viewModelInstance?.institucionesList}">
			app.instituciones.push( (new app.Institucion(${x?.id},"${x?.nombre}")) );
		</g:each>

		puestosArray = [
		    			<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.puestos}">
		    				{
		    					grailsId: ${x?.id},
		    					idInstitucion: ${x?.idInstitucion},
		    					dsInstitucion: app.getInstitucionById(${x?.idInstitucion}).nombre,
		    					fechaInicio_day: ${x?.fechaInicio[Calendar.DATE]},
		    					fechaInicio_month: ${x?.fechaInicio[Calendar.MONTH]+1},
		    					fechaInicio_year: ${x?.fechaInicio[Calendar.YEAR]},
		    					<g:if test="${x.fechaFin != null}">
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
		    					viewMode: app.EXP_PUES_MODE_NONEDIT,
		    				}
		    				<g:if test="${i == viewModelInstance?.sustentanteInstance?.puestos?.size() - 1 }" >
		    				,
		    				</g:if>
		    			</g:each>
		    			]
		
		var puestosView = new app.PuestosView(puestosArray);
	</script>

	<g:render template="../certificacionDictamenPrevio/certificacionDictamen"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.certificacionDictamen.js" />
	<script>
		var app = app || {};

		var cert = new app.CertificacionViewModel();

		cert.set("grailsId",${viewModelInstance?.certificacionInstance?.id}-0);

		cert.set("nombreFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.nombreFigura}");
		cert.set("nombreVarianteFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.nombre}");
		cert.set("tipoAutorizacionFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.tipoAutorizacionFigura}");
		
		cert.set("statusEntHistorialInforme",${viewModelInstance?.certificacionInstance?.statusEntHistorialInforme}-0);
		cert.set("obsEntHistorialInforme","${viewModelInstance?.certificacionInstance?.obsEntHistorialInforme}");
		cert.set("statusEntCartaRec",${viewModelInstance?.certificacionInstance?.statusEntCartaRec}-0);
		cert.set("obsEntCartaRec","${viewModelInstance?.certificacionInstance?.obsEntCartaRec}");
		cert.set("statusConstBolVal",${viewModelInstance?.certificacionInstance?.statusConstBolVal}-0);
		cert.set("obsConstBolVal","${viewModelInstance?.certificacionInstance?.obsConstBolVal}");
		
		var certView = new app.CertificacionView({model:cert});
	</script>

	<!-- INICIA: COMPONENTE CHECKsLIST -->
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.certificacionReposicionAutorizacion.checklist.js" />
	<script>

		var app = app || {};

		var checkSubmitView = new app.CheckSubmitView();
		
		checkSubmitView.setViewInstance(app.CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.CHK_SEPOMEX,sepomexView);
		checkSubmitView.setViewInstance(app.CHK_CERT,certView);
		checkSubmitView.setViewInstance(app.CHK_PUES,puestosView);
		checkSubmitView.setViewInstance(app.CHK_REVALCERT,revCertAutView);
		
		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>	
	<!-- FIN: COMPONENTE CHECKLIST -->


<script>
$(".div-fechaObtencion").remove();
$(".div-fechaInicioAuth").remove();
$(".div-fechaFinAuth").remove();
</script>
</body>
</html>