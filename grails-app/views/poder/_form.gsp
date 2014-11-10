<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>

			<div id="divMsgErrorEnCampos" class="alert alert-danger">
				<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
			</div>
			<div id="divMsgErrorServidor" class="alert alert-danger">
				Mensajes de error de servidor.
			</div>
			
			<fieldset>
				<legend>Datos del representante legal</legend>
				
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField id="txtRepLegalNom" maxlength="100" class="form-control" name="poder.representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>

				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAp1" maxlength="80" class="form-control" name="poder.representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAp2" maxlength="80" class="form-control" name="poder.representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
					</div>
				</div>
				
			</fieldset>
	
			<!-- INICIA: DATOS ENTIDAD FINANCIERA - ROL DE INSTITUCION O GRUPO FINANCIERO -->
			<fieldset>
				<legend>Datos de la institución o grupo financiero</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.nombreGrupoFinancieroOrInstituto.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control" required="" value="${entidadFinanciera?.nombre}" disabled="disabled"/>
		            </div>
				</div>
			</fieldset>
			<!-- FIN: DATOS ENTIDAD FINANCIERA - ROL DE INSTITUCION O GRUPO FINANCIERO -->
			
			<!-- INICIA: SELECCION ENTIDAD FINANCIERA - ROL DE ADMINISTRADOR -->
			<fieldset>
				<legend>Datos de la institución o grupo financiero</legend>
				
				<div id="divMsgProcesandoEntidadFinanciera" class="alert alert-info">
					<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
				</div>
				<div id="divMsgErrorEntidadFinanciera" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Ha habído un error al procesar la petición.
				</div>
				
				<div id="divAdmGrupoFinanciero" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
						<g:select class="form-control" id="selAdmIdGrupoFinanciero" name='poder.idGrupofinanciero' value="${poderInstance?.idGrupofinanciero}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${gruposFinancierosList}'
						optionKey="id" optionValue="nombre"></g:select>
		            </div>
				</div>
				
				<div id="divAdmInstitucion" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.institucion.label" default="Institución" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-9 col-sm-9">
						<select class="form-control" id="selAdmIdInstitucion" name="poder.idInstitucion" value="${poderInstance?.idInstitucion}">
							<option value="-1">-Seleccione-</option>
						</select>
					</div>
				</div>
			</fieldset>
			<!-- FIN: SELECCION ENTIDAD FINANCIERA - ROL DE ADMINISTRADOR -->
			
			<fieldset>
				<legend>Datos del poder</legend>
				
				<div class="form-group">
					<div id="divPdrNumEscrit">
						<label id="lblPdrNumEscrit" class="col-md-2 col-sm-3 control-label">
							<g:message code="poder.numeroEscritura.label" default="Numero de escritura" /><span class="required-indicator">*</span>
						</label>
						<div class="col-md-2 col-sm-2">
							<g:textField id="txtPdrNumEscrit" maxlength="10" class="has-error form-control" name="poder.numeroEscritura" required="" value="${poderInstance?.numeroEscritura}" />
						</div>
					</div>
					<div id="divFhApod">
						<label class="col-md-3 col-sm-3 control-label">
							<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" /><span class="required-indicator">*</span>						
						</label>
						<div class="col-md-4 col-sm-4">
							<g:datePicker name="poder.fechaApoderamiento" value="${poderInstance?.fechaApoderamiento}" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-10..0}"/>
						</div>
					</div>
				</div>
				
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del notario</legend>

					<div id="divMsgProcesandoNotario" class="alert alert-info">
						<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
					</div>
					<div id="divMsgErrorProcesandoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Ha habído un error al procesar la petición.
					</div>
					<div id="divMsgNoEncontradoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> No se encontraron datos de notario.
					</div>
					<div id="divMsgDatoNoValidoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos, introduzca únicamente números.
					</div>
				
				<div id="divNotario" class="form-group">
					<div id="divNumNotario">
						<label class="col-md-2 col-sm-3 control-label">
							<g:message code="poder.notario.numero.label" default="Número" /><span class="required-indicator">*</span>
						</label>
						<div class="col-md-2 col-sm-2">
							<g:textField id="txtNumNotario" maxlength="10" class="form-control" name="notarioNumero" required="" value="${poderInstance?.notario?.numeroNotario}" />
						</div>
					</div>
					<div id="divNotarioEntidadFederativa">
						<label class="col-md-3 col-sm-3 control-label">
							<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
						</label>
						<div class="col-md-4 col-sm-4">
							<g:select id="selNotarioEntidadFederativa" class="form-control" name='notarioIdEntidadFederativa' value="${poderInstance?.notario?.idEntidadFederativa}"
								noSelection="${['null':'-Seleccione-']}"
								from='${entidadFederativaList}'
								optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.nombreCompletro.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" id="txtNombreCompletoNotario" class="form-control" required="" disabled="disabled" value="${poderInstance?.notario?.nombre + ' ' + poderInstance?.notario?.apellido1 + ' ' + poderInstance?.notario?.apellido2}" />
		            </div>
				</div>
				
			</fieldset>
			
			<fieldset>
				<legend>Datos de apoderados</legend>
				
				<div id="divMsgMatriculaYaEnLista" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>ya agregada</strong>.
				</div>
				<div id="divMsgMatriculaNoEncontrada" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>no encontrada</strong>.
				</div>
				<div id="divMsgMatriculaSinDga" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula encontrada <strong>sin oficio DGA válido ó vigente</strong>.
				</div>
				<div id="divMsgProcesandoApoderado" class="alert alert-info">
					<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
				</div>
				
				<div id="divMsgAlMenosUnApoderado" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Se requiere ingresar <strong>al menos un apoderado</strong>.
				</div>
				
				<table class="table">
					<thead>
						<tr>
							<th style='width:8%;'>Matrícula</th>
							<th>Nombre completo</th>
							<th style='width:16%'>DGA CNBV</th>
							<th style='width:8%'>...</th>
						</tr>
					</thead>
					<tbody id="tbdyApoderados">
						<tr>
							<td><input id="txtNewMatricula" class="form-control" type="text" /></td>
							<td><input id="txtNewNombre" class="form-control" type="text" disabled/></td>
							<td>
								<select id="selNewDGA" class="form-control">
									<option value="-1"></option>
								</select>
							</td>
							<td><button id="btnAdd" class="add btn btn-success btn-sm" disabled><span class="glyphicon glyphicon-plus"></span> Agregar</button></td>
						</tr>
					</tbody>
				</table>

			</fieldset>
	
			<!-- INCIA: SECCION DE DOCUMENTOS -->
			<fieldset>
				<legend>Documentos de respaldo</legend>
				
				<div id="divMsgDocRequeridos" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Debes cargar <strong>TODOS</strong> los documentos solicitados.
				</div>
				
				<table class="table">
						<thead>
							<tr>
								<th style='width:32%;'>Tipo de documento</th>
								<th>Nombre de archivo</th>
								<th style='width:18%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyDocs">

						</tbody>
				</table>
				
				
			</fieldset>
			<!-- FIN: SECCION DE DOCUMENTOS -->
			
			<div class="form-group">
				<div class="col-lg-offset-5 col-md-offset-5 col-md-2 col-sm-2">
					<button id="btnSubmit" type="button" class="btn btn-primary btn-lg btn-block">Aceptar</button>
				</div>
			</div>
	
			<!-- INICIA: HIDDENS PARA DATOS ADICIONALES -->
			<!-- NOTA: Estos hiddens unicamente deben ser con fines de validación del lado del "cliente", 
			si se alteran, no deben, en ningún caso, comprometer la seguridad de aplicación (escalamiento de
			privilegios); es por eso que del lado del servidor se hace una segunda validación-->
			<input type="hidden" id="hdnCountApoderadosLoaded" value="${apoderadosList?.size()}"/>
			<input type="hidden" id="hdnCountApoderados" value="${apoderadosList?.size()}"/>
			<input type="hidden" id="hdnDocumentosCompletadosLoaded" value="${areDocumentosCompletados}" />
			<input type="hidden" id="hdnDocumentosCompletados" value="${areDocumentosCompletados}" />
			<input id="hdnIsAdmin" type="hidden" value="true" /> <!-- Para validacion de campos -->
			<!-- FIN: HIDDENS PARA DATOS ADICIONALES -->