searchUsers = (keyword) ->
  'search users' # TODO

document.addEventListener "turbolinks:load", () ->
  $(".generate_login").on "click", () ->
    login = Math.random().toString(36).slice(2, 7)
    $(".modal.fade.in input#user_login").attr("value", login)
     
  $(".generate_password").on "click", () ->
    password = Math.random().toString(36).slice(2, 12)
    $(".modal.fade.in input#user_password").attr("value", password)

  $('#search').on 'keyup', () ->
    keyword = document.getElementById('search').value
    searchUsers(keyword)
