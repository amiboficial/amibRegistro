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
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.matricula.label" default="Matricula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField name="fltMat" id="txtFltMat" class="form-control" maxlength="10" value="${viewModelInstance?.fltMat}"/>
					</div>
				</div>
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button type="button" class="limpiar btn btn-default btn-primary" data-tab="M">Limpiar campos</button>
						<button type="button" class="buscar btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			<div role="tabpanel" id="bid" class="tab-pane-folio tab-pane">
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.id.label" default="Folio" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField name="fltFol" id="txtFltFol" class="form-control" maxlength="10" value="${viewModelInstance?.fltFol}"/>
					</div>
				</div>
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button type="button" class="limpiar btn btn-default btn-primary" data-tab="F" >Limpiar campos</button>
						<button type="button" class="buscar btn btn-default btn-primary" data-tab="F" ><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</div>
			<div role="tabpanel" id="bav" class="tab-pane-busqav tab-pane">
				
				<div id="divFltNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.nombre.label" default="Nombre" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtFltNom" maxlength="80" class="form-control" name="fltNom" value="${viewModelInstance?.fltNom}" />
					</div>
				</div>
				
				<div id="divFltAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.apellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtFltAp1" maxlength="100" class="form-control" name="fltAp1" value="${viewModelInstance?.fltAp1}" />
					</div>
				</div>
				
				<div id="divFltAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.apellido1.label" default="Segundo apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:textField id="txtFltAp2" maxlength="100" class="form-control" name="fltAp2" value="${viewModelInstance?.fltAp2}" />
					</div>
				</div>
									
				<div id="divFltFig" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.figura.label" default="Figura" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fltFig' class="form-control" id="selFltFig" 
						value="${viewModelInstance?.fltFig}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.figuraList}'
						optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				
				<div id="divFltVFig" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.varianteFigura.label" default="Variante de Figura" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select name='fltVFig' class="form-control" id="selFltVFig" 
						value="${viewModelInstance?.fltVFig}"
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.varianteFiguraList}'
						optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-6 col-sm-6" style="text-align: center">
						<button type="button" class="limpiar btn btn-default btn-primary" data-tab="A">Limpiar campos</button>
						<button type="button" class="buscar btn btn-default btn-primary" data-tab="A"><span class="glyphicon glyphicon-search"></span> Realizar búsqueda</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
		</div>
	</fieldset>

	<div class="div-resultados">	
	</div>

</script>

<script type="text/template" id="matriculaTabTemplate">

</script>

<script type="text/template" id="folioTabTemplate">

</script>

<script type="text/template" id="busqAvTemplate">

</script>

<script type="text/template" id="resultTemplate">
	<td class="check handCursor" style="width:1px;white-space:nowrap">
		{{ if(viewChecked==true && procesando==false){ }}
			<span class="glyphicon glyphicon-check" ></span>
		{{ }else if(viewChecked==false && procesando==false){ }}
			<span class="glyphicon glyphicon-unchecked" ></span>
		{{ } }}
	</td>
	<td class="check handCursor" style="white-space:nowrap">{{=grailsId}}</td>
	<td class="check handCursor" style="white-space:nowrap">{{=numeroMatricula}}</td>
	<td class="check handCursor">{{=nombre}}</td>
	<td class="check handCursor">{{=primerApellido}}</td>
	<td class="check handCursor">{{=segundoApellido}}</td>
	<td style="width:1px;white-space:nowrap">
		{{ if(yaEnLote==false && procesando==false){ }}
			<button class="send btn btn-default btn-xs" data-id="{{=grailsId}}">Enviar a lote de envio</button>
		{{ }else if(yaEnLote==true && procesando==false) { }}
			<button class="btn btn-default btn-xs" disabled>Enviado</button>
		{{ }else{ }}
			<button class="btn btn-default btn-xs" disabled>Procesando</button>
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
				<button type="button" class="hideSent btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-eye-close"></span>&nbsp;Ocultar elementos enviados</button>
				&nbsp;&nbsp;&nbsp;
				<div class="btn-group">
					<button type="button" class="selectAll btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-check"></span>&nbsp;Seleccionar todo</button>
					<button type="button" class="selectNone btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon glyphicon-unchecked"></span>&nbsp;De-seleccionar todo</button>
					<button type="button" class="sentSelected btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-share"></span>&nbsp;Enviar seleccionados a lote de envio</button>
				</div>
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="viewLote btn btn-default btn-primary" data-tab="M"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;Ver lote de envio <span class="badge">X</span></button>
			</div>
		</div>
		
		<div class="content scaffold-list" role="main">
			<table class="table">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>${message(code: 'expediente.folio.label', default: 'Folio')} <a href="#"><span class="glyphicon glyphicon-chevron-up"></span></a><a href="#"><span class="glyphicon glyphicon-chevron-down"></span></a></th>
						<th>${message(code: 'expediente.matricula.label', default: 'Matrícula')} <a href="#"><span class="glyphicon glyphicon-chevron-up"></span></a><a href="#"><span class="glyphicon glyphicon-chevron-down"></span></a></th>
						<th>${message(code: 'expediente.nombre.label', default: 'Nombre')} <a href="#"><span class="glyphicon glyphicon-chevron-up"></span></a><a href="#"><span class="glyphicon glyphicon-chevron-down"></span></a></th>
						<th>${message(code: 'expediente.primerApellido.label', default: '1er Apellido')} <a href="#"><span class="glyphicon glyphicon-chevron-up"></span></a><a href="#"><span class="glyphicon glyphicon-chevron-down"></span></a></th>
						<th>${message(code: 'expediente.segundoApellido.label', default: '2do Apellido')} <a href="#"><span class="glyphicon glyphicon-chevron-up"></span></a><a href="#"><span class="glyphicon glyphicon-chevron-down"></span></a></th>
						<th>...</th>
					</tr>
				</thead>
				
				<tbody class="list-items">
					
				</tbody>
			
			</table>

			<ul class="pagination pagination-sm">
				<li><a href="#">&lt;</a></li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">&gt;</a></li>
			</ul>

		</div>
		
	</fieldset>

</script>