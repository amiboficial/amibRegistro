<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="opcionExamenViewTemplate">
	<fieldset>
		<legend>Lista de exámenes acreditados</legend>
		
		<div class="alert-errorNoHaySeleccion alert alert-danger" style="display: none;"><span class="glyphicon glyphicon-info-sign" ></span>&nbsp; Debe seleccionar el <strong>exámen</strong> sobre el cual aplicará la reposición</div>
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Seleccione el exámen de certificación sobre el cual aplicacará la reposición de la autorización.</div>
		
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

<script type="text/template" id="repAutCertViewTemplate">

	<div class="div-opcionExamenVM">
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