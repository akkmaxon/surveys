decreaseQuestionsCount = (id) ->
  elem = $("#{id} .badge")
  currentCount = Number(elem.text())
  elem.text(String(currentCount - 1))

prepareQuestionsPage = () ->
  $('.container_question_form').hide()
  $(".edit_question input[checked='checked']").parent().addClass('active')

document.addEventListener "turbolinks:load", () ->
  prepareQuestionsPage()

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

  $(".delete_question").on "ajax:success", (e, data, status, xhr) ->
    $(@).parents('.question').hide(300)
    decreaseQuestionsCount('#show_all_questions')
    if $(@).parents('.question').hasClass('management')
      decreaseQuestionsCount('#show_only_management_questions')
    else if $(@).parents('.question').hasClass('working_staff')
      decreaseQuestionsCount('#show_only_working_staff_questions')

  $(".edit_question").on "ajax:success", (e, data, status, xhr) ->
    # form for question
    originalElement = $(@).parents('.container_question_form')
    originalElement.hide(300)
    # view question
    elemToUpdate = originalElement.prev()
    elemToUpdate.replaceWith xhr.responseText
    # delete form and change view with response from server
    originalElement.remove()
    elemToUpdate.show(300)
    prepareQuestionsPage()
