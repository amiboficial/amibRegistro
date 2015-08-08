<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="certPendAutMainTemplate">

	<fieldset>
		<legend>Búsqueda de expedientes con certificación pendiente de autorización</legend>
		<div class="tab-content">
		
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active" >
					<a href="#bmat" aria-controls="bmat" role="tab" data-toggle="tab">Por matrícula</a>
				</li>
				<li role="presentation">
					<a href="#bid" aria-controls="bid" role="tab" data-toggle="tab">Por folio</a>
				</li>
				<li role="presentation">
					<a href="#bav" aria-controls="bav" role="tab" data-toggle="tab">Búsqueda avanzada</a>
				</li>
			</ul>
			<br/>
			
			<div role="tabpanel" id="bmat" class="tab-pane-matricula tab-pane active" >
			</div>
			
			<div role="tabpanel" id="bid" class="tab-pane-folio tab-pane">
			</div>
			
			<div role="tabpanel" id="bav" class="tab-pane-busqav tab-pane">
			</div>
			
		</div>
	</fieldset>

	<div class="div-resultados">	
	</div>

</script>

<script type="text/template" id="matriculaTabTemplate">

	<div class="div-numeroMatricula form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.matricula.label" default="Matricula" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="field form-control" maxlength="10" data-field="numeroMatricula"/>
		</div>
	</div>
	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-6 col-sm-6" style="text-align: center">
			<button type="button" class="clean btn btn-default btn-primary">Limpiar campos</button>
			<button type="button" class="find btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>

<script type="text/template" id="folioTabTemplate">

	<div class="div-idSustentante form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.id.label" default="Folio" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" class="idSustentante field form-control" maxlength="10" data-field="idSustentante"/>
		</div>
	</div>
	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-6 col-sm-6" style="text-align: center">
			<button type="button" class="clean btn btn-default btn-primary" data-tab="F" >Limpiar campos</button>
			<button type="button" class="find btn btn-default btn-primary" data-tab="F" ><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>

<script type="text/template" id="busqAvTemplate">

	<div class="form-group div-nombre">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.nombre.label" default="Nombre" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" maxlength="80" class="nombre field form-control" data-field="nombre"/>
		</div>
	</div>

	<div class="form-group div-primerApellido">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.primerApellido.label" default="Primer apellido" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" maxlength="100" class="primerApellido field form-control" data-field="primerApellido"/>
		</div>
	</div>

	<div class="form-group div-segundoApellido">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.apellido1.label" default="Segundo apellido" />
		</label>
		<div class="col-md-9 col-sm-9">
			<input type="text" maxlength="100" class="segundoApellido field form-control" data-field="segundoApellido" />
		</div>
	</div>
						
	<div class="form-group div-idFigura">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.figura.label" default="Figura" />
		</label>
		<div class="col-md-9 col-sm-9">
			<select class="idFigura field form-control" data-field="idFigura">
				<option value="-1">-Seleccione-</option>
				{{ _.each( viewFiguras, function(item){ }}
					<option value="{{=item.id}}">{{=item.nombre}}</option>
				{{ }, this ) }}
			</select>
		</div>
	</div>

	<div class="form-group div-idVarianteFigura">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="expediente.varianteFigura.label" default="Variante de Figura" />
		</label>
		<div class="col-md-9 col-sm-9">
			<select class="idVarianteFigura field form-control" data-field="idVarianteFigura">
				<option value="-1">-Seleccione-</option>
			</select>
		</div>
	</div>

	<br/>
	<div class="form-group">
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
		<div class="col-md-6 col-sm-6" style="text-align: center">
			<button type="button" class="clean btn btn-default btn-primary">Limpiar campos</button>
			<button type="button" class="find btn btn-default btn-primary"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
		</div>
		<div class="col-md-3 col-sm-3">
			&nbsp;
		</div>
	</div>

</script>

<script type="text/template" id="resultTemplate">
	<td class="check handCursor" style="width:1px;white-space:nowrap">
		{{ if(viewChecked==true && procesando==false){ }}
			<span class="glyphicon glyphicon-check" ></span>
		{{ }else if(viewChecked==false && procesando==false){ }}
			<span class="glyphicon glyphicon-unchecked" ></span>
		{{ } }}
	</td>
	<td class="check handCursor" style="white-space:nowrap">{{=idSustentante}}</td>
	<td class="check handCursor" style="white-space:nowrap">{{=numeroMatricula}}</td>
	<td class="check handCursor">{{=nombre}}</td>
	<td class="check handCursor">{{=primerApellido}}</td>
	<td class="check handCursor">{{=segundoApellido}}</td>
	<td style="width:1px;white-space:nowrap">
		{{ if(yaEnLote==false && procesando==false){ }}
			<button class="send btn btn-default btn-xs" data-id="{{=grailsId}}">Enviar a lote de envio</button>
		{{ }else if(yaEnLote==true && procesando==false) { }}
			<strong>Enviado</strong>
		{{ }else{ }}
			<strong>Procesando</strong>
		{{ } }}
	</td>
</script>

<script type="text/template" id="resultsTemplate">

	<fieldset>
		<legend>Resultados de búsqueda</legend>
		
		<div class="procMessage alert alert-info"><asset:image src="spinner_alert_info.gif"/>&nbsp; Procesando datos, espere unos instantes...</div>
		<div class="errorMessage alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> Ha ocurrido un error un la petición, intente mas tarde.</div>
		
		<div class="form-group">
			<div class="col-md-12 col-sm-12">
				<div class="btn-group">
					<button type="button" class="selectAll btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-check"></span>&nbsp;Seleccionar todo</button>
					<button type="button" class="selectNone btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon glyphicon-unchecked"></span>&nbsp;De-seleccionar todo</button>
					<button type="button" class="sendSelected btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-share"></span>&nbsp;Enviar seleccionados a lote de envio</button>
				</div>
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="viewLote btn btn-default btn-primary"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;Ver lote de envio <span class="totalEnLote badge" >0</span></button>
			</div>
		</div>
		
		<div class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>
						${message(code: 'expediente.folio.label', default: 'Folio')} 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						${message(code: 'expediente.matricula.label', default: 'Matrícula')} 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						${message(code: 'expediente.nombre.label', default: 'Nombre')} 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						${message(code: 'expediente.primerApellido.label', default: '1er Apellido')} 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>
						${message(code: 'expediente.segundoApellido.label', default: '2do Apellido')} 
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
							<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
						</th>
						<th>...</th>
					</tr>
				</thead>
				
				<tbody class="list-items">
					
				</tbody>
			
			</table>
			
			<ul class="pagination pagination-sm">

			</ul>
			
		</div>
		
	</fieldset>

</script>