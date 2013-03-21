$ -> 
  $("*[type='submit'][data-remote='true']").hide()
  $(".remove").html('<i class="icon-remove"></i>')
  $(".facets .label").removeClass("label")
  new window.nyulibraries.Tooltip('.record-help').html(false).trigger('hover').init()
  $("#show_user").on 'change', "input[type='checkbox']", ->
    $(this).closest("form").submit()
