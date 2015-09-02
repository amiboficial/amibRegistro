<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="resRevShwTemplate">
	<tr>
		<td>{{=idSustentante}}</td>
		<td>{{=numeroMatricula}}</td>
		<td>{{=nombre}}</td>
		<td>{{=primerApellido}}</td>
		<td>{{=segundoApellido}}</td>
		<td>
			<button type="button" class="show btn btn-default btn-xs" data-idsustentante="{{=idSustentante}}"><span class="glyphicon glyphicon glyphicon-book"></span> Ir a expediente</button>
		</td>
	</tr>
</script>

<script type="text/template" id="resRevShwColTemplate">

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
		<tbody class="list-items"></tbody>
	</table>

</script>