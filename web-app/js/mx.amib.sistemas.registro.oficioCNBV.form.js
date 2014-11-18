		var _isAdmin = $("#hdnIsAdmin").val();
		
		//limpia mensajes de validación
		function cleanValidationMsgs(){
			$("#divMsgErrorEnCampos").hide();
			$("#divMsgErrorServidor").hide();
			
			$('#divMsgAlMenosUnAutorizado').hide();
		}
		
		//callback al boton para submitear
		$( "#btnSubmit" ).click(function() {
			$( "#frmApp" ).submit();
		});
		
		//campos que requieren reset al hacer "back" con el navegador
		$(window).bind("pageshow", function() {
			
		});
		
		//callback para submit
		$('#frmApp').submit( function(event){	
			alert('submit');
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