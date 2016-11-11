document.addEventListener "turbolinks:load", () ->
  $('.container_question_form').hide()
  $(".edit_question input[checked='checked']").parent().addClass('active')

  $('.edit_question_link').on 'click', () ->
    originalElement = $(@).parents('.question')
    originalElement.hide(300)
    originalElement.next().show(300)

  $('.cancel_question').on 'click', () ->
    originalElement = $(@).parents('.container_question_form')
    originalElement.hide(300)
    originalElement.prev().show(300) if originalElement.prev().hasClass('question')

  $('.modal .cancel_question').removeClass('cancel_question').addClass('modal_dismiss')
  $('.modal .modal_dismiss').attr('data-dismiss', 'modal')

  $('#manage_bar #show_all_questions').on 'click', () ->
    $('.question').css('display', 'block')

  $('#manage_bar #show_only_management_questions').on 'click', () ->
    $('.question.working_staff').css('display', 'none')
    $('.question.management').css('display', 'block')

  $('#show_only_working_staff_questions').on 'click', () ->
    $('.question.management').css('display', 'none')
    $('.question.working_staff').css('display', 'block')
