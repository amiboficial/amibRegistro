<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="expedientePuesto">

	<div class="alert alert-danger validationErrorMessage" style="display:none;">
		Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
		<div class="errorMessagesContainer">
		</div>
	</div>

	<div class="form-group div-idInstitucion">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.idInstitucion.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static dsInstitucion">{{=dsInstitucion}}</p>
			{{ } else{ }}
				<select class="form-control idInstitucion field" data-field="idInstitucion">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.instituciones.length;i++){ }}
						{{ if(app.instituciones[i].id == idInstitucion){ }}
							<option value="{{=app.instituciones[i].id}}" selected>{{=app.instituciones[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.instituciones[i].id}}">{{=app.instituciones[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
			{{ } }}
		</div>
	</div>
	<div class="form-group div-fechaInicio">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.fechaInicio.label" default="Fecha a partir de la cual labora" />
		</label>
		<div class="col-md-5 col-sm-5">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static fechaInicio">{{=fechaInicio_day}}/{{=fechaInicio_month}}/{{=fechaInicio_year}}</p>
			{{ } else{ }}
				
				<select style="width: 28%;" class="form-control col-md-4 fechaInicio_day field" data-field="fechaInicio_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaInicio_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaInicio_month field" data-field="fechaInicio_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaInicio_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaInicio_year field" data-field="fechaInicio_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1950;i<=2020;i++){ }}
						{{ if(i == fechaInicio_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				
			{{ } }}
		</div>
	</div>
	<div class="form-group div-fechaFin">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.fechaFin.label" default="Fecha fin de labores" />
		</label>
		<div class="col-md-5 col-sm-5">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				{{ if(fechaFin_year != -1 && fechaFin_month != -1 && fechaFin_day != -1){ }}
					<p class="form-control-static fechaFin">{{=fechaFin_day}}/{{=fechaFin_month}}/{{=fechaFin_year}}</p>
				{{ } else{ }}
					<p class="form-control-static fechaFin">(Puesto Actual)</p>
				{{ } }}
			{{ } else{ }}
				
				<select style="width: 28%;" class="form-control col-md-4 fechaFin_day field" data-field="fechaFin_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaFin_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaFin_month field" data-field="fechaFin_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaFin_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaFin_year field" data-field="fechaFin_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1950;i<=2020;i++){ }}
						{{ if(i == fechaFin_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				
			{{ } }}
		</div>
	</div>
	<div class="form-group div-nombrePuesto">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.nombrePuesto.label" default="Puesto" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static nombrePuesto">{{=nombrePuesto}}</p>
			{{ } else{ }}
				<input type="text" class="form-control nombrePuesto field" data-field="nombrePuesto" value="{{=nombrePuesto}}"/>
			{{ } }}
		</div>
	</div>

	<div class="form-group div-statusEntManifProtesta">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.statusEntManifProtesta.label" default="Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static statusEntManifProtesta">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ statusEntManifProtesta ]}}</p>
			{{ } else{ }}
				<select class="form-control statusEntManifProtesta field" data-field="statusEntManifProtesta">
					<option value="-1">-Seleccione-</option>
					{{ if(statusEntManifProtesta == app.EXP_PUES_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOAPLICA}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOAPLICA}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntManifProtesta == app.EXP_PUES_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_ENTREGO}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_ENTREGO}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntManifProtesta == app.EXP_PUES_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOENTREGO}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOENTREGO}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } }}		
				</select>
			{{ } }}
		</div>
	</div>

	{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
		{{ if( obsEntManifProtesta != undefined && obsEntManifProtesta != "" ){ }}
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="puesto.obsEntManifProtesta.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static obsEntManifProtesta">{{=obsEntManifProtesta}}</p>
				</div>
			</div>
		{{ } }}
	{{ } else{ }}
		<div class="form-group div-obsEntManifProtesta">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="puesto.obsEntManifProtesta.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsEntManifProtesta form-control field" data-field="obsEntManifProtesta" value="{{=obsEntManifProtesta}}"/>
			</div>
		</div>
	{{ } }}
	
	<div class="form-group div-statusEntCartaInter">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.statusEntCartaInter.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static statusEntCartaInter">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ statusEntCartaInter ]}}</p>
			{{ } else{ }}
				<select class="form-control statusEntCartaInter field" data-field="statusEntCartaInter">
					<option value="-1">-Seleccione-</option>
					{{ if(statusEntCartaInter == app.EXP_PUES_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOAPLICA}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOAPLICA}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaInter == app.EXP_PUES_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_ENTREGO}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_ENTREGO}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaInter == app.EXP_PUES_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOENTREGO}}" selected>{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.EXP_PUES_ST_ENTREGA_NOENTREGO}}">{{=app.EXP_PUES_ST_ENTREGA_MSGS[ app.EXP_PUES_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } }}
				</select>
			{{ } }}
		</div>
	</div>

	{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
		{{ if( obsEntCartaInter != undefined && obsEntCartaInter != "" ){ }}
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="puesto.obsEntCartaInter.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static obsEntCartaInter">{{=obsEntCartaInter}}</p>
				</div>
			</div>
		{{ } }}
	{{ } else{ }}
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="puesto.obsEntCartaInter.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsEntCartaInter form-control field" data-field="obsEntCartaInter" value="{{=obsEntCartaInter}}"/>
			</div>
		</div>
	{{ } }}

	<div class="row">
		<div style="text-align:center; margin-top: 0.75em;">
			{{ if(viewStatus == app.EXP_PUES_ST_OPEN && viewMode == app.EXP_PUES_MODE_EDIT){ }}
				<button type="button" class="update btn btn-info"><span class="glyphicon glyphicon-floppy-disk"></span> Finalizar edición</button>
				<button type="button" class="cancelEdit btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
			{{ } }}
			{{ if(viewStatus == app.EXP_PUES_ST_OPEN && viewMode == app.EXP_PUES_MODE_NEW){ }}
				<button type="button" class="save btn btn-info"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar nuevo</button>
				<button type="button" class="cancelNew btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
			{{ } }}
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<button type="button" class="editElement btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
				<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
			{{ } }}
		</div>
	</div>

</script>

<script type="text/template" id="expedientePuestos">

	<fieldset>
		<legend>Datos de relación laboral con institución</legend>
		
		<div class="alert alert-danger validationViewErrorMessage" style="display:none;">
			Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
			<div class="errorViewMessagesContainer">
			</div>
		</div>
		
		<div class="list-group">
			<div class="list-group-item">
				<div class="row" style="padding-left:0.75em;">
					<button type="button" class="add btn btn-success " ><span class="glyphicon glyphicon-plus"></span> Agregar nuevo</button>
				</div>
			</div>
			<div class="listaPuestos">
			</div>
		</div>
	</fieldset>

	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Validar y confirmar datos</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button id="btnCancelEdit" type="button" class="edit btn btn-primary btn-block">Editar datos</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
	
</script>