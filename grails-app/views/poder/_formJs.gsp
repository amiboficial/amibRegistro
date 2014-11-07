<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>

		<!-- INICIA: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
		<script type="text/javascript">
			var institAjaxUrl = '<g:createLink action="obtenerInstituciones"/>';
			<g:if test="${poderInstance.idInstitucion != null}">
				var precargadoIdInstitucion = ${poderInstance.idInstitucion};
			</g:if>
		</script>
		<g:javascript src="mx.amib.sistemas.registro.form.entidadFinanciera.js" />
		<script type="text/javascript">
			$("#selAdmIdGrupoFinanciero").trigger("change");
		</script>
		<!-- FIN: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
		<!-- INICIA: TEMPLATE UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<g:render template="apoderados"/>
		<!-- FIN: TEMPLATE UNDERSCORE PARA COMPONENTE DE APODERADOS -->
		<!-- INICIA: SCRIPT PARA COMPONENTE DE APODERADOS -->
		<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.apoderadosWidget.js" />
		<script type="text/javascript">
		//Carga datos del modelo
		$(function(){
			var apoderados = [
				<g:each in="${apoderadosList}">
					{ matricula: ${it.numeroMatricula}, nombreCompleto: '${it.nombreCompleto}', claveDga: '${it.autorizacionAplicada?.claveDga}', idAutorizadoCNBV: ${it.autorizacionAplicada?.idAutorizadoCNBV} },
				</g:each>
			];
			new apoderadosWidget.ApoderadosView(apoderados, '<g:createLink action="obtenerDatosMatriculaDgaValido"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE APODERADOS -->
		<!-- INICIA: TEMPLATES UNDERSCORE PARA COMPONENTE DE DOCUMENTOS -->
		<g:render template="../common/docs"/>
		<!-- FIN: TEMPLATES UNDERSCORE PARA COMPONENTE DE DOCUMENTOS -->
		<!-- INICIA: SCRIPT PARA COMPONENTE DE DOCUMENTOS -->
		<g:javascript src="mx.amib.sistemas.registro.form.docsWidget.js" />
		<script type="text/javascript">
		$(function(){
			var docs = [<g:each in="${documentosList}">
								{id: ${it.id},idTipoDocumento: ${it.idTipoDocumento}, tipoDocumento: '${it.tipoDocumento}', nombreDocumento: '${it?.nombreArchivo}', status: <g:if test="${it.id < 0}">docsWidget.SIN_ARCHIVO</g:if><g:else>docsWidget.PRECARGADO</g:else>,uuid:'${it?.uuid}', lastErrors: [] },
							</g:each>]
    		new docsWidget.DocumentosView(docs,'<g:createLink action="subirArchivo"/>','<g:createLink action="descargar"/>','<g:createLink action="descargarCargado"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE DOCUMENTOS -->
		<!-- INICIO: SCRIPT PARA COMPONENTE DE NOTARIO -->
		<g:javascript src="mx.amib.sistemas.registro.form.notarioWidget.js" />
		<script type="text/javascript">
		$(function(){
			new notarioWidget.NotarioView(null,'<g:createLink action="obtenerNombreNotario"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE NOTARIO -->
		<!-- INICIO: SCRIPT PARA VISTA -->
		<g:javascript src="mx.amib.sistemas.registro.apoderamiento.form.js" />
		<!-- FIN: SCRIPT PARA VISTA-->