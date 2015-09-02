<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="revocacionIndexViewTemplate">
	<div class="div-revocacionSearch"></div>
	<div class="div-revocacionResults"></div>
</script>

<script type="text/template" id="revocacionSearchViewTemplate">

		<fieldset>
			<legend>Acciones</legend>
			<button type="button" class="create btn btn-primary"><span class="glyphicon glyphicon-file"></span> Alta de revocación</button>
		</fieldset>

		<fieldset>
			<legend>Búsqueda de revocaciones</legend>
			<div id="divBusquedaRevocaciones">
				
				<div class="alert-errorNumeroEscrituraBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir un <strong>Número de escritura</strong></div>
				<div class="alert-errorNumeroEscrituraNonNumeric alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir un valor numérico en <strong>Número de escritura</strong></div>
				<div class="alert-errorFechaRevocacionDelBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir una fecha inicial a buscar por <strong>Fecha de Revocación</strong></div>
				<div class="alert-errorFechaRevocacionAlBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir una fecha final a buscar por <strong>Fecha de Revocación</strong></div>
				<div class="alert-errorFechaRevocacionWrongRange alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir un rango de fechas válido</div>
				<div class="alert-errorGrupoFinancieroNonSelected alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe seleccionar como "mínimo" un grupo financiero</div>
				
				<div class="div-opcionSeleccionada form-group">
					<label class="col-md-2 col-sm-3 control-label">
						Criterio de búsqueda
					</label>
					<div class="col-md-9 col-sm-9">
						<input class="criterioBusqueda field" name="criterioBusquedaDO" data-field="criterioBusqueda" 
						value="{{=app.REV_IDX_OPTION_NUMESCRITURA}}" 
						{{ if(criterioBusqueda == app.REV_IDX_OPTION_NUMESCRITURA){ }}
							checked="" 
						{{ } }}
						type="radio">&nbsp;Numero de escritura&nbsp;&nbsp;
						
						<input class="criterioBusqueda field" name="criterioBusquedaDO" data-field="criterioBusqueda" 
						value="{{=app.REV_IDX_OPTION_FECREV}}" 
						{{ if(criterioBusqueda == app.REV_IDX_OPTION_FECREV){ }}
							checked="" 
						{{ } }}
						type="radio">&nbsp;Fecha de revocación&nbsp;&nbsp;
						
						<input class="criterioBusqueda field" name="criterioBusquedaDO" data-field="criterioBusqueda" 
						value="{{=app.REV_IDX_OPTION_ENTFINANCIERA}}" 
						{{ if(criterioBusqueda == app.REV_IDX_OPTION_ENTFINANCIERA){ }}
							checked="" 
						{{ } }}
						type="radio">&nbsp;Entidad Financiera&nbsp;&nbsp;
						
						<input class="criterioBusqueda field" name="criterioBusquedaDO" data-field="criterioBusqueda" 
						value="{{=app.REV_IDX_OPTION_TODOS}}" 
						{{ if(criterioBusqueda == app.REV_IDX_OPTION_TODOS){ }}
							checked="" 
						{{ } }}
						type="radio">&nbsp;Mostrar todos
					</div>
				</div>
				
				<div class="div-numeroEscritura form-group">
					<label class="col-md-2 col-sm-3 control-label">
						Número de escritura
					</label>
					<div class="col-md-9 col-sm-9">
						<input type="text" maxlength="10" class="numeroEscritura field form-control" data-field="numeroEscritura" />
					</div>
				</div>
				
				<div class="div-fechaRevocacionDel form-group">
					<label class="col-md-2 col-sm-3 control-label">
						Fecha de revocación (del)
					</label>
					<div class="col-md-9 col-sm-9">
						<select style="width: 28%;" class="form-control col-md-4 fechaRevocacionDel_day field" data-field="fechaRevocacionDel_day" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=1;i<=31;i++){ }}
								{{ if(i == fechaRevocacionDel_day){ }}
									<option value="{{=i}}" selected>{{=i}}</option>
								{{ } else{ }}
									<option value="{{=i}}">{{=i}}</option>
								{{ } }}
							{{ } }}
						</select>
						<select style="width: 38%;" class="form-control col-md-4 fechaRevocacionDel_month field" data-field="fechaRevocacionDel_month" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=0;i<app.MESES.length;i++){ }}
								{{ if(app.MESES[i].id == fechaRevocacionDel_month){ }}
									<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
								{{ } else{ }}
									<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
								{{ } }}
							{{ } }}
						</select>
						<select style="width: 34%;" class="form-control col-md-4 fechaRevocacionDel_year field" data-field="fechaRevocacionDel_year" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=1980;i<=2030;i++){ }}
								{{ if(i == fechaRevocacionDel_year){ }}
									<option value="{{=i}}" selected>{{=i}}</option>
								{{ } else{ }}
									<option value="{{=i}}">{{=i}}</option>
								{{ } }}
							{{ } }}
						</select>
					</div>
				</div>
				<div class="div-fechaRevocacionAl form-group">
					<label class="col-md-2 col-sm-3 control-label">
						Fecha de revocación (al)
					</label>
					<div class="col-md-9 col-sm-9">
						<select style="width: 28%;" class="form-control col-md-4 fechaRevocacionAl_day field" data-field="fechaRevocacionAl_day" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=1;i<=31;i++){ }}
								{{ if(i == fechaRevocacionAl_day){ }}
									<option value="{{=i}}" selected>{{=i}}</option>
								{{ } else{ }}
									<option value="{{=i}}">{{=i}}</option>
								{{ } }}
							{{ } }}
						</select>
						<select style="width: 38%;" class="form-control col-md-4 fechaRevocacionAl_month field" data-field="fechaRevocacionAl_month" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=0;i<app.MESES.length;i++){ }}
								{{ if(app.MESES[i].id == fechaRevocacionAl_month){ }}
									<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
								{{ } else{ }}
									<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
								{{ } }}
							{{ } }}
						</select>
						<select style="width: 34%;" class="form-control col-md-4 fechaRevocacionAl_year field" data-field="fechaRevocacionAl_year" >
							<option value="-1">-Seleccione-</option>
							{{ for(var i=1980;i<=2030;i++){ }}
								{{ if(i == fechaRevocacionAl_year){ }}
									<option value="{{=i}}" selected>{{=i}}</option>
								{{ } else{ }}
									<option value="{{=i}}">{{=i}}</option>
								{{ } }}
							{{ } }}
						</select>
					</div>
				</div>
				
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
						Institución
					</label>
					<div class="col-md-9 col-sm-9">
						<select class="field idInstitucion form-control" data-field="idInstitucion">
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button type="button" class="limpiar btn btn-primary">Limpiar campos</button>
						<button type="button" class="buscar btn btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
		</fieldset>
