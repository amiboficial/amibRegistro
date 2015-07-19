<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Registro 0.1 - Detalle del poder</title>
</head>
<body>
	<a id="anchorForm"></a>
	<ul class="breadcrumb">
		<li><a href="#">Gestión</a><span class="divider"></span></li>
		<li><a href="<g:createLink controller="poder" action="index" />">Poderes</a></li>
		<li><a href="#">Detalles de poder</a></li>
	</ul>
	<h2><strong>Detalles de poder</strong></h2>

	<g:if test="${flash.successMessage}">
		<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.successMessage}</div>
	</g:if>
	<g:if test="${flash.errorMessage}">
		<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-info-sign"></span> ${flash.errorMessage}</div>
	</g:if>
	
	<fieldset>
		<legend>Acciones</legend>
		
		<button id="btnExpandir" type="button" class="toggleExpandAll btn btn-default"><span class="glyphicon glyphicon-plus-sign"></span> Expander todos</button>
		<button id="btnContraer" type="button" class="toggleRetractAll btn btn-default"><span class="glyphicon glyphicon-minus-sign"></span> Contraer todos</button>
		
		<button id="btnNuevoPoder" type="button" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar datos del poder</button>
		<button id="btnNuevoPoder" type="button" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar apoderados</button>
	</fieldset>
	
	<fieldset class="form-horizontal">
		<legend>Poder</legend>
		
		<fieldset>
			<legend><span id="#spnTglDi" class="glyphicon glyphicon-plus-sign toggleInstitucion handCursor"></span>&nbsp;<i>Datos de la institución o grupo financiero</i></legend>
		
			<div class="sectionInstitucion">
				<div id="divAdmGrupoFinanciero" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.groupoFinanciero.label" default="Grupo financiero" />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.grupoFinanciero?.nombre}</p>
					</div>
				</div>
				
				<div id="divAdmInstitucion" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.institucion.label" default="Institución" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.institucion?.nombre}</p>
					</div>
				</div>
			</div>
		
		</fieldset>
		
		<fieldset>
			<legend><span id="#spnTglRlgl" class="toggleRepLegal glyphicon glyphicon-plus-sign handCursor"></span>&nbsp;<i>Datos del representante legal</i></legend>
		
			<div class="sectionRepLegal">
				<div id="divRepLegalNom" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalNombre.label" default="Nombre" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.poder?.representanteLegalNombre}</p>
					</div>
				</div>

				<div id="divAp1" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido1.label" default="Primer apellido" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.poder?.representanteLegalApellido1}</p>
					</div>
				</div>
				
				<div id="divAp2" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.representanteLegalApellido2.label" default="Segundo apellido" />					
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.poder?.representanteLegalApellido2}</p>
					</div>
				</div>
			</div>
		
		</fieldset>
		
		<fieldset>
			<legend><span id="#spnTglOfi" class="toggleOficio glyphicon glyphicon-plus-sign handCursor"></span>&nbsp;<i>Datos del oficio</i></legend>
			
			<div class="sectionOficio" >
				<div id="divPdrNumEscrit" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.numeroEscritura.label" default="Numero de escritura" />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.poder?.numeroEscritura}</p>
					</div>
				</div>
				
				<div id="divFhApod" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.fechaApoderamiento.label" default="Fecha de aporderamiento" />
					</label>
					<div class="col-md-9 col-sm-9">
						<p class="form-control-static">${viewModelInstance?.poder?.fechaApoderamiento}</p>
					</div>
				</div>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend><span id="#spnTglNot" class="toggleNotario glyphicon glyphicon-plus-sign handCursor"></span>&nbsp;<i>Datos del notario</i></legend>
		
			<div class="sectionNotario" >
				<div id="divNumNotario" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.notario.numero.label" default="Número" />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.notario?.numeroNotaria}</p>
					</div>
				</div>
				
				<div id="divNotarioEntidadFederativa" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.notario.entidadFederativa.label" default="Entidad Federativa"  />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.notario?.idEntidadFederativa}</p>
					</div>
				</div>
				
				<div id="divNombreCompleto" class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="poder.notario.nombreCompletro.label" default="Nombre" />
					</label>
					
					<div class="col-md-9 col-sm-9">						
						<p class="form-control-static">${viewModelInstance?.notario?.nombreCompleto}</p>
					</div>
				</div>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend><span id="#spnTflApos" class="toggleApoderado glyphicon glyphicon-plus-sign handCursor"></span>&nbsp;<i>Apoderados</i></legend>
			
			<div class="sectionApoderado" >
				<g:each in="${viewModelInstance?.certificacionesApoderados}" var="x">
					<div class="list-group-item" >
						<div class="div-numeroMatricula div-nombreCompleto row">
							<label class="col-sm-2 control-label">Matrícula</label>
							<div class="col-sm-2 col-md-1"><p>${x.sustentante?.numeroMatricula}</p></div>
							<label class="col-sm-3 control-label">Nombre completo</label>
							<div class="col-sm-5"><p class="form-control-static">${x?.sustentante?.nombre} ${x.sustentante?.primerApellido} ${x.sustentante?.segundoApellido}</p></div>
						</div>
						<div class="div-nombreFigura row">
							<label class="col-sm-2 control-label">Figura</label>
							<div class="col-sm-9"><p class="form-control-static">${x?.varianteFigura?.nombreFigura}</p></div>
						</div>
						<div class="div-nombreVarianteFigura row">
							<label class="col-sm-2 control-label">Variante de figura</label>
							<div class="col-sm-9"><p class="form-control-static">${x?.varianteFigura?.nombre}</p></div>
						</div>
						<div class="row">
							&nbsp;
						</div>
					</div>
				</g:each>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend><span id="#spnTglDr" class="toggleDocs glyphicon glyphicon-plus-sign handCursor"></span>&nbsp;<i>Documento de respaldo</i></legend>
		
			<div class="sectionDocs">
				<div class="list-group-item">
					<div class="div-nombreArchivo row">
						<label class="col-sm-2 control-label">Nombre</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.nombre}</p></div>
					</div>
					<div class="div-tipoDocumento row">
						<label class="col-sm-2 control-label">UUID</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.uuid}</p></div>
					</div>
					<div class="div-fecha row">
						<label class="col-sm-2 control-label">Fecha</label>
						<div class="col-sm-9"><p>${viewModelInstance?.documentoRespaldo?.fechaCreacion}</p></div>
					</div>
					
					<div class="row">
						<div class="col-sm-9">
							&nbsp;
						</div>
						<div class="col-sm-2">
							<button type="button" class="download btn btn-sm btn-block btn-default btn-primary"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> Descargar</button>
						</div>
					</div>
				</div>
			</div>
			
		</fieldset>
		
	</fieldset>
	
	<script>
	var app = app || {};

	app.PoderShowViewModel = Backbone.Model.extend({
		defaults: {
			showFieldsetInstitucion : true,
			showFieldsetRepLegal : true,
			showFieldsetOficio : true,
			showFieldsetNotario : true,
			showFieldsetApoderado : true,
			showFieldsetDocs : true,
			urlDownloadDoc: ""
		}
	});
		
	app.PoderShowView = Backbone.View.extend({
		el:'body',
		
		initialize: function(initialModel){
			this.model = initialModel;
			this.listenTo(this.model, 'change:showFieldsetInstitucion', this.render );
			this.listenTo(this.model, 'change:showFieldsetRepLegal', this.render );
			this.listenTo(this.model, 'change:showFieldsetOficio', this.render );
			this.listenTo(this.model, 'change:showFieldsetNotario', this.render );
			this.listenTo(this.model, 'change:showFieldsetApoderado', this.render );
			this.listenTo(this.model, 'change:showFieldsetDocs', this.render );
			this.render();
		},

		render: function(){
			if(this.model.get("showFieldsetInstitucion") == true){
				this.$(".toggleInstitucion").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionInstitucion").show();
			}
			else{
				this.$(".toggleInstitucion").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionInstitucion").hide();
			}
			if(this.model.get("showFieldsetRepLegal") == true){
				this.$(".toggleRepLegal").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionRepLegal").show();
			}
			else{
				this.$(".toggleRepLegal").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionRepLegal").hide();
			}
			if(this.model.get("showFieldsetOficio") == true){
				this.$(".toggleOficio").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionOficio").show();
			}
			else{
				this.$(".toggleOficio").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionOficio").hide();
			}
			if(this.model.get("showFieldsetNotario") == true){
				this.$(".toggleNotario").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionNotario").show();
			}
			else{
				this.$(".toggleNotario").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionNotario").hide();
			}
			if(this.model.get("showFieldsetApoderado") == true){
				this.$(".toggleApoderado").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionApoderado").show();
			}
			else{
				this.$(".toggleApoderado").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionApoderado").hide();
			}
			if(this.model.get("showFieldsetDocs") == true){
				this.$(".toggleDocs").removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".sectionDocs").show();
			}
			else{
				this.$(".toggleDocs").removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".sectionDocs").hide();
			}			
			return this;
		},
		
		events: {
			'click .toggleInstitucion':'toggleInstitucion',
			'click .toggleRepLegal':'toggleRepLegal',
			'click .toggleOficio':'toggleOficio',
			'click .toggleNotario':'toggleNotario',
			'click .toggleApoderado':'toggleApoderado',
			'click .toggleDocs':'toggleDocs',
			'click .toggleExpandAll':'toggleExpandAll',
			'click .toggleRetractAll':'toggleRetractAll',
			'click .download':'downloadDocRespaldo'
		},

		toggleInstitucion: function(e){
			e.preventDefault();
			this.model.set("showFieldsetInstitucion", !this.model.get("showFieldsetInstitucion") );
		},
		
		toggleRepLegal: function(e){
			e.preventDefault();
			this.model.set("showFieldsetRepLegal", !this.model.get("showFieldsetRepLegal"));
		},

		toggleOficio: function(e){
			e.preventDefault();
			this.model.set("showFieldsetOficio", !this.model.get("showFieldsetOficio"));
		},

		toggleNotario: function(e){
			e.preventDefault();
			this.model.set("showFieldsetNotario", !this.model.get("showFieldsetNotario"));
		},

		toggleApoderado: function(e){
			e.preventDefault();
			this.model.set("showFieldsetApoderado", !this.model.get("showFieldsetApoderado"));
		},

		toggleDocs: function(e){
			e.preventDefault();
			this.model.set("showFieldsetDocs", !this.model.get("showFieldsetDocs"));
		},
		
		toggleExpandAll: function(e){
			e.preventDefault();
			this.model.set("showFieldsetInstitucion", true );
			this.model.set("showFieldsetRepLegal", true );
			this.model.set("showFieldsetOficio", true );
			this.model.set("showFieldsetNotario", true );
			this.model.set("showFieldsetApoderado", true );
			this.model.set("showFieldsetDocs", true );
		},

		toggleRetractAll: function(e){
			e.preventDefault();
			this.model.set("showFieldsetInstitucion", false );
			this.model.set("showFieldsetRepLegal", false );
			this.model.set("showFieldsetOficio", false );
			this.model.set("showFieldsetNotario", false );
			this.model.set("showFieldsetApoderado", false );
			this.model.set("showFieldsetDocs", false );
		},
		
		downloadDocRespaldo: function(e){
			e.preventDefault();
			window.open(this.model.get("urlDownloadDoc"));
		}
	});

	var poderShowViewModel = new app.PoderShowViewModel();
	poderShowViewModel.set("urlDownloadDoc",'<g:createLink controller="documento" action="download" id="${viewModelInstance?.documentoRespaldo?.uuid}"/>')
	var poderShowView = new app.PoderShowView(poderShowViewModel);
	
	</script>
	
</body>
</html>