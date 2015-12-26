// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery/dist/jquery.min.js
//= require jquery-ujs/src/rails.js
//= require jquery-ui/jquery-ui.min.js
//= require bootstrap/dist/js/bootstrap.min.js
//= require medium-editor/dist/js/medium-editor
//= require handlebars/handlebars.runtime.min.js
//= require jquery-sortable/source/js/jquery-sortable-min.js
//= require blueimp-file-upload/js/vendor/jquery.ui.widget.js
//= require blueimp-file-upload/js/jquery.iframe-transport.js
//= require blueimp-file-upload/js/jquery.fileupload.js
//= require medium-editor-insert-plugin/dist/js/medium-editor-insert-plugin.min.js
//= require turbolinks
//= require_tree .



$(document).ready (function(){
  // hide alert automatically
  $(".alert").fadeTo(2000, 500).slideUp(300, function(){
    $(".alert").alert('close');
  });

  // Medium-Editor
  $('.editable').bind('input propertychange', function() {
    $("#article_" + $(this).attr("data-field-id")).val($(this).html().replace("#{params[:files]}", "url"));
  });
});

$(function () {
  $(".editable").mediumInsert({
    editor: editor,
    addons: {
      images: {
        fileUploadOptions: {
          url: '/article_images',
          paramName: 'article_image[image]',
          acceptFileTypes: /(.|\/)(gif|jpe?g|png)$/i
        },
        deleteScript: '/article_images/destroy',
        deleteMethod: 'DELETE'
      }
    }
  });
});
