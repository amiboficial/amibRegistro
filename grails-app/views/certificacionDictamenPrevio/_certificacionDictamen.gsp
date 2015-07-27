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
				<g:message code="certificacion.figura.label" default="(Variante)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=nombreVarianteFigura}}</p>
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
					{{ for(var i=1950;i<=2020;i++){ }}
						{{ if(i == fechaObtencion_year){ }}
							<option value="{{=i}}" selected>{{=i}}</option>
						{{ } else{ }}
							<option value="{{=i}}">{{=i}}</option>
						{{ } }}
					{{ } }}
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="certificacion.tipoAutorizacionFigura.label" default="Autorización solicitada" />
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=tipoAutorizacionFigura}}</p>
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
	
</script>