<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Añadir solicitud a registro</title>
</head>
<body>
	<a id="anchorForm"></a>
	<!-- INICIA: BREADCRUMB ADMIN -->
	<ul class="breadcrumb">
		<li><a href="#">Gestión de expedientes</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="expedienteRegistrable" action="index" />">Solicitud de Registro</a></li>
		<li><a href="#">Añadir a registro</a></li>
	</ul>
	<!-- FIN: BREADCRUMB ADMIN -->
	<h2><strong>Añadir a registro</strong></h2>

	<g:if test="${flash.message}">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> ${flash.message}</div>
	</g:if>

	<form id="frmApp" class="form-horizontal" role="form" action="save" method="post">
		<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> Complete adecuadamenete la información del solicitante que se va añadir al registro. Una vez que toda la información proporcionada este completa, revisando el "checklist" en la parte inferior, podrá proceder a agregar la solicitud.</div>
		
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#divGen" aria-controls="divGen" role="tab" data-toggle="tab">Datos generales</a></li>
			<li role="presentation"><a href="#divDom" aria-controls="divDom" role="tab" data-toggle="tab">Datos de domicilio</a></li>
			<li role="presentation"><a href="#divReg" aria-controls="divReg" role="tab" data-toggle="tab">Datos de registro</a></li>
			<li role="presentation"><a href="#divDoc" aria-controls="divDoc" role="tab" data-toggle="tab">Revisión de documentos</a></li>
		</ul>
		
		<div class="tab-content">
			<br/>
			
			<div role="tabpanel" class="tab-pane active" id="divGen">
			
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.nombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control" name="expedienteRegistrable.nombre" value="${expedienteRegistrable?.nombre}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.apellido1.label" default="Primer apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control" name="expedienteRegistrable.apellido1" value="${expedienteRegistrable?.apellido1}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.apellido1.label" default="Segundo apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control" name="expedienteRegistrable.apellido2" value="${expedienteRegistrable?.apellido2}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Fecha de nacimiento" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.genero.label" default="Género" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Masculino
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Femenino
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.rfc.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.curp.label" default="CURP" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.email.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Estado Civil" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Nivel de estudios" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Nacionalidad" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<br/>
				
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block">Validar y confirmar datos generales</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block">Editar datos generales</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divDom">
				
				<div class="alert alert-warning">
					La siguiente <strong>información del domicilio</strong> ha sido proporcionada por el solicitante:<br/>
					<br/>
					<strong>Reintroduza</strong> los datos con base en esta información.
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Código Postal" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Entidad Federativa" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Municipio" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Asentamiento" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Calle" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Número exterior" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Número interior" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<br/>
				
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block">Validar y confirmar datos de domicilio</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block">Editar datos de domicilio</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divReg">
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Actividad o profesión" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Calidad migratoria" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Figura a la que aplicó" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Fecha de certificación" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Autorización solicitada" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Fecha a partir de la cual labora" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Puesto actual" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block">Validar y confirmar datos de registro</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block">Editar datos de registro</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
			<div role="tabpanel" class="tab-pane" id="divDoc">
			
				<div class="alert alert-warning">
					Coteje los documentos solicitados de acuerdo a la figura y/o autorización solicitada. Los documentos en el conjunto mostrado son todos los documentos que fueron almacenados al momento de que se realizó la solicitud.
				</div>
			
				<div class="panel panel-primary">
					<div class="panel-heading">
						Conjunto de documentos del sustentante
					</div>
					<div class="panel-body">
					</div>
				</div>
			
				<div class="panel panel-primary">
					<div class="panel-heading">
						Documentos restantes/faltantes que complementen el registro
					</div>
					<div class="panel-body">
					</div>
				</div>
			
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Informe proporcionado por una sociedad crediticia con historial de cuando menos 5 años" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_2" value="opcion_2">
								No entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_3" value="opcion_3">
								No aplica
							</label>
						</div>
						<br/>
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Carta de recomendación" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_2" value="opcion_2">
								No entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_3" value="opcion_3">
								No aplica
							</label>
						</div>
						<br/>
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Constancias de las bolsas de valores" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_2" value="opcion_2">
								No entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_3" value="opcion_3">
								No aplica
							</label>
						</div>
						<br/>
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Manifestación bajo protesta de decir la verdad de acuerdo al formato entregado por la AMIB" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_2" value="opcion_2">
								No entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_3" value="opcion_3">
								No aplica
							</label>
						</div>
						<br/>
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expedienteRegistrable.edocivil.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
								Entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_2" value="opcion_2">
								No entrego
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="opciones" id="opciones_3" value="opcion_3">
								No aplica
							</label>
						</div>
						<br/>
		            	<input type="text" class="form-control"/>
		            </div>
				</div>
				
				<br/>
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block">Validar y confirmar revisión de documentos</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block">Editar revisión de documentos</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
				
			</div>
			
			<br/>
		</div>
		
		<br/>
		
		<div class="panel panel-default">
			<div class="panel-heading">Checklist de validación de información</div>
			<div class="panel-body">
				<ul style="list-style-type:none">
					<li><span class="glyphicon glyphicon-unchecked"></span> Datos generales</li>
					<li><span class="glyphicon glyphicon-unchecked"></span> Datos de domicilio</li>
					<li><span class="glyphicon glyphicon-unchecked"></span> Datos de registro</li>
					<li><span class="glyphicon glyphicon-unchecked"></span> Revisión de la documentos</li>
				</ul>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-6 col-sm-6" style="text-align: center">
				<button id="btnSubmit" type="button" class="btn btn-primary btn-lg btn-block">Agregar solicitud</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
		
	</form>
	

</body>
</html>