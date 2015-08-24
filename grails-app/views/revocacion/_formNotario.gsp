<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="notarioTemplate">

	<div class="alert-errorNumeroNotariaInvalidType alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Asegurese que el dato intrducido en número de notaria se un dato numerico</div>
	<div class="alert-errorNumeroNotariaBlank alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe ingresar un número de notaria</div>
	<div class="alert-errorEntidadFederativaNonSelected alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No ha seleccionado la entidad federativa</div>
	<div class="alert-errorNotarioNotFound alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> No se encontró ningún notario</div>
	<div class="alert-errorNotarioNotSelected alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> Debe seleccionar un notario</div>
	<div class="alert-processing alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
	
	<div class="div-numeroNotaria form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Numero de notaría
		</label>
		<div class="col-md-6 col-sm-6">
			<input class="numeroNotaria field form-control" maxlength="10" data-field="numeroNotaria" type="text" value="{{=numeroNotaria}}">
		</div>
	</div>
	
	<div class="div-idEntidadFederativa form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Entidad federativa
		</label>
		<div class="col-md-6 col-sm-6">
			<select class="field idEntidadFederativa form-control" data-field="idEntidadFederativa" >
			{{ _.each(entidadesFederativas,function(item){ }}
				{{ if(item.id == idEntidadFederativa){ }}
					<option value="{{=item.id}}" selected>{{=item.text}}</option>
				{{ } else{ }}
					<option value="{{=item.id}}">{{=item.text}}</option>
				{{ } }}
			{{ },this ); }}
			</select>
		</div>
		<div class="col-md-3 col-sm-3">
			
			{{ if(!hayNotariosEncontrados){ }}
				<button type="button" class="btn btn-block btn-info buscarNotario">
			{{ } else{ }}
				<button disabled=""type="button" class="btn btn-block btn-info buscarNotario">	
			{{ } }}
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span> Buscar
				</button>
			
		</div>
	</div>

	
	<div class="div-idNotarioSeleccionado form-group">
		<label class="col-md-2 col-sm-3 control-label">
			Notario*
		</label>
		<div class="col-md-9 col-sm-9">
			<select class="field idNotarioSeleccionado form-control" data-field="idNotarioSeleccionado">
			{{ _.each(notariosEncontrados,function(item){ }}
				{{ if(item.id == idNotarioSeleccionado){ }}
					<option value="{{=item.id}}" selected>{{=item.text}}</option>
				{{ } else{ }}
					<option value="{{=item.id}}">{{=item.text}}</option>
				{{ } }}
			{{ },this ); }}
			</select>
		</div>
	</div>
	
	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block submit">Validar y confirmar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			<button type="button" class="btn btn-primary btn-block edit">Editar</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>
	
</script>