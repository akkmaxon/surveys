document.addEventListener "turbolinks:load", () ->
  $("#new_company").hide()
  $("#add_company").on "click", () ->
    $(@).hide(500)
    $("#new_company").show(500)
