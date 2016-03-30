<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="logIn"/>
<title>Iniciar sesión - Registro 0.1</title>
</head>
<body>

  <form class="form-signin" action='<g:createLink controller="membership" action="authenticate"/>' method="post">
    <asset:image class="center-block" src="amib_logo.png" alt="AMIB" />
    <h1 class="form-signin-heading">AMIB-Registro</h1>
    <h2 class="form-signin-heading">Introduzca sus credenciales para ingresar al sistema</h2>
    <label for="userName" class="sr-only">Nombre de usuario</label>
    <input type=text id="txtUserName" name="vm.userName" class="form-control" placeholder="Nombre de usuario" required="" autofocus="">
    <label for="password" class="sr-only">Constraseña</label>
    <input type="password" id="pwdPassword" name="vm.cleanPassword" class="form-control" placeholder="Constraseña" required="">
	<br/>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Iniciar sesión</button>
    <br/>
    <g:if test="${vm?.errorBlankUserName}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir un nombre de usuario</div>
	</g:if>
	<g:if test="${vm?.errorBlankPassword}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> Debe introducir una contraseña</div>
	</g:if>
	<g:if test="${vm?.errorCredentialsNotFound}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> El <strong>nombre de usuario</strong> y <strong>contraseña</strong> no coinciden con ningun registro. Si el nombre de usuario existe y está introduciendo una contraseña erronea, la cuenta se bloqueará a los 10 intentos.</div>
	</g:if>
	<g:if test="${vm?.errorFetchingData}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> Error al obtener datos de autenticación</div>
	</g:if>
	<g:if test="${vm?.errorIsLockedOut}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> El usuario ha sido bloqueado</div>
	</g:if>
	<g:if test="${vm?.errorNonApproved}">
		<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span> El registro del usuario aún no ha sido autorizado</div>
	</g:if>
	
  </form>

</body>
</html>