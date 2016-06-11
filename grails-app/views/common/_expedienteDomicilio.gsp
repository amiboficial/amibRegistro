<%@ page contentType="text/html;charset=UTF-8" %>
    <script type="text/template" id="expedienteDomicilio">

        <div class="alert alert-danger validationErrorMessage">
            Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
            <div class="errorMessagesContainer">
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.codigoPostal.label" default="Código Postal" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="cp cpchange form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.entidadFederativa.label" default="Entidad Federativa" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="ef form-control"  disabled/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.municipio.label" default="Municipio" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="mun form-control"  disabled/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.asentamiento.label" default="Asentamiento" />
            </label>
            <div class="col-md-9 col-sm-9">
                <select class="form-control asen">
                    <option value="-1">-Seleccione-</option>
                </select>
            </div>
        </div>
		<div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                &nbsp;
            </label>
            <div class="col-md-9 col-sm-9">
                <label>(Solo si el asentamiento no coincide con los proporcionados por Sepomex seleccione el primer asentamiento e ingrese el texto correcto en el siguiente campo )</label>
            </div>
        </div>
		<div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.asentamieto.otro" default="Otro Asentamiento" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="form-control otherAscen" maxlength="255"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.calle.label" default="Calle" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="form-control calle" maxlength="255"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.numeroExterior.label" default="Número exterior" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="form-control numExt" maxlength="64"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 col-sm-3 control-label">
                <g:message code="expediente.numeroInterior.label" default="Número interior" />
            </label>
            <div class="col-md-9 col-sm-9">
                <input type="text" class="form-control numInt" maxlength="64"/>
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="col-md-3 col-sm-3">
                &nbsp;
            </div>
            <div class="col-md-3 col-sm-3">
                <button type="button" class="btn btn-primary btn-block submit">Validar y confirmar datos de domicilio</button>
            </div>
            <div class="col-md-3 col-sm-3">
                <button type="button" class="btn btn-primary btn-block edit">Editar datos de domicilio</button>
            </div>
            <div class="col-md-3 col-sm-3">
                &nbsp;
            </div>
        </div>
    </script>