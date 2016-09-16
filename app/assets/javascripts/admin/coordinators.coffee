resizeCoordinators = () ->
  paddingContainer = 2 * 15
  width = $(window).width()
  newWidth = if width < 768
    width - paddingContainer
  else if(width < 992)
    width / 2 - paddingContainer
  else if(width < 1300)
    width / 3 - paddingContainer
  else
    width / 4 - paddingContainer
  $('.coordinator').css('width', newWidth)

document.addEventListener "turbolinks:load", () ->
  resizeCoordinators()
  $(".generate_login").on "click", () ->
    login = Math.random().toString(36).slice(2, 7)
    $(".modal.fade.in input#coordinator_login").attr("value", login)
     
  $(".generate_password").on "click", () ->
    password = Math.random().toString(36).slice(2, 12)
    $(".modal.fade.in input#coordinator_password").attr("value", password)

  $('#all_coordinators').masonry({
    itemSelector: '.coordinator',
    gutter: 24,
    isFitWidth: true
  })

$(window).resize () ->
  resizeCoordinators()
