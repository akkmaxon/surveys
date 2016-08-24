$(document).ready () ->
  $(".radio input").on "change", () ->
    $("#submit_agreement").click()
    $("#email_field").css "display", "block"
