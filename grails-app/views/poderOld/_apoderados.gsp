<%@ page contentType="text/html;charset=UTF-8" %>
		<script type="text/template" id="apoderadoTemplate">
			<td>{{=matricula}}</td>
			<td>{{=nombreCompleto}}</td>
			<td>{{=claveDga}}</td>
			<td>
				<button class="delete btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> Borrar</button> 
				<input type="hidden" name="apoderadoIdAutorizadoCNBV" value="{{=idAutorizadoCNBV}}" />
			</td>
		</script>