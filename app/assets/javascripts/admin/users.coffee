$(document).ready () ->
  $("#generate_login").on "click", () ->
    login = Math.random().toString(36).slice(2, 8)
    $("input#user_login").attr "value", login
     
  $("#generate_password").on "click", () ->
    password = Math.random().toString(36).slice(2, 12)
    $("input#user_password").attr "value", password
