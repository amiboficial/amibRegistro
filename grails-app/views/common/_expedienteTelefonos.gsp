<%@ page contentType="text/html;charset=UTF-8" %>
	<script type="text/template" id="expedienteTelefonos">
		<div class="alert alert-danger validationErrorMessage" style="display: none;">
			Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
			<div class="errorMessagesContainer">
			</div>
		</div>

		<div class="form-group">

			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="expediente.telefonos.label" default="Telefonos" />
			</label>
			<div class="col-md-9 col-sm-9">
				<table class="table">
					<tr>
						<th>Clave</th>
						<th>Número</th>
						<th>Ext.</th>
						<th>Tipo</th>
						<th>...</th>
					</tr>
					<tr>
						<td style="width:20%"><input type="text" class="form-control lada" maxlength="16"/></td>
						<td><input type="text" class="form-control telefono"  maxlength="50"/></td>
						<td style="width:20%"><input type="text" class="form-control extension"  maxlength="6"/></td>
						<td style="width:20%">
							<select class="form-control tipo">
								<option value="-1">-Seleccione-</option>
								<g:each in="${viewModelInstance?.tipoTelefonoList}">
									<option value="${it.id}">${it.descripcion}</option>
								</g:each>
							</select>
						</td>
						<td><button type="button" class="add btn btn-success btn-sm">Agregar</button></td>
					</tr>
				</table>
			</div>
			<div class="form-group">
				<div class="col-md-3 col-sm-3">
					&nbsp;
				</div>
				<div class="col-md-3 col-sm-3">
					<button type="button" class="submit btn btn-primary btn-block">Validar y confirmar datos de telefonos</button>
				</div>
				<div class="col-md-3 col-sm-3">
					<button type="button" class="edit btn btn-primary btn-block">Editar datos de telefonos</button>
				</div>
				<div class="col-md-3 col-sm-3">
					&nbsp;
				</div>
			</div>
		</div>
	</script>

	<script type="text/template" id="expedienteTelefono">
		<td>{{=lada}}</td>
		<td>{{=telefono}}</td>
		<td>{{=extension}}</td>
		<td>{{=dsTipoTelefono}}</td>
		<td><button type="button" class="remove btn btn-success btn-sm">Quitar</button></td>
	</script>