<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="documentos">

	<fieldset>
		<legend>Carga de documentos</legend>


		<div class="errorValidacion alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" >error de validacion</span><br/>
			<ul class="validationErrorMsgs">
			</ul>
		</div>
		<div class="errorUpload alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorUpload" >error en upload</span><br/>
		</div>

		<div class="div-archivo form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="archivo.label" default="Archivo" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-2 col-sm-2">
				<input type="file" data-field="archivo" class="field archivo" name="archivo" id="ed333dd0286c11e5b345feff819cdc9f" />
			</div>
		</div>
		
		<div class="div-idTipoDocumento form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="idTipoDocumento.label" default="Tipo de documento" /><span class="required-indicator">*</span>
			</label>
			<div class="col-md-9 col-sm-9" >
				<select class="field idTipoDocumento form-control" data-field="idTipoDocumento">
					<option value="-1">-Seleccione-</option>
					<option value="1">Tipo AAA</option>
					<option value="2">Tipo BBB</option>
					<option value="3">Tipo CCC</option>
				</select>
			</div>
		</div>

		<div class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-6 col-sm-6" style="text-align: center">
				<button type="button" class="add btn btn-primary btn-block">Cargar archivo</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>

	</fieldset>

	<fieldset>
		<legend>Listado de archivos</legend>
		<div class="errorManejoVigencia alert alert-danger">
			<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorManejoVigencia" >error en manejo de vigencia</span><br/>
			<ul class="validationErrorMsgs">
			</ul>
		</div>
		
		<div class="listaDocumentos list-group"></div>
		
		<div class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-3 col-sm-3">
				<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar archivos</button>
			</div>
			<div class="col-md-3 col-sm-3">
				<button type="button" class="btn btn-primary btn-block edit">Editar archivos</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
		
	</fieldset>

</script>

<script type="text/template" id="documento">

	<div class="div-nombreArchivo row">
		<label class="col-sm-2 control-label">Nombre</label>
		<div class="col-sm-9"><p>{{=nombreArchivo}}</p></div>
	</div>
	<div class="div-tipoDocumento row">
		<label class="col-sm-2 control-label">Tipo</label>
		<div class="col-sm-9"><p>{{=idTipoDocumento}}</p></div>
	</div>
	<div class="div-fecha row">
		<label class="col-sm-2 control-label">Fecha</label>
		<div class="col-sm-9"><p>{{=fecha}}</p></div>
	</div>
	<div class="div-vigente row">
		<label class="col-sm-2 control-label">Vigente</label>
		<div class="col-sm-9"><p>{{=vigente}}</p></div>
	</div>
	<div class="row">
		<div class="col-sm-5">

			&nbsp;
			<div class="errorProcArc alert alert-danger">
				<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorProcArc">Error en procesamiento</span>
			</div>
			
			<div class="procArc alert alert-info">
				<asset:image src="spinner_alert_info.gif"/>&nbsp;<strong>Procesando...</strong>
			</div>

		</div>
		<div class="col-sm-2">
			<button type="button" class="download btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> Descargar</button>
		</div>
		<div class="col-sm-2">
			<button type="button" class="setVigenciaTrue btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Hacer vigente</button>
		</div>
		<!-- <div class="col-sm-2">
			<button type="button" class="setVigenciaFalse btn btn-default btn-primary"><span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span> Quitar vigencia</button>
		</div>  -->
		<div class="col-sm-2">
			<button type="button" class="delete btn btn-sm btn-block btn-default btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Quitar de la lista</button>
		</div>
	</div>
	
</script>