document.addEventListener "turbolinks:load", () ->
  $('#manage_bar #show_users_search_results').on 'click', () ->
    for model in ['coordinators', 'companies', 'questions']
      $("##{model}_search_results").css('display', 'none')
    $('#users_search_results').css('display', 'block')

  $('#manage_bar #show_coordinators_search_results').on 'click', () ->
    for model in ['users', 'companies', 'questions']
      $("##{model}_search_results").css('display', 'none')
    $('#coordinators_search_results').css('display', 'block')

  $('#manage_bar #show_companies_search_results').on 'click', () ->
    for model in ['users', 'coordinators', 'questions']
      $("##{model}_search_results").css('display', 'none')
    $('#companies_search_results').css('display', 'block')

  $('#manage_bar #show_questions_search_results').on 'click', () ->
    for model in ['users', 'coordinators', 'companies']
      $("##{model}_search_results").css('display', 'none')
    $('#questions_search_results').css('display', 'block')
