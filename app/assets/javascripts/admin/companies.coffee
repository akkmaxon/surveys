$paddingContainer = 15

resizeCompanies = () ->
  $width = $(window).width()
  newWidth = if $width < 992
    $width - 2 * $paddingContainer
  else if($width < 1300)
    $width / 2 - 2 * $paddingContainer
  else
    $width / 3 - 2 * $paddingContainer
  $('.company').css('width', newWidth)

document.addEventListener "turbolinks:load", () ->
  resizeCompanies()
  $("#add_new_company").hide()
  $(".edit_company").hide()

  $("#add_company").on "click", () ->
    $(@).hide(300)
    $("#add_new_company").show(300)

  $(".update_company").on "click", () ->
    $(@).hide()
    $(@).parent().next().remove()
    $(@).parent().next().show(300)

  $('#all_companies').masonry({
    itemSelector: '.company',
    gutter: 24,
    isFitWidth: true
  })

$(window).resize () ->
  resizeCompanies()
