<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Alta de oficio de autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="oficioCnbv" action="index" />">Oficios de Autorización (CNBV)</a></li>
		<li><a href="#">Alta de oficio</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Alta de oficio de autorización</strong></h2>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabOficio" aria-controls="tabOficio" role="tab" data-toggle="tab">Datos del oficio</a></li>
			<li role="presentation"><a href="#tabAutorizados" aria-controls="tabAutorizados" role="tab" data-toggle="tab">Datos de los autorizados</a></li>
			<li role="presentation"><a href="#tabDoc" aria-controls="tabDoc" role="tab" data-toggle="tab">Documento(s) de respaldo</a></li>
			<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Alta de información</a></li>
		</ul>
	
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabOficio">
				
				<div id="divOficioCnbv"></div>
				
			</div>
			<div role="tabpanel" class="tab-pane" id="tabAutorizados">
			
				<div id="divAutorizados"></div>
				
			</div>
			<div role="tabpanel" class="tab-pane" id="tabDoc">
				
				<div id="divDocumentos"></div>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckOficioCnbv" class="glyphicon glyphicon-unchecked"></span> Datos del oficio</li>
							<li><span id="spnCheckAutorizados" class="glyphicon glyphicon-unchecked"></span> Datos de los autorizados</li>
							<li><span id="spnCheckDocs" class="glyphicon glyphicon-unchecked"></span> Documento(s) de respaldo</li>
						</ul>
					</div>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Dar de alta oficio</button>
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

	<g:render template="./formOficioCnbv"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.form.datosOficio.js" />
	<script type="text/javascript">
		var app = app || {};

		var opts = { 
			checkUniqueClaveDgaUrl: '<g:createLink action="checkUniqueClaveDga" />',
			checkUniqueNumeroOficioUrl: '<g:createLink action="checkUniqueNumeroOficio" />'
		};
		
		var datosOficioView = new app.DatosOficioTabView({ model: new app.DatosOficioTabVM(opts) });
	</script>

	<g:render template="./formAutorizados"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.form.datosAutorizados.js" />
	<script type="text/javascript">
		var app = app || {};
		
		var autorizadosData;
		var datosAutorizadoView;
		var findAutorizableByNumeroMatriculaUrl;

		findAutorizableByNumeroMatriculaUrl = '<g:createLink action="findAutorizableByNumeroMatricula" />';
		
		/*autorizadosData = [
			{
				idCertificacion: 1,
				idSustentante: 1,
				numeroMatricula: '1',
				nombreCompleto: 'Perla Poon López',
				nombre: 'Perla',
				primerApellido: 'Poon',
				segundoApellido: 'López',
				dsFigura: 'Asesor de estrategias de inversión',
				dsVarianteFigura: 'Asesor de estrategias de inversión (Serie 100)',
				dsTipoAutorizacion: 'Autorizado para realzar accion dentro del estatuto general que implica los reglamentos impartidos'
			},
			{
				idCertificacion: 2,
				idSustentante: 2,
				numeroMatricula: '2',
				nombreCompleto: 'Meredith Coogan Pérez',
				nombre: 'Meredith',
				primerApellido: 'Coogan',
				segundoApellido: 'Pérez',
				dsFigura: 'Asesor de estrategias de inversión X',
				dsVarianteFigura: 'Asesor de estrategias de inversión (Serie 200)',
				dsTipoAutorizacion: 'XXXX Autorizado para realzar accion dentro del estatuto general que implica los reglamentos impartidos'
			},
			{
				idCertificacion: 3,
				idSustentante: 3,
				numeroMatricula: '3',
				nombreCompleto: 'Josephine Green Martinez',
				nombre: 'Josephine',
				primerApellido: 'Green',
				segundoApellido: 'Martinez',
				dsFigura: 'Asesor de estrategias de inversión Z',
				dsVarianteFigura: 'Asesor de estrategias de inversión (Serie 300)',
				dsTipoAutorizacion: 'ZZZZ Autorizado para realzar accion dentro del estatuto general que implica los reglamentos impartidos'
			},
			{
				idCertificacion: 4,
				idSustentante: 4,
				numeroMatricula: '4',
				nombreCompleto: 'Jennifer Aniston Rodriguez',
				nombre: 'Jennifer',
				primerApellido: 'Aniston',
				segundoApellido: 'Rodriguez',
				dsFigura: 'Asesor de estrategias de inversión Y',
				dsVarianteFigura: 'Asesor de estrategias de inversión (Serie 300)',
				dsTipoAutorizacion: 'YYYY Autorizado para realzar accion dentro del estatuto general que implica los reglamentos impartidos'
			}
		];*/
		
		datosAutorizadoView = new app.DatosAutorizadosTabView({ model: new app.DatosAutorizadosTabVM( {findAutorizableByNumeroMatriculaUrl:findAutorizableByNumeroMatriculaUrl} ), collection: new app.AutorizadoVMCollection() });
	</script>
	
	<g:render template="../common/docMultiples.v2"/>
	<g:javascript src="mx.amib.sistemas.registro.form.docMultiples.v2.js" />
	<script type="text/javascript">
		var app = app || {};
		
		/*
		EJEMPLO DE INSTANCIAMIENTO
		var documentosView = new app.DocumentosView({
			tiposDocumento: [
				{
					grailsId: 1,
					descripcion: "Documento de respaldo de poder 1",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 1,
					manejaVigencia: false
				},
				{
					grailsId: 2,
					descripcion: "Documento de respaldo de poder 2",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 3,
					manejaVigencia: true
				},
			],
			manejaVigencia: true,
			initialDocumentos: new app.Documentos()
		});
		*/
		
		var documentosView = new app.DocumentosView({
			tiposDocumento: [
				{
					grailsId: 1,
					descripcion: "Oficio de autorización",
					vigente: true,
					cantidadRequerida: 1,
					cantidadMaxima: 1,
					manejaVigencia: false
				},
			],
			manejaVigencia: true,
			initialDocumentos: new app.Documentos()
		});
		
		documentosView.setUploadUrl('<g:createLink controller="documento" action="upload" />');
		documentosView.setDownloadNewUrl('<g:createLink controller="documento" action="downloadNew" />');
		documentosView.setDownloadUrl('<g:createLink controller="documento" action="download" />');
		documentosView.setDeleteNewUrl('<g:createLink controller="documento" action="delete" />');
	</script>

	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.create.checklist.js" />
	<script type="text/javascript">
		
		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.OFA_CREATE_CHKIDX_DATOFICIO,datosOficioView);
		checkSubmitView.setViewInstance(app.OFA_CREATE_CHKIDX_AUTORIZADOS,datosAutorizadoView);
		checkSubmitView.setViewInstance(app.OFA_CREATE_CHKIDX_DOCS,documentosView);
		
		/*

		Ejemplo de instanciamineto en el GSP,JSP,etc..-

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_SEPOMEX,sepomexView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_REGISTRO,registroView);

		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});
		*/
	</script>

</body>
</html>