</script>

<script type="text/template" id="revocacionSearchViewInstitucionesTemplate">
	{{ _.each(instituciones,function(item){ }}
		{{ if(item.id == idInstitucion){ }}
			<option value="{{=item.id}}" selected>{{=item.text}}</option>
		{{ } else{ }}
			<option value="{{=item.id}}">{{=item.text}}</option>
		{{ } }}
	{{ },this); }}
</script>

<script type="text/template" id="revocacionResultViewTemplate">
	<tr>
		<td>{{=grailsId}}</td>
		<td>{{=numeroEscritura}}</td>
		<td>{{=fechaRevocacionDDMMYYYY}}</td>
		<td>{{=nombreCompletoNotario}}</td>
		<td>
			<button type="button" class="show btn btn-default btn-xs" data-grailsid="{{=grailsId}}" ><span class="glyphicon glyphicon-eye-open"></span>&nbsp;Ver detalle</button>
		</td>
	</tr>
</script>

<script type="text/template" id="revocacionResultsViewTemplate">
		
			<fieldset>
				<legend>Resultados de búsqueda</legend>
				
				<div class="alert-processing alert alert-info"><img src="/amibRegistro/assets/spinner_alert_info.gif">&nbsp; Procesando datos, espere unos instantes...</div>
				<div class="alert-errorOnRequest alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span>&nbsp; Error en petición</div>
				<div class="alert-warningNotFound alert alert-warning"><span class="glyphicon glyphicon-info-sign"></span>&nbsp; No se encontró ningún resultado</div>
				
				<div class="content scaffold-list" role="main">
					<table class="table">
						<thead>
							<tr>
								<th>
								ID
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="grailsId" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="grailsId" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
								</th>
								<th>
								Número de escritura
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroEscritura" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroEscritura" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
								</th>
								<th>
								Fecha de revocación
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaRevocacion" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
									<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaRevocacion" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
								</th>
								<th>
								Notario
								</th>
								<th>...</th>
							</tr>
						</thead>
						
						<tbody class="list-items"></tbody>
					
					</table>
					
					<ul class="pagination pagination-sm"><li class="disabled"><a href="javascript:void(0);">&lt;</a></li><li class="disabled"><a href="javascript:void(0);">&gt;</a></li></ul>
					
				</div>
				
			</fieldset>

</script>