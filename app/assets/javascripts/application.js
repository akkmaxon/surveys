// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

var resizeMasonryElements = function() {
  var containerPaddings, width, newWidth
  containerPaddings = 2 * 15
  width = $(window).width()
  if (width < 992) {
    newWidth = width - containerPaddings
  }
  else if (width < 1300) {
    newWidth = width / 2 - containerPaddings
  }
  else {
    newWidth = width / 3 - containerPaddings
  }
  $('.masonry_element').css('width', newWidth)
}

document.addEventListener("turbolinks:load", function() {
  $('[title]').tooltip({ placement: 'top' });
  resizeMasonryElements()
  hideMessages = function() {
    $('#messages .alert').slideUp(300)
    $('#error_explanation').slideUp(300)
  }
  setTimeout(hideMessages, 2000)

  $('#masonry_container').masonry({
    itemSelector: '.masonry_element',
    gutter: 24,
    isFitWidth: true
  })
});

$(window).resize(function () {
  resizeMasonryElements()
});
