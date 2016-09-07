document.addEventListener "turbolinks:load", () ->
  $(".new_info input[type='radio']").on "change", () ->
    $(".new_info .actions").css("display", "block")

  $(".edit_info input[checked='checked']").parent().addClass('active')
