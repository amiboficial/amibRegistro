<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="loteEnvAutTemplate">

	<fieldset>
		
		<div class="procMessage alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
		<div class="errorMessage alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> Ha ocurrido un error un la petición, intente mas tarde.</div>
	
		<div class="form-group">
			<div class="col-md-12 col-sm-12">
				<div class="btn-group">
					<button type="button" class="selectAll btn btn-primary" data-tab="M"><span class="glyphicon glyphicon-check"></span>&nbsp;Seleccionar todo</button>
					<button type="button" class="selectNone btn btn-primary" data-tab="M"><span class="glyphicon glyphicon glyphicon-unchecked"></span>&nbsp;De-seleccionar todo</button>
					<button type="button" class="removeSelected btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-share"></span>&nbsp;Eliminar seleccionados</button>
				</div>
				&nbsp;&nbsp;&nbsp;
				<div class="btn-group">
					<button type="button" class="empty btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-trash"></span>&nbsp;Vaciar lote</button>
					<button type="button" class="exportxls btn btn-info" data-tab="M"><img src="${assetPath(src: 'excel_icon_16.png')}"/>&nbsp;Exportar a archivo de excel</button>
				</div>
			</div>
		</div>
		
		<div class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>
						Folio 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Matrícula 
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
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						Fecha de Entrega 
							<%--
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
							--%>
						</th>
						<th>
						Fecha de Envio
							<%--
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
							--%>
						</th>
						<th>
						Tipo de Solicitud
							<%--
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="glyphicon glyphicon-chevron-down"></span></button>
							--%>
						</th>
					</tr>
				</thead>
				
				<tbody class="list-items"></tbody>
			</table>
			<ul class="pagination pagination-sm"></ul>
		</div>
	</fieldset>

</script>

<script type="text/template" id="elemLoteTemplate">
	<td class="check handCursor" style="width:1px;white-space:nowrap">
		{{ if(checked==true){ }}
			<span class="glyphicon glyphicon-check" ></span>
		{{ }else if(checked==false){ }}
			<span class="glyphicon glyphicon-unchecked" ></span>
		{{ } }}
	</td>
	<td class="check handCursor" style="white-space:nowrap">{{=idSustentante}}</td>
	<td class="check handCursor" style="white-space:nowrap">{{=numeroMatricula}}</td>
	<td class="check handCursor">{{=nombre}}</td>
	<td class="check handCursor">{{=primerApellido}}</td>
	<td class="check handCursor">{{=segundoApellido}}</td>
	<td class="check handCursor">{{=fechaEntrega}}</td>
	<td class="check handCursor">{{=fechaEnvio}}</td>
	<td class="check handCursor">{{=tipoSolicitud}}</td>
</script>