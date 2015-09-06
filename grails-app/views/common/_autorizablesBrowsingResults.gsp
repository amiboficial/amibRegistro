<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="templateAutBrwResultsView">
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
						</th>
						<th>
						Folio
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Matricula
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Nombre
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						1er Apellido
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						2do Apellido
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
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

<script type="text/template" id="templateAutBrwResultItemView">
	<tr>
		<td>
			[+]
		</td>
		<td>
			[Folio]
		</td>
		<td>
			[Matricula]
		</td>
		<td>
			[nombre]
		</td>
		<td>
			[primerapellido]
		</td>
		<td>
			[segundapellido]
		</td>
		<td>
			[accion]
		</td>
	</tr>
	<tr>
		<td colspan="8" >
			<div>
				[Atributos adicionales relacionados con la figura]
			</div>
		</td>
	</tr>
</script>