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
//= require jquery-ui
//= require bootstrap
//= require_tree .
//= require jquery_nested_form
//= require bootstrap-datepicker
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require chosen-jquery
//= require highcharts


$(function() {

  $('#send_regimen').click(function(){
    $('.edit_regime').submit();
  });

  $('.notification-bubble').click(function(){
	var pos = $('.icon-warning-sign').offset();
	$('.notification-list-wrapper').css({top: pos.top + 30, left: pos.left - 135});
	$('.notification-list-wrapper').show();	
});

  $('.close-notification-list').click(function(){
  	$('.notification-list-wrapper').hide();
  })
});

function updateBubble(count){
	if(count > 0){
		$('.notification-bubble').html(count);
		$('.notification-bubble').show();
		}
	else{
		$('.notification-bubble').hide();
	}
}
function updateNotifications(data){
	updateBubble(data.length);
	$('.notification-list').html("");
	$.each( data, function( key, val ) {
	 	$('.notification-list').append("<li class='notification-list-item' > <a href='" +  val.link + "' style='color: #666; font-family: verdana, arial, helvetica, sans-serif; font-size: 13px; line-height: 18px;' > " + val.message + "</a> </li>");
	});
}

function get_notifications(){
$.getJSON( "../../notifications", function( data ) {             
	updateNotifications(data);	
});
} 


