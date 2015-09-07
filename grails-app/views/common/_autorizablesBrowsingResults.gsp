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
						<th style="width:81px">
						Folio
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th style="width:107px">
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
			{{ if(!expanded){ }}
				<button type="button" class="showinfo btn btn-default btn-xxs" data-grailsid="{{=grailsId}}"><span class="glyphicon glyphicon-plus"></span></button>
			{{ } else{ }}
				<button type="button" class="hideinfo btn btn-default btn-xxs" data-grailsid="{{=grailsId}}"><span class="glyphicon glyphicon-minus"></span></button>
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
			<button type="button" class="performAction btn btn-default btn-xs" data-grailsid="{{=grailsId}}"><span class="glyphicon glyphicon-{{=iconoBotonAccion}}"></span> {{=mensajeBotonAccion}}</button>
		</td>
	</tr>
	{{ if(expanded){ }}
	<tr>
		<td colspan="8">
			<div>
				 <ul class="list-group">
					<li class="list-group-item"><strong>Figura</strong></li>
					<li class="list-group-item"><strong>Variante de Figura</strong></li>
					<li class="list-group-item"><strong>Status de certificación</strong></li>
					<li class="list-group-item"><strong>Status de autorización</strong></li>
					<li class="list-group-item"><strong>Fecha de inicio desde primera autorziación</strong></li>
					<li class="list-group-item"><strong>Fecha de vencimineto</strong></li>
				</ul>
			</div>
		</td>
	</tr>
	{{ } }}
</script>