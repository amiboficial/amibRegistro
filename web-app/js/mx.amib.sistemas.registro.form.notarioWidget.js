var notarioWidget = notarioWidget || {};

notarioWidget.LISTO = 0;
notarioWidget.PROCESANDO = 1;

notarioWidget.ERROR = 0;
notarioWidget.ERROR_NOT_FOUND = 1;
notarioWidget.ERROR_NOT_VALID_INPUT = 2;

notarioWidget.NotarioView = Backbone.View.extend({
	el: "#divNotario",
	errors: [],
	state: notarioWidget.LISTO,
	ajaxUrl: '',
	
	initialize: function(initModel,_ajaxUrl){
		this.ajaxUrl = _ajaxUrl;
		this.render();
		$('#divMsgProcesandoNotario').hide();
		$('#divMsgErrorProcesandoNotario').hide();
		$('#divMsgNoEncontradoNotario').hide();
		$('#divMsgDatoNoValidoNotario').hide();
		
		$('#divMsgAlMenosUnApoderado').hide();
	},
	
	render: function() {
		if(this.state == notarioWidget.PROCESANDO){
			$('#divMsgProcesandoNotario').show();
			$('#divMsgErrorProcesandoNotario').hide();
			$('#divMsgNoEncontradoNotario').hide();
			$('#divMsgDatoNoValidoNotario').hide();
			
			$('#divNumNotario').removeClass( 'has-error' );
			$('#divNotarioEntidadFederativa').removeClass( 'has-error' );
		}
		else{
			$('#divMsgProcesandoNotario').hide();
			$('#divMsgErrorProcesandoNotario').hide();
			$('#divMsgNoEncontradoNotario').hide();
			$('#divMsgDatoNoValidoNotario').hide();
			
			$('#divNumNotario').removeClass( 'has-error' );
			$('#divNotarioEntidadFederativa').removeClass( 'has-error' );

			if (_.size(this.errors) == 0)
			{
				$('#txtNombreCompletoNotario').val(this.model);
			}
			else
			{
				this.model = '';
				$('#txtNombreCompletoNotario').val('');
				_.each(this.errors, function(err){
					if(err == notarioWidget.ERROR){
						$('#divMsgErrorProcesandoNotario').show();
					}
					else if(err == notarioWidget.ERROR_NOT_FOUND){
						$('#divMsgNoEncontradoNotario').show();
					}
					else if(err == notarioWidget.ERROR_NOT_VALID_INPUT){
						$('#divMsgDatoNoValidoNotario').show();
						$('#divNumNotario').addClass( 'has-error' );
					}
				}, this);
			}
		}
	},
	
	events:{
		'blur #txtNumNotario': 'buscarNotario',
		'change #selNotarioEntidadFederativa': 'buscarNotario',
	},
	
	buscarNotario: function(e) {
		e.preventDefault();
		
		var numNotario = $('#txtNumNotario').val();
		var idEntidadFed = $('#selNotarioEntidadFederativa').val();
		var _url = this.ajaxUrl + '?idEntidadFederativa=' + idEntidadFed + '&numeroNotario=' + numNotario;
		var contexto = this;
		this.errors = []
		
		//valida antes de enviar solicitud
		if( isNaN( $.trim(numNotario) ) )
		{
			contexto.errors.push(notarioWidget.ERROR_NOT_VALID_INPUT);
			contexto.changeStateToListo();
		}
		else if($.trim(numNotario) != '' && idEntidadFed != 'null')
		{
			$.ajax({
				dataType: "json",
				url: _url,
				//data: data,
				success: function( data ){
					if(data.status == "OK")
					{
						contexto.model = data.nombreCompleto;
						contexto.changeStateToListo();
					}
					else if(data.status == "NOT_FOUND")
					{
						contexto.errors.push(notarioWidget.ERROR_NOT_FOUND);
						contexto.changeStateToListo();
					}
					else if(data.status == "NOT_VALID_INPUT")
					{
						contexto.errors.push(notarioWidget.ERROR_NOT_VALID_INPUT);
						contexto.changeStateToListo();
					}
					else
					{
						contexto.errors.push(notarioWidget.ERROR);
						contexto.changeStateToListo();
					}
				}
			});
			this.changeStateToProcesando();
		}
		else
		{
			this.model = '';
			this.changeStateToListo();
		}
		//alert(numNotario + ' ' + idEntidadFed)
	},
	
	changeStateToListo: function(){
		this.state = notarioWidget.LISTO;
		this.render();
	},
	changeStateToProcesando: function(){
		this.state = notarioWidget.PROCESANDO;
		this.render();
	}
});