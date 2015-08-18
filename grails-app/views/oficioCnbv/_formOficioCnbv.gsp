<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvFormDatosOficioTemplate">

	<div class="alert-errorClaveDgaUnique alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Ya existe un registro con el <strong>Numero de Oficio</strong> introducido.</div>
	<div class="alert-errorNumeroOficioUnique alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Ya existe un registro con la <strong>Clave DGA</strong> introducida.</div>
	<div class="alert-errorNumeroOficioUniqueNonValidated alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No se ha validado la disponiblidad del <strong>Numero de Oficio</strong> introducido.</div>
	<div class="alert-errorClaveDgaUniqueNonValidated alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span>  No se ha validado la disponiblidad de la <strong>Clave DGA</strong> introducida.</div>
	<div class="alert-processing alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
	
	<div class="div-wrapper-numeroOficio">
	</div>
	
	<div class="div-wrapper-claveDga">
	</div>
	
	<div class="div-fechaOficio form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Fecha de oficio
		</label>
		<div class="col-md-5 col-sm-5">
			<select style="width: 28%;" class="form-control col-md-4 fechaOficio_day field" data-field="fechaOficio_day">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1;i<=31;i++){ }}
					{{ if(i == fechaOficio_day){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 38%;" class="form-control col-md-4 fechaOficio_month field" data-field="fechaOficio_month">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=0;i<app.MESES.length;i++){ }}
					{{ if(app.MESES[i].id == fechaOficio_month){ }}
						<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
					{{ } else{ }}
						<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 34%;" class="form-control col-md-4 fechaOficio_year field" data-field="fechaOficio_year">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1980;i<=2030;i++){ }}
					{{ if(i == fechaOficio_year){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
		</div>
	</div>
	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button disabled="" type="button" class="btn btn-primary btn-block edit">Editar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
	
</script>

<script type="text/template" id="_ClaveDgaUniqueValidated">
	<div class="div-claveDga form-group has-success">
		<label class="col-md-2 col-sm-3 control-label">
			Clave DGA
		</label>
		<div class="col-md-6 col-sm-6">
			<input class="claveDga field form-control" maxlength="16" data-field="claveDga" type="text" value="{{=claveDga}}">
		</div>
		<div class="col-md-1 col-sm-1 control-label">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
		</div>
	</div>
</script>

<script type="text/template" id="_ClaveDgaUniqueNonValidated">
	<div class="div-claveDga form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Clave DGA
		</label>
		<div class="col-md-6 col-sm-6">
			<input class="claveDga field form-control" maxlength="16" data-field="claveDga" type="text" value="{{=claveDga}}">
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block btn-xs verifyClaveDga">Checar disponibilidad</button>
		</div>
	</div>
</script>

<script type="text/template" id="_NumeroOficioUniqueValidated">
	<div class="div-numeroOficio form-group has-success">
		<label class="col-md-2 col-sm-3 control-label">
			Numero de Oficio
		</label>
		<div class="col-md-6 col-sm-6">
			<input class="numeroOficio field form-control" maxlength="10" data-field="numeroOficio" type="text" value="{{=numeroOficio}}">
		</div>
		<div class="col-md-1 col-sm-1 control-label">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
		</div>
	</div>
</script>

<script type="text/template" id="_NumeroOficioUniqueNonValidated">
	<div class="div-numeroOficio form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Numero de Oficio
		</label>
		<div class="col-md-6 col-sm-6">
			<input class="numeroOficio field form-control" maxlength="10" data-field="numeroOficio" type="text" value="{{=numeroOficio}}">
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block btn-xs verifyNumeroOficio">Checar disponibilidad</button>
		</div>
	</div>
</script>