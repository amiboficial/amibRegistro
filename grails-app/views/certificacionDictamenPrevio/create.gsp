<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Emitir dictamen</title>
<script>
function viewAdjustCustomize(){
	$(".div-fechaObtencion").html("").remove();
	$(".div-fechaInicioAuth").html("").remove();
	$(".div-fechaFinAuth").html("").remove();

	$("#dueLapseTarget").html($("#DueTimeLapse").html());
	$("#DueTimeLapse").remove();
	
	
	$(".fechaEntrega_day").on('change', function() {
    	cert.attributes.fechaEntrega_day = parseInt($(".fechaEntrega_day").val());
    	});

    $(".fechaEntrega_month").on('change', function() {
    	cert.attributes.fechaEntrega_month = parseInt($(".fechaEntrega_month").val());
    	});

    $(".fechaEntrega_year").on('change', function() {
    	cert.attributes.fechaEntrega_year = parseInt($(".fechaEntrega_year").val());
    	});

    $(".fechaEnvio_day").on('change', function() {
    	cert.attributes.fechaEnvio_day = parseInt($(".fechaEnvio_day").val());
    	});

    $(".fechaEnvio_month").on('change', function() {
    	cert.attributes.fechaEnvio_month = parseInt($(".fechaEnvio_month").val());
    	});

    $(".fechaEnvio_year").on('change', function() {
    	cert.attributes.fechaEnvio_year = parseInt($(".fechaEnvio_year").val());
    	});
}

$(function() {
	viewAdjustCustomize();
    var bbbb = $("[name='ZXhwZWRpZW50ZS5uYWNpb25hbGlkYWQ']").val();
    if(bbbb == undefined || bbbb == null || bbbb == "" || bbbb == "-1" ){
    	$("[name='ZXhwZWRpZW50ZS5uYWNpb25hbGlkYWQ']").val("117");
	}
});




