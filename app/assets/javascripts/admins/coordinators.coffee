document.addEventListener "turbolinks:load", () ->
  $(".generate_login").on "click", () ->
    login = Math.random().toString(36).slice(2, 7)
    $(".modal.fade.in input#coordinator_login").attr("value", login)
     
  $(".generate_password").on "click", () ->
    password = Math.random().toString(36).slice(2, 12)
    $(".modal.fade.in input#coordinator_password").attr("value", password)
