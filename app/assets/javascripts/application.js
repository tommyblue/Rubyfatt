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
//= require jquery.ui.all
//= require bootstrap-dropdown
//= require bootstrap-alert
//= require bootstrap-modal
//= require bootstrap-transition
//= require bootstrap-tooltip
//= require tinycon.min
//= require d3.v3
//= require xcharts

$(document).ready(function(){
  $('input.datepicker').datepicker({ dateFormat: 'dd/mm/yy' });
  $('[rel=tooltip]').tooltip();
  // Focus sul campo data se si clicca sul calendario
  $('form .add-on .icon-calendar').click(function(){
    var el = this.parentNode.parentNode;
    $(el).find('input').focus();
  });
})
