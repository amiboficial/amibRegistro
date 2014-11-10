<%@ page contentType="text/html;charset=UTF-8" %>
		<script type="text/template" id="documentoMultiTemplate">
			<div class="row">
				<div class="col-sm-1"><label>Nombre:</label></div>
				<div class="col-sm-3">{{=nombre}}</div>
				<div class="col-sm-offset-1 col-sm-1"><label>Tipo:</label></div>
				<div class="col-sm-3">{{=dsTipo}}</div>
				<div class="col-sm-3" style="text-align:center;">
					<button type="button" class="download btn btn-xs btn-primary"><span class="glyphicon glyphicon-circle-arrow-down"></span> Descargar</button>
					<button type="button" class="delete btn btn-xs btn-danger"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
				</div>
				<input type="hidden" name="documento" value="{ id: {{=grailsId}}, idTipo:{{=idTipo}}, status:{{=status}}, uuid:'{{=uuid}}' }" />
			</div>
		</script>