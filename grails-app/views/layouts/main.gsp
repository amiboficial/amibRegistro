<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="es" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=0.75">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>	
	</head>
	<body>
		
		<div class="container-fluid">
			<div class="body-content">
				<div class="navbar-fixed-top">

					<header>
		       	 		<div class="container-fluid colorcabecera">
		          			<div class="row">
		            			<div class="col-sm-3 col-md-2">
		           					<a href="${createLink(uri: '/')}">
		           						<asset:image class="center-block" src="logoamib.jpeg" alt="AMIB" />
		                   			</a>
		                		</div>
		                		<div class="hidden-xs col-sm-9" style="padding-top:1.18em">    
		                			<span class="letracabecera">Asociación Mexicana de Intermediarios Bursátiles</span>
		                		</div>
		                	</div>
		                </div>	
		             </header>         
			
					<div role="navigation">
						<div>
						
							<nav class="navbar navbar-default">
			        			<div class="navbar-header">       	
			     					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			                				<span class="sr-only">Toggle navigation</span>
			                    			<span class="icon-bar"></span>
			                    			<span class="icon-bar"></span>
			                    			<span class="icon-bar"></span>
			            				</button>
			            				<a href="#" class="navbar-brand"><strong>Registro</strong> 0.1</a>
								</div>
								<div class="navbar-collapse collapse">
									<div class="nav" role="navigation">
										<ul class="nav navbar-nav pull-right" role="navigation">
											<li><a href="#"><span class="glyphicon glyphicon-user"></span> USUARIO_REGISTRADO (Cerrar Sesión)</a></li>
										</ul>
									</div>
								</div>		
							</nav>
							
						</div>
					</div>
				
				</div>

				<div class="row">
					<div class="col-sm-3 col-md-2">
					    <g:render template="/layouts/menusidebar" />
				   	</div>
				    <div class="col-sm-9 col-sm-offset3 col-md-10 col-md-offset2">
			    		<g:layoutBody/>
					</div>
				</div>
				
			</div>
			
			<g:render template="/layouts/footer" />
			
		</div>
		
		<!-- div "oculto" para probar si no estamos en telefono  -->
		<div id="divDesktopTest" class="hidden-xs"></div>
	
	<!-- INICIA: SCRIPT AFFIX-LIKE -->
	<!-- No se puedo emplear el affix del bootstrap como tal debido a que este implementaba position:fixed y el menu se "echaba a perder" -->
	<script>
		/*var iScrollPos = 0;
		$(window).scroll(function () {
		    var iCurScrollPos = $(this).scrollTop();
		    if(!$('#divDesktopTest').is(':hidden'))
			{
		    	$('#divLineBreaks').height( iCurScrollPos );
			}
		    else
			{
		    	$('#divLineBreaks').height( 0 );
			}
		});*/
	</script>
	<!-- FIN: SCRIPT AFFIX-LIKE -->
	
	</body>
</html>

