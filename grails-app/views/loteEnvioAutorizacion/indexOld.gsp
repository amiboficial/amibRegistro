<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Lote de envío a autorización</title>
</head>
<body>

	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="certificacionEnvioAutorizacion" action="index" />">Pendientes de autorización</a></li>
		<li><a href="#">Lote de envío a autorización</a></li>
	</ul>
	<h2><strong>Lote de envío a autorización</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>

	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form">
		<fieldset>
		
			<div class="form-group">
				<div class="col-md-12 col-sm-12">
					<div class="btn-group">
						<button type="button" class="selectAll btn btn-primary" data-tab="M"><span class="glyphicon glyphicon-check"></span>&nbsp;Seleccionar todo</button>
						<button type="button" class="selectNone btn btn-primary" data-tab="M"><span class="glyphicon glyphicon glyphicon-unchecked"></span>&nbsp;De-seleccionar todo</button>
						<button type="button" class="removeSelected btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-share"></span>&nbsp;Eliminar seleccionados</button>
					</div>
					&nbsp;&nbsp;&nbsp;
					<div class="btn-group">
						<button type="button" class="empty btn btn-danger" data-tab="M"><span class="glyphicon glyphicon-trash"></span>&nbsp;Vaciar lote</button>
						<button type="button" class="exportxls btn btn-info" data-tab="M"><img src="${assetPath(src: 'excel_icon_16.png')}"/>&nbsp;Exportar a archivo de excel</button>
					</div>
					
				</div>
			</div>
			
			<div class="content scaffold-list" role="main">
				<table class="table">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th>
							Folio 
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="idSustentante" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
							</th>
							<th>
							Matrícula 
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="numeroMatricula" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
							</th>
							<th>
							Nombre 
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="nombre" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
							</th>
							<th>
							1er Apellido 
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="primerApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
							</th>
							<th>
							2do Apellido 
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="asc"><span class="sort handCursor glyphicon glyphicon-chevron-up"></span></button>
								<button type="button" class="sort btn btn-default btn-xxs" data-sort="segundoApellido" data-order="desc"><span class="sort handCursor glyphicon glyphicon-chevron-down"></span></button>
							</th>
						</tr>
					</thead>
					
					<tbody class="list-items"><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">113489</td>
				<td class="check handCursor" style="white-space:nowrap">27141</td>
				<td class="check handCursor">Usuario de Prueba</td>
				<td class="check handCursor">AMIB</td>
				<td class="check handCursor">Certifica</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">113488</td>
				<td class="check handCursor" style="white-space:nowrap">111972</td>
				<td class="check handCursor">Gloria Mireya</td>
				<td class="check handCursor">Mejía</td>
				<td class="check handCursor">Medina</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">113486</td>
				<td class="check handCursor" style="white-space:nowrap">107754</td>
				<td class="check handCursor">Gerardo Daniel</td>
				<td class="check handCursor">Espinosa</td>
				<td class="check handCursor">Samano</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">93484</td>
				<td class="check handCursor" style="white-space:nowrap">111974</td>
				<td class="check handCursor">Fernando Keneth</td>
				<td class="check handCursor">Lozano</td>
				<td class="check handCursor">Osorio</td>
				</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">83496</td>
				<td class="check handCursor" style="white-space:nowrap">111976</td>
				<td class="check handCursor">Erik Daniel</td>
				<td class="check handCursor">Ramírez</td>
				<td class="check handCursor">Salazar</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">83488</td>
				<td class="check handCursor" style="white-space:nowrap">111963</td>
				<td class="check handCursor">Claudia Gabriela</td>
				<td class="check handCursor">Vega</td>
				<td class="check handCursor">Piedra</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">83487</td>
				<td class="check handCursor" style="white-space:nowrap">112011</td>
				<td class="check handCursor">Cinthya Jaqueline</td>
				<td class="check handCursor">Figueroa</td>
				<td class="check handCursor">Corral</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">83486</td>
				<td class="check handCursor" style="white-space:nowrap">111941</td>
				<td class="check handCursor">Christian Vianey</td>
				<td class="check handCursor">Flota</td>
				<td class="check handCursor">Osalde</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">83485</td>
				<td class="check handCursor" style="white-space:nowrap">111977</td>
				<td class="check handCursor">Carlos Alberto</td>
				<td class="check handCursor">Esquivel</td>
				<td class="check handCursor">Cabral</td>
			</tr><tr style="background-color: rgb(255, 255, 255);">
				<td class="check handCursor" style="width:1px;white-space:nowrap">
					
						<span class="glyphicon glyphicon-unchecked"></span>
					
				</td>
				<td class="check handCursor" style="white-space:nowrap">63477</td>
				<td class="check handCursor" style="white-space:nowrap">108429</td>
				<td class="check handCursor">Antonio</td>
				<td class="check handCursor">Pardo</td>
				<td class="check handCursor">Díaz</td>
			</tr></tbody>
				
				</table>
				
				<ul class="pagination pagination-sm"><li class="disabled"><a href="javascript:void(0);">&lt;</a></li><li class="active"><a href="javascript:void(0);">1</a></li><li class="page handCursor" data-page="2"><a href="javascript:void(0);">2</a></li><li class="page handCursor" data-page="2"><a href="javascript:void(0);">&gt;</a></li></ul>
				
			</div>
			
		</fieldset>
	</form>

</body>
</html>