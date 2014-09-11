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
		            	<g:textField class="form-control" name="nombreGrupoFinancieroOrInstituto" required="" value="${poderInstance?.representanteLegalNombre}" />
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
				
				
				
				<div id="divMsgMatriculaNoEncontrada" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>no encontrada</strong>.
				</div>
				<div id="divMatriculaSinDga" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula encontrada <strong>sin oficio DGA válido ó vigente</strong>.
				</div>
				<div id="divAlMenosUnApoderado" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Se requiere ingresar <strong>al menos un apoderado</strong>.
				</div>
				
					<table class="table">
						<thead>
							<tr>
								<th style='width:8%;'>Matrícula</th>
								<th>Nombre completo</th>
								<th style='width:16%'>DGA CNBV</th>
								<th style='width:8%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyApoderados">
							<tr>
								<td><input id="txtNewMatricula" class="form-control" type="text" /></td>
								<td><input id="txtNewNombre" class="form-control" type="text" disabled/></td>
								<td>
									<select id="selNewDGA" class="form-control">
										<option value="-1"></option>
									</select>
								</td>
								<td><button id="btnAdd" class="add btn btn-default btn-success" disabled><span class="glyphicon glyphicon-plus"></span> Agregar</button></td>
							</tr>
						</tbody>
					</table>

				
			</fieldset>
	
			<fieldset>
				<legend>Documentos de respaldo</legend>
				
				<div id="divMsgMaxFileSize" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El archivo xxx rebasa los <strong>5</strong>MB.
				</div>
				<div id="divMsgNonCompatibleFile" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo <strong>no es compatible</strong>.
				</div>
				
				<table class="table">
						<thead>
							<tr>
								<th style='width:32%;'>Tipo de documento</th>
								<th>Nombre de archivo</th>
								<th style='width:18%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyDocsRespaldo">
							<tr>
								<td>Acuse de recibo AMIB.FT.11</td>
								<td>acuse.docx</td>
								<td><button type="button" class="btn btn-info btn-xs">Descargar</button>&nbsp;<button type="button" class="btn btn-info btn-xs">Cargar archivo</button></td>
							</tr>
							<tr>
								<td>Escrito de Apoderamiento con relación del personal AMIB.FT.l67</td>
								<td>apoderamiento.pdf</td>
								<td><button type="button" class="btn btn-info btn-xs">Descargar</button>&nbsp;<button type="button" class="btn btn-info btn-xs">Cargar archivo</button></td>
							</tr>
						</tbody>
					</table>
				</table>
			</fieldset>
			
			<div class="form-group">
				<div class="col-lg-offset-5 col-md-offset-5 col-md-2 col-sm-2">
					<button type="button" class="btn btn-primary btn-lg btn-block">Dar de alta el poder</button>
				</div>
			</div>
	
		</form>
		<!-- INICIA: TEMPLATES UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<script type="text/template" id="apoderadoTemplate">
			<td>{{=matricula}}</td>
			<td>{{=nombreCompleto}}</td>
			<td>{{=dga}}</td>
			<td><button class="delete btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> Borrar</button> </td>
		</script>
		<!-- FIN: TEMPLATES UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<!-- INICIA: SCRIPT PARA COMPONENTE DE APODERADOS -->
		<script type="text/javascript">

		var apoderadosWidget = apoderadosWidget || {}

		apoderadosWidget.Dga = Backbone.Model.extend({
			defaults: {
				dga: ''
			}
		});

		apoderadosWidget.Dgas = Backbone.Model.extend({
			model: apoderadosWidget.Dga
		});
		
		apoderadosWidget.ApoderadoConDgas = Backbone.Model.extend({
			defaults: {
				matricula: -1,
				nombreCompleto: '(Sin nombre)',
				dga: '(Sin DGA)',
			}
		});
		
		apoderadosWidget.Apoderado = Backbone.Model.extend({
			defaults: {
				matricula: -1,
				nombreCompleto: '(Sin nombre)',
				dga: '(Sin DGA)',
				validado: 0
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
				this.$el.html( this.template( this.model.toJSON() ) );
				return this;
			},

			events:{
				'click .delete':'quitarApoderado'
			},
		
			quitarApoderado: function() {
				//Borra el model
				this.model.destroy();
				//Destruye esta vista
				this.remove();
			}
		
		});
		
		apoderadosWidget.ApoderadosView = Backbone.View.extend({
			state: 'LISTO', //LISTO,DGA
			el: '#tbdyApoderados',
			currentMatricula: '',
			
			initialize: function( initialApoderados ){
				this.collection = new apoderadosWidget.Apoderados(initialApoderados);
				this.render();
				this.listenTo( this.collection, 'add', this.renderApoderado );
			},
			
			render: function() {
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMatriculaSinDga').hide();
				this.collection.each( function(item){
					this.renderApoderado(item);
				},this );
			},
			renderApoderado: function(item){
				var apoderadoView = new apoderadosWidget.ApoderadoView({model:item});
				this.$el.append( apoderadoView.render().el );
			},

			events:{
				'click #btnAdd': 'agregarApoderado', 
				'blur #txtNewMatricula': 'buscarPorMatricula'
			},

			agregarApoderado: function(e) {
				e.preventDefault();

				var newMatricula = $('#txtNewMatricula').val();
				var newNombre = $('#txtNewNombre').val();
				var newDga = $('#selNewDGA').val();

				var apoderado = new apoderadosWidget.Apoderado( { matricula: newMatricula, nombreCompleto: newNombre, dga: newDga } );

				this.collection.add(apoderado);

				$('#txtNewMatricula').val('');
				$('#txtNewNombre').val('');
				$('#selNewDGA').html('');
				$('#btnAdd').prop('disabled', true);
				//$('#btnAdd').addClass('hidden');
			},

			buscarPorMatricula: function(e) {
				e.preventDefault();

				var newMatricula = $.trim($('#txtNewMatricula').val());

				if( newMatricula == '' )
				{
					$('#divMsgMatriculaNoEncontrada').hide();
					$('#divMatriculaSinDga').hide();
					//Matricula sin introducir
					$('#txtNewMatricula').val('');
					$('#txtNewNombre').val('');
					$('#selNewDGA').html('');
					$('#btnAdd').prop('disabled', true);
				}
				
				else if( newMatricula == '111' ) //Aqui va una llamada ajax
				{
					$('#divMsgMatriculaNoEncontrada').hide();
					$('#divMatriculaSinDga').hide();
					
					newNombre = 'PETRONILA PEREZ PUEBLA';
					dgasDisponibles = ['DGA123','DGA234','DGA345'];

					$('#txtNewNombre').val(newNombre);
					$('#selNewDGA').html('');
					$.each(dgasDisponibles, function(key, value) {
						$('#selNewDGA').append($("<option></option>").attr(value,key).text(value));
					});

					$('#btnAdd').prop('disabled', false);
				}

				else if( newMatricula == '222' ) //Aqui va una llamada ajax
				{
					$('#divMsgMatriculaNoEncontrada').hide();
					$('#divMatriculaSinDga').hide();
					
					newNombre = 'GERONIMO OSWALDO PEREZ BRISUELA';
					dgasDisponibles = ['DGA999','DGA888','DGA777'];

					$('#txtNewNombre').val(newNombre);
					$('#selNewDGA').html('');
					$.each(dgasDisponibles, function(key, value) {
						$('#selNewDGA').append($("<option></option>").attr(value,key).text(value));
					});

					$('#btnAdd').prop('disabled', false);
				}

				else if( newMatricula == '333' )
				{
					//matricula encontrada, pero sin autorización CNBV (dga) vigente
					$('#divMsgMatriculaNoEncontrada').hide();
					$('#divMatriculaSinDga').show();

					newNombre = 'ARMANDO DE LA TORRE ALZATE';

					$('#txtNewNombre').val(newNombre);
					$('#selNewDGA').html('');

					$('#btnAdd').prop('disabled', true);
				}
				
				else
				{
					//matricula no encontrada
					$('#divMsgMatriculaNoEncontrada').show();
					$('#divMatriculaSinDga').hide();
					//$('#txtNewMatricula').val('');
					$('#txtNewNombre').val('');
					$('#selNewDGA').html('');
					$('#btnAdd').prop('disabled', true);
				}
				
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
