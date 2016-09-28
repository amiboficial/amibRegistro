<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="hrevocsTemplate">
	<table class="table">
		<thead>
			<tr>

				<th>
					ID
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="grailsId" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="grailsId" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
					N° de escritura
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroEscritura" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroEscritura" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
					Notario
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombreCompletoNotario" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombreCompletoNotario" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
					Fecha de revocación
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaRevocacion" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaRevocacion" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
					Grupo financiero
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="grupoFinancieroNombre" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="grupoFinancieroNombre" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
					Institución
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="institucionNombre" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="institucionNombre" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				
			</tr>
		</thead>
		<tbody class="table-body">
		</tbody>
	</table>
	<ul class="pagination pagination-sm"></ul>
</script>

<script type="text/template" id="hrevocTemplate">
	<tr>
		<td>{{=grailsId}}</td>
		<td>{{=numeroEscritura}}</td>
		<td>{{=nombreCompletoNotario}}</td>
		<td>{{=fechaRevocacion}}</td>
		<td>{{=grupoFinancieroNombre}}</td>
		<td>{{=institucionNombre}}</td>
	</tr>
</script>