var app = app || {};

app.APODERADOS_READY = 0;
app.APODERADOS_VALIDATED = 1;
app.APODERADOS_PROC = 2;

app.APODERADOS_ERRMSG_NOAPO = "";
app.APODERADOS_ERRMSG_NOTFOUND = "";
app.APODERADOS_ERRMSG_ALREADY = "";

app.Apoderado = Backbone.Model.extend ({
	defaults: {
		grailsId: -1,
		idCertificacion: -1,
		nombreCompletoSustentante: "",
		varianteFiguraNombre: "",
		figuraNombre: ""
	}
});

app.Apoderados = Backbone.Collection.extend({
	model: app.Apoderado
});

app.ApoderadoView = Backbone.View.extend({
});

app.ApoderadosView = Backbone.View.extend({
});