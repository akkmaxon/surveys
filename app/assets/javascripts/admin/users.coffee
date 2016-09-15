resizeUsers = () ->
  paddingContainer = 2 * 15
  width = $(window).width()
  newWidth = if width < 992
    width - paddingContainer
  else if(width < 1300)
    width / 2 - paddingContainer
  else
    width / 3 - paddingContainer
  $('.user').css('width', newWidth)

searchUsers = (keyword) ->
  'search users' # TODO

document.addEventListener "turbolinks:load", () ->
  resizeUsers()
  $(".generate_login").on "click", () ->
    login = Math.random().toString(36).slice(2, 8)
    $(".modal.fade.in input#user_login").attr("value", login)
     
  $(".generate_password").on "click", () ->
    password = Math.random().toString(36).slice(2, 12)
    $(".modal.fade.in input#user_password").attr("value", password)

  $('#all_users').masonry({
    itemSelector: '.user',
    gutter: 24,
    isFitWidth: true
  })

  $('#search').on 'keyup', () ->
    keyword = document.getElementById('search').value
    searchUsers(keyword)

$(window).resize () ->
  resizeUsers()
