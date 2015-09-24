<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Gestión de documentación</title>
</head>
<body>

	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="index" />">Expedientes</a></li>
		<li><a href="<g:createLink controller="expediente" action="show" id="${viewModelInstance?.sustentanteInstance?.id}"/>">Vista de expediente</a></li>
		<li><a href="#">Gestión de documentación</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Gestión de documentación</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action='<g:createLink controller="expediente" action="updateDoc" id="${viewModelInstance?.sustentanteInstance?.id}"/>' method="post">
	
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabDoc" aria-controls="tabDoc" role="tab" data-toggle="tab">Documentos del sustentante</a></li>
			<li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Confirmar acción</a></li>
		</ul>
		
		<div class="tab-content">
			<br/>
			<div role="tabpanel" class="tab-pane active" id="tabDoc">
				<div id="divDocumentos"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
				
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
					<div class="panel-heading">Checklist de validación de información</div>
					<div class="panel-body">
						<ul style="list-style-type:none">
							<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Documentos del sustentante</li>
						</ul>
					</div>
					<div class="form-group">
						<div class="col-md-3 col-sm-3">
							&nbsp;
						</div>
						<div class="col-md-6 col-sm-6" style="text-align: center">
							<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Confirmar edición de información</button>
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

	
	<g:render template="../common/docMultiples.v2"/>
	<g:javascript src="mx.amib.sistemas.registro.form.docMultiples.v2.js" />
	<script type="text/javascript">
		var app = app || {};
		var tiposDocumento = new Array();
		var initialDocumentosArray = new Array();
		
		<g:each var="x" in="${viewModelInstance?.tipoDocumentoList}">
			tiposDocumento.push({
				grailsId: ${x.id},
				descripcion: "${x.descripcion}",
				vigente: ${x.vigente},
				cantidadRequerida: 0,
				cantidadMaxima: 128,
				manejaVigencia: true
			});
		</g:each>

		<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.documentos}">
			initialDocumentosArray.push({
				grailsId: ${i+1},
				uuid: '${x?.uuid}',
				vigente:  ${x?.vigente},
				nombreArchivo: "${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.nombre}",
				mimeType: "${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.mimetype}",
				idTipoDocumento:  ${x?.tipoDocumentoSustentate?.id},
				descripcionTipoDocumento: " ${x?.tipoDocumentoSustentate?.descripcion}",
				manejaVigenciaTipoDocumento: true,
				fecha: '${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.fechaCreacion}'
			})
		</g:each>
		
		var documentosView = new app.DocumentosView({
			tiposDocumento: tiposDocumento,
			manejaVigencia: true,
			initialDocumentos: new app.Documentos(initialDocumentosArray)
		});
		
		documentosView.setUploadUrl('<g:createLink controller="documento" action="upload" />');
		documentosView.setDownloadNewUrl('<g:createLink controller="documento" action="downloadNew" />');
		documentosView.setDownloadUrl('<g:createLink controller="documento" action="download" />');
		documentosView.setDeleteNewUrl('<g:createLink controller="documento" action="delete" />');

		documentosView.render();
		
	</script>
	
	<script>

		var app = app || {};

		app.CHK_DOCS = 0;

		app.CheckSubmit = Backbone.Model.extend({
			defaults: {
				checkarray: [false,false,false],
				viewsarray: [undefined,undefined,undefined],

				sustentanteId: -1
			}
		});

		app.CheckSubmitView = Backbone.View.extend({
			el: '#divCheckSubmit',
			allchecked: false,
			model: new app.CheckSubmit(),

			initialize: function(){
				this.render();
			},

			events: {
				'click .submit': 'submitDatos',
			},

			render: function(){
				var arr = this.model.get("checkarray");
				var allChecked = true;
				if(arr[app.CHK_DOCS] == false){
					allChecked = false;
					this.$("#spnCheckGrales").removeClass("glyphicon-check");
					this.$("#spnCheckGrales").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckGrales").removeClass("glyphicon-unchecked");
					this.$("#spnCheckGrales").addClass("glyphicon-check");
				}

				if(allChecked == false){
					this.$(".submit").prop( "disabled", true );
				}
				else{
					this.$(".submit").prop( "disabled", false );
				}
			},

			setViewInstance: function(viewIndex,viewInstance){
				var arr = this.model.get('viewsarray');
				var context = this;

				viewInstance.setCheckId(viewIndex); // <- setea el viewIndex como checkId
				arr[viewIndex] = viewInstance;

				viewInstance.on("stateChange",function(newState, checkId){
					context.checkElement(newState,checkId); //<- usa el checkId como viewIndex
				});
			},

			//TODO: EVENTS, EL SUBMIT CON TODOS LOS DATOS PARA EL REGISTRO
			checkElement: function(newState,viewIndex){
				var checkarr = this.model.get('checkarray');
				if(newState == "VALIDATED")
					checkarr[viewIndex] = true;
				else
					checkarr[viewIndex] = false;
				this.render();
			},

			submitDatos: function(){
				var arr = this.model.get('viewsarray');

				this.$("#spnHdnPostData").html('<input type="hidden" name="documentos" value=\'' + JSON.stringify(arr[app.CHK_DOCS].collection.toJSON()) + '\' />');

				$("#frmApp").submit();
			},
		});

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.model.set('sustentanteId', ${viewModelInstance?.sustentanteInstance?.id} )
		checkSubmitView.setViewInstance(app.CHK_DOCS,documentosView);

		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>

</body>
</html>