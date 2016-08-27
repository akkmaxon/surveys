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
    $(@).parent().parent().hide(200)
    updateProgressBar()
    if finishedSurvey()
      $("#finish_survey").removeClass("disabled")

  $(".new_response input[type='radio']").on "change", () ->
    submitId = $(@).attr('class')
    $(".submit_question##{submitId}").click()

  $(".new_response .submit_question_2").on "click", () ->
    form = $(@).parent()
    form.parent().parent().hide(200)

  $(".edit_survey input[type='radio']").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"
