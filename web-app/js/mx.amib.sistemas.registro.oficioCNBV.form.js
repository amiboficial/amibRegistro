		var _isAdmin = $("#hdnIsAdmin").val();
		
		//limpia mensajes de validación
		function cleanValidationMsgs(){
			$("#divMsgErrorEnCampos").hide();
			$("#divMsgErrorServidor").hide();
			
			$('#divMsgAlMenosUnAutorizado').hide();
			
			$('#divClaveDga').removeClass( 'has-error' );
			$('#divFechaFinVigencia').removeClass( 'has-error' );
		}
		
		//callback al boton para submitear
		$( "#btnSubmit" ).click(function() {
			$( "#frmApp" ).submit();
		});
		
		//campos que requieren reset al hacer "back" con el navegador
		$(window).bind("pageshow", function() {
			var loadedCount = $("#hdnAutorizadosWidgetLoadedCount").val();
			if(loadedCount == ""){
				$("#hdnAutorizadosWidgetCount").val(0);
			}
			else{
				$("#hdnAutorizadosWidgetCount").val(loadedCount);
			}
		});
		
		//callback para submit
		$('#frmApp').submit( function(event){	
			//validaciones "cliente"
			//de igual manera se valida el servicio
			//por si "algun listo" altera el DOM...
			var valid = true;
			var errorMsg = [];
			
			cleanValidationMsgs();
			
			if($.trim($('#txtClaveDga').val()) == ''){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Clave DGA' });
				$('#divClaveDga').addClass( 'has-error' );
				valid = false;
			}
			
			if($('#oficioCNBV\\.fechaFinVigencia_day').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de fin de vigencia (día)' });
				$('#divFechaFinVigencia').addClass( 'has-error' );
				valid = false;
			}
			if($('#oficioCNBV\\.fechaFinVigencia_month').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de fin de vigencia (mes)' });
				$('#divFechaFinVigencia').addClass( 'has-error' );
				valid = false;
			}
			if($('#oficioCNBV\\.fechaFinVigencia_year').val() == 'null'){
				errorMsg.push({ errName: 'Campo requerido', errField: 'Fecha de fin de vigencia (año)' });
				$('#divFechaFinVigencia').addClass( 'has-error' );
				valid = false;
			}
			
			if( parseInt($('#hdnAutorizadosWidgetCount').val()) <= 0 ){
				errorMsg.push({ errName: 'Datos requeridos', errField: 'Autorizados' });
				$('#divMsgAlMenosUnAutorizado').show();
				valid = false;
			}
			
			if(valid == false)
			{
				$('#divMsgErrorEnCampos').show();
				event.preventDefault();
				
				$('form').animate({ scrollTop: 0 }, 'fast');
				$('html, body').animate({
				   'scrollTop':   $('#anchorForm').offset().top - 150
				 }, 'fast');
			}

		});
		
		//fixes a ejecutarse al inicio
		$(function(){
			cleanValidationMsgs();
			$('#oficioCNBV\\.fechaFinVigencia_day').addClass( 'form-control' );
			$('#oficioCNBV\\.fechaFinVigencia_month').addClass( 'form-control' );
			$('#oficioCNBV\\.fechaFinVigencia_year').addClass( 'form-control' );
			$('#oficioCNBV\\.fechaFinVigencia_day').addClass( 'col-md-4' );
			$('#oficioCNBV\\.fechaFinVigencia_month').addClass( 'col-md-4' );
			$('#oficioCNBV\\.fechaFinVigencia_year').addClass( 'col-md-4' );
			$('#oficioCNBV\\.fechaFinVigencia_day').css( 'width', '25%' );
			$('#oficioCNBV\\.fechaFinVigencia_month').css( 'width', '40%' );
			$('#oficioCNBV\\.fechaFinVigencia_year').css( 'width', '35%' );
		});