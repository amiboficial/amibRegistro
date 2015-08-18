<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvFormAutorizadosTemplate">

	<div class="div-numeroMatricula form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Número de matrícula
		</label>
		<div class="col-md-4 col-sm-4">
			<input class="numeroMatricula field form-control" maxlength="10" data-field="numeroMatricula" type="text" value="{{=numeroMatricula}}">
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
			<input class="nombre form-control" type="text" value="{{=nombre}} {{=primerApellido}} {{=segundoApellido}}" disabled>
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
	
	<div class="div-autorizados">
		
	</div>
	
</script>

<script type="text/template" id="oficioCnbvFormAutorizadosListTemplate">

	<fieldset>
		<legend>Listado de autorizados</legend>
		<table class="table">
			<thead>
				<tr>
					<th>
					Folio 
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>
					Matrícula 
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>
					Nombre 
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>
					1er Apellido 
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>
					2do Apellido 
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
						<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
					</th>
					<th>...</th>
				</tr>
			</thead>
			<tbody class="list-items"></tbody>
		</table>
	</fieldset>

</script>