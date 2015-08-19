<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvFormAutorizadosTemplate">

	<div class="alert-errorNumeroMatricula alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Ha habido un error con el <strong>Numero de matrícula</strong> introducido.</div>
	<div class="alert-errorNumeroMatriculaNotFound alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No se puedo encontrar un registro <strong>En Autorización</strong> con el <strong>Numero de matrícula</strong> introducida.</div>
	<div class="alert-errorNumeroMatriculaInvalidDataType alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> válido.</div>
	<div class="alert-errorNumeroMatriculaInList alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Introduzca un <strong>Numero de matrícula</strong> que no haya sido ya incluido en la lista.</div>
	<div class="alert-processing alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
	
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

	<div class="div-result">
	</div>

	<div class="div-autorizados">
	</div>
	
</script>

<script type="text/template" id="oficioCnbvFormAutorizadosResultTemplate">
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
	
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-6 col-sm-6">
		
			{{ if(!numeroMatriculaFoundValidated){ }}
				<button disabled="" type="button" class="btn btn-primary btn-block add">
			{{ } else{ }}
				<button type="button" class="btn btn-primary btn-block add">	
			{{ } }}
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Agregar
				</button>
		
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
</script>

<script type="text/template" id="oficioCnbvFormAutorizadosListTemplate">

	<fieldset>
		<legend>Listado de autorizados</legend>
		<table class="table">
			<thead>
				<tr>
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
					<th class="hidden-xs hidden-sm">
					Tipo de Autorización<br/>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="dsTipoAutorizacion" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="dsTipoAutorizacion" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>...</th>
				</tr>
			</thead>
			<tbody class="list-items"></tbody>
		</table>
	</fieldset>

</script>

<script type="text/template" id="oficioCnbvFormAutorizadosElementTemplate">
	<td class="hidden-xs">{{=idSustentante}}</td>
	<td>{{=numeroMatricula}}</td>
	<td class="hidden-sm hidden-md hidden-lg">{{=nombreCompleto}}</td>
	<td class="hidden-xs">{{=nombre}}</td>
	<td class="hidden-xs">{{=primerApellido}}</td>
	<td class="hidden-xs">{{=segundoApellido}}</td>
	<td class="hidden-xs hidden-sm" style="width: 330px">{{=dsTipoAutorizacion}}</td>
	<td>
		<button type="button" class="remove btn btn-default btn-xs" data-idCertificacion="{{=idCertificacion}}"><span class="glyphicon glyphicon glyphicon-trash"></span> Eliminar</button>
	</td>
</script>