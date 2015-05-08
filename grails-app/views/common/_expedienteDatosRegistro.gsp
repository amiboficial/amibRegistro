<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="expedienteDatosRegistro">
	<div class="alert alert-danger validationErrorMessage" style="display: none;">
		Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
		<div class="errorMessagesContainer">
		</div>
	</div>

				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.figura.label" default="Figura a la que aplicó" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control figura" disabled="" value="${varianteFiguraInstance.nombre}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.fechaCertificacion.label" default="Fecha de certificación" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control fechaCertificacion"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.autorizacionSolicitada.label" default="Autorización solicitada" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control autorizacionSolicitada" disabled="" value="${varianteFiguraInstance.figura.tipoAutorizacion}"/>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.intermediario.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control intermediario"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.fechaLabora.label" default="Fecha a partir de la cual labora" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control fechaLabora"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.puestoActual.label" default="Puesto actual" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control puestoActual"/>
		            </div>
				</div>
				
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block">Validar y confirmar datos de registro</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block">Editar datos de registro</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
</script>