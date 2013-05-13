// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require jquery_nested_form

$(function() {

$('#send_regimen').click(function(){

  
  $('.horario_val').each( function(){

    var id = $(this).parents(".accordion-body").attr('id');

    if(id == "collapseDesayuno"){
      $(this).val(1);

    }

    else if( id == "collapseAlmuerzo" ){
      $(this).val(2);
    }

    else{
      $(this).val(3);

    }
    
  });

  $('.edit_regime').submit();


});

});