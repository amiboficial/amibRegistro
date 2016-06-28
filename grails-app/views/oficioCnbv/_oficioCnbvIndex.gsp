<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvIndexTemplate">

	<fieldset>
		<legend>Acciones</legend>
		<button type="button" class="create btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Alta de oficio</button>
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

	<div class="div-opcionSeleccionada form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.opcionSeleccionada.label" default="Criterio de búsqueda" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="0" checked>&nbsp;Número de oficio&nbsp;&nbsp;
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="1" >&nbsp;Clave DGA&nbsp;&nbsp;
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="2" >&nbsp;Fecha de oficio
		</div>
	</div>

	<div class="div-numeroOficio form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.numeroOficio.label" default="Número de oficio" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="numeroOficio field form-control" maxlength="10" data-field="numeroOficio"/>
		</div>
	</div>
	
	<div class="div-claveDga form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.claveDga.label" default="Clave DGA" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="claveDga field form-control" maxlength="16" data-field="claveDga"/>
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

	<div class="div-opcionSeleccionada form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.opcionSeleccionada.label" default="Criterio de búsqueda" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionada" data-field="opcionSeleccionada" value="0" checked>&nbsp;Matrícula&nbsp;&nbsp;
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionada" data-field="opcionSeleccionada" value="1" >&nbsp;Folio&nbsp;&nbsp;
			<input type="radio" class="opcionSeleccionada field" name="opcionSeleccionada" data-field="opcionSeleccionada" value="2" >&nbsp;Nombre y/o apellido(s)&nbsp;&nbsp;
		</div>
	</div>

	<div class="div-numeroMatricula form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.numeroMatricula.label" default="Matrícula" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="numeroMatricula field form-control" maxlength="10" data-field="numeroMatricula"/>
		</div>
	</div>
	
	<div class="div-idSustentante form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.idSustentante.label" default="Folio" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="idSustentante field form-control" maxlength="10" data-field="idSustentante"/>
		</div>
	</div>
	
	<div class="div-nombre form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.nombre.label" default="Nombre(s)" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="nombre field form-control" maxlength="100" data-field="nombre"/>
		</div>
	</div>
	
	<div class="div-primerApellido form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.primerApellido.label" default="Primer apellido" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="primerApellido field form-control" maxlength="80" data-field="primerApellido"/>
		</div>
	</div>
	
	<div class="div-segundoApellido form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="oficioCnbv.segundoApellido.label" default="Segundo apellido" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="segundoApellido field form-control" maxlength="80" data-field="segundoApellido"/>
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

<script type="text/template" id="oficioCnbvResultTemplate">

	<td style="white-space:nowrap">{{=claveDga}}</td>
	<td style="white-space:nowrap">{{=numeroOficio}}</td>
	<td>{{=fechaOficio}}</td>
	<td>{{=autorizados}}</td>
	<td>
		<button type="button" class="show btn btn-default btn-xs" data-grailsId="{{=grailsId}}" ><span class="glyphicon glyphicon-eye-open"></span>&nbsp;Ver detalle</button>
		<button type="button" class="edition btn btn-default btn-xs" data-grailsId="{{=grailsId}}" ><span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar autorizados</button>
	</td>

</script>

<script type="text/template" id="oficioCnbvResultsTemplate">
	<fieldset>
		<legend>Resultados de búsqueda</legend>
		
		<div class="procMessage alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
		<div class="errorMessage alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> <span class="errorMessageText">Ha ocurrido un error un la petición, intente mas tarde.</span></div>
		
		<div class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<th>
						Clave DGA
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="claveDga" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="claveDga" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						N. Oficio
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroOficio" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroOficio" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Fecha Oficio
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaOficio" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaOficio" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Autorizados
						</th>
						<th>...</th>
					</tr>
				</thead>
				
				<tbody class="list-items"></tbody>
			
			</table>
			
			<ul class="pagination pagination-sm"></ul>
			
		</div>
		
	</fieldset>
</script>