prepareQuestionsPage = () ->
  $('.container_question_form').hide()
  $(".edit_question input[checked='checked']").parent().addClass('active')

tuneManageBar = () ->
  # management
  elem = $("#show_only_management_questions .badge")
  managementCount = $('.management').size()
  elem.text String(managementCount)
  # working staff
  elem = $("#show_only_working_staff_questions .badge")
  workingStaffCount = $('.working_staff').size()
  elem.text String(workingStaffCount)
  # all
  elem = $("#show_all_questions .badge")
  totalCount = managementCount + workingStaffCount
  elem.text String(totalCount)

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
    parent = $(@).parents('.question')
    parent.replaceWith "<p class=\"alert alert-success\">Вопрос удален</p>"
    tuneManageBar()

  $('.edit_question').on "ajax:success", (e, data, status, xhr) ->
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
    tuneManageBar()
