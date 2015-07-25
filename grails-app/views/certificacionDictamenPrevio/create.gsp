<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Emitir dictamen</title>
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
				<div id="divCert">
				
				
					<fieldset>
						<legend>Datos de figura certificacada a autorizar</legend>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.figura.label" default="Figura a la que aplicó" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">xxxxx</p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.fechaCertificacion.label" default="Fecha de certificación" />
							</label>
							<div class="col-md-5 col-sm-5">
								<select style="width: 28%;" class="form-control col-md-4 fechaCertificacionDay">
									<option value="-1">-Seleccione-</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
								<select style="width: 38%;" class="form-control col-md-4 fechaCertificacionMonth">
									<option value="-1">-Seleccione-</option>
									<option value="1">enero</option>
									<option value="2">febrero</option>
									<option value="3">marzo</option>
									<option value="4">abril</option>
									<option value="5">mayo</option>
									<option value="6">junio</option>
									<option value="7">julio</option>
									<option value="8">agosto</option>
									<option value="9">septiembre</option>
									<option value="10">octubre</option>
									<option value="11">noviembre</option>
									<option value="12">diciembre</option>
								</select>
								<select style="width: 34%;" class="form-control col-md-4 fechaCertificacionYear">
									<option value="-1">-Seleccione-</option>
									<option value="1950">1950</option>
									<option value="1951">1951</option>
									<option value="1952">1952</option>
									<option value="1953">1953</option>
									<option value="1954">1954</option>
									<option value="1955">1955</option>
									<option value="1956">1956</option>
									<option value="1957">1957</option>
									<option value="1958">1958</option>
									<option value="1959">1959</option>
									<option value="1960">1960</option>
									<option value="1961">1961</option>
									<option value="1962">1962</option>
									<option value="1963">1963</option>
									<option value="1964">1964</option>
									<option value="1965">1965</option>
									<option value="1966">1966</option>
									<option value="1967">1967</option>
									<option value="1968">1968</option>
									<option value="1969">1969</option>
									<option value="1970">1970</option>
									<option value="1971">1971</option>
									<option value="1972">1972</option>
									<option value="1973">1973</option>
									<option value="1974">1974</option>
									<option value="1975">1975</option>
									<option value="1976">1976</option>
									<option value="1977">1977</option>
									<option value="1978">1978</option>
									<option value="1979">1979</option>
									<option value="1980">1980</option>
									<option value="1981">1981</option>
									<option value="1982">1982</option>
									<option value="1983">1983</option>
									<option value="1984">1984</option>
									<option value="1985">1985</option>
									<option value="1986">1986</option>
									<option value="1987">1987</option>
									<option value="1988">1988</option>
									<option value="1989">1989</option>
									<option value="1990">1990</option>
									<option value="1991">1991</option>
									<option value="1992">1992</option>
									<option value="1993">1993</option>
									<option value="1994">1994</option>
									<option value="1995">1995</option>
									<option value="1996">1996</option>
									<option value="1997">1997</option>
									<option value="1998">1998</option>
									<option value="1999">1999</option>
									<option value="2000">2000</option>
									<option value="2001">2001</option>
									<option value="2002">2002</option>
									<option value="2003">2003</option>
									<option value="2004">2004</option>
									<option value="2005">2005</option>
									<option value="2006">2006</option>
									<option value="2007">2007</option>
									<option value="2008">2008</option>
									<option value="2009">2009</option>
									<option value="2010">2010</option>
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
									<option value="2026">2026</option>
									<option value="2027">2027</option>
									<option value="2028">2028</option>
									<option value="2029">2029</option>
									<option value="2030">2030</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.autorizacionSolicitada.label" default="Autorización solicitada" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">yyyyy</p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.statusEntHistorialInforme.label" default="Informe proporcionado por una sociedad de información crediticia son su historial de cuando menos 5 años" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="1">&nbsp;Entregó
								<br/>
								<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="2">&nbsp;No entregó
								<br/>
								<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="0" checked>&nbsp;No aplica
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.obsEntHistorialInforme.label" default="(Observaciones)" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" class="obsEntHistorialInforme form-control"/>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.statusEntCartaRec.label" default="Cartas de Recomendación" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="1">&nbsp;Entregó
								<br/>
								<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="2">&nbsp;No entregó
								<br/>
								<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="0" checked>&nbsp;No aplica
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.obsEntCartaRec.label" default="(Observaciones)" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" class="obsEntCartaRec form-control"/>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.statusConstBolVal.label" default="Constancias de las Bolsas de Valores" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="1">&nbsp;Entregó
								<br/>
								<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="2">&nbsp;No entregó
								<br/>
								<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="0" checked>&nbsp;No aplica
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="datosRegistro.obsConstBolVal.label" default="(Observaciones)" />
							</label>
							<div class="col-md-9 col-sm-9">
								<input type="text" class="obsConstBolVal form-control"/>
							</div>
						</div>
						
					</fieldset>
				
				
				</div>
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
		var generalesView = new app.GeneralesView(generalesModel);
	</script>
	
	<g:render template="../common/expedienteTelefonos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.telefonos.js" />
	<script>
		var app = app || {};
	
		var telefonosModel = new Array();
		var telefonosView = new app.TelefonosView(telefonosModel);
	</script>
	
	<g:render template="../common/expedienteDomicilio"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.form.domicilio.js" />
	<script>
	var sepomexView = new app.SepomexView(new Array(),new app.Domicilio(), '<g:createLink controller="Sepomex" action="obtenerDatosSepomex"/>');
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
		
		var puestosView = new app.PuestosView(puestosArray);
	</script>
		
	<!-- INICIA: COMPONENTE CHECKLIST -->
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
		//checkSubmitView.setViewInstance(app.EXP_EDT_CHK_CERT,telefonosView);
		checkSubmitView.setViewInstance(app.EXP_EDT_CHK_PUES,puestosView);
		
		$(window).bind("pageshow", function(){
			$('#spnHdnPostData').html("");
		});

	</script>
	
	<!-- FIN: COMPONENTE CHECKLIST -->
</body>
</html>