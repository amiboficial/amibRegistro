<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="apoderados">
	
	<div class="errorValidacion alert alert-danger">
		<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" ></span><br/>
		<ul class="validationErrorMsgs">
		</ul>
	</div>
	
	<fieldset>
		<legend>Búsqueda de apoderable</legend>
	
		<div class="procBusqueda alert alert-info">
			<asset:image src="spinner_alert_info.gif"/><strong>Procesando datos, espere un momento</strong>.
		</div>
		<div class="errorBusqueda alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span><span class="msgErrorBusqueda" ></span>
		</div>
	
		<div class="div-numeroMatriculaBuscar form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="apoderados.numeroMatriculaBuscar.label" default="Matrícula" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-2 col-sm-2">
				<input type="text" data-field="numeroMatriculaBuscar" maxlength="10" class="field numeroMatriculaBuscar form-control" name="apoderados.numeroMatriculaBuscar" value="{{ if(numeroMatricula>0){ }}{{=numeroMatricula}}{{ } }}" />
			</div>
		</div>
		
		<div class="div-nombreCompletoBuscar form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="apoderados.nombreCompletoBuscar.label" default="Nombre completo" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" data-field="nombreCompletoBuscar" maxlength="10" class="field nombreCompletoBuscar form-control" name="apoderados.nombreCompletoBuscar" value="{{=nombreCompleto}}" disabled/>
			</div>
		</div>
		
		<div class="div-nombreFiguraBuscar form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="apoderados.nombreFiguraBuscar.label" default="Figura" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" data-field="nombreFiguraBuscar" maxlength="10" class="field nombreFiguraBuscar form-control" name="apoderados.nombreFiguraBuscar" value="{{=nombreFigura}}" disabled/>
			</div>
		</div>
		
		<div class="div-nombreVarianteFiguraBuscar form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="apoderados.nombreVarianteFiguraBuscar.label" default="Variante" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" data-field="nombreVarianteFiguraBuscar" maxlength="10" class="field nombreVarianteFiguraBuscar form-control" name="apoderados.nombreVarianteFiguraBuscar" value="{{=nombreVarianteFigura}}" disabled/>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-6 col-sm-6">
				<button type="button" class="btn btn-primary btn-block add"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Agregar</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
		
	</fieldset>
	
	<fieldset>
		<legend>Listado de apoderados</legend>
		<div class="listaApoderados list-group">
			<!-- aqui se tiene que renderear los apoderados -->
		</div>
	</fieldset>
	
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar apoderados</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block edit">Editar apoderados</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
	
</script>

<script type="text/template" id="apoderado">

	<div class="div-numeroMatricula div-nombreCompleto row">
		<label class="col-sm-2 control-label">Matrícula</label>
		<div class="col-sm-2"><p>{{=numeroMatricula}}</p></div>
		<label class="col-sm-3 control-label">Nombre completo</label>
		<div class="col-sm-5"><p class="form-control-static">{{=nombreCompleto}}</p></div>
	</div>
	<div class="div-nombreFigura row">
		<label class="col-sm-2 control-label">Figura</label>
		<div class="col-sm-9"><p class="form-control-static">{{=nombreFigura}}</p></div>
	</div>
	<div class="div-nombreVarianteFigura row">
		<label class="col-sm-2 control-label">Variante de figura</label>
		<div class="col-sm-9"><p class="form-control-static">{{=nombreVarianteFigura}}</p></div>
	</div>
	<div class="row">
		<div class="col-sm-9">
			&nbsp;
		</div>
		<div class="col-sm-2">
			<button type="button" class="delete btn btn-default btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Quitar de la lista</button>
		</div>
	</div>
	<div class="row">
		&nbsp;
	</div>
	
</script>