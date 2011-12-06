// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function(){
	prettyPrint();
	
	$("#search").bind("keyup", function() {
	  	$("#note-list").addClass("loading"); // show the spinner
	  	var form = $("#search-form"); // grab the form wrapping the search bar.
	  	var url = "/notes/search"; // live_search action.  
	  	var formData = form.serialize(); // grab the data in the form  
	  	$.get(url, formData, function(html) { // perform an AJAX get
	    	$("#note-list").removeClass("loading"); // hide the spinner
	    	$("#note-list").html(html); // replace the "results" div with the results
	  	});
	}); 
}); 