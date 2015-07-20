<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="poder">

<div class="errorValidacion alert alert-danger">
	<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" ></span><br/>
	<ul class="validationErrorMsgs">
	</ul>
</div>

<fieldset>
	<legend>Datos de la institución o grupo financiero</legend>
	
		<div class="procInstituciones alert alert-info">
			<asset:image src="spinner_alert_info.gif"/><strong>Procesando datos, espere un momento</strong>.
		</div>
		<div class="errorInstituciones alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorInstituciones" ></span>
		</div>
		
		<div class="div-idGrupoFinanciero form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<g:select class="field idGrupoFinanciero form-control" name='poder.idGrupoFinanciero' value="{{=idGrupoFinanciero}}"
				noSelection="${['-1':'-Seleccione-']}"
				from='${viewModelInstance.gruposFinancieroList}'
				optionKey="id" optionValue="nombre" data-field="idGrupoFinanciero"></g:select>
			</div>
		</div>
		
		<div class="div-idInstitucion form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.institucion.label" default="Institución" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idInstitucion form-control" name="poder.idInstitucion" data-field="idInstitucion">
					<option value="-1">-Seleccione-</option>
					{{ _.each(institucionList,function(item){ }}
						<option value="{{=item.id}}">{{=item.nombre}}</option>
					{{ },this); }}
				</select>
			</div>
		</div>
		
</fieldset>
<fieldset>
	<legend>Datos del representante legal</legend>
		<div class="div-representanteLegalNombre form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" data-field="representanteLegalNombre" maxlength="100" class="field representanteLegalNombre form-control" name="poder.representanteLegalNombre" value="{{=representanteLegalNombre}}" />
			</div>
		</div>

		<div class="div-representanteLegalApellido1 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text"data-field="representanteLegalApellido1" maxlength="80" class="field representanteLegalApellido1 form-control" name="poder.representanteLegalApellido1" value="{{=representanteLegalApellido1}}" />
			</div>
		</div>
		<div class="div-representanteLegalApellido2 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" />						
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" data-field="representanteLegalApellido2" maxlength="80" class="field representanteLegalApellido2 form-control" name="poder.representanteLegalApellido2" value="{{=representanteLegalApellido2}}" />
			</div>
		</div>
</fieldset>
<fieldset>
	<legend>Datos de oficio</legend>
	<div class="div-datosPoder form-group">
	
		<div class="procNumeroEscritura alert alert-info">
			<asset:image src="spinner_alert_info.gif"/><strong>Procesando datos, espere un momento</strong>.
		</div>
	
		<div class="errorNumeroEscritura alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorNumeroEscritura" ></span>
		</div>
	
		<div class="div-numeroEscritura">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="poder.numeroEscritura.label" default="Numero de escritura" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-2 col-sm-2">
				<input type="text" data-field="numeroEscritura" maxlength="10" class="field numeroEscritura form-control" name="poder.numeroEscritura" required="" value="{{=numeroEscritura}}" />
			</div>
		</div>
		<div class="div-fechaApoderamiento">
			<label class="col-md-3 col-sm-3 control-label">
				<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" /><span class="required-indicator">*</span>						
			</label>
			<div class="col-md-4 col-sm-4">
				
				<!-- asignar por backbone -->
				<select data-field="fechaApoderamiento_day" name="poder.fechaApoderamiento_day" id="poder.fechaApoderamiento_day" class="field fechaApoderamiento_day form-control col-md-4" style="width: 25%;"><option value="-1">-Seleccione-</option>
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
				<select data-field="fechaApoderamiento_month" name="poder.fechaApoderamiento_month" id="poder.fechaApoderamiento_month" class="field fechaApoderamiento_month form-control col-md-4" style="width: 40%;"><option value="-1">-Seleccione-</option>
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
				<select data-field="fechaApoderamiento_year" name="poder.fechaApoderamiento_year" id="poder.fechaApoderamiento_year" class="field fechaApoderamiento_year form-control col-md-4" style="width: 35%;"><option value="-1">-Seleccione-</option>
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
	</div>
</fieldset>
<fieldset>
	<legend>Datos del notario</legend>
	
	<div class="procNotario alert alert-info">
		<asset:image src="spinner_alert_info.gif"/><strong>Procesando datos, espere un momento</strong>.
	</div>
	<div class="errorNotario alert alert-danger">
		<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorNotario" > </span>
	</div>
	
	<div class="div-notario form-group">
		<div class="div-numeroNotaria">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="notario.numeroNotaria.label" default="Número" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-2 col-sm-2">
				<input type="text" data-field="numeroNotariaNotario" maxlength="10" class="field numeroNotariaNotario form-control" name="notario.numeroNotaria" value="{{=numeroNotariaNotario}}" />
			</div>
		</div>
		<div class="div-idEntidadFederativa">
			<label class="col-md-3 col-sm-3 control-label">
				<g:message code="notario.idEntidadFederativa.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
			</label>
			<div class="col-md-4 col-sm-4">
				<g:select data-field="idEntidadFederativaNotario" class="field idEntidadFederativaNotario form-control" name='notario.idEntidadFederativa' value="{{=idEntidadFederativaNotario}}"
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance.entidadFederativaList}'
					optionKey="id" optionValue="nombre"></g:select>
			</div>
		</div>
	</div>
	
	<div class="div-nombreCompleto form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="notario.nombreCompletro.label" default="Nombre" /><span class="required-indicator">*</span>
		</label>
		<div class="col-md-9 col-sm-9">
			<!-- setear por backbone -->
			<select data-field="idNotario" class="field idNotario form-control" name="notario.id">
				<option value="-1">-Seleccione-</option>
				{{ _.each(notarioList,function(item){ }}
					<option value="{{=item.id}}">{{=item.nombreCompleto}}</option>
				{{ },this); }}
			</select>
		</div>
	</div>
	
</fieldset>	

<br/>
				
<div class="form-group">
	<div class="col-md-3 col-sm-3">
		&nbsp;
	</div>
	<div class="col-md-3 col-sm-3">
		<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar datos de poder</button>
	</div>
	<div class="col-md-3 col-sm-3">
		<button type="button" class="btn btn-primary btn-block edit">Editar datos de poder</button>
	</div>
	<div class="col-md-3 col-sm-3">
		&nbsp;
	</div>
</div>

</script>