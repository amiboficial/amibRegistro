<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="oficioCnbvShowAutorizadosListTemplate">

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

</script>

<script type="text/template" id="oficioCnbvShowAutorizadosElementTemplate">
	<td class="hidden-xs">{{=idSustentante}}</td>
	<td>{{=numeroMatricula}}</td>
	<td class="hidden-sm hidden-md hidden-lg">{{=nombreCompleto}}</td>
	<td class="hidden-xs">{{=nombre}}</td>
	<td class="hidden-xs">{{=primerApellido}}</td>
	<td class="hidden-xs">{{=segundoApellido}}</td>
	<td class="hidden-xs hidden-sm" style="width: 330px">{{=dsTipoAutorizacion}}</td>
	<td>
		<button type="button" class="show btn btn-default btn-xs" data-idSustentante="{{=idSustentante}}"><span class="glyphicon glyphicon glyphicon-book"></span> Ir a expediente</button>
	</td>
</script>