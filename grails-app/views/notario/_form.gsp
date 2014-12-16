<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="mx.amib.sistemas.registro.notario.model.Notario" %>

<div id="divMsgErrorEnCampos" class="alert alert-danger">
	<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
</div>
<div id="divMsgErrorServidor" class="alert alert-danger">
	Mensajes de error de servidor.
</div>

<fieldset>
<legend>Datos de personales</legend>

<div id="divNom" class="form-group">
	<label class="col-md-2 col-sm-3 control-label">
          	<g:message code="notario.nombre.label" default="Nombre" /><span class="required-indicator">*</span>
	</label>
          <div class="col-md-9 col-sm-9">
          	<g:textField id="txtNom" maxlength="100" class="form-control" name="notario.nombre" required="" value="${notarioInstance?.nombre}" />
          </div>
</div>
<div id="divAp1" class="form-group">
	<label class="col-md-2 col-sm-3 control-label">
		<g:message code="notario.apellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
	</label>
	<div class="col-md-9 col-sm-9">
		<g:textField id="txtAp1" maxlength="80" class="form-control" name="notario.apellido1" required="" value="${notarioInstance?.apellido1}" />
	</div>
</div>
<div id="divAp2" class="form-group">
	<label class="col-md-2 col-sm-3 control-label">
		<g:message code="notario.apellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
	</label>
	<div class="col-md-9 col-sm-9">
		<g:textField id="txtAp2" maxlength="80" class="form-control" name="notario.apellido2" required="" value="${notarioInstance?.apellido2}" />
	</div>
</div>

</fieldset>

<fieldset>
<legend>Datos de identificación</legend>

<div id="divNotario" class="form-group">
	<div id="divNumNotario">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="notario.numeroNotario.label" default="Número de notaría" /><span class="required-indicator">*</span>
		</label>
		<div class="col-md-2 col-sm-2">
			<g:textField id="txtNumNotario" maxlength="10" class="form-control" name="notario.numeroNotario" required="" value="${notarioInstance?.numeroNotario}" />
		</div>
	</div>
	<div id="divNotarioEntidadFederativa">
		<label class="col-md-3 col-sm-3 control-label">
			<g:message code="notario.entidadFederativa.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
		</label>
		<div class="col-md-4 col-sm-4">
			<g:select id="selNotarioEntidadFederativa" class="form-control" name='notario.idEntidadFederativa' value="${notarioInstance?.idEntidadFederativa}"
				noSelection="${['null':'-Seleccione-']}"
				from='${viewModelInstance?.entidadesFederativasList}'
				optionKey="id" optionValue="nombre"></g:select>
		</div>
	</div>
</div>

</fieldset>

<fieldset>
<legend>Vigencia actual</legend>

<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> <g:message code="notario.informacionVigencia" default="" /></div>

<div id="divVigencia" class="form-group">
	<label class="col-md-2 col-sm-3 control-label">
		<g:message code="notario.vigente.label" default="Estatus de vigencia" /><span class="required-indicator">*</span>						
	</label>
	<div class="col-md-9 col-sm-9">
		<g:checkBox name="notario.vigente" value="${notarioInstance?.vigente}" /> Vigente
	</div>
</div>

</fieldset>


<div class="form-group" style="text-align:center">
	<div>
		<button id="btnSubmit" type="button" class="btn btn-primary btn-lg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Aceptar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	</div>
</div>