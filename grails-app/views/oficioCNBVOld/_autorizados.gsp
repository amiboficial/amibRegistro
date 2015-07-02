<%@ page contentType="text/html;charset=UTF-8" %>
		<script type="text/template" id="autorizadoTemplate">
			<td>{{=numeroMatricula}}</td>
			<td>{{=nombreCompleto}}</td>
			<td>
				<button class="delete btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm">  Borrar</span></button> 
				<input type="hidden" name="autorizado" value="{ id:{{=grailsId}}, numeroMatricula:{{=numeroMatricula}}, nombreCompleto:'{{=nombreCompleto}}' }" />
			</td>
		</script>
		<script type="text/template" id="newAutorizadoTemplate">
			<tr>
				<td><input id="txtAutorizadosNewMatricula" class="newMatricula form-control" type="text" /></td>
				<td><input id="txtAutorizadosNewNombre" class="newNombre form-control" type="text" disabled/></td>
				<td><button id="btnAutorizadosAdd" class="add btn btn-success btn-sm" disabled><span class="glyphicon glyphicon-plus"></span><span class="hidden-xs hidden-sm"> Agregar</span></button></td>
			</tr>
		</script>