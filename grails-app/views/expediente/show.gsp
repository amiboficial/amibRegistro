<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Vista de expediente</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expediente" action="index" />">Expedientes</a></li>
		<li><a href="#">Vista de Expediente</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Datos de expediente</strong></h2>
	<h4>Juan Perez López (Matricula: 1, Folio:1)</h4>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button id="btnEditar" type="button" onclick="btnEditar_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar datos personales</button>
		<button id="btnEditar" type="button" onclick="btnEditar_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Gestión de documentación</button>
		<button id="btnEliminar" type="button" onclick="btnEliminar_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
		<!-- 
		<button id="btnRevalidarPuntos" type="button" onclick="btnRevalidarPuntos_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Revalidar por puntos</button>
		<button id="btnRevalidarExp" type="button" onclick="btnRevalidarExp_click(${expedienteInstance?.id})" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Revalidar por experiencia</button>
		 -->
	</fieldset>
	
	<fieldset class="form-horizontal">
		<legend>Expediente</legend>
		
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#divDatosPersonales" aria-controls="divDatosPersonales" role="tab" data-toggle="tab">Datos personales</a></li>
		  <li role="presentation"><a href="#divDocumentacion" aria-controls="divDocumentacion" role="tab" data-toggle="tab">Documentación</a></li>
		  <li role="presentation"><a href="#divCertifaciones" aria-controls="divCertifaciones" role="tab" data-toggle="tab">Certificaciones</a></li>
		  <li role="presentation"><a href="#divPoderVigente" aria-controls="divPoderVigente" role="tab" data-toggle="tab">Poder vigente</a></li>
		  <li role="presentation"><a href="#divHistPoder" aria-controls="divHistPoder" role="tab" data-toggle="tab">Histórico de apoderamientos</a></li>
		  <li role="presentation"><a href="#divHistRevoc" aria-controls="divHistRevoc" role="tab" data-toggle="tab">Histórico de revocaciones</a></li>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="divDatosPersonales">
				<br/>
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Género" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="CURP" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Fecha de nacimiento" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">Lorem Ipsum&nbsp;</p>
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Dolor sit amet&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Nacionalidad" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">Notaris pubrota&nbsp;</p>
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Nivel de estudios" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="C.P." />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Entidad Federativa" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Delegación o Municipio" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Asentamiento (Colonia)" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Calle y Número" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">&nbsp;</p>
					</div>
				</div>
				
			</div>
			
			<!-- INICIA: SECCION DE DOCUMENTACIÓN -->
			<div role="tabpanel" class="tab-pane" id="divDocumentacion">
			
				<table class="table">
					<thead>
						<tr>
							<th style='width:32%;'>Tipo</th>
							<th>Nombre</th>
							<th>Vigente</th>
							<th>Fecha de carga</th>
							<th style='width:18%'>...</th>
						</tr>
					</thead>
					
					<tbody id="tbdyDocs">
						<tr>
							<td>Ejemplo 1</td>
							<td>Ejemplo 1</td>
							<td>Sí</td>
							<td>17/06/1990</td>
							<td>
								<button type="button" onclick="btnDescargar_click()" class="download btn btn-info btn-xs">Descargar</button>
							</td>
						</tr>
						<tr>
							<td>Ejemplo 2</td>
							<td>Ejemplo 2</td>
							<td>Sí</td>
							<td>17/06/1990</td>
							<td>
								<button type="button" onclick="btnDescargar_click()" class="download btn btn-info btn-xs">Descargar</button>
							</td>
						</tr>
						<tr>
							<td>Ejemplo 3</td>
							<td>Ejemplo 3</td>
							<td>Sí</td>
							<td>17/06/1990</td>
							<td>
								<button type="button" onclick="btnDescargar_click()" class="download btn btn-info btn-xs">Descargar</button>
							</td>
						</tr>
						<g:each in="${expedienteInstance?.documentos}">
							<tr>
								<td>Ejemplo 1</td>
								<td>Ejemplo 1</td>
								<td>Ejemplo 1</td>
								<td>Ejemplo 1</td>
								<td>
									<button type="button" onclick="btnDescargar_click('${it.uuid}')" class="download btn btn-info btn-xs">Descargar</button>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			
			</div>
			<!-- FIN: SECCION DE DOCUMENTACIÓN -->
			
			<div role="tabpanel" class="tab-pane" id="divCertifaciones">
				<br/>
				<div class="list-group">
					<div class="list-group-item">
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Figura</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Tipo de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de certificación</label>
							<div class="col-sm-4"><p class="form-control-static">Certificado&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Autorizado con poderes&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="row">
							<div style="text-align:center; margin-top: 0.75em;">
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Emitir dictamen</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por puntos</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por experiencia</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Autorizar</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar certificación</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar autorización</button>
								<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
								<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
							</div>
						</div>
					</div>
					<div class="list-group-item">
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Figura</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Tipo de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de certificación</label>
							<div class="col-sm-4"><p class="form-control-static">Certificado&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Autorizado con poderes&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="row">
							<div style="text-align:center; margin-top: 0.75em;">
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Emitir dictamen</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por puntos</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por experiencia</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Autorizar</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar certificación</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar autorización</button>
								<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
								<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
							</div>
						</div>
					</div>
					<div class="list-group-item">
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Figura</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Tipo de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Operador de Bolsa&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de certificación</label>
							<div class="col-sm-4"><p class="form-control-static">Certificado&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Estatus de autorización</label>
							<div class="col-sm-4"><p class="form-control-static">Autorizado con poderes&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="figuraRow row">
							<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
							<div class="col-sm-4"><p class="form-control-static">17/06/1990&nbsp;</p></div>
						</div>
						<div class="row">
							<div style="text-align:center; margin-top: 0.75em;">
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Emitir dictamen</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por puntos</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revalidar por experiencia</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Autorizar</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar certificación</button>
								<button type="button" class="edit btn btn-info"><span class="glyphicon glyphicon-pencil"></span> Revocar autorización</button>
								<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
								<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divPoderVigente">
				<br/>
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
			
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divHistPoder">
			<br/>(PENDIENTE)
			</div>
			<div role="tabpanel" class="tab-pane" id="divHistRevoc">
			<br/>(PENDIENTE)
			</div>
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
</body>
</html>