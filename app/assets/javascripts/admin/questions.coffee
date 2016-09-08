document.addEventListener "turbolinks:load", () ->
  $('#new_first_question').hide()
  $('#new_second_question').hide()

  $('#add_first_question').on 'click', () ->
    $('#new_second_question').hide()
    $('#new_first_question').show(300)

  $('#add_second_question').on 'click', () ->
    $('#new_first_question').hide()
    $('#new_second_question').show(300)
