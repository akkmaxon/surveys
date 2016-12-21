document.addEventListener "turbolinks:load", () ->
  $("#add_new_work_position").hide()
  $(".edit_work_position").hide()

  $("#add_work_position").on "click", () ->
    $("#add_new_work_position").toggle(300)

  $(".edit_work_position_link").on "click", () ->
    $(@).hide()
    $(@).parent().next().remove()
    $(@).parent().next().show(300)
