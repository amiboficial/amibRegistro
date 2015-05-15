<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Añadir solicitud a registro</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expedienteRegistrable" action="index" />">Solicitud de Registro</a></li>
		<li><a href="#">Añadir a registro</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Añadir a registro</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Complete adecuadamenete la información del solicitante que se va añadir al registro. Una vez que toda la información proporcionada este completa, revisando el "checklist" en la parte inferior, podrá proceder a agregar la solicitud.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Datos de teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Datos de domicilio</a></li>
			<li role="presentation"><a href="#tabReg" aria-controls="tabReg" role="tab" data-toggle="tab">Datos de registro</a></li>
			<!-- 
			<li role="presentation"><a href="#divDoc" aria-controls="divDoc" role="tab" data-toggle="tab">Revisión de documentos</a></li>
			 -->
		</ul>
		
		<div class="tab-content">
			<br/>
			
			<div role="tabpanel" class="tab-pane active" id="tabGen">
				<div id="divGen"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabTels">
				<div id="divTelefonos"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabDom">
				<div id="divDom"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabReg">
				<div id="divReg"></div>
			</div>

			<br/>
		</div>
		
		<br/>
		
		<div id="divCheckSubmit" class="panel panel-default">
			<div class="panel-heading">Checklist de validación de información</div>
			<div class="panel-body">
				<ul style="list-style-type:none">
					<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
					<li><span id="spnCheckTels" class="glyphicon glyphicon-unchecked"></span> Datos de teléfonos</li>
					<li><span id="spnCheckSepomex" class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
					<li><span id="spnCheckRegistro" class="glyphicon glyphicon-unchecked"></span> Datos de registro</li>
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

	</form>
	
	<g:render template="../common/expedienteGenerales"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.generales.js" />
	<script>
	var generalesView = new app.GeneralesView(new app.Generales());
	</script>
	
	<g:render template="../common/expedienteTelefonos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.telefonos.js" />
	<script>
	var telefonosView = new app.TelefonosView();
	</script>

	<g:render template="../common/expedienteDomicilio"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.domicilio.js" />
	<script>
	// TODO: RECIBIR CADENA CON ANTIGUO FORMATO DE DOMICILIO
	var sepomexView = new app.SepomexView(new Array(),new app.Domicilio(), '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>
	
	<g:render template="../common/expedienteDatosRegistro"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.registro.js" />
	<script>
	var registroView = new app.RegistroView(new app.Registro());
	</script>

	<script>

		var app = app || {};

		app.EXP_REG_CHK_GRALES = 0;
		app.EXP_REG_CHK_TELS = 1;
		app.EXP_REG_CHK_SEPOMEX = 2;
		app.EXP_REG_CHK_REGISTRO = 3;

		app.CheckSubmit = Backbone.Model.extend({
			defaults: {
				checkarray: [true,true,true,true],
			}
		});

		app.CheckSubmitView = Backbone.View.extend({
			el: '#divCheckSubmit',
			allchecked: false,
			model: new app.CheckSubmit(),

			initialize: function(){
				this.render();
			},

			render: function(){
				var arr = this.model.get("checkarray");
				var allChecked = true;
				if(arr[app.EXP_REG_CHK_GRALES] == false){
					allChecked = false;
					this.$("#spnCheckGrales").removeClass("glyphicon-check");
					this.$("#spnCheckGrales").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckGrales").removeClass("glyphicon-unchecked");
					this.$("#spnCheckGrales").addClass("glyphicon-check");
				}
				if(arr[app.EXP_REG_CHK_TELS] == false){
					allChecked = false;
					this.$("#spnCheckTels").removeClass("glyphicon-check");
					this.$("#spnCheckTels").addClass("glyphicon-unchecked");
				}
				else{
					console.log("fue true el de telefonos");
					this.$("#spnCheckTels").removeClass("glyphicon-unchecked");
					this.$("#spnCheckTels").addClass("glyphicon-check");
				}
				if(arr[app.EXP_REG_CHK_SEPOMEX] == false){
					allChecked = false;
					this.$("#spnCheckSepomex").removeClass("glyphicon-check");
					this.$("#spnCheckSepomex").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckSepomex").removeClass("glyphicon-unchecked");
					this.$("#spnCheckSepomex").addClass("glyphicon-check");
				}
				if(arr[app.EXP_REG_CHK_REGISTRO] == false){
					allChecked = false;
					this.$("#spnCheckRegistro").removeClass("glyphicon-check");
					this.$("#spnCheckRegistro").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckRegistro").removeClass("glyphicon-unchecked");
					this.$("#spnCheckRegistro").addClass("glyphicon-check");
				}

				if(allChecked == false){
					this.$(".submit").prop( "disabled", true );
				}
				else{
					this.$(".submit").prop( "disabled", false );
				}
			}
			//TODO: EVENTS, EL SUBMIT CON TODOS LOS DATOS PARA EL REGISTRO
		});

		var checkSubmitView = new app.CheckSubmitView();

	</script>
	
</body>
</html>