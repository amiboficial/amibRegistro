<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="documentos">

	<fieldset>
		<legend>Carga de documentos</legend>


		<div class="errorValidacion alert alert-danger alert-dismissible" role="alert">
			<button style="right: 3px;" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorValidacion" >error de validacion</span>
			<br/>
			<ul class="validationErrorMsgs">
			</ul>
		</div>
		<div class="errorUpload alert alert-danger alert-dismissible" role="alert">
			<button style="right: 3px;" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span class="msgErrorUpload" >error en upload</span>
			<br/>
		</div>
		<div class="successUpload alert alert-success">
			<span class="glyphicon glyphicon-ok"></span>&nbsp;<span class="msgSuccessUpload" >La carga del archivo se realizó satisfactoriamente</span><br/>
		</div>
		<div class="procUpload alert alert-info">
			<asset:image src="spinner_alert_info.gif"/>&nbsp;<span class="msgProcUpload" >Procesando carga de archivo...</span><br/>
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
					{{ _.each(tiposDocumento,function(item){ }}
						<option value="{{=item.grailsId}}">{{=item.descripcion}}</option>
					{{ },this) }}
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
		
		<div class="btn-group" role="group" aria-label="...">
			<button type="button" class="orderByNombreArchivo btn btn-default">Ordernar por <strong>nombre</strong></button>
			<button type="button" class="orderByIdTipoDocumento btn btn-default">Ordernar por <strong>tipo</strong></button>
			<button type="button" class="orderByFecha btn btn-default">Ordernar por <strong>fecha</strong></button>
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
		<div class="col-sm-9"><p>{{=descripcionTipoDocumento}}</p></div>
	</div>
	<div class="div-fecha row">
		<label class="col-sm-2 control-label">Fecha</label>
		<div class="col-sm-9"><p>{{=fecha}}</p></div>
	</div>
	{{ if(manejaVigenciaTipoDocumento){ }}
		<div class="div-vigente row">
			<label class="col-sm-2 control-label">Vigente</label>
			{{ if(vigente){ }}
				<div class="col-sm-9"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span><p></p></div>
			{{ } else{ }}
				<div class="col-sm-9"><p><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></p></div>
			{{ } }}
		</div>
	{{ } }}
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

		{{ if(manejaVigenciaTipoDocumento){ }}
			{{ if(vigente){ }}
				<div class="col-sm-2">
					<button type="button" class="setVigenciaFalse btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span> Quitar vigencia</button>
				</div>
			{{ } else { }}
				<div class="col-sm-2">
					<button type="button" class="setVigenciaTrue btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Hacer vigente</button>
				</div>
			{{ } }}
		{{ } else{ }}
			<div class="col-sm-2">
				&nbsp;
			</div>
		{{ } }}
		<div class="col-sm-2">
			<button type="button" class="download btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> Descargar</button>
		</div>
		<div class="col-sm-2">
			<button type="button" class="delete btn btn-sm btn-block btn-default btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Quitar de la lista</button>
		</div>
	</div>
	
</script>