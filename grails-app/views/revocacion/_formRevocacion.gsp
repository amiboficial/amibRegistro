<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="formRevocacionTemplate">
	


<div style="display: none;" class="errorValidacion alert alert-danger">
	<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion"></span><br>
	<ul class="validationErrorMsgs">
	</ul>
</div>

<fieldset>
	<legend>Datos de la institución o grupo financiero</legend>
	
		<div style="display: none;" class="procInstituciones alert alert-info">
			<img src="/amibRegistro/assets/spinner_alert_info.gif"><strong>Procesando datos, espere un momento</strong>.
		</div>
		<div style="display: none;" class="errorInstituciones alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorInstituciones"></span>
		</div>
		
		<div class="div-idGrupoFinanciero form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Grupo financiero<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idGrupoFinanciero form-control" name="poder.idGrupoFinanciero" data-field="idGrupoFinanciero" id="poder.idGrupoFinanciero">
<option value="-1">-Seleccione-</option>
<option value="2">ABN AMRO</option>
<option value="3">AFIRME</option>
<option value="57">Allianz Fondika, S.A. de C.V.</option>
<option value="4">BANAMEX</option>
<option value="67">BANCO BASE, S.A.</option>
<option value="33">BANREGIO</option>
<option value="6">BBVA BANCOMER</option>
<option value="7">BITAL</option>
<option value="49">Banca Multiple</option>
<option value="52">Banco Amigo S.A., Institución de Banca Multiple</option>
<option value="65">Banco Autofin México S.A.</option>
<option value="32">Bank Of America</option>
<option value="48">Barclays Bank México, S.A.</option>
<option value="30">Bursamex Grupo Financiero</option>
<option value="58">Consultoría Internacional</option>
<option value="63">Deutsche bank</option>
<option value="64">Distribuidora Principal México, S.A. de C.V.</option>
<option value="8">FINAMEX</option>
<option value="54">Franklin Templeton Asset Management Mexico, S.A.</option>
<option value="10">GBM</option>
<option value="9">GE CAPITAL</option>
<option value="68">Genérico</option>
<option value="69">Goldman Sachs</option>
<option value="24">Gpo. Financiero Credit Suisse First Boston México</option>
<option value="62">Grupo Financiero Actinver, S.A. de C.V.</option>
<option value="5">Grupo Financiero Banorte</option>
<option value="59">Grupo Financiero Barclays México</option>
<option value="28">Grupo Financiero HSBC</option>
<option value="29">Grupo Financiero Intercam</option>
<option value="60">ICAP Referenciadora S.A. de C.V.</option>
<option value="11">INBURSA</option>
<option value="1">INDEPENDIENTE</option>
<option value="12">ING</option>
<option value="13">INTERACCIONES</option>
<option value="14">INVEX</option>
<option value="15">IXE</option>
<option value="45">Inversión Casa de Bolsa, S.A. de C.V.</option>
<option value="16">J.P.MORGAN</option>
<option value="17">MIFEL</option>
<option value="18">MONEX</option>
<option value="19">MULTIVALORES</option>
<option value="43">Merfon, S.A. de C.V.</option>
<option value="61">Morgan Stanley México, Casa de Bolsa S.A. de C.V.</option>
<option value="55">O`Rourke &amp; Asociados, S.A. de C.V.</option>
<option value="39">Profuturo GNP Fondos de Inversión, S.A. de C.V.,</option>
<option value="41">Prudential</option>
<option value="51">Prudential Bank, S.A.</option>
<option value="20">SANTANDER SERFIN</option>
<option value="21">SCOTIAINVERLAT</option>
<option value="47">Schroder Investment Management, S.A. de C.V.</option>
<option value="40">Sociedad Hipotecaria Federal , S.N.C.</option>
<option value="46">Sociedad Operadora de Sociedades de Inversión</option>
<option value="36">Tecnología en Estrategias de Inversión, S.C.</option>
<option value="22">VALUE</option>
<option value="23">VECTOR</option>
<option value="31">Ve por Mas Grupo Financiero</option>
<option value="66">Zurich</option>
</select>
			</div>
		</div>
		
		<div class="div-idInstitucion form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Institución<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idInstitucion form-control" name="poder.idInstitucion" data-field="idInstitucion">
					<option value="-1">-Seleccione-</option>
					
				</select>
			</div>
		</div>
		
</fieldset>
<fieldset>
	<legend>Datos del representante legal</legend>
		<div class="div-representanteLegalNombre form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Nombre<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalNombre" maxlength="100" class="field representanteLegalNombre form-control" name="poder.representanteLegalNombre" value="" type="text">
			</div>
		</div>

		<div class="div-representanteLegalApellido1 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Primer apellido<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalApellido1" maxlength="80" class="field representanteLegalApellido1 form-control" name="poder.representanteLegalApellido1" value="" type="text">
			</div>
		</div>
		<div class="div-representanteLegalApellido2 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Segundo apellido						
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalApellido2" maxlength="80" class="field representanteLegalApellido2 form-control" name="poder.representanteLegalApellido2" value="" type="text">
			</div>
		</div>
</fieldset>
<fieldset>
	<legend>Datos de oficio</legend>
	<div class="div-datosPoder form-group">
	
		<div style="display: none;" class="procNumeroEscritura alert alert-info">
			<img src="/amibRegistro/assets/spinner_alert_info.gif"><strong>Procesando datos, espere un momento</strong>.
		</div>
	
		<div style="display: none;" class="errorNumeroEscritura alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorNumeroEscritura"></span>
		</div>
	
		<div class="div-numeroEscritura">
			<label class="col-md-2 col-sm-3 control-label">
				Numero de escritura<span class="required-indicator">*</span>
			</label>
			<div class="col-md-2 col-sm-2">
				<input data-field="numeroEscritura" maxlength="10" class="field numeroEscritura form-control" name="poder.numeroEscritura" required="" value="" type="text">
			</div>
		</div>
		
		<div class="div-fechaRevocacion">
			<label class="col-md-3 col-sm-3 control-label">
				Fecha de revocación<span class="required-indicator">*</span>						
			</label>
			<div class="col-md-4 col-sm-4">
				
				<!-- asignar por backbone -->
				<select style="width: 28%;" class="form-control col-md-4 fechaRevocacion_day field" data-field="fechaRevocacion_day" >
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaRevocacion_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaRevocacion_month field" data-field="fechaRevocacion_month" >
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaRevocacion_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaRevocacion_year field" data-field="fechaRevocacion_year" >
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1980;i<=2030;i++){ }}
						{{ if(i == fechaRevocacion_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>

			
			</div>
		</div>
	</div>
</fieldset>

<br>
				
<div class="form-group">
	<div class="col-md-3 col-sm-3">
		&nbsp;
	</div>
	<div class="col-md-3 col-sm-3">
		<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar</button>
	</div>
	<div class="col-md-3 col-sm-3">
		<button disabled="disabled" type="button" class="btn btn-primary btn-block edit">Editar datos</button>
	</div>
	<div class="col-md-3 col-sm-3">
		&nbsp;
	</div>
</div>



</script>