		
		var _action = $("#hdnAction").val();
		
		//limpia mensajes de validación
		function cleanValidationMsgs(){
			$('#divMsgErrorEnCampos').hide();
			$('#divMsgErrorServidor').hide();
			
			$('#divRepLegalNom').removeClass( 'has-error' );
			$('#divAp1').removeClass( 'has-error' );
			$('#divAp2').removeClass( 'has-error' );
			$('#divRevNumEscrit').removeClass( 'has-error' );
			$('#divFhRev').removeClass( 'has-error' );
			
			$('#divNumNotario').removeClass( 'has-error' );
			$('#divNotarioEntidadFederativa').removeClass( 'has-error' );
			
			$('#divMsgRevAlMenosUno').hide();
			$('#divMsgRevEditando').hide();
			
			$('#divDocsCompletos').hide();
			
			if(_action == "create" || _action == "edit" || _action == "editVerify" ){
				$('#divAdmGrupoFinanciero').removeClass( 'has-error' );
			}
			
		}
		
		//callback al boton para submitear
		$( "#btnSubmit" ).click(function() {
			$( "#frmApp" ).submit();
		});
		
		//campos que requieren reset al hacer "back" con el navegador
		$(window).bind("pageshow", function() {
			var _action = $("#hdnAction").val();
			
			$('#hdnDocsModelValidated').val( $('#hdnDocsModelValidatedLoaded').val() );
			$('#hdnDocsIsBusy').val("false");
			
			$('#hdnRevocadosWidgetCount').val( $('#hdnRevocadosWidgetLoadedCount').val() );
			$('#hdnRevocadosWidgetBusyCount').val("0");
			
			$('#txtNumNotario').trigger('blur');
		});
		
		//callback para submit
		$('#frmApp').submit( function(event){	
			
			//validaciones "cliente"
			//de igual manera se valida el servicio
			//por si "algun listo" altera el DOM...
			var valid = true;
			var errorMsg = [];
			
			//alert("NOT YET IMPLEMENTED");
			//event.preventDefault();
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
			
			if($.trim($('#txtRevNumEscrit').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Numero de escritura' });
				$('#divRevNumEscrit').addClass( 'has-error' );
				valid = false;
			}
			if( isNaN($.trim($('#txtRevNumEscrit').val())) == true ){
				errorMsg.push({ errName: 'Formato incorrecto, debe ser numérico entero', errField: 'Numero de escritura' });
				$('#divRevNumEscrit').addClass( 'has-error' );
				valid = false;
			}
			
			if($('#revocacion\\.fechaRevocacion_day').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (día)' });
				$('#divFhRev').addClass( 'has-error' );
				valid = false;
			}
			if($('#revocacion\\.fechaRevocacion_month').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (mes)' });
				$('#divFhRev').addClass( 'has-error' );
				valid = false;
			}
			if($('#revocacion\\.fechaRevocacion_year').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de apoderamiento (año)' });
				$('#divFhRev').addClass( 'has-error' );
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
			
			if( $('#hdnRevocadosWidgetCount').val() == 0 ){
				errorMsg.push({ errName: 'Datos requeridos', errField: 'Apoderados' });
				$('#divMsgRevAlMenosUno').show();
				valid = false;
			}
			
			if( parseInt($('#hdnRevocadosWidgetBusyCount').val()) > 0 ){
				errorMsg.push({ errName: 'Datos aún editandose', errField: 'Apoderados' });
				$('#divMsgRevEditando').show();
				valid = false;
			}
			
			if( $('#hdnDocsModelValidated').val() == 'false' ){
				errorMsg.push({ errName: 'Faltan documentos', errField: 'Documentos' });
				$('#divDocsCompletos').show();
				valid = false;
			}
			
			if(_action == "create" || _action == "edit" || _action == "editVerify"){
				if($("#selAdmIdGrupoFinanciero").val() == "-1"){
					errorMsg.push({ errName: 'Dato requerido', errField: 'Grupo Financiero' });
					$('#divAdmGrupoFinanciero').addClass( 'has-error' );
					valid = false;
				}
			}

			//alert(JSON.stringify(errorMsg));  ""
			
			if(valid == false)
			{
				$('#divMsgErrorEnCampos').show();
				event.preventDefault();
				
				$('form').animate({ scrollTop: 0 }, 'fast');
				$('html, body').animate({
				   'scrollTop':   $('#anchorForm').offset().top - 150
				 }, 'fast');
			}
			/*else
			{
				console.log('TODO ES VALIDO');
				event.preventDefault();
			}*/
		});
		
		//fixes a ejecutarse al inicio
		$(function(){
			cleanValidationMsgs();
			$('#revocacion\\.fechaRevocacion_day').addClass( 'form-control' );
			$('#revocacion\\.fechaRevocacion_month').addClass( 'form-control' );
			$('#revocacion\\.fechaRevocacion_year').addClass( 'form-control' );
			$('#revocacion\\.fechaRevocacion_day').addClass( 'col-md-4' );
			$('#revocacion\\.fechaRevocacion_month').addClass( 'col-md-4' );
			$('#revocacion\\.fechaRevocacion_year').addClass( 'col-md-4' );
			$('#revocacion\\.fechaRevocacion_day').css( 'width', '25%' );
			$('#revocacion\\.fechaRevocacion_month').css( 'width', '40%' );
			$('#revocacion\\.fechaRevocacion_year').css( 'width', '35%' );
		});
		