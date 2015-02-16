// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
var orig;
var value2;
var value;
var remaining;
var value1;


$(document).ready(function() {

	orig = $("#count").text();
	count = 0;
	//count = parseInt(orig, 10);
	remaining = orig;
	value = $('#count').val();
	value1 = $('#count').text();

	//alert(value2);
//	alert($("#count").text());
});


$(document).ready(function(){
    $('.jqtextarea').keyup(function() {
     //   alert(value2);'
    	count = $('.jqtextarea').val().length;
        remaining = orig - count;
       // remaining = orig - count;
        $("#count").text(remaining);
    });
});