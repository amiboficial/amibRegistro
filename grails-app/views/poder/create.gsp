<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
		<title>Registro 0.1 - Alta de poder</title>
	</head>
	<body>
	
		<ul class="breadcrumb">
	           <li><a href="#">Servicios</a><span class="divider"></span></li>
	           <li><a href="#">Alta de poder</a></li>
		</ul>
	
		<h1><strong>Alta de poder</strong></h1>
	
		<form class="form-horizontal" role="form">

			<fieldset>
				<legend>Datos del representante legal</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
		            </div>
				</div>
				
			</fieldset>
	
			<fieldset>
				<legend>Datos de la institución o grupo financiero</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.nombreGrupoFinancieroOrInstituto.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del poder</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Numero de escritura" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Fecha de aporderamiento" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
		            </div>
				</div>
				
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del notario</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Número" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-2 col-sm-2">
		            	<g:textField class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-4 col-sm-4">
		            	<g:textField class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.nombreGrupoFinancieroOrInstituto.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
				
			</fieldset>
			
			<fieldset>
				<legend>Datos de apoderados</legend>
				
				<form id="frmApoderados" action="#">
					<table class="table">
						<thead>
							<tr>
								<th style='width:10%;'>Matrícula</th>
								<th>Nombre completo</th>
								<th>DGA CNBV</th>
								<th style='width:10%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyApoderados">
							<tr>
								<td><input id="txtNewMatricula" class="form-control" type="text" /></td>
								<td><input id="txtNewNombre" class="form-control" type="text" /></td>
								<td><input id="txtNewDGA" class="form-control" type="text" /></td>
								<td><button id="btnAdd" class="add btn btn-default"><span class="glyphicon glyphicon-plus"></span> Agregar</button></td>
							</tr>
						</tbody>
					</table>
				</form>
				
			</fieldset>
	
			<fieldset>
				<legend>Documentos de respaldo</legend>
			</fieldset>
	
		</form>
		<!-- INICIA: TEMPLATES UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<script type="text/template" id="apoderadoTemplate">
			<td>{{=matricula}}</td>
			<td>{{=nombreCompleto}}</td>
			<td>{{=dga}}</td>
			<td><button class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button> </td>
		</script>
		<!-- FIN: TEMPLATES UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<!-- INICIA: SCRIPT PARA COMPONENTE DE APODERADOS -->
		<script type="text/javascript">

		var apoderadosWidget = apoderadosWidget || {}
		
		apoderadosWidget.Apoderado = Backbone.Model.extend({
			defaults: {
				matricula: -1,
				nombreCompleto: '(Sin nombre)',
				dga: '(Sin DGA)'
			}
		});

		apoderadosWidget.Apoderados = Backbone.Collection.extend({
			model: apoderadosWidget.Apoderado
		});
		
		apoderadosWidget.ApoderadoView = Backbone.View.extend({
			tagName: 'tr',
			className: 'apoderadoRow',
			template: _.template( $('#apoderadoTemplate').html() ),
			
			render : function() {

				console.log(JSON.stringify(this.model));
				console.log($('#apoderadoTemplate').html());
				console.log(this.template( this.model.toJSON() ));
				
				this.$el.html( this.template( this.model.toJSON() ) );

				return this;
			}
		});
		
		apoderadosWidget.ApoderadosView = Backbone.View.extend({
			el: '#tbdyApoderados',
			initialize: function( initialApoderados ){
				this.collection = new apoderadosWidget.Apoderados(initialApoderados);
				this.render();
			},
			render: function() {
				this.collection.each( function(item){
					this.renderApoderado(item);
				},this );
			},
			renderApoderado: function(item){
				var apoderadoView = new apoderadosWidget.ApoderadoView({model:item});
				this.$el.append( apoderadoView.render().el );
			}
		});

		$(function(){
			var apoderatosTest = [
				{ matricula: 1, nombreCompleto: 'PETRONILA PEREZ', dga: 'DGA-XXXX'},
				{ matricula: 2, nombreCompleto: 'AZUL GARCIA', dga: 'DGA-XXXX'},
				{ matricula: 3, nombreCompleto: 'JOHN DOE', dga: 'DGA-XXXX'},
    		];

    		new apoderadosWidget.ApoderadosView(apoderatosTest);
		});
		
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE APODERADOS -->
	</body>
</html>
