<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Revocacion" %>

			<div id="divMsgErrorEnCampos" class="alert alert-danger">
				<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
			</div>
			<div id="divMsgErrorServidor" class="alert alert-danger">
				Mensajes de error de servidor.
			</div>
			
			<fieldset>
				<legend>Datos del oficio</legend>
				<div id="divClaveDga" class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
		            	<g:message code="oficioCNBV.claveDga.label" default="Clave DGA" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-4 col-sm-4">
		            	<g:textField id="txtClaveDga" maxlength="16" class="form-control" name="oficioCNBV.claveDga" required="" value="${oficioCNBVInstance?.claveDga}" />
		            </div>
				</div>
				<div id="divFechaFinVigencia" class="form-group">
					<label class="col-md-3 col-sm-4 control-label">
		            	<g:message code="oficioCNBV.fechaFinVigencia.label" default="Fecha de fin de vigencia" /><span class="required-indicator">*</span>
					</label>
					<div class="col-md-4 col-sm-8">
						<g:datePicker name="oficioCNBV.fechaFinVigencia" precision="day" default="none" noSelection="${['null':'-Seleccione-']}" precision="day" value="${oficioCNBVInstance?.fechaFinVigencia}" relativeYears="${-30..30}" />
					</div>
				</div>
			</fieldset>
			
			<fieldset>
				<legend>Datos de autorizados</legend>
				
				<div id="divAutorizados">

					<div id="divMsgMatriculaYaEnLista" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>ya agregada</strong>.
					</div>
					<div id="divMsgMatriculaNoEncontrada" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>no encontrada</strong>.
					</div>
					<div id="divMsgErrorSolicitud" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Error al procesar la solicitud</strong>.
					</div>
					<div id="divMsgProcesandoAutorizado" class="alert alert-info">
						<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
					</div>
					
					
					<div id="divMsgAlMenosUnAutorizado" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Se requiere ingresar <strong>al menos un autorizado</strong>.
					</div>

					<table class="table">
						<thead>
							<tr>
								<th style='width:20%;'>Matrícula</th>
								<th>Nombre completo</th>
								<th style='width:8%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyAutorizados">
							
						</tbody>
					</table>
					
				</div>
				
				<input type="hidden" id="hdnAutorizadosWidgetLoadedCount" value="${oficioCNBVInstance?.autorizadosCNBV?.size()}"/>
				<input type="hidden" id="hdnAutorizadosWidgetCount" />
			</fieldset>
			
			
			<div class="form-group" style="text-align:center">
				<div>
					<button id="btnSubmit" type="button" class="btn btn-primary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Aceptar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
				</div>
			</div>