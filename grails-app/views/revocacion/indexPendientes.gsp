<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>

<title>Registro 0.1 - Revocaciones pendientes de revisión</title>

</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
		<li><a href="#">Revocaciones de revisión</a></li>
	</ul>
	
	<h2><strong>Revocaciones pendientes de revisión</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<form id="frmApp" class="form-horizontal" role="form" action="<g:createLink controller="revocacion" action="index" />" method="get">
		
		<fieldset>
			
			<div id="list-poder" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<tr>
						
							<g:sortableColumn property="id" title="${message(code: 'revocacion.id.label', default: 'ID')}"  />
						
							<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'revocacion.fechaRevocacion.label', default: 'Fec. Apoderamiento')}"/>
							
							<g:sortableColumn property="numeroEscritura" title="${message(code: 'revocacion.numeroEscritura.label', default: 'Num. Escritura')}"/>
						
							<th>...</th>
							
						</tr>
					</thead>
					<tbody>
					<g:each in="${revocacionInstanceList}" status="i" var="revocacionInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${revocacionInstance.id}">${revocacionInstance.id}</g:link></td>
						
							<td><g:formatDate date="${revocacionInstance.fechaRevocacion}" /></td>
						
							<td>${fieldValue(bean: revocacionInstance, field: "numeroEscritura")}</td>
							
							<td>
								<button id="btnVer" onclick="btnVer_click(${revocacionInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								
								<button id="btnRevisar" onclick="btnRevisar_click(${revocacionInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-edit"></span><span class="hidden-xs hidden-sm"> Revisar</span></button>
								
								<button id="btnEditar" onclick="btnEditar_click(${revocacionInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span><span class="hidden-xs hidden-sm"> Editar</span></button>
								<button id="btnEliminar" onclick="btnEliminar_click(${revocacionInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash"></span><span class="hidden-xs hidden-sm"> Eliminar</span></button>
							</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${revocacionInstanceCount?:0}" />
				</div>
			</div>
			
		</fieldset>
	</form>
	
	
	<script>
	
	//callbacks para botones en lista
	function btnVer_click(id){
		window.location.href = '<g:createLink controller="revocacion" action="show" />/'+id;
	}
	function btnRevisar_click(id){
		window.location.href = '<g:createLink controller="revocacion" action="editVerify" />/'+id;
	}
	function btnEditar_click(id){
		window.location.href = '<g:createLink controller="revocacion" action="edit" />/'+id;
	}
	function btnEliminar_click(id){
		var url = '<g:createLink controller="revocacion" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	</script>
</body>
</html>