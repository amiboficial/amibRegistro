<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.OficioCNBV" %>

	<!-- INICIA: SCRIPT PARA FUNCIONAMIENTO DE AUTORIZADOS -->
	<g:render template="autorizados"/>
	<g:javascript src="mx.amib.sistemas.registro.oficioCNBV.form.autorizadosWidget.js" />
	<script type="text/javascript">
		$(function(){ 
			var autorizadosView = new app.AutorizadosView();
			autorizadosView.ajaxUrl = '<g:createLink action="obtenerSustentantePorMatricula"/>';
		});
	</script>
	<!-- FIN: SCRIPT PARA FUNCIONAMIENTO DE AUTORIZADOS -->
	
	<!-- INICIO: SCRIPT PARA VISTA -->
	<g:javascript src="mx.amib.sistemas.registro.oficioCNBV.form.js" />
	<!-- FIN: SCRIPT PARA VISTA-->