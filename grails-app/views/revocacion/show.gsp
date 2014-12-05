<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'revocacion.label', default: 'Poder')}" />
	<title>Registro 0.1 - Datos de la Revocación</title>
</head>
<body>
	<a id="anchorForm"></a>
	
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="revocacion" action="index" />">Revocaciones</a></li>
		<li><a href="#">Datos de la revocación</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	
	<h2><strong>Datos de la revocación</strong></h2>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button id="btnNuevaRevoc" type="button" onclick="btnNuevaRevoc_click()" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo</button>
		&nbsp;&nbsp;&nbsp;
		<button id="btnEditarRevoc" type="button" onclick="btnEditarRevoc_click(${revocacionInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
		<button id="btnEliminarRevoc" type="button" onclick="btnEliminarRevoc_click(${revocacionInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
		
	</fieldset>
	
	<fieldset>
		<legend>Revocación</legend>
		
		<fieldset>
			<legend><i>Datos del representante legal</i></legend>
			<div id="divRepLegalNom" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.representanteLegalNombre.label" default="Nombre" />
				</label>
	            <div class="col-md-9 col-sm-9">
	            	<p class="form-control-static">${revocacionInstance?.representanteLegalNombre}</p>
	            </div>
			</div>

			<div id="divAp1" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="revocacion.representanteLegalApellido1.label" default="Primer apellido" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${revocacionInstance?.representanteLegalApellido1}</p>
				</div>
			</div>
			
			<div id="divAp2" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="revocacion.representanteLegalApellido2.label" default="Segundo apellido" />					
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${revocacionInstance?.representanteLegalApellido2}</p>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><i>Datos de la institución o grupo financiero</i></legend>
			
			<div id="divAdmGrupoFinanciero" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.groupoFinanciero.label" default="Grupo financiero" />
				</label>
				
	            <div class="col-md-9 col-sm-9">						
					<p class="form-control-static">${revocacionInstance?.nombreGrupoFinanciero}</p>
	            </div>
			</div>
			
			<div id="divAdmInstitucion" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.institucion.label" default="Institución" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${revocacionInstance?.nombreInstitucion}</p>
				</div>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend><i>Datos de la revocación</i></legend>
			
			<div id="divPdrNumEscrit" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.numeroEscritura.label" default="Numero de escritura" />
				</label>
				
	            <div class="col-md-9 col-sm-9">						
					<p class="form-control-static">${revocacionInstance?.numeroEscritura}</p>
	            </div>
			</div>
			
			<div id="divFhApod" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.fechaApoderamiento.label" default="Fecha de revocación" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${revocacionInstance?.fechaRevocacion}</p>
				</div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><i>Datos del notario</i></legend>
			<div id="divNumNotario" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.notario.numero.label" default="Número" />
				</label>
				
	            <div class="col-md-9 col-sm-9">						
					<p class="form-control-static">${revocacionInstance?.notario?.numeroNotario}</p>
	            </div>
			</div>
			<div id="divNotarioEntidadFederativa" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.notario.entidadFederativa.label" default="Entidad Federativa"  />
				</label>
				
	            <div class="col-md-9 col-sm-9">						
					<p class="form-control-static">${revocacionInstance?.notario?.nombreEntidadFederativa}</p>
	            </div>
			</div>
			<div id="divNombreCompleto" class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
	            	<g:message code="revocacion.notario.nombreCompletro.label" default="Nombre" />
				</label>
				
	            <div class="col-md-9 col-sm-9">						
					<p class="form-control-static">${revocacionInstance?.notario?.nombre + ' ' + revocacionInstance?.notario?.apellido1 + ' ' + revocacionInstance?.notario?.apellido2}</p>
	            </div>
			</div>
		</fieldset>
		
		<fieldset>
			<legend><i>Datos de apoderados</i></legend>
			
			<table class="table">
				<thead>
					<tr>
						<th style='width:8%;'>Matrícula</th>
						<th>Nombre completo</th>
						<th style='width:32%'>Motivo</th>
						<th>Fecha de baja</th>
					</tr>
				</thead>
				<tbody id="tbdyApoderados">
					<g:each in="${revocacionInstance?.revocados}">
						<tr>
							<td>${it.numeroMatricula}</td>
							<td>${it.nombreCompleto}</td>
							<td>${it.motivo}</td>
							<td>${it.fechaBaja}</td>
						</tr>
					</g:each>			
				</tbody>
			</table>
			
		</fieldset>
		
		<fieldset>
			<legend><i>Documentos de respaldo</i></legend>
			<table class="table">
				<thead>
					<tr>
						<th style='width:32%;'>Tipo de documento</th>
						<th>Nombre de archivo</th>
						<th style='width:18%'>...</th>
					</tr>
				</thead>
				
				<tbody id="tbdyDocs">
					<g:each in="${revocacionInstance?.documentosRespaldoRevocacion}">
						<tr>
							<td>${it.tipoDocumentoRespaldoRevocacion?.descripcion}</td>
							<td>${it.nombreDeArchivo}</td>
							<td>
								<button type="button" onclick="btnDescargar_click('${it.uuidDocumentoRepositorio}')" class="download btn btn-info btn-xs">Descargar</button>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</fieldset>
	</fieldset>
	
	<!-- INCIA: SCRIPTS ESPECIFICOS DE VISTA -->
	<script>
	function btnNuevaRevoc_click(){
		window.location.href = "<g:createLink controller="revocacion" action="create" />";
	}
	function btnEditarRevoc_click(id){
		window.location.href = "<g:createLink controller="revocacion" action="edit" />/"+id;
	}
	function btnEliminarRevoc_click(id){
		var url = '<g:createLink controller="revocacion" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	function btnDescargar_click(uuid){
		window.open("<g:createLink controller="documento" action="download" />/"+uuid);
	}
	</script>
	<!-- FIN: SCRIPTS ESPECIFICOS DE VISTA -->
	
</body>
</html>