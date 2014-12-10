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
            	<a class="list-group-item colortitle">Gestión de expediente</a>
            	<a href="<g:createLink controller="notario" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Expedientes</a>
            	<a class="list-group-item colortitle">Gestión de oficios</a>
            	<a href="<g:createLink controller="poder" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Poderes</a>
                <a href="<g:createLink controller="revocacion" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Revocaciones</a>
                <a href="<g:createLink controller="oficioCNBV" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-file"></span>&nbsp;Oficios CNBV</a>
            	<a class="list-group-item colortitle">Gestión de catálogos</a>
            	<a href="<g:createLink controller="notario" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Notarios</a>
                <a class="list-group-item colortitle">Servicios</a>
                <a href="<g:createLink controller="poder" action="create" />" class="list-group-item"><span class="glyphicon glyphicon-open"></span>&nbsp;Alta de poder</a>
                <a href="<g:createLink controller="revocacion" action="create" />" class="list-group-item"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;Solicitud de Revocación</a>
                
                <a href="#" class="list-group-item colortitle">Información</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Detalle de solicitudes</a>
                <a href="<g:createLink controller="busqueda" action="index" />" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Poderes vigentes</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Personal apoderado</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Consulta de autorizados</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-book"></span>&nbsp;Catálogo de notarios</a>
                <a href="#" class="list-group-item colortitle">Acciones</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-user"></span>&nbsp;Información de usuario</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-cog"></span>&nbsp;Cambio de contraseña</a>
                <a href="#" class="list-group-item"><span class="glyphicon glyphicon-off"></span>&nbsp;Cerrar sesión</a>
            </div>
        </div>