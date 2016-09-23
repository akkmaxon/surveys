document.addEventListener "turbolinks:load", () ->
  $("#add_new_company").hide()
  $(".edit_company").hide()

  $("#add_company").on "click", () ->
    $("#add_new_company").toggle(300)

  $(".edit_company_link").on "click", () ->
    $(@).hide()
    $(@).parent().next().remove()
    $(@).parent().next().show(300)
