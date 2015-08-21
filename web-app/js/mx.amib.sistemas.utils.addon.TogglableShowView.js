/*

	@author Gabriel Medina
	
	haciendo uso del atributo class con los tags
	toggle
	toggle-n
	section-n
	expand-all
	collapse-all
	
	junto con el atributo data-toggle-idx="n"
	
	siendo 'n' un indice del 0 al 9
	
	hace que los fieldset sean "togglable"
	
	
	
	Diseñado para trabajar junto con backbone.js y bootstrap
*/

var app = app || {};

app.TogglableShowVM = Backbone.Model.extend({
	defaults: {
		showFieldset : [ true,true,true,true,true,true,true,true,true,true ],
		notify : 0
	},
	notifyChange: function(){
		this.set('notify', this.get('notify')+1 );
	}
});

app.TogglableShowView = Backbone.View.extend({
	el:'body',

	initialize: function(){
		this.model = new app.TogglableShowVM();
		this.listenTo(this.model, 'change:notify', this.render );
		this.render();
	},

	render: function(){
		var flagArray = this.model.get('showFieldset');
		var flagArraySize = flagArray.length;
		
		for(var i=0; i < flagArraySize; i++){
			if(flagArray[i] == true){
				this.$(".toggle-"+i).removeClass( "glyphicon-plus-sign" ).addClass( "glyphicon-minus-sign" );
				this.$(".section-"+i).show();
			}
			else{
				this.$(".toggle-"+i).removeClass( "glyphicon-minus-sign" ).addClass( "glyphicon-plus-sign" );
				this.$(".section-"+i).hide();
			}
		}
	},

	events: {
		'click .toggle':'toggleFieldset',
		'click .expand-all':'expandAllFieldset',
		'click .collapse-all':'collapseAllFieldset'
	},

	toggleFieldset: function(e){
		e.preventDefault();
		
		var idx = parseInt(this.$(e.currentTarget).data("toggle-idx"));
		var flagArray = this.model.get('showFieldset');
		
		flagArray[idx] = !flagArray[idx];
		
		this.model.notifyChange();
	},
	expandAllFieldset: function(e){
		e.preventDefault();
		
		var flagArray = this.model.get('showFieldset');
		var flagArraySize = flagArray.length;
		for(var i=0; i < flagArraySize; i++){
			flagArray[i] = true;
		}

		this.model.notifyChange();
	},
	collapseAllFieldset: function(e){
		e.preventDefault();
		
		var flagArray = this.model.get('showFieldset');
		var flagArraySize = flagArray.length;
		for(var i=0; i < flagArraySize; i++){
			flagArray[i] = false;
		}

		this.model.notifyChange();
	}
});