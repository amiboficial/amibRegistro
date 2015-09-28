<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="hpoderesTemplate">
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
					Fecha de apoderamiento
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaApoderamiento" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
					<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaApoderamiento" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
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

<script type="text/template" id="hpoderTemplate">
	<tr>
		<td>{{=grailsId}}</td>
		<td>{{=numeroEscritura}}</td>
		<td>{{=nombreCompletoNotario}}</td>
		<td>{{=fechaApoderamiento}}</td>
		<td>{{=grupoFinancieroNombre}}</td>
		<td>{{=institucionNombre}}</td>
		<td>
			<button type="button" class="download btn btn-info btn-xs" data-id="{{=grailsId}}">Revisar poder</button>
		</td>
	</tr>
</script>