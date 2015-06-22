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
		<li><a href="#">Vista de expediente</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Datos de expediente</strong></h2>
	<h4>${raw(viewModelInstance?.nombreCompleto)} (Matricula: ${viewModelInstance?.sustentanteInstance?.numeroMatricula}, Folio: ${viewModelInstance?.sustentanteInstance?.id})</h4>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="edit" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="editar btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar datos personales</button>
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="editDoc" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="editarDoc btn btn-default btn-primary"><span class="glyphicon glyphicon-pencil"></span> Gestión de documentación</button>
		<button type="button" data-id="${viewModelInstance?.sustentanteInstance?.id}" data-url="<g:createLink controller="expediente" action="remove" id="${viewModelInstance?.sustentanteInstance?.id}"/>" class="eliminar btn btn-default btn-primary"><span class="glyphicon glyphicon-trash"></span> Eliminar</button>
		
	</fieldset>
	
	<fieldset class="form-horizontal">
		<legend>Expediente</legend>
		
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#tabDatosPersonales" aria-controls="tabDatosPersonales" role="tab" data-toggle="tab">Datos personales</a></li>
		  <li role="presentation"><a href="#tabDocumentacion" aria-controls="tabDocumentacion" role="tab" data-toggle="tab">Documentación</a></li>
		  <li role="presentation"><a href="#tabCertifaciones" aria-controls="tabCertifaciones" role="tab" data-toggle="tab">Certificaciones</a></li>
		  <li role="presentation"><a href="#tabPoderVigente" aria-controls="tabPoderVigente" role="tab" data-toggle="tab">Poder vigente</a></li>
		  <li role="presentation"><a href="#tabHistPoder" aria-controls="tabHistPoder" role="tab" data-toggle="tab">Histórico de apoderamientos</a></li>
		  <li role="presentation"><a href="#tabHistRevoc" aria-controls="tabHistRevoc" role="tab" data-toggle="tab">Histórico de revocaciones</a></li>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tabDatosPersonales">
				<br/>
				
				<legend><i>Información personal</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.nombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nombre}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.primerApellido.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.primerApellido}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.segundoApellido.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.segundoApellido}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.genero.label" default="Género" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.genero}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.rfc.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.rfc}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.curp.label" default="CURP" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.curp}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="sustentante.fechaNacimiento.label" default="Fecha de nacimiento" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.fechaNacimiento}&nbsp;</p>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.nacionalidad.label" default="Nacionalidad" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nacionalidad?.descripcion}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.nivelEstudios.label" default="Nivel de estudios" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.nivelEstudios?.descripcion}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.calidadMigratoria.label" default="Calidad Migratoria" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.calidadMigratoria?.descripcion}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.profesion.label" default="Profesion" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.profesion?.descripcion}&nbsp;</p>
					</div>
				</div>
				
				<legend><i>Domicilio</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.codigoPostal.label" default="C.P." />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.codigoPostal}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.entidadFederativa.label" default="Entidad Federativa" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.municipio?.entidadFederativa?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.municipio.label" default="Delegación o Municipio" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.municipio?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.asentamiento.label" default="Asentamiento (Colonia)" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sepomexData?.asentamiento?.nombre}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.calle.label" default="Calle" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.calle}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.numeroExterior.label" default="Numero Exterior" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroExterior}&nbsp;</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.numeroInterior.label" default="Numero Interior" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.numeroInterior}&nbsp;</p>
					</div>
				</div>
				
				<legend><i>Contacto</i></legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.correoElectronico.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.correoElectronico}&nbsp;</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="sustentante.telefonos.label" default="Teléfono(s)" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">
							<g:each in="${viewModelInstance?.sustentanteInstance?.telefonos.sort{it?.tipoTelefonoSustentante}}">
								${it?.lada}&nbsp;${it?.telefono}&nbsp;
								<g:if test="${it.extension != null && it.extension.trim() != ''}">
									Ext. ${it?.extension}&nbsp;
								</g:if>
								(${it?.tipoTelefonoSustentante?.descripcion})
								<br/>
							</g:each>
						</p>
					</div>
				</div>
				
			</div>
			
			<!-- INICIA: SECCION DE DOCUMENTACIÓN -->
			<div role="tabpanel" class="tab-pane" id="tabDocumentacion">
			
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
			
			<div role="tabpanel" class="tab-pane" id="tabCertifaciones">
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
			
			<div role="tabpanel" class="tab-pane" id="tabPoderVigente">
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
			
			<div role="tabpanel" class="tab-pane" id="tabHistPoder">
			<br/>(PENDIENTE)
			</div>
			<div role="tabpanel" class="tab-pane" id="tabHistRevoc">
			<br/>(PENDIENTE)
			</div>
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<script>
	
	$(".editar").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	$(".editarDoc").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	$(".eliminar").click(function(e){
		e.preventDefault();
		var id = $(this).attr("data-id");
		var url = $(this).attr("data-url");
		window.location.href = url;
	});
	
	</script>
	
</body>
</html>