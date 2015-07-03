<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Registro 0.1 - Detalle de altas y solicitudes</title>
	</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Información</a><span class="divider"></span></li>
		<li><a href="#">Detalle de altas y solicitudes</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Detalle de altas y solicitudes</strong></h2>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<ul class="nav nav-tabs" role="tablist">
	  <li role="presentation" class="active"><a href="#divPoderes" aria-controls="divPoderes" role="tab" data-toggle="tab">Altas de Poder</a></li>
	  <li role="presentation"><a href="#divRevocaciones" aria-controls="divRevocaciones" role="tab" data-toggle="tab">Solicitudes de Revocación</a></li>
	</ul>
	
	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="divPoderes">
		
			<div id="list-poder" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<g:sortableColumn property="id" title="${message(code: 'poder.id.label', default: 'ID')}"  />
						<g:sortableColumn property="fechaApoderamiento" title="${message(code: 'poder.fechaApoderamiento.label', default: 'Fec. Apoderamiento')}"  />
						<g:sortableColumn property="numeroEscritura" title="${message(code: 'poder.numeroEscritura.label', default: 'Num. Escritura')}" />
						<g:sortableColumn property="fechaCreacion" title="${message(code: 'poder.fechaCreacion.label', default: 'Fec. Alta')}" />
						<g:sortableColumn property="verificado" title="${message(code: 'poder.verificado.label', default: 'Verificado')}" />
						<g:sortableColumn property="aprobado" title="${message(code: 'poder.aprobado.label', default: 'Aprobado')}" />
						<th>...</th>
					</thead>
					
					<tbody>
						<g:each in="${poderInstanceList}" status="i" var="poderInstance">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td><g:link controller="poderOld" action="showEntidadFinanciera" id="${poderInstance.id}">${poderInstance.id}</g:link></td>
								<td><g:formatDate date="${poderInstance.fechaApoderamiento}" /></td>
								<td>${fieldValue(bean: poderInstance, field: "numeroEscritura")}</td>
								<td><g:formatDate date="${poderInstance.fechaCreacion}" /></td>
								<td>
									<g:if test="${poderInstance.verificado == true}">
										<span class="glyphicon glyphicon-ok"></span>
									</g:if>
								</td>
								<td>
									<g:if test="${poderInstance.verificado == true}">
										<g:if test="${poderInstance.aprobado == true}">
											<span class="glyphicon glyphicon-ok"></span>
										</g:if>
										<g:else>
											<span class="glyphicon glyphicon-remove"></span>
										</g:else>
									</g:if>
								</td>
								<td>
									<button id="btnVer" onclick="btnVerPoder_click(${poderInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		
		</div>
		<div role="tabpanel" class="tab-pane" id="divRevocaciones">
		
			<div id="list-revocacion" class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<g:sortableColumn property="id" title="${message(code: 'revocacion.id.label', default: 'ID')}"  />
						<g:sortableColumn property="fechaRevocacion" title="${message(code: 'revocacion.fechaApoderamiento.label', default: 'Fec. Apoderamiento')}"  />
						<g:sortableColumn property="numeroEscritura" title="${message(code: 'revocacion.numeroEscritura.label', default: 'Num. Escritura')}" />
						<g:sortableColumn property="fechaCreacion" title="${message(code: 'revocacion.fechaCreacion.label', default: 'Fec. Alta')}" />
						<g:sortableColumn property="verificado" title="${message(code: 'revocacion.verificado.label', default: 'Verificado')}" />
						<g:sortableColumn property="aprobado" title="${message(code: 'revocacion.aprobado.label', default: 'Aprobado')}" />
						<th>...</th>
					</thead>
					
					<tbody>
						<g:each in="${revocacionInstanceList}" status="i" var="revocacionInstance">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td><g:link controller="revocacionOld" action="showEntidadFinanciera" id="${revocacionInstance.id}">${revocacionInstance.id}</g:link></td>
								<td><g:formatDate date="${revocacionInstance.fechaRevocacion}" /></td>
								<td>${fieldValue(bean: revocacionInstance, field: "numeroEscritura")}</td>
								<td><g:formatDate date="${revocacionInstance.fechaCreacion}" /></td>
								<td>
									<g:if test="${revocacionInstance.verificado == true}">
										<span class="glyphicon glyphicon-ok"></span>
									</g:if>
								</td>
								<td>
									<g:if test="${revocacionInstance.verificado == true}">
										<g:if test="${revocacionInstance.aprobado == true}">
											<span class="glyphicon glyphicon-ok"></span>
										</g:if>
										<g:else>
											<span class="glyphicon glyphicon-remove"></span>
										</g:else>
									</g:if>
								</td>
								<td>
									<button id="btnVer" onclick="btnVerRevocacion_click(${revocacionInstance.id})" type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span><span class="hidden-xs hidden-sm"> Ver detalle</span></button>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		
		</div>
	</div>
	<script>

	function btnVerPoder_click(id){
		window.location.href = '<g:createLink controller="poder" action="showEntidadFinanciera" />/'+id;
	}

	function btnVerRevocacion_click(id){
		window.location.href = '<g:createLink controller="revocacion" action="showEntidadFinanciera" />/'+id;
	}
	
	</script>
</body>
</html>