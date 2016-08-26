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

  $(".edit_survey input").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"

  $(".new_response").on "ajax:success", (e, data, status, xhr) ->
    $(@).parent().parent().hide(200)
    updateProgressBar()
    if finishedSurvey()
      $("#finish_survey").removeClass("disabled")
