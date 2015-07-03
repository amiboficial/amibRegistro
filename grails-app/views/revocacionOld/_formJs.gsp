<%@ page import="mx.amib.sistemas.registro.apoderamiento.model.Poder" %>
		
		<!-- INICIA: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
		<script type="text/javascript">
			var institAjaxUrl = '<g:createLink action="obtenerInstituciones"/>';
			<g:if test="${revocacionInstance.idInstitucion != null}">
				var precargadoIdInstitucion = ${revocacionInstance.idInstitucion};
			</g:if>
		</script>
		<g:javascript src="mx.amib.sistemas.registro.form.entidadFinanciera.js" />
		<script type="text/javascript">
			$("#selAdmIdGrupoFinanciero").trigger("change");
		</script>
		<!-- FIN: SCRIPT PARA FUNCIONAMIENTO DE ENTIDAD FINANCIERA -->
		
		<!-- INICIA: SCRIPT PARA REVOCADOS -->
		<g:render template="revocados"/>
		<g:javascript src="mx.amib.sistemas.registro.revocacion.form.revocadosWidget.js" />
		<script type="text/javascript">
		$(function(){ 
			var revocados = [
			<g:each in="${revocacionInstance.revocados}">
				{ grailsId: ${it.id}, numeroMatricula:${it.numeroMatricula}, nombreCompleto:'${it.nombreCompleto}', numeroEscritura: ${it.numeroEscritura}, motivo:'${it.motivo}', fechaBajaDia:'${ String.format("%02d", it.fechaBaja.getAt(Calendar.DAY_OF_MONTH))}',fechaBajaMes:'${ String.format("%02d", it.fechaBaja.getAt(Calendar.MONTH)) }',fechaBajaAnyo:'${ String.format("%04d", it.fechaBaja.getAt(Calendar.YEAR)) }' },
			</g:each> ];
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
			var docs = [
			<g:each in="${revocacionInstance.documentosRespaldoRevocacion}">
				{ grailsId: ${it.id}, uuid:'${it.uuidDocumentoRepositorio}', idTipo:${it.tipoDocumentoRespaldoRevocacion.id}, dsTipo:'${it.tipoDocumentoRespaldoRevocacion.descripcion}', nombre:'${it.nombreDeArchivo}', status:app.ST_VM_DOC_READY ,_urlDown:'<g:createLink controller="documento" action="download" id="${it.uuidDocumentoRepositorio}"/>',_urlDelete:'' },
			</g:each> ];
			
			<g:each in="${viewModelInstance.tipoDocumentoList}">
				app.DocsValidator.addDocType(${it.id});
			</g:each>
			
			var docsView = new app.DocsView(docs);
			docsView.validator = app.DocsValidator;

			docsView.viewModel.set('urlUpload','<g:createLink controller="documento" action="upload" />');
			docsView.viewModel.set('urlDownloadNew','<g:createLink controller="documento" action="downloadNew"/>');
			docsView.viewModel.set('urlDeleteNew','<g:createLink controller="documento" action="delete"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA DOCUMENTOS  -->
		<!-- INICIO: SCRIPT PARA COMPONENTE DE NOTARIO -->
		<g:javascript src="mx.amib.sistemas.registro.form.notarioWidget.js" />
		<script type="text/javascript">
		$(function(){
			new notarioWidget.NotarioView(null,'<g:createLink action="obtenerNombreNotario"/>');
		});
		</script>
		<!-- FIN: SCRIPT PARA COMPONENTE DE NOTARIO -->
		<!-- INICIO: SCRIPT PARA VISTA -->
		<g:javascript src="mx.amib.sistemas.registro.revocacion.form.js" />
		<!-- FIN: SCRIPT PARA VISTA-->