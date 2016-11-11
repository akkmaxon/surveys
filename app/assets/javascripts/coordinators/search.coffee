document.addEventListener "turbolinks:load", () ->
  $('#manage_bar #coord_users_search_results').on 'click', () ->
    $('#surveys_search_results').css('display', 'none')
    $('#users_search_results').css('display', 'block')

  $('#manage_bar #coord_surveys_search_results').on 'click', () ->
    $('#users_search_results').css('display', 'none')
    $('#surveys_search_results').css('display', 'block')
