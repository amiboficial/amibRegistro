<%@ page contentType="text/html;charset=UTF-8" %>
		<script type="text/template" id="autorizadoTemplate">
			<td>{{=numeroMatricula}}</td>
			<td>{{=nombreCompleto}}</td>
			<td>
				<button class="delete btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm">  Borrar</span></button> 
				<input type="hidden" name="autorizado" value="{ id:{{=grailsId}}, numeroMatricula:{{=numeroMatricula}}, nombreCompleto:'{{=nombreCompleto}}' }" />
			</td>
		</script>