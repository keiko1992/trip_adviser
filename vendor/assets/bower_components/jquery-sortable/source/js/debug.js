//= require "jquery-sortable/source/js/vendor/jquery"
//= require "jquery-sortable/source/js/jquery-sortable"

$(function () {
	$('#root.region').sortable({
		group: 'nested',
		itemSelector: '.part, .layout',
    containerSelector: '.region',
		nested: true,
		placeholder: '<div class="placeholder">Drop here</div>',
	});
})
