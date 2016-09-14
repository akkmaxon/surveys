resizeSurveys = () ->
  paddingContainer = 2 * 15
  width = $(window).width()
  newWidth = if width < 992
    width - paddingContainer
  else if(width < 1300)
    width / 2 - paddingContainer
  else
    width / 3 - paddingContainer
  $('.survey').css('width', newWidth)

document.addEventListener "turbolinks:load", () ->
  resizeSurveys()

  $('#all_surveys').masonry({
    itemSelector: '.survey',
    gutter: 24,
    isFitWidth: true
  })

$(window).resize () ->
  resizeSurveys()