</script>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="certificacionDictamenPrevio" action="index" />">Dictamen Previo</a></li>
		<li><a href="#">Emitir dictamen</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	
	<h2><strong>Emitir dictamen para autorización</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action=<g:createLink controller="certificacionDictamenPrevio" action="save"/> method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Revise y, en caso de ser necesario, rectifique la información del solicitante del cual solicitará autorización. Una vez que toda la información proporcionada este completa, revisando la pestaña "Emitir Dictamen", podrá proceder a emitir el dictamen y enviarlo a autorización.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#tabGen" aria-controls="tabGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#tabTels" aria-controls="tabTels" role="tab" data-toggle="tab">Teléfonos</a></li>
			<li role="presentation"><a href="#tabDom" aria-controls="tabDom" role="tab" data-toggle="tab">Domicilio</a></li>
			<li role="presentation"><a href="#tabCert" aria-controls="tabCert" role="tab" data-toggle="tab">Figura</a></li>
			<li role="presentation"><a href="#tabPues" aria-controls="tabPues" role="tab" data-toggle="tab">Relaciones laborales</a></li>
			 <li role="presentation"><a href="#tabCheckSubmit" aria-controls="tabCheckSubmit" role="tab" data-toggle="tab">Emitir dictamen</a></li>
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
							<li><span id="spnCheckGrales" class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
							<li><span id="spnCheckTels" class="glyphicon glyphicon-unchecked"></span> Datos de teléfonos</li>
							<li><span id="spnCheckSepomex" class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
							<li><span id="spnCheckFigura" class="glyphicon glyphicon-unchecked"></span> Datos de figura</li>
							<li><span id="spnCheckPuestos" class="glyphicon glyphicon-unchecked"></span> Datos de relaciones laborales con institución</li>
						</ul>
					</div>
					<div id="dueLapseTarget">
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

		<g:if test="${viewModelInstance?.sustentanteInstance?.fechaNacimiento != null}">
		generalesModel.set("fechaNacimientoDay", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento?.getAt(Calendar.DATE)});
		generalesModel.set("fechaNacimientoMonth", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento?.getAt(Calendar.MONTH)+1});
		generalesModel.set("fechaNacimientoYear", ${viewModelInstance?.sustentanteInstance?.fechaNacimiento?.getAt(Calendar.YEAR)});
		</g:if>
		
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
		domicilioModel.set("numeroInterior","${viewModelInstance?.sustentanteInstance?.numeroInterior}");
		domicilioModel.set("numeroExterior","${viewModelInstance?.sustentanteInstance?.numeroExterior}");
		domicilioModel.set("asentamientoOtro","${viewModelInstance?.sustentanteInstance?.asentamientoOtro}");
		sepomexArray = ${raw(viewModelInstance?.sepomexJsonList)};
	</g:if>
	var sepomexView = new app.SepomexView(sepomexArray, domicilioModel, '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
	</script>
	
	<g:render template="../common/expedienteShowPuestos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.puestos.js" />
	<script type="text/javascript">
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

		    					<g:if test="${x?.esActual}" >
		    						esActual: "esActual"
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
		
	<g:render template="certificacionDictamen"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.certificacionDictamen.js" />
	<script>
		var app = app || {};

		var cert = new app.CertificacionViewModel();

		cert.set("grailsId",${viewModelInstance?.certificacionInstance?.id}-0);

		cert.set("nombreFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.nombreFigura}");
		cert.set("nombreVarianteFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.nombre}");
		cert.set("tipoAutorizacionFigura","${viewModelInstance?.certificacionInstance?.varianteFigura?.tipoAutorizacionFigura}");

		<g:if test="${viewModelInstance?.certificacionInstance?.fechaInicio != null}">
		cert.set("fechaInicio_day",${viewModelInstance?.certificacionInstance?.fechaInicio[Calendar.DATE]});
		cert.set("fechaInicio_month",${viewModelInstance?.certificacionInstance?.fechaInicio[Calendar.MONTH]+1});
		cert.set("fechaInicio_year",${viewModelInstance?.certificacionInstance?.fechaInicio[Calendar.YEAR]});
		</g:if>

		<g:if test="${viewModelInstance?.certificacionInstance?.fechaFin != null}">
		cert.set("fechaFin_day",${viewModelInstance?.certificacionInstance?.fechaFin[Calendar.DATE]});
		cert.set("fechaFin_month",${viewModelInstance?.certificacionInstance?.fechaFin[Calendar.MONTH]+1});
		cert.set("fechaFin_year",${viewModelInstance?.certificacionInstance?.fechaFin[Calendar.YEAR]});
		</g:if>

		<g:if test="${viewModelInstance?.certificacionInstance?.fechaObtencion != null}">
		cert.set("fechaObtencion_day",${viewModelInstance?.certificacionInstance?.fechaObtencion[Calendar.DATE]});
		cert.set("fechaObtencion_month",${viewModelInstance?.certificacionInstance?.fechaObtencion[Calendar.MONTH]+1});
		cert.set("fechaObtencion_year",${viewModelInstance?.certificacionInstance?.fechaObtencion[Calendar.YEAR]});
		</g:if>

		<g:if test="${viewModelInstance?.certificacionInstance?.fechaEntregaRecepcion != null}">
		cert.set("fechaEntrega_day",${viewModelInstance?.certificacionInstance?.fechaEntregaRecepcion[Calendar.DATE]});
		cert.set("fechaEntrega_month",${viewModelInstance?.certificacionInstance?.fechaEntregaRecepcion[Calendar.MONTH]+1});
		cert.set("fechaEntrega_year",${viewModelInstance?.certificacionInstance?.fechaEntregaRecepcion[Calendar.YEAR]});
		</g:if>
		<g:if test="${viewModelInstance?.certificacionInstance?.fechaEnvioComision != null}">
		cert.set("fechaEnvio_day",${viewModelInstance?.certificacionInstance?.fechaEnvioComision[Calendar.DATE]});
		cert.set("fechaEnvio_month",${viewModelInstance?.certificacionInstance?.fechaEnvioComision[Calendar.MONTH]+1});
		cert.set("fechaEnvio_year",${viewModelInstance?.certificacionInstance?.fechaEnvioComision[Calendar.YEAR]});
		</g:if>
		
		cert.set("statusEntHistorialInforme",${viewModelInstance?.certificacionInstance?.statusEntHistorialInforme}-0);
		cert.set("obsEntHistorialInforme","${viewModelInstance?.certificacionInstance?.obsEntHistorialInforme}");
		cert.set("statusEntCartaRec",${viewModelInstance?.certificacionInstance?.statusEntCartaRec}-0);
		cert.set("obsEntCartaRec","${viewModelInstance?.certificacionInstance?.obsEntCartaRec}");
		cert.set("statusConstBolVal",${viewModelInstance?.certificacionInstance?.statusConstBolVal}-0);
		cert.set("obsConstBolVal","${viewModelInstance?.certificacionInstance?.obsConstBolVal}");
		
		var certView = new app.CertificacionView({model:cert});
	</script>
		
	<script>

		var app = app || {};

		app.EXP_EDT_CHK_GRALES = 0;
		app.EXP_EDT_CHK_TELS = 1;
		app.EXP_EDT_CHK_SEPOMEX = 2;
		app.EXP_EDT_CHK_CERT = 3;
		app.EXP_EDT_CHK_PUES = 4;
		
		app.CheckSubmit = Backbone.Model.extend({
			defaults: {
				checkarray: [false,false,false,false,false],
				viewsarray: [undefined,undefined,undefined,undefined,undefined]
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
				if(arr[app.EXP_EDT_CHK_CERT] == false){
					allChecked = false;
					this.$("#spnCheckFigura").removeClass("glyphicon-check");
					this.$("#spnCheckFigura").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckFigura").removeClass("glyphicon-unchecked");
					this.$("#spnCheckFigura").addClass("glyphicon-check");
				}
				if(arr[app.EXP_EDT_CHK_PUES] == false){
					allChecked = false;
					this.$("#spnCheckPuestos").removeClass("glyphicon-check");
					this.$("#spnCheckPuestos").addClass("glyphicon-unchecked");
				}
				else{
					this.$("#spnCheckPuestos").removeClass("glyphicon-unchecked");
					this.$("#spnCheckPuestos").addClass("glyphicon-check");
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
				this.$("#spnHdnPostData").html("");
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
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.asentamientoOtro" value="' + arr[app.EXP_EDT_CHK_SEPOMEX].model.get('asentamientoOtro') + '" />');
				//datos de certificacion
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.id" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('grailsId') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_day" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaObtencion_day') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_month" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaObtencion_month') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaObtencion_year" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaObtencion_year') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaInicio_day" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaInicio_day') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaInicio_month" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaInicio_month') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaInicio_year" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaInicio_year') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaFin_day" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaFin_day') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaFin_month" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaFin_month') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaFin_year" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaFin_year') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusEntHistorialInforme" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('statusEntHistorialInforme') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsEntHistorialInforme" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('obsEntHistorialInforme') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusEntCartaRec" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('statusEntCartaRec') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsEntCartaRec" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('obsEntCartaRec') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.statusConstBolVal" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('statusConstBolVal') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.obsConstBolVal" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('obsConstBolVal') + '" />');
				
				//datos de lapso de atencion
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEntrega_day" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEntrega_day') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEntrega_month" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEntrega_month') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEntrega_year" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEntrega_year') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEnvio_day" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEnvio_day') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEnvio_month" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEnvio_month') + '" />');
				this.$("#spnHdnPostData").append('<input type="hidden" name="certificacion.fechaEnvio_year" value="' + arr[app.EXP_EDT_CHK_CERT].model.get('fechaEnvio_year') + '" />');
				//datos de puestos
				var puestosJson = JSON.stringify(arr[app.EXP_EDT_CHK_PUES].collection.toJSON());
				this.$("#spnHdnPostData").append('<input type="hidden" name="sustentante.puestos_json" value=\'' + puestosJson + '\' />');
				$("#frmApp").submit();
			},
		});

		var checkSubmitView = new app.CheckSubmitView();
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_GRALES,generalesView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_TELS,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_SEPOMEX,sepomexView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_CERT,certView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_PUES,puestosView);
		
		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>
	
	<!-- FIN: COMPONENTE CHECKLIST -->
</body>
</html>