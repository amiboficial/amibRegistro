<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="opcionExamenViewTemplate">
	<fieldset>
		<legend>Lista de exámenes acreditados</legend>
		
		<div class="alert-errorNoHaySeleccion alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Debe seleccionar el <strong>exámen</strong> sobre el cual aplicó la revalidación</div>
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Seleccione el exámen sobre el cual aplicó la renovación de la certificación</div>
		
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

<script type="text/template" id="revCertAutViewTemplate">

	<fieldset>
		<legend>Revalidación de cértificación</legend>
		
		<div class="alert-errorNoMetodoValidacion alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Seleccione un <strong>Método de validación</strong></div>
		
		<div class="form-group div-idMetodoValidacion">
			<label class="col-md-2 col-sm-3 control-label">
				Método de revalidación
			</label>
			<div class="col-md-9 col-sm-9">
				<select class="idMetodoValidacion field form-control" data-field="idMetodoValidacion">
					{{ _.each(metodosValidacion,function(item){ }}
						{{ if(item.id == idMetodoValidacion){ }}
							<option value="{{=item.id}}" selected>{{=item.text}}</option>
						{{ } else{ }}
							<option value="{{=item.id}}">{{=item.text}}</option>
						{{ } }}
					{{ }, this); }}
				</select>
			</div>
		</div>
	</fieldset>

	<div class="div-opcionExamenVM">
	</div>
	
	<fieldset class="opcionPuntos">
		<legend>Puntos</legend>
		
		<div class="alert-errorPuntajeBlank alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Ingrese un número de puntaje</div>
		<div class="alert-errorPuntajeNonNumeric alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Ingrese un valor numérico de puntaje</div>
		
		
		<div class="form-group div-totalpuntos">
			<label class="col-md-2 col-sm-3 control-label">
				Total de puntos obtenidos
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="puntaje field form-control" maxlength="4" data-field="puntaje" value="{{=puntaje}}" />
			</div>
		</div>
	</fieldset>

	<fieldset id="opcionPFI">
	<div class="alert-errorPFICantSelect alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Debe seleccionar el <strong>exámen</strong> sobre el cual aplicó la revalidación</div>
		<legend>Lista de exámenes PFI</legend>
		<ul class="list-group" id="clasicPFIrevalidation">
				
		</ul>
	</fieldset>
	
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
