<%@ page contentType="text/html;charset=UTF-8" %>

            <!--  <div style="text-align: center;">
           <!--       <!-- <img src="web-app/images/amib_logo.png" /><br/>  -->
              <!--   <asset:image src="amib_logo.png" alt="AMIB"/>
              <!--   <h3>Catálogos</h3>
             <!--    <h5>Ver. 0.1</h5>
           <!--   </div>-->
		<div id="divAffixSidebar">
			<div id="divLineBreaks">
			</div>
            <div class="list-group" >
            	<a class="list-group-item colortitle"><strong>Gestión de expediente</strong></a>
            	<a href="<g:createLink controller="expediente" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Expedientes</a></a>
            	<a class="list-group-item colortitle"><strong>Gestión de autorización</strong></a>
            	<a href="<g:createLink controller="expedienteRegistrable" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Solicitud de registro</a>
            	<a href="<g:createLink controller="certificacionActualizacionAutorizacion" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-refresh"></span>&nbsp;Actualización de la autorización</a>
            	<a href="<g:createLink controller="certificacionReposicionAutorizacion" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-retweet"></span>&nbsp;Reposición de la autorización</a>
            	<a href="<g:createLink controller="certificacionCambioFigura" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-transfer"></span>&nbsp;Cambio de figura</a>
            	<a href="<g:createLink controller="certificacionDictamenPrevio" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-edit"></span>&nbsp;Dictamen previo</a>
            	<a href="<g:createLink controller="certificacionEnvioAutorizacion" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-inbox"></span>&nbsp;Pendientes a autorizar</a>
            	<a class="list-group-item colortitle"><strong>Gestión de oficios</strong></a>
            	<a href="<g:createLink controller="poder" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Poderes</a>
                <a href="<g:createLink controller="revocacion" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Revocaciones</a>
                <a href="<g:createLink controller="oficioCnbv" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-file"></span>&nbsp;Oficios CNBV</a>
            	
                
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
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-user"></span>&nbsp;Información de usuario</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-cog"></span>&nbsp;Cambio de contraseña</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-off"></span>&nbsp;Cerrar sesión</a>
            </div>
        </div>