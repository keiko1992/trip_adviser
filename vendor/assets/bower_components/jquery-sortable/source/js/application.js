//= require "jquery-sortable/source/js/vendor/jquery"
//= require "jquery-sortable/source/js/vendor/jquery.color"
//= require "jquery-sortable/source/js/vendor/bootstrap-switch"
//= require "jquery-sortable/source/js/vendor/bootstrap-scrollspy"
//= require "jquery-sortable/source/js/vendor/bootstrap-dropdown"
//= require "jquery-sortable/source/js/vendor/bootstrap-button"
//= require "jquery-sortable/source/js/jquery-sortable"
//= require_directory "./examples/"

$(function  () {
  if(!/test/.test(window.location.pathname))
    $('body').scrollspy()
  $('.show-code').on('click', function  () {
    $(this).closest('.row').children('.example').slideToggle()
  })
  $('ol.default').sortable()
})
