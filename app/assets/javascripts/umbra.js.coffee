$ ->
  $("*[type='submit'][data-remote='true']").hide()
  $("#show_user").on 'change', "input[type='checkbox']", ->
    $(this).closest("form").submit()
