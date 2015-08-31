<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="revocacionIndexViewTemplate">
	<div class="div-revocacionSearch"></div>
	<div class="div-revocacionResults"></div>
</script>

<script type="text/template" id="revocacionSearchViewTemplate">
		<fieldset>
			<legend>Búsqueda de revocaciones</legend>
			<div id="divBusquedaRevocaciones">
				
				<div class="div-opcionSeleccionada form-group">
					<label class="col-md-2 col-sm-3 control-label">
						Criterio de búsqueda
					</label>
					<div class="col-md-9 col-sm-9">
						<input class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="0" checked="" type="radio">&nbsp;Numero de escritura&nbsp;&nbsp;
						<input class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="1" type="radio">&nbsp;Fecha de revocación&nbsp;&nbsp;
						<input class="opcionSeleccionada field" name="opcionSeleccionadaDO" data-field="opcionSeleccionada" value="2" type="radio">&nbsp;Entidad Financiera
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
						Institución<span class="required-indicator">*</span>
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

<script type="text/template" id="revocacionResultViewTemplate">
	
</script>

<script type="text/template" id="revocacionResultsViewTemplate">
		
			<fieldset>
				<legend>Resultados de búsqueda</legend>
				
				<div class="alert-processing alert alert-info"><img src="/amibRegistro/assets/spinner_alert_info.gif">&nbsp; Procesando datos, espere unos instantes...</div>
				<div class="alert-errorOnRequest alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span>&nbsp; Error en petición</div>
				
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