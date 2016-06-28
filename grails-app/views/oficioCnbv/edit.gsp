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
		<li><a href="<g:createLink controller="oficioCnbv" action="edit" />">Oficios de Autorización (CNBV)</a></li>
		<li><a href="#">Edición de oficio</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->

	<h2><strong>Edición de oficio de autorización</strong></h2>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="update" method="post">
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabOficio" aria-controls="tabOficio" role="tab" data-toggle="tab">Datos del oficio</a></li>
			<li role="presentation"><a href="#tabAutorizados" aria-controls="tabAutorizados" role="tab" data-toggle="tab">Datos de los autorizados</a></li>
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
			
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckOficioCnbv" class="glyphicon glyphicon-unchecked"></span> Datos del oficio</li>
							<li><span id="spnCheckAutorizados" class="glyphicon glyphicon-unchecked"></span> Datos de los autorizados</li>
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
		<span id="spnHdnPostData"></span>
	</form>

	<g:render template="./formOficioCnbv"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.edit.datosOficio.js" />
	<script type="text/javascript">
		var app = app || {};

		var opts;
		<g:if test="${viewModelInstance?.oficioCnbv?.fechaOficio != null}">
		opts = { 
				checkUniqueClaveDgaUrl: '<g:createLink action="checkUniqueClaveDga" />',
				checkUniqueNumeroOficioUrl: '<g:createLink action="checkUniqueNumeroOficio" />',
					claveDga: "${viewModelInstance?.oficioCnbv?.claveDga}",
					numeroOficio: "${viewModelInstance?.oficioCnbv?.numeroOficio}",
					fechaOficio_day: ${viewModelInstance?.oficioCnbv?.fechaOficio[Calendar.DATE]},
					fechaOficio_month: ${viewModelInstance?.oficioCnbv?.fechaOficio[Calendar.MONTH]+1},
					fechaOficio_year: ${viewModelInstance?.oficioCnbv?.fechaOficio[Calendar.YEAR]}
			};
		</g:if>
		<g:else>
		opts = { 
			checkUniqueClaveDgaUrl: '<g:createLink action="checkUniqueClaveDga" />',
			checkUniqueNumeroOficioUrl: '<g:createLink action="checkUniqueNumeroOficio" />',
				claveDga: "${viewModelInstance?.oficioCnbv?.claveDga}",
				numeroOficio: "${viewModelInstance?.oficioCnbv?.numeroOficio},",
				fechaOficio_day: -1,
				fechaOficio_month: -1,
				fechaOficio_year: -1
		};
		</g:else>
		var datosOficioView = new app.DatosOficioTabView({ model: new app.DatosOficioTabVM(opts) });
	</script>

	<g:render template="./formAutorizados"/>
	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.form.datosAutorizados.viewModels.js" />
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
			}
		];*/
		
		datosAutorizadoView = new app.DatosAutorizadosTabView({ model: new app.DatosAutorizadosTabVM( {findAutorizableByNumeroMatriculaUrl:findAutorizableByNumeroMatriculaUrl} ), collection: new app.AutorizadoVMCollection() });
	</script>

	<g:javascript src="mx.amib.sistemas.registro.autorizacionCnbv.oficioCnbv.edit.checklist.js" />
	<script type="text/javascript">

//	var congiuration = {
//			checkarray: [false],
//			viewsarray: [undefined]
//		}
//		var checkSubmitView = new app.CheckSubmitView({ model: new app.CheckSubmit(congiuration) });
	var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.OFA_CREATE_CHKIDX_DATOFICIO,datosOficioView);
		checkSubmitView.setViewInstance(app.OFA_CREATE_CHKIDX_AUTORIZADOS,datosAutorizadoView);

		$(function() {
		    
		});
	</script>

</body>
</html>