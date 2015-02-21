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

var checkBox = "input[type=checkbox]";
var checked = "input[type=checkbox]:checked";

// filters the suppliers items from checkbox clicked
var $filterSupplierItems =     $(".supplier_list" + '' + checkBox).click(function(){
  $('.suppliers').hide();
  var $selectedSupplier = $(checked).map(function(index, element){
    return '.' + $(element).val()
  });
  var suppliers = $.makeArray($selectedSupplier).join(",");
  suppliers ? $(suppliers).show() : $('.suppliers').show();
});


// filters the categories from the checkbox clicked
var $filterCategoryItems = $(checkBox).click(function(){
  $('.categories').hide();
  var $selected = $(checked).map(function (index, element) {
    return '.' + $(element).val()
  });
  var categories = $.makeArray($selected).join(',');
  categories ? $(categories).show() : $('.categories').show();
});


$(document).ready(function(){
  $(".not_logged_in").click(function(){
    alert("You must be logged in to check out!")
  });

    $filterCategoryItems;
    $filterSupplierItems;

    $('#order-tabs a[href="#status-ordered"]').click(function (e) {
      e.preventDefault()
      $(this).tab('show')
    })

    $('#order-tabs a[href="#status-cancelled"]').click(function (e) {
      e.preventDefault()
      $(this).tab('show')
    })

    $('#order-tabs a[href="#status-shipped"]').click(function (e) {
      e.preventDefault()
      $(this).tab('show')
    })

});
