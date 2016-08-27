$(document).ready () ->
  $(".new_info input[type='radio']").on "click", () ->
    $(".new_info .actions").css("display", "block")
