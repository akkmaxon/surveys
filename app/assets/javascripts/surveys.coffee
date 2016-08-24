$(document).ready () ->
  $(".radio input").on "change", () ->
    $("#submit_agreement").click()
