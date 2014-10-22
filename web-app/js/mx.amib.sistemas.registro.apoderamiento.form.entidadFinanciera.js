		var institAjaxUrl = institAjaxUrl || {};
		var precargadoIdInstitucion = precargadoIdInstitucion || 0;
		
		$(function(){
			//OCULTA MENSAJES
			$("#divMsgProcesandoEntidadFinanciera").hide();
			$("#divMsgErrorEntidadFinanciera").hide();
		});
		
		$("#selAdmIdGrupoFinanciero").on("change", function(e){
			//muestra mensaje procesando hasta que lleguen los datos
			$("#divMsgProcesandoEntidadFinanciera").show();
			$("#divMsgErrorEntidadFinanciera").hide();
			if( $("#selAdmIdGrupoFinanciero").val() == '-1' ) {
				$("#divMsgProcesandoEntidadFinanciera").hide();
				$("#selAdmIdInstitucion").html('');
				$("#selAdmIdInstitucion").append('<option value="-1">-Seleccione-</option>');
			}
			else {
				$.ajax({
					dataType: "json",
					url: institAjaxUrl + '/' + $("#selAdmIdGrupoFinanciero").val(),
					error: function(_jqXHR,_textStatus,_errorThrown){
						$("#divMsgProcesandoEntidadFinanciera").hide();
						$("#divMsgErrorEntidadFinanciera").show();
						
						$("#selAdmIdInstitucion").html('');
					},
					success: function(data,status,_jqXHR){
						$("#divMsgProcesandoEntidadFinanciera").hide();
						$("#selAdmIdInstitucion").html('');
						$("#selAdmIdInstitucion").append('<option value="-1">-Sin especificar-</option>');
						_.each(data,function(item){
							$("#selAdmIdInstitucion").append('<option value="' + item.id + '">' + item.nombre + '</option>');
						}, this);
						if(precargadoIdInstitucion > 0)
						{
							$("#selAdmIdInstitucion").val(precargadoIdInstitucion);
							//solamente se carga una sola vez
							precargadoIdInstitucion = 0;
						}
					}
				});
			}
		});	