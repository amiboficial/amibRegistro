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

	<form id="frmApp" class="form-horizontal" role="form" action=<g:createLink controller="expedienteRegistrable" action="save"/> method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Complete adecuadamenete la información del solicitante que se va añadir al registro. Una vez que toda la información proporcionada este completa, revisando el "checklist" en la parte inferior, podrá proceder a agregar la solicitud.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Datos de teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Datos de domicilio</a></li>
			<li role="presentation"><a href="#tabReg" aria-controls="tabReg" role="tab" data-toggle="tab">Datos de registro</a></li>
			<!-- 
			<li role="presentation"><a href="#divDoc" aria-controls="divDoc" role="tab" data-toggle="tab">Revisión de documentos</a></li>
			 -->
			 <li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Agregar solicitud</a></li>
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
				<g:if test="${viewModelInstance?.registroExamenInstance != null && viewModelInstance?.registroExamenInstance?.domicilio != null && viewModelInstance?.registroExamenInstance.domicilio != ""}">
		            <div class="alert alert-warning">
		                La siguiente <strong>información del domicilio</strong> ha sido proporcionada por el solicitante:<br/>
		                <span style="font-style: italic; font-size: 150%;">${viewModelInstance?.registroExamenInstance?.domicilio} , <strong>Código Postal:</strong> ${viewModelInstance?.registroExamenInstance?.codigoPostal}</span> <br/>
		                <strong>Reintroduza</strong> los datos con base en esta información. El código postal debe proporcionar información que coincida con la entidad federativa y el municipio del solicitante.
		            </div>
		        </g:if>
				<div id="divDom"></div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tabReg">
				<div id="divReg"></div>
			</div>

			<div role="tabpanel" class="tab-pane" id="tabCheckSubmit">
			
				<div id="divCheckSubmit" class="panel panel-default">
					<span id="spnHdnPostData">
					</span>
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
				
			</div>

		</div>
		
		<br/>
		
				

	</form>
	
	<g:render template="../common/expedienteGenerales"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.generales.js" />
	<script>

	var generalesModel = new app.Generales();
	generalesModel.set("numeroMatricula",${viewModelInstance?.registroExamenInstance?.numeroMatricula});
	generalesModel.set("nombre","${raw(viewModelInstance?.registroExamenInstance?.nombre)}");
	generalesModel.set("primerApellido","${raw(viewModelInstance?.registroExamenInstance?.primerApellido)}");
	generalesModel.set("segundoApellido","${raw(viewModelInstance?.registroExamenInstance?.segundoApellido)}");

	generalesModel.set("fechaNacimientoDay",${viewModelInstance?.registroExamenInstance?.fechaNacimientoDay});
	generalesModel.set("fechaNacimientoMonth",${viewModelInstance?.registroExamenInstance?.fechaNacimientoMonth});
	generalesModel.set("fechaNacimientoYear",${viewModelInstance?.registroExamenInstance?.fechaNacimientoYear});

	generalesModel.set("genero","${viewModelInstance?.registroExamenInstance?.genero}");
	generalesModel.set("rfc","${viewModelInstance?.registroExamenInstance?.rfc}");
	generalesModel.set("curp","${viewModelInstance?.registroExamenInstance?.curp}");
	generalesModel.set("correoElectronico","${viewModelInstance?.registroExamenInstance?.correoElectronico}");

	generalesModel.set("estadoCivil",${viewModelInstance?.registroExamenInstance?.idEstadoCivil});
	generalesModel.set("nivelEstudios",${viewModelInstance?.registroExamenInstance?.idNivelEstudios});
	generalesModel.set("nacionalidad",${viewModelInstance?.registroExamenInstance?.idNacionalidad});

	generalesModel.set("calidadMigratoria","");
	generalesModel.set("profesion","");
	generalesModel.set("asentamientoOtro","");

	var generalesView = new app.GeneralesView(generalesModel);

	</script>
	
	<g:render template="../common/expedienteTelefonos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.telefonos.js" />
	<script>
	var telefonosModel = new Array();
	<g:if test="${viewModelInstance?.registroExamenInstance != null && viewModelInstance?.registroExamenInstance?.telefonoCasa != null && viewModelInstance?.registroExamenInstance.telefonoCasa != ""}">
	telefonosModel.push({ grailsId:-1,lada:'',telefono:'${viewModelInstance?.registroExamenInstance?.telefonoCasa}',extension:'', idTipoTelefono:1,dsTipoTelefono:'Casa' })
	</g:if>
	<g:if test="${viewModelInstance?.registroExamenInstance != null && viewModelInstance?.registroExamenInstance?.telefonoOficina != null && viewModelInstance?.registroExamenInstance.telefonoOficina != ""}">
	telefonosModel.push({ grailsId:-1,lada:'',telefono:'${viewModelInstance?.registroExamenInstance?.telefonoOficina}',extension:'${viewModelInstance?.registroExamenInstance?.extensionOficina}', idTipoTelefono:2,dsTipoTelefono:'Oficina' })
	</g:if>
	var telefonosView = new app.TelefonosView(telefonosModel);
	</script>

	<g:render template="../common/expedienteDomicilio"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.domicilio.js" />
	<script>
	var sepomexView = new app.SepomexView(new Array(),new app.Domicilio(), '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>
	
	<g:render template="../common/expedienteDatosRegistro"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.registro.js" />
	<script>
	var registroModel = new app.Registro();
	registroModel.set("nombrePuesto","${viewModelInstance?.registroExamenInstance?.puesto}");
	//registroModel.set("fechaInicioDay",-1);
	//registroModel.set("fechaInicioMonth",-1);
	//registroModel.set("fechaInicioYear",-1);
	registroModel.set("idInstitucion","${viewModelInstance?.registroExamenInstance?.idInstitucion}");
	registroModel.set("idVarianteFigura","${viewModelInstance?.registroExamenInstance?.idFigura}");
	registroModel.set("descAutorizacion","${viewModelInstance?.registroExamenInstance?.descripcionFigura}");
	registroModel.set("fechaObtencionDay","${viewModelInstance?.registroExamenInstance?.fechaAplicacionExamenDay}");
	registroModel.set("fechaObtencionMonth","${viewModelInstance?.registroExamenInstance?.fechaAplicacionExamenMonth}");
	registroModel.set("fechaObtencionYear","${viewModelInstance?.registroExamenInstance?.fechaAplicacionExamenYear}");
	var registroView = new app.RegistroView(registroModel);
	</script>

	<script>

		var app = app || {};

		app.EXP_REG_CHK_GRALES = 0;
		app.EXP_REG_CHK_TELS = 1;
		app.EXP_REG_CHK_SEPOMEX = 2;
		app.EXP_REG_CHK_REGISTRO = 3;

		app.CheckSubmit = Backbone.Model.extend({
			defaults: {
				checkarray: [false,false,false,false],
				viewsarray: [undefined,undefined,undefined,undefined]
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
			},

			setViewInstance: function(viewIndex,viewInstance){
				var arr = this.model.get('viewsarray');
				var context = this;

				viewInstance.setCheckId(viewIndex); // <- setea el viewIndex como checkId
				arr[viewIndex] = viewInstance;

				//aqui es donde se "suscribe" el método "checkElement" a la llamada "stateChange" de cualquier componente validable
				viewInstance.on("stateChange",function(newState, checkId){
					context.checkElement(newState,checkId); //<- usa el checkId como viewIndex
				});
			},

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
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroMatricula" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('numeroMatricula') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.nombre" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('nombre') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.primerApellido" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('primerApellido') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.segundoApellido" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('segundoApellido') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.genero" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('genero') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.rfc" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('rfc') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.curp" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('curp') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_day" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoDay') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_month" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoMonth') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.fechaNacimiento_year" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('fechaNacimientoYear') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.correoElectronico" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('correoElectronico') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calidadMigratoria" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('calidadMigratoria') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.profesion" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('profesion') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNacionalidad" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('nacionalidad') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idNivelEstudios" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('nivelEstudios') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idEstadoCivil" value="' + arr[app.EXP_REG_CHK_GRALES].model.get('estadoCivil') + '" />');
				//datos de telefonos
				var telsJson = "[";
				arr[app.EXP_REG_CHK_TELS].collection.each(function(item){
					telsJson += JSON.stringify(item) + ",";
				}, this);
				telsJson += "]";
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.telefonos_json" value=\'' + telsJson + '\' />');
				//datos de sepomex
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.idSepomex" value="' + arr[app.EXP_REG_CHK_SEPOMEX].model.get('idSepomex') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.calle" value="' + arr[app.EXP_REG_CHK_SEPOMEX].model.get('calle') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroInterior" value="' + arr[app.EXP_REG_CHK_SEPOMEX].model.get('numeroInterior') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.numeroExterior" value="' + arr[app.EXP_REG_CHK_SEPOMEX].model.get('numeroExterior') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.asentamientoOtro" value="' + arr[app.EXP_REG_CHK_SEPOMEX].model.get('asentamientoOtro') + '" />');
				//datos de registro
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.nombrePuesto" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('nombrePuesto') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaInicio_day" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaInicioDay') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaInicio_month" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaInicioMonth') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaInicio_year" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaInicioYear') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.idInstitucion" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('idInstitucion') + '" />');
				
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.statusEntManifProtesta" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('statusEntManifProtesta') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.obsEntManifProtesta" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('obsEntManifProtesta') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.statusEntCartaInter" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('statusEntCartaInter') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.obsEntCartaInter" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('obsEntCartaInter') + '" />');
				
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaObtencion_day" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaObtencionDay') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaObtencion_month" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaObtencionMonth') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.fechaObtencion_year" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('fechaObtencionYear') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.idVarianteFigura" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('idVarianteFigura') + '" />');

				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.statusEntHistorialInforme" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('statusEntHistorialInforme') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.obsEntHistorialInforme" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('obsEntHistorialInforme') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.statusEntCartaRec" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('statusEntCartaRec') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.obsEntCartaRec" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('obsEntCartaRec') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.statusConstBolVal" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('statusConstBolVal') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="registro.obsConstBolVal" value="' + arr[app.EXP_REG_CHK_REGISTRO].model.get('obsConstBolVal') + '" />');
				
				$("#frmApp").submit();
			},
		});

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_SEPOMEX,sepomexView);
		checkSubmitView.setViewInstance(app.EXP_REG_CHK_REGISTRO,registroView);

		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>
	
</body>
</html>