
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
		docsWidget.MSG_ERROR_TAM_MAYOR = 'El archivo supera el tama�o permitido';
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
				uuid: ''
			}
		});
		
		docsWidget.Documentos = Backbone.Collection.extend({
			model: docsWidget.Documento
		});
		
		docsWidget.DocumentoView = Backbone.View.extend({
			state: docsWidget.LISTO, //LISTO, PROCESANDO
			tagName: 'tr',
			className: 'documentoRow',
			uploadUrl: '',
			downloadTmpUrl: '',
			downloadUrl: '',
			
			//template: _.template( $('#documentoTemplate').html() ),
			templateListoSinArchivo: _.template( $('#documentoTemplate_listoSinArchivo').html() ),
			templateListoPrecargado: _.template( $('#documentoTemplate_listoPrecargado').html() ),
			templateListoCargado: _.template( $('#documentoTemplate_listoCargado').html() ),
			templateProcesando: _.template( $('#documentoTemplate_procesando').html() ),
			
			render : function() {
				console.log("AL RENDEREAR" + this.uploadUrl)
			
				if( this.state == docsWidget.LISTO ){
					if( this.model.get('status') == docsWidget.SIN_ARCHIVO ){
						this.$el.html( this.templateListoSinArchivo( this.model.toJSON() ) );
					}
					else if ( this.model.get('status') == docsWidget.CARGADO ){
						this.$el.html( this.templateListoCargado( this.model.toJSON() ) );
					}
					else if ( this.model.get('status') == docsWidget.PRECARGADO ){
						this.$el.html( this.templateListoPrecargado( this.model.toJSON() ) );
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
				'click .downloadTmp':'descargarDocumentoTmp',
				'click .download':'descargarDocumento',
				'change .upload':'subirDocumento'
			},
			
			//importante cambiar el estado con estos m�todos
			changeStateToListo: function(){
				this.state = docsWidget.LISTO;
				this.render();
			},
			changeStateToProcesando: function(){
				this.state = docsWidget.PROCESANDO;
				this.render();
			},
			
			descargarDocumentoTmp: function(){
				//alert("DESCARGAR PRECARGADO - No implementado");
				//window.open('http://www.mydomain.com?ReportID=1', '_blank');
				var _url = this.downloadTmpUrl + '?uuid=' + this.model.get('uuid');
				
				window.open(_url);
			},
			
			descargarDocumento: function(){
				var _url = this.downloadUrl + '?uuid=' + this.model.get('uuid');
				window.open(_url);
			},
			
			subirDocumento: function(){
				var contexto = this;
				var idTipoDoc = this.model.get('idTipoDocumento');
				var uuidAnterior = this.model.get('uuid');
				
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
								{uuid: respuestaJson.uuid, 
								 nombreDocumento: respuestaJson.filename,
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
						formData.append("uuidAnterior", uuidAnterior);
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
			uploadUrl: '',
			downloadTmpUrl: '',
			downloadUrl: '',
			
			initialize: function( initialDocumentos,uploadUrl,downloadUrl,downloadTmpUrl ){
				this.uploadUrl = uploadUrl;
				this.downloadUrl = downloadUrl;
				this.downloadTmpUrl = downloadTmpUrl;
				this.collection = new apoderadosWidget.Apoderados(initialDocumentos);
				this.render();
				this.listenTo( this.collection, "change", this.renderHiddenData );
			},
			
			render: function() {
				this.collection.each( function(item){
					this.renderDocumento(item);
				},this );
				//this.changeStateToListo();
			},
			renderHiddenData: function() {
				var valid = true;
				
				this.collection.each( function(item){
					if( item.get('status') == docsWidget.SIN_ARCHIVO ){
						
						valid = false;
					}
				}, this );
				
				$('#hdnDocumentosCompletados').val(valid);
			},
			
			renderDocumento: function(item){
				console.log("AL CREAR LA VISTA DE COL." + this.uploadUrl)
				var documentoView = new docsWidget.DocumentoView({model:item});
				documentoView.uploadUrl = this.uploadUrl;
				documentoView.downloadTmpUrl = this.downloadTmpUrl;
				documentoView.downloadUrl = this.downloadUrl;
				this.$el.append( documentoView.render().el );
			},
			
		});
		