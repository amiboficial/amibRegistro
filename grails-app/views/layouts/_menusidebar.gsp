<%@ page contentType="text/html;charset=UTF-8"%>
<%
    def membershipService = grailsApplication.mainContext.getBean("membershipService");
	long[] path_Expedientes = [1,11]
	long[] path_SolicitudRegistro = [1,5]
	long[] path_CandidatosSolicitudRegistro = [1,5]
	long[] path_ActualizacionAutorizacion = [1,8]
	long[] path_CandidatosActualizacionAutorizacion = [1,8]
	long[] path_ReposicionAutorizacion = [1,9]
	long[] path_CandidatosReposicionAutorizacion = [1,9]
	long[] path_CambioFigura = [1,10]
	long[] path_CandidatosCambioFigura = [1,10]
	long[] path_DictamenPrevio = [1,6]
	long[] path_PendientesAutorizar = [1,7]
	long[] path_Poderes = [1,2]
	long[] path_Revocaciones = [1,3]
	long[] path_OficiosCNBV = [1,4]
	long[] path_BajaInstitucion = [1,16]
	long[] path_AltaInstitucion = [1,16]
	
%>

<!--  <div style="text-align: center;">
           <!--       <!-- <img src="web-app/images/amib_logo.png" /><br/>  -->
<!--   <asset:image src="amib_logo.png" alt="AMIB"/>
              <!--   <h3>Catálogos</h3>
             <!--    <h5>Ver. 0.1</h5>
           <!--   </div>-->
<div id="divAffixSidebar">
	<div id="divLineBreaks"></div>
	<div class="list-group">

		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_Expedientes?.contains(it.numberRole) } }">
			<a class="list-group-item colortitle"><strong>Gestión de
					expediente</strong></a>
			<a href="<g:createLink controller="expediente" action="index" />"
				class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Expedientes</a>
			</a>
		</g:if>

		<a class="list-group-item colortitle"><strong>Gestión de
				autorización</strong></a>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_SolicitudRegistro?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="expedienteRegistrable" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-share-alt"></span>&nbsp;Solicitud de
				registro</a>
			<a
				href="<g:createLink controller="consultaTipoServicio" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-share-alt"></span>&nbsp;Candidatos al
				proceso de registro</a>




		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_ActualizacionAutorizacion?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="certificacionActualizacionAutorizacion" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-refresh"></span>&nbsp;Actualización de la
				autorización</a>

			<a
				href="<g:createLink controller="consultaTipoServicio6" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-refresh"></span>&nbsp;Candidatos al
				proceso de actualización de la autorización</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_ReposicionAutorizacion?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="certificacionReposicionAutorizacion" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-retweet"></span>&nbsp;Reposición de la
				autorización</a>

			<a
				href="<g:createLink controller="consultaTipoServicio5" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-retweet"></span>&nbsp;Candidatos al
				proceso de reposición de la autorización</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_CambioFigura?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="certificacionCambioFigura" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-transfer"></span>&nbsp;Cambio de figura</a>

			<a
				href="<g:createLink controller="consultaTipoServicio4" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-transfer"></span>&nbsp;Candidatos al
				proceso de cambio de figura</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_DictamenPrevio?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="certificacionDictamenPrevio" action="index" />"
				class="list-group-item"><span class="glyphicon glyphicon-edit"></span>&nbsp;Dictamen
				previo</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_PendientesAutorizar?.contains(it.numberRole) } }">
			<a
				href="<g:createLink controller="certificacionEnvioAutorizacion" action="index" />"
				class="list-group-item"><span class="glyphicon glyphicon-inbox"></span>&nbsp;Pendientes
				a autorizar</a>
		</g:if>

		<a class="list-group-item colortitle"><strong>Gestión de
				oficios</strong></a>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_Poderes?.contains(it.numberRole) } }">
			<a href="<g:createLink controller="poder" action="index" />"
				class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Poderes</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_Revocaciones?.contains(it.numberRole) } }">
			<a href="<g:createLink controller="revocacion" action="index" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-share-alt"></span>&nbsp;Revocaciones</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_OficiosCNBV?.contains(it.numberRole) } }">
			<a href="<g:createLink controller="oficioCnbv" action="index" />"
				class="list-group-item"><span class="glyphicon glyphicon-file"></span>&nbsp;Oficios
				CNBV</a>
		</g:if>
		<a class="list-group-item colortitle"><strong>Movimientos
				de personal</strong></a>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_BajaInstitucion?.contains(it.numberRole) } }">
			<a href="<g:createLink controller="bajaPersonal" action="create" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-hand-down"></span>&nbsp;Baja en
				Institución</a>
		</g:if>
		<g:if
			test="${membershipService?.authenticatedUserRoles.any{ path_AltaInstitucion?.contains(it.numberRole) } }">
			<a href="<g:createLink controller="altaPersonal" action="create" />"
				class="list-group-item"><span
				class="glyphicon glyphicon-hand-up"></span>&nbsp;Alta en Institución</a>
		</g:if>

		<!-- ESTO SE PUEDE USAR MAS ADELANTE PARA SOLICITUDES
                <a class="list-group-item colortitle"><strong>Gestión de catálogos</strong></a>
            	<a href="<g:createLink controller="notario" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Notarios</a>
                <a class="list-group-item colortitle">Servicios</a>
                <a href="<g:createLink controller="poder" action="createAltaGpoFin" />" class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Alta de poder</a>
                <a href="<g:createLink controller="revocacion" action="createSolGpoFin" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Solicitud de Revocación</a>
                <a class="list-group-item colortitle">Servicios</a>
                <a href="<g:createLink controller="poder" action="createAltaInst" />" class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Alta de poder</a>
                <a href="<g:createLink controller="revocacion" action="createSolInst" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Solicitud de Revocación</a>
                <a href="#" class="list-group-item colortitle">Información</a>
                <a href="<g:createLink controller="solicitudes" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Detalle de solicitudes</a>
                <a href="<g:createLink controller="poderVigente" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Personal apoderado</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Consulta de autorizados</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Catálogo de notarios</a>
                 -->

		<a href="#" class="list-group-item colortitle"><strong>Acciones</strong></a>
		<a href="#" class="list-group-item"><span
			class="glyphicon glyphicon-user"></span>&nbsp;Información de usuario</a>
		<a href="#" class="list-group-item"><span
			class="glyphicon glyphicon-cog"></span>&nbsp;Cambio de contraseña</a> <a
			href="<g:createLink controller="membership" action="logOut" />"
			class="list-group-item"><span class="glyphicon glyphicon-off"></span>&nbsp;Cerrar
			sesión</a>
	</div>
</div>