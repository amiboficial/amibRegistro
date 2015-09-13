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
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="#">Actualización de la autorización</a></li>
		<li><a href="<g:createLink controller="certificacionActualizacionAutorizacion" action="index" />">Búsqueda de candidatos a proceso</a></li>
		<li><a href="#">Proceso de actualización</a></li>
	</ul>
	<h2><strong>Proceso de actualización de autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action='<g:createLink controller="certificacionActualizacionAutorizacion" action="save"/>' method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Revise y, en caso de ser necesario, rectifique la información del solicitante del cual solicitará autorización. Una vez que toda la información proporcionada este completa, vaya la pestaña "Aplicar proceso" y seleccione confirmar para completar.</div>
	
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabRevCert" aria-controls="tabRevCert" role="tab" data-toggle="tab">Revalidación de certificación</a></li>
			<li role="presentation"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Domicilio</a></li>
			<li role="presentation"><a href="#tabCert" aria-controls="tabCert" role="tab" data-toggle="tab">Figura</a></li>
			<li role="presentation"><a href="#tabPues" aria-controls="tabPues" role="tab" data-toggle="tab">Relaciones laborales</a></li>
			<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Aplicar proceso</a></li>
		</ul>
	
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabRevCert">
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
							<li><span id="spnCheckRevCert" class="glyphicon glyphicon-unchecked"></span> Datos de la revalidación de la certificación</li>
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

	<g:render template="../common/RevalidacionCertificacionAlAutorizar"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.opcionExamen.js" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.js" />
	<script type="text/javascript">
		var revCertAutView = null;
		var examenVMCollection = new app.ExamenVMCollection();

		examenVMCollection.add( new app.ExamenVM({grailsId:1,numeroMatricula:1}) );
		examenVMCollection.add( new app.ExamenVM({grailsId:2,numeroMatricula:2}) );
		examenVMCollection.add( new app.ExamenVM({grailsId:3,numeroMatricula:3}) );

		revCertAutView = new app.RevCertAutView( { examenVMCollection:examenVMCollection } );
	</script>

	<!-- INICIA: COMPONENTE DATOS GENERALES -->
	<g:render template="../common/expedienteGenerales"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.generales.js" />
	<script>
		var app = app || {};
		
		var generalesModel = new app.Generales();
		
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

		var sepomexView = new app.SepomexView(sepomexArray, domicilioModel, '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>


	<g:render template="../common/expedientePuestos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.puestos.js" />
	<script>
		var app = app || {};

		var puestosArray = new Array();
		app.instituciones = new Array();
		
		var puestosView = new app.PuestosView(puestosArray);
	</script>

	<g:render template="../certificacionDictamenPrevio/certificacionDictamen"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.certificacionDictamen.js" />
	<script>
		var app = app || {};

		var cert = new app.CertificacionViewModel();
		
		var certView = new app.CertificacionView({model:cert});
	</script>

	<!-- INICIA: COMPONENTE CHECKsLIST -->
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.revalidacionCertificacionAlAutorizar.checklist.js" />
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

</body>
</html>