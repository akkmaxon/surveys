document.addEventListener "turbolinks:load", () ->
  $("#new_company").hide()
  $(".edit_company").hide()

  $("#add_company").on "click", () ->
    $(@).hide(300)
    $("#new_company").show(300)

  $(".update_company").on "click", () ->
    $(@).hide()
    $(@).parent().next().remove()
    $(@).parent().next().show(300)
