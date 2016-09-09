document.addEventListener "turbolinks:load", () ->
  $('#new_first_question').hide()
  $('#new_second_question').hide()
  $('.container_question_form').hide()
  $(".edit_question input[checked='checked']").parent().addClass('active')

  $('#add_first_question').on 'click', () ->
    $('#new_second_question').hide(300)
    $('#new_first_question').show(300)

  $('#add_second_question').on 'click', () ->
    $('#new_first_question').hide(300)
    $('#new_second_question').show(300)

  $('.edit_question_link').on 'click', () ->
    originalElement = $(@).parents('.question')
    originalElement.hide(300)
    originalElement.next().show(300)

  $('.cancel_question').on 'click', () ->
    originalElement = $(@).parents('.container_question_form')
    originalElement.hide(300)
    originalElement.prev().show(300) if originalElement.prev().hasClass('question')
