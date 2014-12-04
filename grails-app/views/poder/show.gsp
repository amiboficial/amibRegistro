<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Datos del Poder</title>
	</head>
	<body>
		<a id="anchorForm"></a>
	
		<!-- INICIA: BREADCRUMB ADMIN -->
		<ul class="breadcrumb">
			<li><a href="#">Gestión</a><span class="divider"></span></li>
			<li><a href="<g:createLink controller="poder" action="index" />">Poderes</a></li>
			<li><a href="#">Datos del poder</a></li>
		</ul>
		<!-- FIN: BREADCRUMB ADMIN -->
		
		<h2><strong>Datos del poder</strong></h2>
		
		<fieldset>
			<legend>Acciones</legend>
			
			<button id="btnNuevoPoder" type="button" onclick="btnNuevoPoder_click()" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-file"></span> Nuevo</button>
			&nbsp;&nbsp;&nbsp;
			<button id="btnEditarPoder" type="button" onclick="btnEditarPoder_click(${poderInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
			<button id="btnEliminarPoder" type="button" onclick="btnEliminarPoder_click(${poderInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
			
		</fieldset>
		
		<fieldset>
			<legend>Poder</legend>
			
			<fieldset>
				<legend><i>Datos del representante legal</i></legend>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${poderInstance?.representanteLegalNombre}</p>
		            </div>
				</div>

				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${poderInstance?.representanteLegalApellido1}</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${poderInstance?.representanteLegalApellido2}</p>
					</div>
				</div>
				
			</fieldset>
			
			
			<fieldset>
				<legend><i>Datos de la institución o grupo financiero</i></legend>
				
				<div id="divAdmGrupoFinanciero" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
					</label>
					
		            <div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${poderInstance?.nombreGrupoFinanciero}</p>
		            </div>
				</div>
				
				<div id="divAdmInstitucion" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.institucion.label" default="Institución" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${poderInstance?.nombreInstitucion}</p>
					</div>
				</div>
				
			</fieldset>
			
			<fieldset>
				<legend><i>Datos del poder</i></legend>
				
				<div id="divPdrNumEscrit" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.numeroEscritura.label" default="Numero de escritura" />
					</label>
					
		            <div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${poderInstance?.numeroEscritura}</p>
		            </div>
				</div>
				
				<div id="divFhApod" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${poderInstance?.fechaApoderamiento}</p>
					</div>
				</div>
				
			</fieldset>
			
			<fieldset>
				<legend><i>Datos del notario</i></legend>
				
				<div id="divNumNotario" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.numero.label" default="Número" />
					</label>
					
		            <div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${poderInstance?.notario?.numeroNotario}</p>
		            </div>
				</div>
				
				<div id="divNotarioEntidadFederativa" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa"  />
					</label>
					
		            <div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${poderInstance?.notario?.nombreEntidadFederativa}</p>
		            </div>
				</div>
				
				<div id="divNombreCompleto" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.nombreCompletro.label" default="Nombre" />
					</label>
					
		            <div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${poderInstance?.notario?.nombre + ' ' + poderInstance?.notario?.apellido1 + ' ' + poderInstance?.notario?.apellido2}</p>
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
							<th style='width:16%'>DGA CNBV</th>
						</tr>
					</thead>
					<tbody id="tbdyApoderados">
						<g:each in="${poderInstance?.apoderados}">
							<tr>
								<td>${it.autorizado?.numeroMatricula}</td>
								<td>${it.autorizado?.nombreCompleto}</td>
								<td>${it.autorizado?.oficioCNBV?.claveDga}</td>
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
						<g:each in="${poderInstance?.documentosRespaldoPoder}">
							<tr>
								<td>${it.tipoDocumentoRespaldoPoder?.descripcion}</td>
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
	function btnNuevoPoder_click(){
		window.location.href = "<g:createLink controller="poder" action="create" />";
	}
	function btnEditarPoder_click(id){
		window.location.href = "<g:createLink controller="poder" action="edit" />/"+id;
	}
	function btnEliminarPoder_click(id){
		var url = '<g:createLink controller="poder" action="delete" />/'+id
		var r = confirm("¿Desea eliminar el elemento seleccionado?");
		if(r == true)
			window.location.href = url;
	}
	function btnDescargar_click(uuid){
		window.open("<g:createLink controller="poder" action="descargar" />?uuid="+uuid);
	}
	</script>
	<!-- FIN: SCRIPTS ESPECIFICOS DE VISTA -->
	
	</body>
</html>
