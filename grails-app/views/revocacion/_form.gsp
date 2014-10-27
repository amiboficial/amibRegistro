<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Revocacion" %>

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
		            	<g:message code="revocacion.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField id="txtRepLegalNom" maxlength="100" class="form-control" name="revocacion.representanteLegalNombre" required="" value="${revocacionInstance?.representanteLegalNombre}" />
		            </div>
				</div>
				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAp1" maxlength="80" class="form-control" name="poder.representanteLegalApellido1" required="" value="${revocacionInstance?.representanteLegalApellido1}" />
					</div>
				</div>
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="revocacion.representanteLegalApellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtAp2" maxlength="80" class="form-control" name="revocacion.representanteLegalApellido2" required="" value="${revocacionInstance?.representanteLegalApellido2}" />
					</div>
				</div>
			</fieldset>
			
			<!-- INICIA: DATOS ENTIDAD FINANCIERA - ROL DE INSTITUCION O GRUPO FINANCIERO -->
			<fieldset>
				<legend>Datos de la institución o grupo financiero</legend>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.nombreGrupoFinancieroOrInstituto.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control" required="" value="${viewModelInstance?.entidadFinanciera?.nombre}" disabled="disabled"/>
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
		            	<g:message code="revocacion.groupoFinanciero.label" default="Grupo financiero" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
						<g:select class="form-control" id="selAdmIdGrupoFinanciero" name='revocacion.idGrupofinanciero' value="${revocacionInstance?.idGrupofinanciero}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.gruposFinancierosList}'
						optionKey="id" optionValue="nombre"></g:select>
		            </div>
				</div>
				
				<div id="divAdmInstitucion" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.institucion.label" default="Institución" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-9 col-sm-9">
						<select class="form-control" id="selAdmIdInstitucion" name="revocacion.idInstitucion" value="${revocacionInstance?.idInstitucion}">
							<option value="-1">-Seleccione-</option>
						</select>
					</div>
				</div>
			</fieldset>
			<!-- FIN: SELECCION ENTIDAD FINANCIERA - ROL DE ADMINISTRADOR -->
			
			<fieldset>
				<legend>Datos de la revocación</legend>
				<div class="form-group">
					<div id="divPdrNumEscrit">
						<label id="lblPdrNumEscrit" class="col-md-2 col-sm-3 control-label">
							<g:message code="revocacion.numeroEscritura.label" default="Numero de escritura" /><span class="required-indicator">*</span>
						</label>
						<div class="col-md-2 col-sm-2">
							<g:textField id="txtPdrNumEscrit" maxlength="10" class="has-error form-control" name="revocacion.numeroEscritura" required="" value="${revocacionInstance?.numeroEscritura}" />
						</div>
					</div>
					<div id="divFhApod">
						<label class="col-md-3 col-sm-3 control-label">
							<g:message code="revocacion.fechaApoderamiento.label" default="Fecha de revocación" /><span class="required-indicator">*</span>						
						</label>
						<div class="col-md-4 col-sm-4">
							<g:datePicker name="revocacion.fechaApoderamiento" value="${revocacionInstance?.fechaApoderamiento}" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-10..0}"/>
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
							<g:message code="revocacion.notario.numero.label" default="Número" /><span class="required-indicator">*</span>
						</label>
						<div class="col-md-2 col-sm-2">
							<g:textField id="txtNumNotario" maxlength="10" class="form-control" name="notarioNumero" required="" value="${revocacionInstance?.notario?.numeroNotario}" />
						</div>
					</div>
					<div id="divNotarioEntidadFederativa">
						<label class="col-md-3 col-sm-3 control-label">
							<g:message code="revocacion.notario.entidadFederativa.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
						</label>
						<div class="col-md-4 col-sm-4">
							<g:select id="selNotarioEntidadFederativa" class="form-control" name='notarioIdEntidadFederativa' value="${revocacionInstance?.notario?.idEntidadFederativa}"
								noSelection="${['null':'-Seleccione-']}"
								from='${viewModelInstance?.entidadFederativaList}'
								optionKey="id" optionValue="nombre"></g:select>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="revocacion.notario.nombreCompletro.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" id="txtNombreCompletoNotario" class="form-control" required="" disabled="disabled" value="${revocacionInstance?.notario?.nombre + ' ' + revocacionInstance?.notario?.apellido1 + ' ' + revocacionInstance?.notario?.apellido2}" />
		            </div>
				</div>
				
			</fieldset>
			
			<fieldset>
				<legend>Datos de revocados</legend>
				
				<div id="divMsgRevAlMenosUno" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Se requiere ingresar <strong>al menos un revocado</strong>.
				</div>
				<div id="divMsgRevEditando" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Debes confirmar cambios para continuar.
				</div>

				<div id="divLgRevocados" class="list-group">
					<div class="newElementAction list-group-item"><button type="button" class="add btn btn-success"> <a href=""></a><span class="glyphicon glyphicon-plus-sign"></span> Agregar nuevo elemento</button></div>
				</div>

			</fieldset>