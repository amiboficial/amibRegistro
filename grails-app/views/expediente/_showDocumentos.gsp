<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="docsTemplate">
	<table class="table">
		<thead>
			<tr>
				<th style='width:32%;'>
				Tipo
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="dsTipo" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="dsTipo" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
				Nombre
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th>
				Vigente
				</th>
				<th>
				Fecha de carga
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaCargaUnixEpoch" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
				<button type="button" class="sort btn btn-default btn-xxs" data-sort="fechaCargaUnixEpoch" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
				</th>
				<th style='width:18%'>&nbsp;</th>
			</tr>
		</thead>
		<tbody class="table-body">
		</tbody>
	</table>
	<ul class="pagination pagination-sm"></ul>
</script>

<script type="text/template" id="docTemplate">
	<tr>
		<td>{{=dsTipo}}</td>
		<td>{{=nombre}}</td>
		<td>
		{{ if(vigente){ }}
			<span class="glyphicon glyphicon-ok"></span>
		{{ } else{ }}
			<span class="glyphicon glyphicon-remove"></span>
		{{ } }}
		</td>
		<td>{{=fechaCarga}}</td>
		<td>
			<button type="button" class="download btn btn-info btn-xs" data-uuid="{{=uuid}}">Descargar</button>
		</td>
	</tr>
</script>