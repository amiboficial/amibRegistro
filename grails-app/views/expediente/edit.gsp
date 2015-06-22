<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Editar datos personales</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="index" />">Expedientes</a></li>
		<li><a href="<g:createLink controller="expediente" action="show" id="${viewModelInstance?.sustentanteInstance?.id}"/>">Vista de expediente</a></li>
		<li><a href="#">Editar datos personales</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Editar  datos personales</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action=<g:createLink controller="expediente" action="updateDatosPersonales"/> method="post">
	
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Edite adecuadamenete la información del solicitante. Una vez que toda la información proporcionada este completa, revisando el "checklist" en la parte inferior, podrá proceder a confirmar los cambios.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Datos de teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Datos de domicilio</a></li>
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

			<br/>
		</div>
	
		<br/>
		
		<div id="divCheckSubmit" class="panel panel-default">
			<span id="spnHdnPostData">
			</span>
			<div class="panel-heading">Checklist de validación de información</div>
			<div class="panel-body">
				<ul style="list-style-type:none">
					<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
					<li><span id="spnCheckTels" class="glyphicon glyphicon-unchecked"></span> Datos de teléfonos</li>
					<li><span id="spnCheckSepomex" class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
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
	
	</form>
	
	<g:render template="../common/expedienteGenerales"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.generales.js" />
	<script>
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
	
	<g:render template="../common/expedienteTelefonos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.telefonos.js" />
	<script>
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
		domicilioModel.set("numeroInterior","${viewModelInstance?.sustentanteInstance?.numeroInterior}");
		domicilioModel.set("numeroExterior","${viewModelInstance?.sustentanteInstance?.numeroExterior}");
		sepomexArray = ${raw(viewModelInstance?.sepomexJsonList)};
	</g:if>
	var sepomexView = new app.SepomexView(sepomexArray, domicilioModel, '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>
	
	<script>

		var app = app || {};

		app.EXP_EDT_CHK_GRALES = 0;
		app.EXP_EDT_CHK_TELS = 1;
		app.EXP_EDT_CHK_SEPOMEX = 2;

		app.CheckSubmit = Backbone.Model.extend({
			defaults: {
				checkarray: [false,false,false],
				viewsarray: [undefined,undefined,undefined]
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
				if(arr[app.EXP_EDT_CHK_GRALES] == false){
					allChecked = false;
					this.$("#spnCheckGrales").removeClass("glyphicon-check");
					this.$("#spnCheckGrales").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckGrales").removeClass("glyphicon-unchecked");
					this.$("#spnCheckGrales").addClass("glyphicon-check");
				}
				if(arr[app.EXP_EDT_CHK_TELS] == false){
					allChecked = false;
					this.$("#spnCheckTels").removeClass("glyphicon-check");
					this.$("#spnCheckTels").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckTels").removeClass("glyphicon-unchecked");
					this.$("#spnCheckTels").addClass("glyphicon-check");
				}
				if(arr[app.EXP_EDT_CHK_SEPOMEX] == false){
					allChecked = false;
					this.$("#spnCheckSepomex").removeClass("glyphicon-check");
					this.$("#spnCheckSepomex").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckSepomex").removeClass("glyphicon-unchecked");
					this.$("#spnCheckSepomex").addClass("glyphicon-check");
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
				//El método introduce los datos en campos "hidden" con los que se hará POST
				//datos generales
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.id" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('grailsId') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroMatricula" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('numeroMatricula') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.nombre" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('nombre') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.primerApellido" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('primerApellido') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.segundoApellido" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('segundoApellido') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.genero" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('genero') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.rfc" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('rfc') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.curp" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('curp') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_day" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('fechaNacimientoDay') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_month" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('fechaNacimientoMonth') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_year" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('fechaNacimientoYear') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.correoElectronico" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('correoElectronico') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calidadMigratoria" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('calidadMigratoria') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.profesion" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('profesion') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNacionalidad" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('nacionalidad') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNivelEstudios" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('nivelEstudios') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idEstadoCivil" value="' + arr[app.EXP_EDT_CHK_GRALES].model.get('estadoCivil') + '" />');
				//datos de telefonos
				var telsJson = "[";
				arr[app.EXP_EDT_CHK_TELS].collection.each(function(item){
					telsJson += JSON.stringify(item) + ",";
				}, this);
				telsJson += "]";
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.telefonos_json" value=\'' + telsJson + '\' />');
				//datos de sepomex
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idSepomex" value="' + arr[app.EXP_EDT_CHK_SEPOMEX].model.get('idSepomex') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calle" value="' + arr[app.EXP_EDT_CHK_SEPOMEX].model.get('calle') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroInterior" value="' + arr[app.EXP_EDT_CHK_SEPOMEX].model.get('numeroInterior') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroExterior" value="' + arr[app.EXP_EDT_CHK_SEPOMEX].model.get('numeroExterior') + '" />');

				$("#frmApp").submit();
			},
		});

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_SEPOMEX,sepomexView);

		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>
	
</body>
</html>