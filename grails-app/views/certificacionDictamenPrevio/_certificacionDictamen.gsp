<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="certificacionDictamen">
	
	<div class="alert alert-danger validationErrorMessage" style="display:none;">
		Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
		<div class="errorMessagesContainer">
		</div>
	</div>
	
	<fieldset>
		<legend>Datos de figura certificada a autorizar</legend>
	
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.figura.label" default="Figura a la que aplicó" />
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=nombreFigura}}</p>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				(Variante en la que aplicó por primera vez)
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=nombreVarianteFigura}}</p>
			</div>
		</div>
		
		
		<legend><i>Certificación</i></legend>
		<div class="form-group div-fechaInicio">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de inicio a aplicar
			</label>
			<div class="col-md-5 col-sm-5">
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
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaInicio_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group div-fechaFin">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de fin a aplicar
			</label>
			<div class="col-md-5 col-sm-5">
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
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaFin_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		

		<legend><i>Autorización</i></legend>
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.tipoAutorizacionFigura.label" default="Autorización solicitada" />
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=tipoAutorizacionFigura}}</p>
			</div>
		</div>

		<div class="form-group div-fechaObtencion">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.fechaObtencion.label" default="Fecha de obtención" />
			</label>
			<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaObtencion_day field" data-field="fechaObtencion_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaObtencion_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaObtencion_month field" data-field="fechaObtencion_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaObtencion_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaObtencion_year field" data-field="fechaObtencion_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaObtencion_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group div-fechaInicioAuth">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de inicio de autorización
			</label>
			<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaInicioAutorizacion_day field" data-field="fechaInicioAutorizacion_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaInicioAutorizacion_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaInicioAutorizacion_month field" data-field="fechaInicioAutorizacion_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaInicioAutorizacion_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaInicioAutorizacion_year field" data-field="fechaInicioAutorizacion_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaInicioAutorizacion_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group div-fechaFinAuth">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de fin de autorización
			</label>
			<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaFinAutorizacion_day field" data-field="fechaFinAutorizacion_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaFinAutorizacion_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaFinAutorizacion_month field" data-field="fechaFinAutorizacion_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaFinAutorizacion_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaFinAutorizacion_year field" data-field="fechaFinAutorizacion_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaFinAutorizacion_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>





		<div class="form-group div-statusEntHistorialInforme">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.statusEntHistorialInforme.label" default="Informe proporcionado por una sociedad de información crediticia son su historial de cuando menos 5 años" />
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="form-control statusEntHistorialInforme field" data-field="statusEntHistorialInforme">
					<option value="-1">-Seleccione-</option>
					{{ if(statusEntHistorialInforme == app.CERTDICT_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntHistorialInforme == app.CERTDICT_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntHistorialInforme == app.CERTDICT_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.obsEntHistorialInforme.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsEntHistorialInforme form-control field" data-field="obsEntHistorialInforme"/>
			</div>
		</div>
		
		<div class="form-group div-statusEntCartaRec">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.statusEntCartaRec.label" default="Cartas de Recomendación" />
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="form-control statusEntCartaRec field" data-field="statusEntCartaRec">
					<option value="-1">-Seleccione-</option>
					{{ if(statusEntCartaRec == app.CERTDICT_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaRec == app.CERTDICT_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaRec == app.CERTDICT_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.obsEntCartaRec.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsEntCartaRec form-control field" data-field="obsEntCartaRec"/>
			</div>
		</div>
		
		<div class="form-group div-statusConstBolVal">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.statusConstBolVal.label" default="Constancias de las Bolsas de Valores" />
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="form-control statusConstBolVal field" data-field="statusConstBolVal">
					<option value="-1">-Seleccione-</option>
					{{ if(statusConstBolVal == app.CERTDICT_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOAPLICA}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusConstBolVal == app.CERTDICT_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_ENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusConstBolVal == app.CERTDICT_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CERTDICT_ST_ENTREGA_NOENTREGO}}">{{=app.CERTDICT_ST_ENTREGA_MSGS[ app.CERTDICT_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.obsConstBolVal.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsConstBolVal form-control field" data-field="obsConstBolVal"/>
			</div>
		</div>
	
	</fieldset>
	
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="submit btn btn-primary btn-block">Validar y confirmar datos</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="edit btn btn-primary btn-block">Editar datos</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

<div id="DueTimeLapse">
	<legend><i>Lapso de átencion</i></legend>
		<div class="form-group div-fechaEntrega">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de entrega
			</label>
			<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaEntrega_day field" data-field="fechaEntrega_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaEntrega_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaEntrega_month field" data-field="fechaEntrega_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaEntrega_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaEntrega_year field" data-field="fechaEntrega_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaEntrega_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		
		<div class="form-group div-fechaEnvio">
			<label class="col-md-2 col-sm-3 control-label">
				Fecha de envio
			</label>
			<div class="col-md-5 col-sm-5">
				<select style="width: 28%;" class="form-control col-md-4 fechaEnvio_day field" data-field="fechaEnvio_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						{{ if(i == fechaEnvio_day){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaEnvio_month field" data-field="fechaEnvio_month">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=0;i<app.MESES.length;i++){ }}
						{{ if(app.MESES[i].id == fechaEnvio_month){ }}
							<option value="{{=app.MESES[i].id}}" selected>{{=app.MESES[i].nombre}}</option>
						{{ } else{ }}
							<option value="{{=app.MESES[i].id}}">{{=app.MESES[i].nombre}}</option>
						{{ } }}
					{{ } }}
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaEnvio_year field" data-field="fechaEnvio_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1990;i<=2030;i++){ }}
						{{ if(i == fechaEnvio_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
</div>
	
</script>