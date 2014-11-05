var app = app || {};

//este "implementación" de validador:
// -Solo permite subir un tipo de documento a la vez
// -Al "submitear" la información, valida que haya un documento por cada tipo

app.DOC_VAL_ERR_TYPE_ALRDY = 1;
app.DOC_VAL_ERR_FALTA_DOC_MSG = "Se requieren cargar todos los documentos de cada tipo";

app.DocsValidator = {
	docTypes: [], //tuplas con (idTipo,Cantidad) de los tipos de documento a cargar
	errors: [], //errType
	lastSubmitErrorMsg: "",
	
	addDocType: function(idTipo){
		this.docTypes.push("{ idTipo:"+idTipo+", cant:0 }");
	},
	
	submitValidation: function(collection){
		// -Al "submitear" la información, valida que haya un documento por cada tipo
		_.each(this.docTypes,function(item){
			item.cant = 0;
			collection.forEach(function(item2){
				if(item2.get('idTipo') == item.idTipo){
					item.cant++;
				}
			},this);
		}, this);
		
		//revisa si hay alguno que haya quedado con cantidad de 0,
		//de ser así entonces aun faltan documentos por subir.
		var valid = true;
		_.each(this.docTypes,function(item){
			if(item.cant == 0){
				valid = false;
			}
		}, this);
		if(valid==false){
			lastSubmitErrorMsg = app.DOC_VAL_ERR_FALTA_DOC_MSG;
		}
		else{
			lastSubmitErrorMsg = "";
		}
		return valid;
	},
	renderLastSubmitValidationMsg: function(){
		return lastSubmitErrorMsg;
	},
	
	validateBeforeUpload: function(collection,file,idTipo){
		console.log("validateBeforeUpload -> idTipo:"+idTipo);
		this.errors = new Array();
		//REVISA QUE SOLO HAYA UN TIPO POR IDTIPO
		var valid = true;
		collection.forEach(function(item){
			if(item.get('idTipo') == idTipo){
				valid = false;
			}
		}, this);
		if(valid == false)
			this.errors.push({ errType: app.DOC_VAL_ERR_TYPE_ALRDY, errMsg: 'Ya hay un documento del mismo tipo' });
		return valid;
	},
	renderLastBeforeUploadErrorsHtml: function(){
		var htmlString = "";
		_.each(this.errors, function(item){
			htmlString += '<span class="glyphicon glyphicon-ban-circle"></span> ' + item.errMsg;
		}, this);
		return htmlString;
	}
}