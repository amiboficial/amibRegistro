<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>
		<!-- INICIA: SCRIPT PARA REVOCADOS -->
		<g:render template="revocados"/>
		<g:javascript src="mx.amib.sistemas.registro.revocacion.form.revocadosWidget.js" />
		<script type="text/javascript">
		$(function(){
			var revocados = [];
			new app.RevocadosView(revocados, '<g:createLink action="obtenerSustentantePorMatricula"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA REVOCADOS  -->
		<!-- INICIA: SCRIPT PARA DOCUMENTOS -->
		<g:render template="../common/multiDocs"/>
		<g:javascript src="mx.amib.sistemas.registro.form.docsMultiWidget.js" />
		<g:javascript src="mx.amib.sistemas.registro.revocacion.form.docsValidator.js" />
		<script type="text/javascript">
		$(function(){
			var docs = [];
			<g:each in="${viewModelInstance.tipoDocumentoList}">
				app.DocsValidator.addDocType(${it.id});
			</g:each>
			
			var docsView = new app.DocsView(docs);
			docsView.validator = app.DocsValidator;
			
		});
		</script>
		<!-- FIN: SCRIPT PARA DOCUMENTOS  -->