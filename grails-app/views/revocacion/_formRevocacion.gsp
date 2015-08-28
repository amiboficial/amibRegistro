<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="formRevocacionTemplate">

<div class="alert-processing alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>

<fieldset>
	<legend>Datos de la institución o grupo financiero</legend>
	
		<div class="alert-errorNoGrupoFinanciero alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNoGrupoFinanciero</div>
	
		<div class="div-idGrupoFinanciero form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Grupo financiero<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idGrupoFinanciero form-control" data-field="idGrupoFinanciero">
					{{ _.each(gruposFinancieros,function(item){ }}
						{{ if(item.id == idGrupoFinanciero){ }}
							<option value="{{=item.id}}" selected>{{=item.text}}</option>
						{{ } else{ }}
							<option value="{{=item.id}}">{{=item.text}}</option>
						{{ } }}
					{{ },this); }}
				</select>
			</div>
		</div>
		
		<div class="div-idInstitucion form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Institución<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idInstitucion form-control" data-field="idInstitucion">
				</select>
			</div>
		</div>
		
</fieldset>

<fieldset>
	<legend>Datos del representante legal</legend>
	
		<div class="alert-errorNoRepresentanteLegalNombre alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNoRepresentanteLegalNombre</div>
		<div class="alert-errorNoRepresentanteLegalApellido1 alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNoRepresentanteLegalApellido1</div>
	
		<div class="div-representanteLegalNombre form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Nombre<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalNombre" maxlength="100" class="field representanteLegalNombre form-control" value="" type="text">
			</div>
		</div>

		<div class="div-representanteLegalApellido1 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Primer apellido<span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalApellido1" maxlength="80" class="field representanteLegalApellido1 form-control" value="" type="text">
			</div>
		</div>
		<div class="div-representanteLegalApellido2 form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Segundo apellido						
			</label>
			<div class="col-md-9 col-sm-9">
				<input data-field="representanteLegalApellido2" maxlength="80" class="field representanteLegalApellido2 form-control" value="" type="text">
			</div>
		</div>
</fieldset>

<fieldset>
	<legend>Datos de oficio</legend>
	
	<div class="alert-errorNumeroEscrituraNonCheckedYet alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNumeroEscrituraNonCheckedYet</div>
	<div class="alert-errorNumeroEscrituraNonUnique alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNumeroEscrituraNonUnique</div>
	
	<div class="alert-errorNoNumeroEscritura alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNoNumeroEscritura</div>
	<div class="alert-errorNumeroEscrituraNoNumerico alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNumeroEscrituraNoNumerico</div>
	<div class="alert-errorNoFechaRevocacion alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> errorNoFechaRevocacion</div>
	
	<div class="div-datosRevocacion form-group">
		
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