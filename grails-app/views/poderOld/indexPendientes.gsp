<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>

<title>Registro 0.1 - Poderes pendientes de revisión</title>

</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="poder" action="index" />">Poderes</a></li>
		<li><a href="#">Pendientes de revisión</a></li>
	</ul>
	
	<h2><strong>Poderes pendientes de revisión</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="poder" action="index" />" method="get">
		
		<fieldset>
			
			<div id="list-poder" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<tr>
						
							<g:sortableColumn property="id" title="${message(code: 'poder.id.label', default: 'ID')}"  />
						
							<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'poder.fechaApoderamiento.label', default: 'Fec. Apoderamiento')}"/>
							
							<g:sortableColumn property="numeroEscritura" title="${message(code: 'poder.numeroEscritura.label', default: 'Num. Escritura')}"/>
						
							<th>...</th>
							
						</tr>
					</thead>
					<tbody>
					<g:each in="${poderInstanceList}" status="i" var="poderInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${poderInstance.id}">${poderInstance.id}</g:link></td>
						
							<td><g:formatDate date="${poderInstance.fechaApoderamiento}" /></td>
						
							<td>${fieldValue(bean: poderInstance, field: "numeroEscritura")}</td>
							
							<td>
								<button id="btnVer" onclick="btnVer_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								
								<button id="btnRevisar" onclick="btnRevisar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-edit"></span><span class="hidden-xs hidden-sm"> Revisar</span></button>
								
								<button id="btnEditar" onclick="btnEditar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${poderInstanceCount?:0}" />
				</div>
			</div>
			
		</fieldset>
	</form>
	
	
	<script>
	
	//callbacks para botones en lista
	function btnVer_click(id){
		window.location.href = '<g:createLink controller="poder" action="show" />/'+id;
	}
	function btnRevisar_click(id){
		window.location.href = '<g:createLink controller="poder" action="editVerify" />/'+id;
	}
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="poder" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="poder" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	</script>
</body>
</html>