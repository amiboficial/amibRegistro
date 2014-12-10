<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="mx.amib.sistemas.registro.notario.model.Notario" %>

<script>

//funciones propias de la vista 
function cleanValidationMsgs(){
	$('#divMsgErrorEnCampos').hide();
	$('#divMsgErrorServidor').hide();

	$('#divNom').removeClass( 'has-error' );
	$('#divAp1').removeClass( 'has-error' );
	$('#divAp2').removeClass( 'has-error' );
	$('#divNumNotario').removeClass( 'has-error' );
	$('#divNotarioEntidadFederativa').removeClass( 'has-error' );
}

function trimFields(){
	$('#txtNom').val( $.trim($('#txtNom').val()) );
	$('#txtAp1').val( $.trim($('#txtAp1').val()) );
	$('#txtAp2').val( $.trim($('#txtAp2').val()) );
	$('#txtNumNotario').val( $.trim($('#txtNumNotario').val()) );
}

function validateInput(){
	var valid = true;
	
	var nombre = $('#txtNom').val();
	var apellido1 = $('#txtAp1').val();
	var apellido2 = $('#txtAp2').val();
	var notarioNumero = $('#txtNumNotario').val();
	var idEntidadFederativa = $('#selNotarioEntidadFederativa').val();

	var regExpNotarioNumero = new RegExp("^\\d+$", "i");
	
	if(nombre == ""){
		$('#divNom').addClass( 'has-error' );
		valid = false;
	}
	if(apellido1 == ""){
		$('#divAp1').addClass( 'has-error' );
		valid = false;
	}
	if(apellido2 == ""){
		$('#divAp2').addClass( 'has-error' );
		valid = false;
	}
	if(notarioNumero == "" || regExpNotarioNumero.test(notarioNumero) == false ){
		$('#divNumNotario').addClass( 'has-error' );
		valid = false;
	}
	if(idEntidadFederativa == "null"){
		$('#divNotarioEntidadFederativa').addClass( 'has-error' );
		valid = false;
	}

	if(!valid){
		$('#divMsgErrorEnCampos').show();
		$('form').animate({ scrollTop: 0 }, 'fast');
		$('html, body').animate({
		   'scrollTop':   $('#anchorForm').offset().top - 150
		 }, 'fast');
	}
	
	return valid;
}

//Acciones a ejectuar al inicio
$(function(){
	cleanValidationMsgs();
});

//callback al boton para submitear
$( "#btnSubmit" ).click(function() {
	$( "#frmApp" ).submit();
});

$('#frmApp').submit( function(event){	
	
	//validaciones "cliente"
	//de igual manera se valida el servicio
	//por si "algun listo" altera el DOM...
	var valid = true;

	trimFields();
	cleanValidationMsgs();
	valid = validateInput();

	if(!valid)
		event.preventDefault();
});
</script>