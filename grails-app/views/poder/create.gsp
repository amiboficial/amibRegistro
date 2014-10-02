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
				
				<div id="divMsgMatriculaYaEnLista" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>ya agregada</strong>.
				</div>
				<div id="divMsgMatriculaNoEncontrada" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>no encontrada</strong>.
				</div>
				<div id="divMsgMatriculaSinDga" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Matrícula encontrada <strong>sin oficio DGA válido ó vigente</strong>.
				</div>
				<div id="divMsgAlMenosUnApoderado" class="alert alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Se requiere ingresar <strong>al menos un apoderado</strong>.
				</div>
				<div id="divMsgProcesandoApoderado" class="alert alert-info">
					<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
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
			<td>{{=claveDga}}</td>
			<td><button class="delete btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> Borrar</button> </td>
		</script>
		<!-- FIN: TEMPLATES UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<!-- INICIA: SCRIPT PARA COMPONENTE DE APODERADOS -->
		<script type="text/javascript">

		var apoderadosWidget = apoderadosWidget || {}
		
		apoderadosWidget.Apoderado = Backbone.Model.extend({
			defaults: {
				matricula: -1,
				nombreCompleto: '(Sin nombre)',
				idAutorizadoCNBV: -1,
				claveDga: '(Sin DGA)',
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
			state: 'LISTO', //LISTO,LISTO_YA_HAY_MATRICULA,LISTO_ERROR_MATRICULA,LISTO_DGA_NO_VALIDO,PROCESANDO,LISTO_PARA_AGREGAR
			el: '#tbdyApoderados',
			currentMatricula: '',
			
			initialize: function( initialApoderados ){
				this.collection = new apoderadosWidget.Apoderados(initialApoderados);
				this.render();
				this.listenTo( this.collection, 'add', this.renderApoderado );
			},
			
			render: function() {
				this.collection.each( function(item){
					this.renderApoderado(item);
				},this );
				this.changeStateToListo();
			},
			renderApoderado: function(item){
				var apoderadoView = new apoderadosWidget.ApoderadoView({model:item});
				this.$el.append( apoderadoView.render().el );
			},

			events:{
				'click #btnAdd': 'agregarApoderado', 
				'blur #txtNewMatricula': 'buscarPorMatricula'
			},

			//importante cambiar el estado con estos métodos
			changeStateToListo: function(){
				//mensajes
				$('#divMsgMatriculaYaEnLista').hide();
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMsgMatriculaSinDga').hide();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').hide();
				//campos
				$('#txtNewMatricula').val('');
				$('#txtNewNombre').val('');
				$('#selNewDGA').html('');
				$('#btnAdd').prop('disabled', true);
				//status
				state = 'LISTO';
			},
			changeStateToListoYaHayMatricula: function(){
				//mensajes
				$('#divMsgMatriculaYaEnLista').show();
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMsgMatriculaSinDga').hide();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').hide();
				//campos
				//se deja el campo de nueva matricula tal cual
				$('#txtNewNombre').val('');
				$('#selNewDGA').html('');
				$('#btnAdd').prop('disabled', true);
				//status
				state = 'LISTO_YA_HAY_MATRICULA';
			},
			changeStateToListoErrorMatricula: function(){
				//mensajes
				$('#divMsgMatriculaYaEnLista').hide();
				$('#divMsgMatriculaNoEncontrada').show();
				$('#divMsgMatriculaSinDga').hide();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').hide();
				//campos
				//se deja el campo de nueva matricula tal cual
				$('#txtNewNombre').val('');
				$('#selNewDGA').html('');
				$('#btnAdd').prop('disabled', true);
				//status
				state = 'LISTO_ERROR_MATRICULA';
			},
			changeStateToListoDgaNoValido: function(nombreCompleto){
				//mensajes
				$('#divMsgMatriculaYaEnLista').hide();
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMsgMatriculaSinDga').show();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').hide();
				//campos
				//se deja el campo de nueva matricula tal cual
				$('#txtNewNombre').val(nombreCompleto);
				$('#selNewDGA').html('');
				$('#btnAdd').prop('disabled', true);
				//status
				state = 'LISTO_DGA_NO_VALIDO';
			},
			changeStateToProcesando: function(){
				//mensajes
				$('#divMsgMatriculaYaEnLista').hide();
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMsgMatriculaSinDga').hide();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').show();
				
				state = 'PROCESANDO';
			},
			changeStateToListoAgregar: function(apoderadoConDgas){
				//mensajes
				$('#divMsgMatriculaYaEnLista').hide();
				$('#divMsgMatriculaNoEncontrada').hide();
				$('#divMsgMatriculaSinDga').hide();
				$('#divMsgAlMenosUnApoderado').hide();
				$('#divMsgProcesandoApoderado').hide();
				
				$('#txtNewNombre').val(apoderadoConDgas.get('nombreCompleto'));
				$('#selNewDGA').html('');


				var dgas = apoderadoConDgas.get('autorizacionesCNBV');

				
				dgas.forEach(function(model){ 
					$('#selNewDGA').append($("<option></option>").attr("value",model.idAutorizadoCNBV).text(model.claveDga));
				});

				$('#btnAdd').prop('disabled', false);
				
				state = 'LISTO_PARA_AGREGAR';
			},
			
			//agregarApoderado: LISTOAGREGAR -> LISTO
			agregarApoderado: function(e) {
				e.preventDefault();

				//captura los datos del formulario
				var newMatricula = $('#txtNewMatricula').val();
				var newNombre = $('#txtNewNombre').val();
				var newIdAutorizado = $('#selNewDGA').val();
				var newDga = $('#selNewDGA option:selected').text();
				var apoderado = new apoderadosWidget.Apoderado( { matricula: newMatricula, nombreCompleto: newNombre, idAutorizadoCNBV: newIdAutorizado, claveDga: newDga } );

				this.collection.add(apoderado);

				//cambia a estado de "listo"
				this.changeStateToListo();
			},

			buscarPorMatricula: function(e) {
				e.preventDefault();

				var newMatricula = $.trim($('#txtNewMatricula').val());
				var yaExisteMatricula = false;
				
				if( newMatricula == '' )
				{
					//cambia a estado de "listo"
					this.changeStateToListo();
				}
				else
				{
					this.collection.forEach( function(model){
						if(model.get('matricula') == newMatricula)
							yaExisteMatricula = true
					} );
					
					if(yaExisteMatricula == true)
						this.changeStateToListoYaHayMatricula();
					else
					{
						var ApoderadoResponse = Backbone.Model.extend({urlRoot : '<g:createLink action="obtenerDatosMatriculaDgaValido"/>'});
						var apoderadoResponse = new ApoderadoResponse({id: newMatricula});
						var currentView = this;

						apoderadoResponse.fetch({
						    success: function(){
	
						    	//if(apoderadoResponse.get('autorizacionesCNBV'))
						    	if(apoderadoResponse.get('numeroMatricula') == -1)
						    	{
						    		currentView.changeStateToListoErrorMatricula();
						    	}
						    	else if(apoderadoResponse.get('autorizacionesCNBV').length == 0)
							    {
							    	currentView.changeStateToListoDgaNoValido( apoderadoResponse.get('nombreCompleto') );
							    }
							    else
							    {
							    	currentView.changeStateToListoAgregar( apoderadoResponse );
							    }
						    }
						});
	
						this.changeStateToProcesando();
					}
				}
				
			}
		});

		$(function(){
			/*var apoderatosTest = [
				{ matricula: 1, nombreCompleto: 'PETRONILA PEREZ', dga: 'DGA-XXXX'},
				{ matricula: 2, nombreCompleto: 'AZUL GARCIA', dga: 'DGA-XXXX'},
				{ matricula: 3, nombreCompleto: 'JOHN DOE', dga: 'DGA-XXXX'},
    		];*/

    		new apoderadosWidget.ApoderadosView(apoderatosTest);
		});
		
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE APODERADOS -->
	</body>
</html>
