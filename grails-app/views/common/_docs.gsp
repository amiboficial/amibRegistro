<%@ page contentType="text/html;charset=UTF-8" %>
		<script type="text/template" id="documentoTemplate_listoSinArchivo">
			<td>{{=tipoDocumento}}</td>
			<td>(Pendiente)</td>
			<td>
				<div style="float:left; margin-right:3px;">
					<input type="file" style="width: 96px;" class="upload invisibleFileUpload btn btn-info btn-xs" name="archivo" id="archivo_{{=idTipoDocumento}}">
					<button type="button" class="btn btn-info btn-xs">Cargar archivo</button>
				</div>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
				<input type="hidden" name="documento" value="{ 'idTipoDocumento':{{=idTipoDocumento}},'status':'SIN_ARCHIVO','uuid':'' }" />
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_listoPrecargado">
			<td>{{=tipoDocumento}}</td>
			<td>{{=nombreDocumento}}</td>
			<td>
				<button type="button" class="download btn btn-info btn-xs">Descargar</button>&nbsp;
				<div style="float:left; margin-right:3px;">
					<input type="file" style="width: 136px;" class="upload invisibleFileUpload btn btn-info btn-xs" name="archivo" id="archivo_{{=idTipoDocumento}}">
					<button type="button" class="btn btn-info btn-xs">Cargar nuevo archivo</button>
				</div>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
				<input type="hidden" name="documento" value="{ 'idTipoDocumento':{{=idTipoDocumento}},'status':'PRECARGADO','uuid':'{{=uuid}}' }" />
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_listoCargado">
			<td>{{=tipoDocumento}}</td>
			<td>{{=nombreDocumento}}</td>
			<td>
				<button type="button" class="downloadTmp btn btn-info btn-xs">Descargar</button>&nbsp;<button type="button" class="upload btn btn-info btn-xs">Cargar nuevo archivo</button>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
				<input type="hidden" name="documento" value="{ 'idTipoDocumento':{{=idTipoDocumento}},'status':'CARGADO','uuid':'{{=uuid}}' }" />
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_procesando">
			<td>{{=tipoDocumento}}</td>
			<td>... <input type="hidden" name="documento" value="{ 'idTipoDocumento':{{=idTipoDocumento}},'status':'SIN_ARCHIVO','uuid':'' }" /> </td>
			<td><asset:image src="spinner_alert_info.gif"/> Procesando</td>
		</script>