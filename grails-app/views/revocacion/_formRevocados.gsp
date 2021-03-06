<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="formRevocadosTemplate">

	<div class="alert-errorRevocadosListBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe ingresar al menos un revocado</div>
	<div class="alert-processing alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>

	<div class="div-revocable"></div>
	
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-6 col-sm-6">
			<button disabled="" type="button" class="btn btn-primary btn-block add">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Agregar
			</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
	
	<div class="div-list-revocados"></div>

	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block edit">Editar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>

<script type="text/template" id="formRevocableTemplate">

	<div class="alert-errorNumeroMatriculaNotFound alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No se puedo encontrar un registro <strong>Autorizado con poderes</strong> con el <strong>Numero de matrícula</strong> introducida.</div>
	<div class="alert-errorNumeroMatriculaNotRevocable alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No es posible aplicar revocación alguna a la matricula mencioanda.</div>
	<div class="alert-errorNumeroMatriculaBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> válido.</div>
	<div class="alert-errorNumeroMatriculaNonNumeric alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> válido. El valor debe ser numérico.</div>
	<div class="alert-errorNumeroMatriculaInList alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> que no haya sido ya incluido en la lista.</div>

	<div class="alert-errorIdApoderadoNotSelected alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No ha seleccionado el <strong>poder</strong> a revocar.</div>
	<div class="alert-errorDsMotivoBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe incresar un <strong>Motivo</strong> para la revocación.</div>
	<div class="alert-errorFechaBajaNotValid alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Ha habido un error con la <strong>Fecha de baja</strong> introducida.</div>
	
	<div class="div-numeroMatricula form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Número de matrícula
		</label>
		<div class="col-md-4 col-sm-4">
			<input type="text" class="numeroMatricula field form-control" maxlength="10" data-field="numeroMatricula" value={{=numeroMatricula}}>
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-info btn-block btn-xs verifyNumeroMatricula"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;Buscar</button>
		</div>
	</div>

	<div class="div-nombreCompleto form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Nombre completo
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="nombreCompleto form-control" type="text" value="{{=nombreCompleto}}" disabled>
		</div>
	</div>

	<div class="div-idApoderado form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Poder a revocar
		</label>
		<div class="col-md-9 col-sm-9">
			<select class="field idApoderado form-control" data-field="idApoderado" disabled>
			{{ _.each(apoderamientosEncontrados,function(item){ }}
				{{ if(item.id == idApoderado){ }}
					<option value="{{=item.id}}" selected>{{=item.text}}</option>
				{{ } else{ }}
					<option value="{{=item.id}}">{{=item.text}}</option>
				{{ } }}
			{{ },this ); }}
			</select>
		</div>
	</div>
	
	<div class="div-motivo form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Motivo
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="motivo field form-control" data-field="motivo" type="text" value="{{=motivo}}" disabled>
		</div>
	</div>
	
	<div class="div-fechaBaja form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Fecha de baja
		</label>
		<div class="col-md-9 col-sm-9">
			
			<select style="width: 28%;" class="form-control col-md-4 fechaBaja_day field" data-field="fechaBaja_day" disabled>
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1;i<=31;i++){ }}
					{{ if(i == fechaBaja_day){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 38%;" class="form-control col-md-4 fechaBaja_month field" data-field="fechaBaja_month" disabled>
				<option value="-1">-Seleccione-</option>
				{{ for(var i=0;i<app.MESES.length;i++){ }}
					{{ if(app.MESES[i].id == fechaBaja_month){ }}
						<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
					{{ } else{ }}
						<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
					{{ } }}
				{{ } }}
			</select>
			<select style="width: 34%;" class="form-control col-md-4 fechaBaja_year field" data-field="fechaBaja_year" disabled>
				<option value="-1">-Seleccione-</option>
				{{ for(var i=1980;i<=2030;i++){ }}
					{{ if(i == fechaBaja_year){ }}
						<option value="{{=i}}" selected>{{=i}}</option>
					{{ } else{ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				{{ } }}
			</select>
			
		</div>
	</div>
	
</script>

<script type="text/template" id="formRevocadosCollectionTemplate">

	<fieldset>
		<legend>Listado de revocables</legend>
		<table class="table">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th class="hidden-xs">
					Folio<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>
					Matrícula<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th class="hidden-sm hidden-md hidden-lg">
					Nombre completo<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombreCompleto" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombreCompleto" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th class="hidden-xs">
					Nombre<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th class="hidden-xs">
					1er Apellido<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th class="hidden-xs">
					2do Apellido<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>...</th>
				</tr>
			</thead>
			<tbody class="list-items">
			</tbody>
		</table>
	</fieldset>

</script>

<script type="text/template" id="formRevocadosRowTemplate">

	<tr>
		<td>
			{{ if(vistaExpandida){ }}
				<button class="collapseRow btn btn-default btn-xxs" data-id="{{=idApoderado}}"><span class="glyphicon glyphicon-minus"></span></button>
			{{ } else { }}
				<button class="expandRow btn btn-default btn-xxs" data-id="{{=idApoderado}}"><span class="glyphicon glyphicon-plus"></span></button>
			{{ } }}
		</td>
		<td>
		{{=idSustentante}}
		</td>
		<td>
		{{=numeroMatricula}}
		</td>
		<td>
		{{=nombre}}
		</td>
		<td>
		{{=primerApellido}}
		</td>
		<td>
		{{=segundoApellido}}
		</td>
		<td>
			<button class="removeItem btn btn-danger btn-xs" data-id="{{=idApoderado}}"><span class="glyphicon glyphicon-trash"></span>Eliminar</button>
		</td>
	</tr>
	{{ if(vistaExpandida){ }}
		<tr>
			<td colspan="7">
				<div class="div-revocado-details-{{=idApoderado}}">
					<ul>
						<li><strong>Motivo:</strong>&nbsp;{{=motivo}}</li>
						<li><strong>Fecha de baja:</strong>&nbsp;{{=fechaBaja_day}}/{{=fechaBaja_month}}/{{=fechaBaja_year}}</li>
						<li><strong>Poder a revocar:</strong>&nbsp;{{=dsPoderRevocar}}</li>
					</ul>
				</div>
			</td>
		</tr>
	{{ } }}
</script>