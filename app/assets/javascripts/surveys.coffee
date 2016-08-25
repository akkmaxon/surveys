$(document).ready () ->
  $(".edit_survey input").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"
