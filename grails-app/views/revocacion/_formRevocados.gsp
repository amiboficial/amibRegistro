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

	<div class="alert-errorNumeroMatricula alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Ha habido un error con el <strong>Numero de matrícula</strong> introducido.</div>
	<div class="alert-errorNumeroMatriculaNotFound alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No se puedo encontrar un registro <strong>Autorizado con poderes</strong> con el <strong>Numero de matrícula</strong> introducida.</div>
	<div class="alert-errorNumeroMatriculaBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> válido.</div>
	<div class="alert-errorNumeroMatriculaNonNumeric alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> válido.</div>
	<div class="alert-errorNumeroMatriculaInList alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> que no haya sido ya incluido en la lista.</div>

	<div class="div-numeroMatricula form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Número de matrícula
		</label>
		<div class="col-md-4 col-sm-4">
			<input class="numeroMatricula field form-control" maxlength="10" data-field="numeroMatricula" type="text">
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block btn-xs verifyNumeroMatricula">Buscar</button>
		</div>
	</div>

	<div class="div-nombreCompleto form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Nombre completo
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="nombre form-control" type="text" value="{{=nombreCompleto}}" disabled>
		</div>
	</div>

	<div class="div-dsFigura form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Figura
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="nombre form-control" type="text" value="{{=dsFigura}}" disabled>
		</div>
	</div>

	<div class="div-dsVarianteFigura form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Variante de Figura
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="dsVarianteFigura form-control" type="text" value="{{=dsVarianteFigura}}" disabled>
		</div>
	</div>

	<div class="div-dsTipoAutorizacion form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Tipo de autorización
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="dsTipoAutorizacion form-control" type="text" value="{{=dsTipoAutorizacion}}" disabled>
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
	
	<div class="div-dsMotivo form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Motivo
		</label>
		<div class="col-md-9 col-sm-9">
			<input class="dsMotivo form-control" type="text" value="{{=dsMotivo}}" disabled>
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