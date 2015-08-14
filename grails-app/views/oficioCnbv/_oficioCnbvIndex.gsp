<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvIndexTemplate">

	<fieldset>
		<legend>Acciones</legend>
		<button id="btnAltaOficio" type="button" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Alta de oficio</button>
	</fieldset>

	<fieldset>
		<legend>Búsqueda de Oficios de Autorización</legend>
		
		<div class="tab-content">
		
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active" >
					<a href="#tabDatosOficio" aria-controls="tabDatosOficio" role="tab" data-toggle="tab">Por datos de oficio</a>
				</li>
				<li role="presentation">
					<a href="#tabDatosSust" aria-controls="tabDatosSust" role="tab" data-toggle="tab">Por datos del sustentante</a>
				</li>
			</ul>
			<br/>
			
			<div role="tabpanel" id="tabDatosOficio" class="tab-pane-oficio tab-pane active" >
			</div>
			
			<div role="tabpanel" id="tabDatosSust" class="tab-pane-sustentante tab-pane">
			</div>
			
			<div class="div-resultados">	
			</div>
				
		</div>
		
	</fieldset>

</script>

<script type="text/template" id="oficioCnbvIndexDatosOficioTemplate">

	<div class="div-numeroOficio form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.numeroOficio.label" default="Número de oficio" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="field form-control" maxlength="10" data-field="numeroOficio"/>
		</div>
	</div>
	
	<div class="div-claveDga form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.claveDga.label" default="Clave DGA" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="field form-control" maxlength="16" data-field="claveDga"/>
		</div>
	</div>
	
	
	
	<div class="div-fechaOficioDel form-group">
	
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCNBV.fechaOficioDel.label" default="Fecha de oficio (del)" />
		</label>
		<div class="col-md-5 col-sm-5">
			
			<select style="width: 28%;" class="form-control col-md-4 fechaOficioDel_day field" data-field="fechaOficioDel_day">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1;i<=31;i++){ }}
					{{ if(i == fechaOficioDel_day){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 38%;" class="form-control col-md-4 fechaOficioDel_month field" data-field="fechaOficioDel_month">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=0;i<app.MESES.length;i++){ }}
					{{ if(app.MESES[i].id == fechaOficioDel_month){ }}
						<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
					{{ } else{ }}
						<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 34%;" class="form-control col-md-4 fechaOficioDel_year field" data-field="fechaOficioDel_year">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1980;i<=2030;i++){ }}
					{{ if(i == fechaOficioDel_year){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			
		</div>
			
	</div>
	
	<div class="div-fechaOficioAl form-group">
	
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCNBV.fechaOficioAl.label" default="Fecha de oficio (al)" />
		</label>
		<div class="col-md-5 col-sm-5">
			
			<select style="width: 28%;" class="form-control col-md-4 fechaOficioAl_day field" data-field="fechaOficioAl_day">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1;i<=31;i++){ }}
					{{ if(i == fechaOficioAl_day){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 38%;" class="form-control col-md-4 fechaOficioAl_month field" data-field="fechaOficioAl_month">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=0;i<app.MESES.length;i++){ }}
					{{ if(app.MESES[i].id == fechaOficioAl_month){ }}
						<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
					{{ } else{ }}
						<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 34%;" class="form-control col-md-4 fechaOficioAl_year field" data-field="fechaOficioAl_year">
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1980;i<=2030;i++){ }}
					{{ if(i == fechaOficioAl_year){ }}
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
		<div class="col-md-6 col-sm-6" style="text-align: center">
			<button type="button" class="clean btn btn-default btn-primary">Limpiar campos</button>
			<button type="button" class="find btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>

<script type="text/template" id="oficioCnbvIndexDatosSustTemplate">

</script>
