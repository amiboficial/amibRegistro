<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="templateAutBrwParamsView">
	<fieldset>
		<legend>Parámetros de búsqueda</legend>
		
		<div class="alert-processing alert alert-info" style="display: none;"><img src="/amibRegistro/assets/spinner_alert_info.gif">&nbsp; Procesando datos, espere unos instantes...</div>
		
		<div class="alert-errorNumeroMatriculaBlank alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Ingrese un <strong>Número de Matrícula</strong></div>
		<div class="alert-errorNumeroMatriculaNonNumeric alert alert-danger"  style="display: none;"><span class="glyphicon glyphicon-info-sign"></span>&nbsp; Ingrese un valor numérico para <strong>Número de Matrícula</strong></div>
		
		<div class="alert-errorIdSustentanteBlank alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Ingrese un <strong>Folio</strong></div>
		<div class="alert-errorIdSustentanteNonNumeric alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Ingrese un valor numérico para <strong>Folio</strong></div>
		
		<div class="alert-errorBusqAvNoHayAlMenosUnParametro alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Debé ingresar al menos parametro para la búsqueda avanzada. (Nombre, Primer Apellido, Segundo Apellido, y/o detalles de la Figura)</div>
		
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Criterio de búsqueda
			</label>
			<div class="col-md-9 col-sm-9">
				<input class="criterio field" name="criterioDO" data-field="criterio" 
				value="{{=app.CRIT_MATRICULA}}" 
				{{ if(criterio == app.CRIT_MATRICULA){ }}
					checked="" 
				{{ } }}
				type="radio">&nbsp;Matrícula&nbsp;&nbsp;
				
				<input class="criterio field" name="criterioDO" data-field="criterio" 
				value="{{=app.CRIT_FOLIO}}" 
				{{ if(criterio == app.CRIT_FOLIO){ }}
					checked="" 
				{{ } }}
				type="radio">&nbsp;Folio&nbsp;&nbsp;
				
				<input class="criterio field" name="criterioDO" data-field="criterio" 
				value="{{=app.CRIT_BUSQAV}}" 
				{{ if(criterio == app.CRIT_BUSQAV){ }}
					checked="" 
				{{ } }}
				type="radio">&nbsp;Búsqueda avanzada&nbsp;&nbsp;
				
				<input class="criterio field" name="criterioDO" data-field="criterio" 
				value="{{=app.CRIT_TODOS}}" 
				{{ if(criterio == app.CRIT_TODOS){ }}
					checked="" 
				{{ } }}
				type="radio">&nbsp;Mostrar todos
			
			</div>
		</div>
		
		<div class="div-numeroMatricula form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Matrícula
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="field numeroMatricula form-control" data-field="numeroMatricula" maxlength="10" value="{{=numeroMatricula}}" 
				{{ if(criterio != app.CRIT_MATRICULA){ }}
					disabled="" 
				{{ } }}
				/>
			</div>
		</div>
		
		<div class="div-idSustentante form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Folio
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="field idSustentante form-control" data-field="idSustentante" maxlength="10" value="{{=idSustentante}}"
				{{ if(criterio != app.CRIT_FOLIO){ }}
					disabled="" 
				{{ } }}
				/>
			</div>
		</div>
		
		<div class="div-busqavparam form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Nombre
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="field nombre form-control" data-field="nombre" maxlength="100" value="{{=nombre}}"
				{{ if(criterio != app.CRIT_BUSQAV){ }}
					disabled="" 
				{{ } }}
				/>
			</div>
		</div>
		
		<div class="div-busqavparam form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Primer apellido
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="field primerApellido form-control" data-field="primerApellido" maxlength="80" value="{{=primerApellido}}"
				{{ if(criterio != app.CRIT_BUSQAV){ }}
					disabled="" 
				{{ } }}
				/>
			</div>
		</div>
		
		<div class="div-busqavparam form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Segundo apellido
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="field segundoApellido form-control" data-field="segundoApellido" maxlength="80" value="{{=segundoApellido}}"
				{{ if(criterio != app.CRIT_BUSQAV){ }}
					disabled="" 
				{{ } }}
				/>
			</div>
		</div>
		
		<div class="div-busqavparam form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Figura
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idFigura form-control" data-field="idFigura" 
				{{ if(criterio != app.CRIT_BUSQAV){ }}
					disabled="" 
				{{ } }}
				>
				
					{{ _.each(figuras,function(item){ }}
						{{ if(item.id == idFigura){ }}
							<option value="{{=item.id}}" selected>{{=item.text}}</option>
						{{ } else{ }}
							<option value="{{=item.id}}">{{=item.text}}</option>
						{{ } }}
					{{ },this); }}
				
				</select>
			</div>
		</div>
		
		<div class="div-busqavparam form-group">
			<label class="col-md-2 col-sm-3 control-label">
				Variante de figura
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="field idVarianteFigura form-control" data-field="idVarianteFigura"
				{{ if(criterio != app.CRIT_BUSQAV){ }}
					disabled="" 
				{{ } }}
				>
				
					{{ _.each(variantesFigura,function(item){ }}
						{{ if(item.id == idVarianteFigura){ }}
							<option value="{{=item.id}}" selected>{{=item.text}}</option>
						{{ } else{ }}
							<option value="{{=item.id}}">{{=item.text}}</option>
						{{ } }}
					{{ },this); }}
					
				</select>
			</div>
		</div>
		
		<div class="div- form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-6 col-sm-6" style="text-align: center">
				<button type="button" class="limpiarCampos btn btn-default btn-primary">Limpiar campos</button>
				<button type="button" class="realizarBusqueda btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
		
	</fieldset>
	
</script>