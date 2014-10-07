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
	
		<form id="frmApp" class="form-horizontal" role="form">

			<div id="divMsgErrorEnCampos" class="alert alert-danger">
				<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
			</div>
			
			<div id="divMsgErrorServidor" class="alert alert-danger">
				Mensajes de error de servidor.
			</div>
		
			<fieldset>
				<legend>Datos del representante legal</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalNombre.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField id="txtRepLegalNom" maxlength="100" class="form-control" name="representanteLegalNombre" required="" value="${poderInstance?.representanteLegalNombre}" />
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField id="txtAp1" maxlength="80" class="form-control" name="representanteLegalApellido1" required="" value="${poderInstance?.representanteLegalApellido1}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-3 col-sm-3">
		            	<g:textField id="txtAp2" maxlength="80" class="form-control" name="representanteLegalApellido2" required="" value="${poderInstance?.representanteLegalApellido2}" />
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
		            	<g:textField class="form-control" name="nombreGrupoFinancieroOrInstituto" required="" value="${entidadFinancieraInstance?.nombre}" disabled="disabled"/>
		            </div>
				</div>
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del poder</legend>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.numeroEscritura.label" default="Numero de escritura" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-2 col-sm-2">
		            	<g:textField id="txtPdrNumEscrit" maxlength="10" class="form-control" name="numeroEscritura" required="" value="${poderInstance?.numeroEscritura}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-4 col-sm-4">
						<g:datePicker name="fechaApoderamiento" value="${poderInstance?.fechaApoderamiento}" default="noSelection" noSelection="${['null':'-Seleccione-']}" precision="day" relativeYears="${-10..0}"/>
		            </div>
				</div>
				
			</fieldset>
	
	
			<fieldset>
				<legend>Datos del notario</legend>

					<div id="divMsgProcesandoNotario" class="alert alert-info">
						<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
					</div>
					<div id="divMsgErrorProcesandoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Ha habído un error al procesar la petición.
					</div>
					<div id="divMsgNoEncontradoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> No se encontraron datos de notario.
					</div>
					<div id="divMsgDatoNoValidoNotario" class="alert alert-danger">
						<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos, introduzca únicamente números.
					</div>
				
				<div id="divNotario" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.numero.label" default="Número" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-2 col-sm-2">
		            	<g:textField id="txtNumNotario" maxlength="10" class="form-control" name="auxparam.numeroNotario" required="" value="${poderInstance?.notario?.numeroNotario}" />
		            </div>
		            <label class="col-md-3 col-sm-3 control-label">
		            	<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa" /><span class="required-indicator">*</span>						
					</label>
		            <div class="col-md-4 col-sm-4">
						<g:select id="selNotarioEntidadFederativa" class="form-control" name='auxparam.notarioIdEntidadFederativa' value="${poderInstance?.notario?.idEntidadFederativa}"
							noSelection="${['null':'-Seleccione-']}"
							from='${entidadFederativaList}'
							optionKey="id" optionValue="nombre"></g:select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="poder.notario.nombreCompletro.label" default="Nombre" /><span class="required-indicator">*</span>
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<g:textField id="nombreCompletoNotario" class="form-control" name="auxparam.nombreCompletoNotario" required="" disabled="disabled" />
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
								
				<table class="table">
						<thead>
							<tr>
								<th style='width:32%;'>Tipo de documento</th>
								<th>Nombre de archivo</th>
								<th style='width:18%'>...</th>
							</tr>
						</thead>
						<tbody id="tbdyDocs">

						</tbody>
				</table>
			</fieldset>
			
			<div class="form-group">
				<div class="col-lg-offset-5 col-md-offset-5 col-md-2 col-sm-2">
					<button id="btnSubmit" type="button" class="btn btn-primary btn-lg btn-block">Aceptar</button>
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
    		var apoderatosTest = []
    		
    		new apoderadosWidget.ApoderadosView(apoderatosTest);
		});
		
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE APODERADOS -->
		
		<!-- INICIA: TEMPLATES UNDERSCORE PARA COMPONENTE DE DOCUMENTOS -->
		
		<script type="text/template" id="documentoTemplate_listoSinArchivo">
			<td>{{=tipoDocumento}}</td>
			<td>(Pendiente)</td>
			<td>
				<div style="float:left; margin-right:3px;">
					<input type="file" style="width: 96px;" class="upload invisibleFileUpload btn btn-info btn-xs" name="archivo" id="archivo_{{=idTipoDocumento}}">
					<button type="button" class="btn btn-info btn-xs">Cargar archivo</button>
				</div>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_listoPrecargado">
			<td>{{=tipoDocumento}}</td>
			<td>{{=nombreDocumento}}</td>
			<td>
				<button type="button" class="downloadPre btn btn-info btn-xs">Descargar</button>&nbsp;
				<div style="float:left; margin-right:3px;">
					<input type="file" style="width: 136px;" class="upload invisibleFileUpload btn btn-info btn-xs" name="archivo" id="archivo_{{=idTipoDocumento}}">
					<button type="button" class="btn btn-info btn-xs">Cargar nuevo archivo</button>
				</div>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_listoCargado">
			<td>{{=tipoDocumento}}</td>
			<td>{{=nombreDocumento}}</td>
			<td>
				<button type="button" class="download btn btn-info btn-xs">Descargar</button>&nbsp;<button type="button" class="upload btn btn-info btn-xs">Cargar nuevo archivo</button>
				<br/>
				<div class="msgErrorTamMayor alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El tamaño de archivo rebasa los <strong>5</strong>MB.
				</div>
				<div class="msgErrorTipo alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> El formato de archivo no es compatible.
				</div>
				<div class="msgError alert alert-small alert-danger">
					<span class="glyphicon glyphicon-ban-circle"></span> Error desconocido.
				</div>
			</td>
		</script>
		<script type="text/template" id="documentoTemplate_procesando">
			<td>{{=tipoDocumento}}</td>
			<td>...</td>
			<td><asset:image src="spinner_alert_info.gif"/> Procesando</td>
		</script>
		<!-- FIN: TEMPLATES UNDERSCORE PARA COMPONENTE DE DOCUMENTOS -->
		
		<!-- INICIA: SCRIPT PARA COMPONENTE DE DOCUMENTOS -->
		<script type="text/javascript">
		
		var docsWidget = docsWidget || {};

		docsWidget.LISTO = 0;
		docsWidget.PROCESANDO = 1;
		
		docsWidget.SIN_ARCHIVO = 0;
		docsWidget.CARGADO = 1;
		docsWidget.PRECARGADO = 2; 
		
		docsWidget.NOERROR = 0;
		docsWidget.ERROR = 1;
		docsWidget.ERROR_TAM_MAYOR = 2;
		docsWidget.ERROR_TIPO = 3;
		
		docsWidget.MSG_ERROR = 'Error al subir archivo';
		docsWidget.MSG_ERROR_TAM_MAYOR = 'El archivo supera el tamaño permitido';
		docsWidget.MSG_ERROR_TIPO = 'El formato del archivo no es compatible';
		
		docsWidget.Documento = Backbone.Model.extend({
			defaults: {
				id: -1,
				
				idTipoDocumento: -1,
				tipoDocumento: '(Tipo Documento)',
				
				nombreDocumento: '(Nombre Documento)',
				claveDocumento: '',
				mimeType: '',
				
				lastErrors: [],
				status: docsWidget.SIN_ARCHIVO,
				uuidTemp: ''
			}
		});
		
		docsWidget.Documentos = Backbone.Collection.extend({
			model: docsWidget.Documento
		});
		
		docsWidget.DocumentoView = Backbone.View.extend({
			state: docsWidget.LISTO, //LISTO, PROCESANDO
			tagName: 'tr',
			className: 'documentoRow',
			uploadUrl: '<g:createLink action="subirArchivo"/>',
			
			//template: _.template( $('#documentoTemplate').html() ),
			templateListoSinArchivo: _.template( $('#documentoTemplate_listoSinArchivo').html() ),
			templateListoPrecargado: _.template( $('#documentoTemplate_listoPrecargado').html() ),
			templateListoCargado: _.template( $('#documentoTemplate_listoCargado').html() ),
			templateProcesando: _.template( $('#documentoTemplate_procesando').html() ),
			
			render : function() {
				if( this.state == docsWidget.LISTO ){
					if( this.model.get('status') == docsWidget.SIN_ARCHIVO ){
						this.$el.html( this.templateListoSinArchivo( this.model.toJSON() ) );
					}
					else if ( this.model.get('status') == docsWidget.CARGADO ){
						this.$el.html( this.templateListoPrecargado( this.model.toJSON() ) );
					}
					else if ( this.model.get('status') == docsWidget.PRECARGADO ){
						this.$el.html( this.templateListoCargado( this.model.toJSON() ) );
					}
					
					//mensajes de error
					
					this.$('.msgErrorTamMayor').hide();
					this.$('.msgErrorTipo').hide();
					this.$('.msgError').hide();
					this.model.get('lastErrors').forEach(function(errstatus){
						if(errstatus == docsWidget.ERROR_TAM_MAYOR)
							this.$('.msgErrorTamMayor').show();
						else if(errstatus == docsWidget.ERROR_TIPO)
							this.$('.msgErrorTipo').show();
						else 
							this.$('.msgError').show();
					}, this );

				}
				else if( this.state == docsWidget.PROCESANDO ){ 
					
					this.$el.html( this.templateProcesando( this.model.toJSON() ) );
				}
				
				return this;
			},
			
			events:{
				'click .downloadPre':'descargarDocumentoPrecargado',
				'click .download':'descargarDocumento',
				'change .upload':'subirDocumento'
			},
			
			//importante cambiar el estado con estos métodos
			changeStateToListo: function(){
				this.state = docsWidget.LISTO;
				this.render();
			},
			changeStateToProcesando: function(){
				this.state = docsWidget.PROCESANDO;
				this.render();
			},
			
			descargarDocumentoPrecargado: function(){
				alert("DESCARGAR PRECARGADO - No implementado");
			},
			
			descargarDocumento: function(){
				alert("DESCARGAR - No implementado");
			},
			
			subirDocumento: function(){
				var contexto = this;
				var idTipoDoc = this.model.get('idTipoDocumento');
				
				var file = document.getElementById('archivo_'+idTipoDoc).files[0];
				var xhr = new XMLHttpRequest();
				
				
				if (xhr.upload) {
				
					xhr.addEventListener('readystatechange', function(evnt){ 
						if(xhr.readyState == 4 && xhr.status != 200 )
						{
							contexto.model.set('{lastErrors:[]}');
							contexto.model.get('lastErrors').push(docsWidget.ERROR);
							contexto.changeStateToListo();
						}
						else if(xhr.readyState == 4 && xhr.status == 200)
						{
							var respuestaJson = JSON.parse(xhr.responseText);
							//alert(JSON.stringify(respuestaJson));
							
							contexto.model.set(
								{uuidTemp: respuestaJson.uuidTemp, 
								 nombreDocumento: respuestaJson.nombreDocumento,
								 mimeType: respuestaJson.mimeType,
								 status: docsWidget.CARGADO}
							);
							
							contexto.changeStateToListo();
						}
							
					}, false);
				
					xhr.open('POST', this.uploadUrl, true);
					
					try
					{
						var formData = new FormData();
						formData.append("archivo", file);
						formData.append("idTipoDocumento", idTipoDoc);
						xhr.send(formData);
						
						this.changeStateToProcesando();
					}
					catch(err)
					{
						alert(err);
						
						this.model.set('{lastErrors:[]}');
						this.model.get('lastErrors').push(docsWidget.ERROR);
						this.changeStateToListo();
					}
				
				}
			},
			
			recibirRespuestaSubirDocumento: function(){
				this.changeStateToListo();
			},
			
			simulaError: function(){
				this.model.set('{lastErrors:[]}');
				this.model.get('lastErrors').push(docsWidget.ERROR_TAM_MAYOR);
				this.changeStateToListo();
			}
		});
		
		docsWidget.DocumentosView = Backbone.View.extend({
			
			el: '#tbdyDocs',
			
			initialize: function( initialDocumentos ){
				this.collection = new apoderadosWidget.Apoderados(initialDocumentos);
				this.render();
				this.listenTo( this.collection, 'add', this.renderApoderado );
			},
			
			render: function() {
				this.collection.each( function(item){
					this.renderDocumento(item);
				},this );
				//this.changeStateToListo();
			},
			
			renderDocumento: function(item){
				var documentoView = new docsWidget.DocumentoView({model:item});
				this.$el.append( documentoView.render().el );
			},
			
		});
		
		$(function(){
			/*var apoderatosTest = [
				{ matricula: 1, nombreCompleto: 'PETRONILA PEREZ', dga: 'DGA-XXXX'},
				{ matricula: 2, nombreCompleto: 'AZUL GARCIA', dga: 'DGA-XXXX'},
				{ matricula: 3, nombreCompleto: 'JOHN DOE', dga: 'DGA-XXXX'},
    		];*/
			
			var docsTest = [<g:each in="${tipoDocumentoList}">
								{id: -${it.id},idTipoDocumento: ${it.id}, tipoDocumento: '${it.descripcion}', nombreDocumento: '', status: docsWidget.SIN_ARCHIVO, lastErrors: [] },
							</g:each>]
    		new docsWidget.DocumentosView(docsTest);
		});
		
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE DOCUMENTOS -->
		
		<!-- INICIO: SCRIPT PARA COMPONENTE DE NOTARIO -->
		<script type="text/javascript">
		
		var notarioWidget = notarioWidget || {};
		
		notarioWidget.LISTO = 0;
		notarioWidget.PROCESANDO = 1;
		
		notarioWidget.ERROR = 0;
		notarioWidget.ERROR_NOT_FOUND = 1;
		notarioWidget.ERROR_NOT_VALID_INPUT = 2;
		
		notarioWidget.NotarioView = Backbone.View.extend({
			el: "#divNotario",
			errors: [],
			state: notarioWidget.LISTO,
			ajaxUrl: '<g:createLink action="obtenerNombreNotario"/>',
			
			initialize: function(){
				this.render();
				$('#divMsgProcesandoNotario').hide();
				$('#divMsgErrorProcesandoNotario').hide();
				$('#divMsgNoEncontradoNotario').hide();
				$('#divMsgDatoNoValidoNotario').hide();
			},
			
			render: function() {
				if(this.state == notarioWidget.PROCESANDO){
					$('#divMsgProcesandoNotario').show();
					$('#divMsgErrorProcesandoNotario').hide();
					$('#divMsgNoEncontradoNotario').hide();
					$('#divMsgDatoNoValidoNotario').hide();
				}
				else{
					$('#divMsgProcesandoNotario').hide();
					$('#divMsgErrorProcesandoNotario').hide();
					$('#divMsgNoEncontradoNotario').hide();
					$('#divMsgDatoNoValidoNotario').hide();
					
					if (_.size(this.errors) == 0)
					{
						$('#nombreCompletoNotario').val(this.model);
					}
					else
					{
						this.model = '';
						$('#nombreCompletoNotario').val('');
						_.each(this.errors, function(err){
							if(err == notarioWidget.ERROR){
								$('#divMsgErrorProcesandoNotario').show();
							}
							else if(err == notarioWidget.ERROR_NOT_FOUND){
								$('#divMsgNoEncontradoNotario').show();
							}
							else if(err == notarioWidget.ERROR_NOT_VALID_INPUT){
								$('#divMsgDatoNoValidoNotario').show();
							}
						}, this);
					}
				}
			},
			
			events:{
				'blur #txtNumNotario': 'buscarNotario',
				'change #selNotarioEntidadFederativa': 'buscarNotario',
			},
			
			buscarNotario: function(e) {
				e.preventDefault();
				
				var numNotario = $('#txtNumNotario').val();
				var idEntidadFed = $('#selNotarioEntidadFederativa').val();
				var _url = this.ajaxUrl + '?idEntidadFederativa=' + idEntidadFed + '&numeroNotario=' + numNotario;
				var contexto = this;
				this.errors = []
				
				//valida antes de enviar solicitud
				if( isNaN( $.trim(numNotario) ) )
				{
					contexto.errors.push(notarioWidget.ERROR_NOT_VALID_INPUT);
					contexto.changeStateToListo();
				}
				else if($.trim(numNotario) != '' && idEntidadFed != 'null')
				{
					$.ajax({
						dataType: "json",
						url: _url,
						//data: data,
						success: function( data ){
							if(data.status == "OK")
							{
								contexto.model = data.nombreCompleto;
								contexto.changeStateToListo();
							}
							else if(data.status == "NOT_FOUND")
							{
								contexto.errors.push(notarioWidget.ERROR_NOT_FOUND);
								contexto.changeStateToListo();
							}
							else if(data.status == "NOT_VALID_INPUT")
							{
								contexto.errors.push(notarioWidget.ERROR_NOT_VALID_INPUT);
								contexto.changeStateToListo();
							}
							else
							{
								contexto.errors.push(notarioWidget.ERROR);
								contexto.changeStateToListo();
							}
						}
					});
					this.changeStateToProcesando();
				}
				else
				{
					this.model = '';
					this.changeStateToListo();
				}
				//alert(numNotario + ' ' + idEntidadFed)
			},
			
			changeStateToListo: function(){
				this.state = notarioWidget.LISTO;
				this.render();
			},
			changeStateToProcesando: function(){
				this.state = notarioWidget.PROCESANDO;
				this.render();
			}
		});
		
		$(function(){
			new notarioWidget.NotarioView();
		});
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE NOTARIO -->
		
		<!-- INICIO: SCRIPT PARA VISTA -->
		<script type="text/javascript">
		
		$( "#btnSubmit" ).click(function() {
			$( "#frmApp" ).submit();
		});
		
		$('#frmApp').submit( function(event){			
			//validaciones
			var valid = true;
			var errorMsg = [];
			
			if($.trim($('#txtRepLegalNom').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Nombre (Representante Legal)' });
				valid = false;
			}
			if($.trim($('#txtAp1').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Primer Apellido (Representante Legal)' });
				valid = false;
			}
			if($.trim($('#txtAp2').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Segundo Apellido (Representante Legal)' });
				valid = false;
			}
			if($.trim($('#txtPdrNumEscrit').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Numero de escritura' });
				valid = false;
			}
			if( isNaN($.trim($('#txtPdrNumEscrit').val())) == true ){
				errorMsg.push({ errName: 'Formato incorrecto, debe ser numérico entero', errField: 'Numero de escritura' });
				valid = false;
			}
			if($('#fechaApoderamiento_day').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (día)' });
				valid = false;
			}
			if($('#fechaApoderamiento_month').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (mes)' });
				valid = false;
			}
			if($('#fechaApoderamiento_year').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (año)' });
				valid = false;
			}
			
			alert(JSON.stringify(errorMsg));
			
			if(valid == false)
				event.preventDefault();
		});
		
		$(function(){
			$('#divMsgErrorEnCampos').hide();
			$('divMsgErrorServidor').hide();
		});
		
		</script>
		<!-- FIN: SCRIPT PARA VISTA-->
		
		<!-- INICIO: CSS FIXES -->
		<script type="text/javascript">
			$('#fechaApoderamiento_day').addClass( 'form-control' );
			$('#fechaApoderamiento_month').addClass( 'form-control' );
			$('#fechaApoderamiento_year').addClass( 'form-control' );
			$('#fechaApoderamiento_day').addClass( 'col-md-4' );
			$('#fechaApoderamiento_month').addClass( 'col-md-4' );
			$('#fechaApoderamiento_year').addClass( 'col-md-4' );
			//$('#fechaApoderamiento_day').addClass( 'col-sm-4' );
			//$('#fechaApoderamiento_month').addClass( 'col-sm-4' );
			//$('#fechaApoderamiento_year').addClass( 'col-sm-4' );
			$('#fechaApoderamiento_day').css( 'width', '25%' );
			$('#fechaApoderamiento_month').css( 'width', '40%' );
			$('#fechaApoderamiento_year').css( 'width', '35%' );
		</script>
		<!-- FIN: CSS FIXES -->
	</body>
</html>
