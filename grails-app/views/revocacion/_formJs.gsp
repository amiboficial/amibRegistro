<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>
		<!-- INICIA: SCRIPT PARA REVOCADOS -->
		<g:render template="revocados"/>
		<g:javascript src="mx.amib.sistemas.registro.revocacion.form.revocadosWidget.js" />
		<script type="text/javascript">
		$(function(){
			var revocados = [];
			new app.RevocadosView(revocados, 'http://localhost:8080/amibRegistro/sustentante/findByMatricula');
		});
		</script>
		<!-- FIN: SCRIPT PARA REVOCADOS  -->