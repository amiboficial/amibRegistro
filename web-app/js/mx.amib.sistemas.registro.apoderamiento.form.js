		
		var _isAdmin = $("#hdnIsAdmin").val();
		
		//limpia mensajes de validación
		function cleanValidationMsgs(){
			$('#divMsgErrorEnCampos').hide();
			$('#divMsgErrorServidor').hide();
			
			$('#divRepLegalNom').removeClass( 'has-error' );
			$('#divAp1').removeClass( 'has-error' );
			$('#divAp2').removeClass( 'has-error' );
			$('#divPdrNumEscrit').removeClass( 'has-error' );
			$('#divFhApod').removeClass( 'has-error' );
			$('#divNumNotario').removeClass( 'has-error' );
			$('#divNotarioEntidadFederativa').removeClass( 'has-error' );
			
			$('#divMsgAlMenosUnApoderado').hide();
			$('#divMsgDocRequeridos').hide();
			
			if(_isAdmin == "true"){
				$('#divAdmGrupoFinanciero').removeClass( 'has-error' );
			}
			
		}
		
		//callback al boton para submitear
		$( "#btnSubmit" ).click(function() {
			$( "#frmApp" ).submit();
		});
		
		//campos que requieren reset al hacer "back" con el navegador
		$(window).bind("pageshow", function() {
			var _isAdmin = $("#hdnIsAdmin").val();
		
			$('#hdnCountApoderados').val( $('#hdnCountApoderadosLoaded').val() );
			$('#hdnDocumentosCompletados').val( $('#hdnDocumentosCompletadosLoaded').val() );
			
			$('#txtNumNotario').trigger('blur');
		});
		
		//callback para submit
		$('#frmApp').submit( function(event){			
			//validaciones "cliente"
			//de igual manera se valida el servicio
			//por si "algun listo" altera el DOM...
			var valid = true;
			var errorMsg = [];
			
			//oculta mensajes de validación
			cleanValidationMsgs();
			
			if($.trim($('#txtRepLegalNom').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Nombre (Representante Legal)' });
				$('#divRepLegalNom').addClass( 'has-error' );
				valid = false;
			}
			if($.trim($('#txtAp1').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Primer Apellido (Representante Legal)' });
				$('#divAp1').addClass( 'has-error' );
				valid = false;
			}
			if($.trim($('#txtAp2').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Segundo Apellido (Representante Legal)' });
				$('#divAp2').addClass( 'has-error' );
				valid = false;
			}
			if($.trim($('#txtPdrNumEscrit').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Numero de escritura' });
				$('#divPdrNumEscrit').addClass( 'has-error' );
				valid = false;
			}
			if( isNaN($.trim($('#txtPdrNumEscrit').val())) == true ){
				errorMsg.push({ errName: 'Formato incorrecto, debe ser numérico entero', errField: 'Numero de escritura' });
				$('#divPdrNumEscrit').addClass( 'has-error' );
				valid = false;
			}
			if($('#poder\\.fechaApoderamiento_day').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (día)' });
				$('#divFhApod').addClass( 'has-error' );
				valid = false;
			}
			if($('#poder\\.fechaApoderamiento_month').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (mes)' });
				$('#divFhApod').addClass( 'has-error' );
				valid = false;
			}
			if($('#poder\\.fechaApoderamiento_year').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (año)' });
				$('#divFhApod').addClass( 'has-error' );
				valid = false;
			}
			
			if($.trim($('#txtNumNotario').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Número del notario' });
				$('#divNumNotario').addClass( 'has-error' );
				valid = false;
			}
			if(isNaN($.trim($('#txtNumNotario').val())) == true){
				errorMsg.push({ errName: 'Formato incorrecto, debe ser numérico entero', errField: 'Número del notario' });
				$('#divNumNotario').addClass( 'has-error' );
				valid = false;
			}
			
			if($('#selNotarioEntidadFederativa').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Entidad federativa del notario' });
				$('#divNotarioEntidadFederativa').addClass( 'has-error' );
				valid = false;
			}
			
			if( ($.trim($('#txtNombreCompletoNotario').val())) == '' ){
				errorMsg.push({ errName: 'Dato requerido', errField: 'Información del notario' });
				$('#divNumNotario').addClass( 'has-error' );
				$('#divNotarioEntidadFederativa').addClass( 'has-error' );
				valid = false;
			}
			
			if( $('#hdnCountApoderados').val() == 0 ){
				errorMsg.push({ errName: 'Datos requeridos', errField: 'Apoderados' });
				$('#divMsgAlMenosUnApoderado').show();
				valid = false;
			}
			
			if( $('#hdnDocumentosCompletados').val() == 'false' ){
				errorMsg.push({ errName: 'Faltan documentos', errField: 'Documentos' });
				$('#divMsgDocRequeridos').show();
				valid = false;
			}
			
			if(_isAdmin == "true"){
				if($("#selAdmIdGrupoFinanciero").val() == "-1"){
					errorMsg.push({ errName: 'Dato requerido', errField: 'Grupo Financiero' });
					$('#divAdmGrupoFinanciero').addClass( 'has-error' );
				}
			}
			//alert(JSON.stringify(errorMsg));
			
			if(valid == false)
			{
				$('#divMsgErrorEnCampos').show();
				event.preventDefault();
				
				/*$('form').animate({ scrollTop: 0 }, 'fast');*/
				$('html, body').animate({
				   'scrollTop':   $('#anchorForm').offset().top - 150
				 }, 'fast');
			}
			else
			{
				console.log('TODO ES VALIDO');
				//event.preventDefault();
			}
		});
		
		//fixes a ejecutarse al inicio
		$(function(){
			cleanValidationMsgs();
			$('#poder\\.fechaApoderamiento_day').addClass( 'form-control' );
			$('#poder\\.fechaApoderamiento_month').addClass( 'form-control' );
			$('#poder\\.fechaApoderamiento_year').addClass( 'form-control' );
			$('#poder\\.fechaApoderamiento_day').addClass( 'col-md-4' );
			$('#poder\\.fechaApoderamiento_month').addClass( 'col-md-4' );
			$('#poder\\.fechaApoderamiento_year').addClass( 'col-md-4' );
			$('#poder\\.fechaApoderamiento_day').css( 'width', '25%' );
			$('#poder\\.fechaApoderamiento_month').css( 'width', '40%' );
			$('#poder\\.fechaApoderamiento_year').css( 'width', '35%' );
		});
		