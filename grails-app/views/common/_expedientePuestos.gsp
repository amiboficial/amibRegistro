<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="expedientePuesto">

	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.idInstitucion.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static dsInstitucion">XXXXXXXXXXXXXXXXXXXXXXXXX</p>
			{{ } else{ }}
				<g:select class="form-control idInstitucion field" name='aW5zdGl0dWNpb25lcw' 
				noSelection="${['-1':'-Seleccione-']}"
				from='${viewModelInstance?.institucionesList}'
				optionKey="id" optionValue="nombre"></g:select>
			{{ } }}
		</div>
	</div>
	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.fechaInicio.label" default="Fecha a partir de la cual labora" />
		</label>
		<div class="col-md-5 col-sm-5">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static fechaInicio">01/01/2001</p>
			{{ } else{ }}
				
				<select style="width: 28%;" class="form-control col-md-4 fechaInicio_day field" data-field="fechaInicio_day">
					<option value="-1">-Seleccione-</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaInicio_month field" data-field="fechaInicio_month">
					<option value="-1">-Seleccione-</option>
					<option value="1">enero</option>
					<option value="2">febrero</option>
					<option value="3">marzo</option>
					<option value="4">abril</option>
					<option value="5">mayo</option>
					<option value="6">junio</option>
					<option value="7">julio</option>
					<option value="8">agosto</option>
					<option value="9">septiembre</option>
					<option value="10">octubre</option>
					<option value="11">noviembre</option>
					<option value="12">diciembre</option>
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaInicio_year field" data-field="fechaInicio_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1950;i<=2020;i++){ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				</select>
				
			{{ } }}
		</div>
	</div>
	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.fechaFin.label" default="Fecha fin de labores" />
		</label>
		<div class="col-md-5 col-sm-5">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static fechaFin">01/01/2005</p>
			{{ } else{ }}
				
				<select style="width: 28%;" class="form-control col-md-4 fechaFin_day field" data-field="fechaFin_day">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1;i<=31;i++){ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				</select>
				<select style="width: 38%;" class="form-control col-md-4 fechaFin_month field" data-field="fechaFin_month">
					<option value="-1">-Seleccione-</option>
					<option value="1">enero</option>
					<option value="2">febrero</option>
					<option value="3">marzo</option>
					<option value="4">abril</option>
					<option value="5">mayo</option>
					<option value="6">junio</option>
					<option value="7">julio</option>
					<option value="8">agosto</option>
					<option value="9">septiembre</option>
					<option value="10">octubre</option>
					<option value="11">noviembre</option>
					<option value="12">diciembre</option>
				</select>
				<select style="width: 34%;" class="form-control col-md-4 fechaFin_year field" data-field="fechaFin_year">
					<option value="-1">-Seleccione-</option>
					{{ for(var i=1950;i<=2020;i++){ }}
						<option value="{{=i}}">{{=i}}</option>
					{{ } }}
				</select>
				
			{{ } }}
		</div>
	</div>
	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.nombrePuesto.label" default="Puesto actual" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static nombrePuesto">Ejecutivo de cuenta</p>
			{{ } else{ }}
				<input type="text" class="form-control nombrePuesto field" data-field=""/>
			{{ } }}
		</div>
	</div>

	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.statusEntManifProtesta.label" default="Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static statusEntManifProtesta">Entregó</p>
			{{ } else{ }}
				<select class="form-control statusEntManifProtesta field" data-field="">
					<option value="-1">-Seleccione-</option>
					<option value="0">No aplica</option>
					<option value="1">Entregó</option>
					<option value="2">No entregó</option>
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
		<div class="form-group">
			<label class="col-md-2 col-sm-3 control-label">
				<g:message code="puesto.obsEntManifProtesta.label" default="(Observaciones)" />
			</label>
			<div class="col-md-9 col-sm-9">
				<input type="text" class="obsEntManifProtesta form-control field" data-field=""/>
			</div>
		</div>
	{{ } }}
	
	<div class="form-group">
		<label class="col-md-2 col-sm-3 control-label">
			<g:message code="puesto.statusEntCartaInter.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
		</label>
		<div class="col-md-9 col-sm-9">
			{{ if(viewStatus == app.EXP_PUES_ST_VALIDATED){ }}
				<p class="form-control-static statusEntCartaInter">No aplica</p>
			{{ } else{ }}
				<select class="form-control statusEntCartaInter field" data-field="">
					<option value="-1">-Seleccione-</option>
					<option value="0">No aplica</option>
					<option value="1">Entregó</option>
					<option value="2">No entregó</option>
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
				<input type="text" class="obsEntCartaInter form-control field" data-field=""/>
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
				<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
				<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
			{{ } }}
		</div>
	</div>

</script>

<script type="text/template" id="expedientePuestos">

	<fieldset>
		<legend>Datos de relación laboral con institución</legend>
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

</script>