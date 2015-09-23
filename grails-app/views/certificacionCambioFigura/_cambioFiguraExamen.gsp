<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="opcionExamenViewTemplate">
	<fieldset>
		<legend>Lista de exámenes acreditados</legend>
		
		<div class="alert-errorNoHaySeleccion alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Debe seleccionar el <strong>exámen</strong> sobre el cual aplicará la reposición</div>
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Seleccione el exámen de certificación sobre el cual aplicará el cambio de figura.</div>
		
		<ul class="list-group">
			{{ examenVMCollection.each(function(item){ }}
				<a href="javascript:void(0);" 
				
				class="list-group-item 
						{{ if(item.attributes.seleccionado){ }}
						active 
						{{ } }}
						seleccionarExamen" 
				
				data-grailsid='{{=item.attributes.grailsId}}'>
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							Número de matrícula
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">{{=item.attributes.numeroMatricula}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							Fecha de aplicación
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">{{=item.attributes.fechaAplicacionExamen}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-3 control-label">
							Figura
						</label>
						<div class="col-md-9 col-sm-9">
							<p class="form-control-static">{{=item.attributes.descripcionFigura}}</p>
						</div>
					</div>
				</a>
			{{ }, this); }}
		</ul>
	</fieldset>
</script>

<script type="text/template" id="datosCertificacionViewTemplate">

<fieldset>
		<legend>Datos de figura certificada a autorizar</legend>
	
		<div class="alert-errValidacion alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Hay error uno o mas campos, por favor revise haberlos completado adecuadamente</div>
	
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Figura a la que aplicó
			</label>
			<div class="col-md-9 col-sm-9">
				<p class="form-control-static">{{=nombreFigura}}</p>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				(Variante de figura)
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
					{{ if(statusEntHistorialInforme == app.CAMFIGEX_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntHistorialInforme == app.CAMFIGEX_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntHistorialInforme == app.CAMFIGEX_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
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
					{{ if(statusEntCartaRec == app.CAMFIGEX_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaRec == app.CAMFIGEX_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusEntCartaRec == app.CAMFIGEX_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
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
					{{ if(statusConstBolVal == app.CAMFIGEX_ST_ENTREGA_NOAPLICA){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOAPLICA}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOAPLICA  ]}}</option>
					{{ } }}
					
					{{ if(statusConstBolVal == app.CAMFIGEX_ST_ENTREGA_ENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_ENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_ENTREGO ]}}</option>
					{{ } }}
					
					{{ if(statusConstBolVal == app.CAMFIGEX_ST_ENTREGA_NOENTREGO){ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}" selected>{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
					{{ } else{ }}
						<option value="{{=app.CAMFIGEX_ST_ENTREGA_NOENTREGO}}">{{=app.CAMFIGEX_ST_ENTREGA_MSGS[ app.CAMFIGEX_ST_ENTREGA_NOENTREGO ]}}</option>
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

</script>

<script type="text/template" id="cambioFiguraExamenViewTemplate">

	<div class="div-opcionExamenVM">
	</div>
	
	<div class="div-datosCertificacionVM">
	</div>
	
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="submit btn btn-primary btn-block">Validar y confirmar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button disabled="" type="button" class="edit btn btn-primary btn-block">Editar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>