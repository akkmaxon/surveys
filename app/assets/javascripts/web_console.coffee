document.addEventListener "turbolinks:load", () ->
  $('#console').hide()

  $('#console-toggle').click () ->
    $('#console').toggle()
