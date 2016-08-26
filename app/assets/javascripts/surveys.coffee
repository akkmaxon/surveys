$(document).ready () ->
  finishedSurvey = () ->
    text = $(".progress").text().trim()
    [checked, total] = text.split '/'
    checked is total

  updateProgressBar = () ->
    total = $('.new_response').size()
    checked = $('.checked_response').size()
    progressBar = $('.progress-bar')
    $(progressBar).text("#{checked}/#{total}")
    $(progressBar).css('width', "#{checked/total * 100}%")

  updateProgressBar()

  $(".edit_survey input").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"

  $(".new_response input[type='radio']").on "change", () ->
    $(@).parent().parent().addClass 'checked_response'
    updateProgressBar()
    if finishedSurvey()
      $("#finish_survey").removeClass("disabled")
