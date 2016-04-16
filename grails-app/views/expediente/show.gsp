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
	
	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
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
						<g:if test="${viewModelInstance?.sustentanteInstance?.segundoApellido != null}" >
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.segundoApellido}&nbsp;</p>
						</g:if>
						<g:else>
							<p class="form-control-static">&nbsp;</p>
						</g:else>
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
		            	<p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${viewModelInstance?.sustentanteInstance?.fechaNacimiento}"/>&nbsp;</p>
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
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.calidadMigratoria != null && viewModelInstance?.sustentanteInstance?.calidadMigratoria?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.calidadMigratoria.label" default="Calidad Migratoria" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.calidadMigratoria?.descripcion}&nbsp;</p>
						</div>
					</div>
				</g:if>
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.calidadMigratoria != null && viewModelInstance?.sustentanteInstance?.calidadMigratoria?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.profesion.label" default="Profesión" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">${viewModelInstance?.sustentanteInstance?.profesion?.descripcion}&nbsp;</p>
						</div>
					</div>
				</g:if>
				
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
				
				<g:if test="${viewModelInstance?.sustentanteInstance?.numeroInterior != null && viewModelInstance?.sustentanteInstance?.numeroInterior?.trim()?.compareToIgnoreCase('null') != 0}" >
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="sustentante.numeroInterior.label" default="Numero Interior" />					
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">&nbsp;</p>
						</div>
					</div>
				</g:if>
				
				
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
								<g:if test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('CASA') == 0}">
									<span class="glyphicon glyphicon-home"></span>
								</g:if>
								<g:elseif test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('TRABAJO') == 0}">
									<span class="glyphicon glyphicon-briefcase"></span>
								</g:elseif>
								<g:elseif test="${it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('MÓVIL') == 0 || it?.tipoTelefonoSustentante?.descripcion?.trim()?.compareToIgnoreCase('MOVIL') == 0}">
									<span class="glyphicon glyphicon-phone"></span>
								</g:elseif>
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
			
				<div id="divDocumentosSustentante">
				</div>
			
			</div>
			<!-- FIN: SECCION DE DOCUMENTACIÓN -->
			
			<div role="tabpanel" class="tab-pane" id="tabCertifaciones">
				<br/>
				<div class="list-group">
				
					<g:each var="x" in="${viewModelInstance?.sustentanteInstance?.certificaciones}">
						<div class="list-group-item">
						
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Figura</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.varianteFigura?.nombre}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Tipo de autorización</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.varianteFigura?.tipoAutorizacionFigura}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Estatus de  autorización </label>
								<div class="col-sm-4"><p class="form-control-static">${x?.statusAutorizacion?.descripcion}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Estatus de certificación</label>
								<div class="col-sm-4"><p class="form-control-static">${x?.statusCertificacion?.descripcion}&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de obtención</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaObtencion}"/>&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de inicio de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaInicio}"/>&nbsp;</p></div>
							</div>
							<div class="figuraRow row">
								<label class="col-sm-3 control-label">Fecha de fin de vigencia</label>
								<div class="col-sm-4"><p class="form-control-static"><g:formatDate format="dd-MM-yyyy" date="${x?.fechaFin}"/>&nbsp;</p></div>
							</div>
							<div class="row">
								<div style="text-align:center; margin-top: 0.75em;">
									<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
									<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
								</div>
							</div>
							
						</div>
					</g:each>
				
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabPoderVigente">
				<br/>
				<g:if test="${viewModelInstance?.poderInstance != null}">
				
					<fieldset>
						<legend><i>Datos del representante legal</i></legend>
						
						<div id="divRepLegalNom" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" />
							</label>
				            <div class="col-md-9 col-sm-9">
				            	<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalNombre}</p>
				            </div>
						</div>
		
						<div id="divAp1" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalApellido1}</p>
							</div>
						</div>
						
						<div id="divAp2" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
								<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" />					
							</label>
							<div class="col-md-9 col-sm-9">
								<g:if test="${viewModelInstance.poderInstance.representanteLegalApellido2.toString().compareToIgnoreCase('null') != 0}" >
									<p class="form-control-static">${viewModelInstance?.poderInstance?.representanteLegalApellido2}</p>
								</g:if>
								<g:else>
									<p class="form-control-static">&nbsp;</p>
								</g:else>
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
								<p class="form-control-static">${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).grupoFinanciero?.nombre}</p>
				            </div>
						</div>
						
						<div id="divAdmInstitucion" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.institucion.label" default="Institución" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.institucionesPoderesMap?.get( viewModelInstance?.poderInstance?.idInstitucion ).nombre}</p>
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
								<p class="form-control-static">${viewModelInstance?.poderInstance?.numeroEscritura}</p>
				            </div>
						</div>
						
						<div id="divFhApod" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" />
							</label>
							<div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.poderInstance?.fechaApoderamiento}</p>
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
								<p class="form-control-static">${viewModelInstance?.notarioPoder?.numeroNotaria}</p>
				            </div>
						</div>
						
						<div id="divNotarioEntidadFederativa" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa"  />
							</label>
							
				            <div class="col-md-9 col-sm-9">						
								<p class="form-control-static">${viewModelInstance?.entidadFederativaNotarioPoder?.nombre}</p>
				            </div>
						</div>
						
						<div id="divNombreCompleto" class="form-group">
							<label class="col-md-2 col-sm-3 control-label">
				            	<g:message code="poder.notario.nombreCompletro.label" default="Nombre" />
							</label>
							
				            <div class="col-md-9 col-sm-9">
								<p class="form-control-static">${viewModelInstance?.notarioPoder?.nombreCompleto}</p>
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
									<tr>
										<td>Documento de respaldo poder</td>
										<td>${viewModelInstance?.documentoPoderRespaldo?.nombre}</td>
										<td>
											<button type="button" data-uuid="${viewModelInstance?.poderInstance?.uuidDocumentoRespaldo}" class="download btn btn-info btn-xs">Descargar</button>
										</td>
									</tr>
							</tbody>
						</table>
						
					</fieldset>
				
				</g:if>
				<g:else>
					<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> No hay datos respecto a algún apoderamiento vigente</div>
				</g:else>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="tabHistPoder">
				<br/>	
				<div id="divHistoricoPoderSustentante"></div>			
			</div>
			<div role="tabpanel" class="tab-pane" id="tabHistRevoc">
				<br/>
				<div id="divHistoricoRevocacionSustentante"></div>
			</div>
		</div>
		
	</fieldset>
	
	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>
	
	<g:render template="showDocumentos"/>
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.documentos.js" />
	<script>

	var app = app || {};

	var documentosView;
	var docsArray = new Array();
	var downloadUrl;

	<g:each status="i" var="x" in="${viewModelInstance?.sustentanteInstance?.documentos}">
		docsArray.push({
			grailsId: ${i+1},
			uuid: '${x?.uuid}',
			vigente:  ${x?.vigente},
			nombre: "${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.nombre}",
			dsTipo: " ${x?.tipoDocumentoSustentate?.descripcion}",
			manejaVigenciaTipoDocumento: true,
			fechaCarga: '<g:formatDate format="dd-MM-yyyy" date="${viewModelInstance?.documentosRespositorioUuidMap?.get(x?.uuid)?.fechaCreacion}"/> ',
			
			<g:if test="${i < 10}">
				visible: true
			</g:if>
		})
	</g:each>
	downloadUrl = '<g:createLink controller="documento" action="download" />';
	
	documentosView = new app.DocumentoSustentanteCollectionView({
		docsArray: docsArray,
		downloadUrl: downloadUrl
	});
	
	</script>
	
	<g:render template="showHistoricoApoderados" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.historicoApoderados.js" />
	<script>
	var app = app || {};

	var elementsArray = new Array();
	var poderUrl;
	var historioPoderView;
	
	<g:each var="x" in="${viewModelInstance?.historicoPoderes}">
		elementsArray.push({
			grailsId: ${x.id},
			numeroEscritura: ${x.numeroEscritura},
			nombreCompletoNotario: "${x.idNotario}",
			fechaApoderamiento: "<g:formatDate format="dd-MM-yyyy" date="${x.fechaApoderamiento}"/>",
			fechaApoderamientoUnixEpoch: ${x.fechaApoderamiento.getTime()/1000},
			grupoFinancieroNombre: "${x.idGrupoFinanciero}",
			institucionNombre: "${x.idInstitucion}",
			visible: true
		});
	</g:each>
	
	poderUrl = '<g:createLink controller="poder" action="show" />';
	historioPoderView = new app.HPoderVMCollectionView({elementsArray:elementsArray,poderUrl:poderUrl}); 
	
	</script>
	
	<g:render template="showHistoricoRevocados" />
	<g:javascript src="mx.amib.sistemas.registro.expediente.show.historicoRevocados.js" />
	<script>

	var app = app || {};

	var elementsArray = new Array();
	var revocacionUrl;
	var historioRevocacionesView;
	
	<g:each var="x" in="${viewModelInstance?.historioRevocaciones}">
		elementsArray.push({
			grailsId: ${x.id},
			numeroEscritura: ${x.numeroEscritura},
			nombreCompletoNotario: "${x.idNotario}",
			fechaRevocacion: "<g:formatDate format="dd-MM-yyyy" date="${x.fechaRevocacion}"/>",
			fechaRevocacionUnixEpoch: ${x.fechaRevocacion.getTime()/1000},
			grupoFinancieroNombre: "${x.idGrupoFinanciero}",
			institucionNombre: "${x.idInstitucion}",
			visible: true
		});
	</g:each>

	revocacionUrl = '<g:createLink controller="revocacion" action="show" />';
	historioRevocacionesView = new app.HRevocacionVMCollectionView({elementsArray:elementsArray, revocacionUrl:revocacionUrl}); 
	
	</script>
	
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