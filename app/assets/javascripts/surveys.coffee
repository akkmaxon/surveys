$(document).ready () ->
  parseProgressBarId = () ->
    [checked, total] = $(".progress-bar").attr('id').split '/'
    [Number(checked), Number(total)]

  finishedSurvey = () ->
    [checked, total] = parseProgressBarId()
    checked is total

  updateProgressBar = () ->
    [wasChecked, total] = parseProgressBarId()
    nowChecked = wasChecked + 1
    newId = "#{nowChecked}/#{total}"
    $('.progress-bar').text(newId)
    $('.progress-bar').attr('id', newId)
    $('.progress-bar').css('width', "#{nowChecked/total * 100}%")

  $(".new_response").on "ajax:success", (e, data, status, xhr) ->
    currentTr = $(@).parent().parent()
    nextTr = currentTr.next()
    currentTr.remove()
    nextTr.css('display', 'block')
    updateProgressBar()
    # end of the game
    if finishedSurvey()
      $("#finish_survey").css('display', 'block').removeClass("disabled")
    # finishing 1 questions
    if ($('.submit_question_1').size() is 0) and $("#first_questions").size() isnt 0
      $("#first_questions").remove()
      $("#second_questions").css('display', 'block')
    # finishing 2 questions
    if $('.submit_question_2').size() is 0
      $('#second_questions').remove()

  # 1 questions radios
  $(".new_response input[type='radio']").on "change", () ->
    submitId = $(@).attr('class')
    submitButton = $(".submit_question_1##{submitId}")
    submitButton.click()

  # 2 questions forms
  $(".new_response .submit_question_2").on "click", () ->
    form = $(@).parent()
    form.parent().parent().css('display', 'none')

  # after survey
  $(".edit_survey input[type='radio']").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"
