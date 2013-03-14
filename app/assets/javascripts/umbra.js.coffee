$ -> 
  $("*[type='submit'][data-remote='true']").hide()
  $(".remove").html('<i class="icon-remove"></i>')
  $(".facets .label").removeClass("label")
  new window.nyulibraries.Tooltip('.record-help').html(false).trigger('hover').init()
  $("#show_user").find("input[type='checkbox']").live 'change', ->
    $(this).closest("form").submit()
