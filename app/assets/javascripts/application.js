// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
  $(".not_logged_in").click(function(){
    alert("You must be logged in to check out!")
  });

  $("input[type=checkbox]").click(function(){
    var category = $(this).val();
    // var $all = $('.categories').hide();
    $('.' + category).toggle("show");
  });

	$("input[type=checkbox]").click(function(){
		var supplier = $(this).val();
	//	var $all = $('.suppliers').hide();
		$('.' + supplier).toggle('show');
	});
});
