document.addEventListener "turbolinks:load", () ->
  $('.edit_survey input[checked="checked"]').parent().addClass('active')
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
    currentQ = $(@).parents('.response')
    nextQ = currentQ.next()
    currentQ.remove()
    nextQ.css('display', 'block')

    updateProgressBar()
    # end of the game
    if finishedSurvey()
      $('#second_questions').remove()
      $("#finish_survey").css('display', 'block').removeClass("disabled")
    # finishing 1 questions
    if ($('.submit_questions_1').size() is 0) and ($("#first_questions").size() isnt 0)
      $("#first_questions").remove()
      $("#second_questions").css('display', 'block')

  # 1 questions radios
  $(".new_response input[type='radio']").on "change", () ->
    submitId = $(@).attr('class')
    submitButton = $(".submit_questions_1##{submitId}")
    submitButton.click()

  # after survey
  $("#agreement input[type='radio']").on "change", () ->
    $("#submit_agreement").click()
    $("#agreement").slideUp(300)

  $("#email_field .edit_survey").on "ajax:success", (e, data, status, xhr) ->
    $("#email_field").slideUp(300)
