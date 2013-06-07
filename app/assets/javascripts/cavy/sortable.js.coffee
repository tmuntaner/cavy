jQuery ->
  $("#item_group_items tbody").sortable({
    axis: 'y',
    update: ->
      $.post($('#item_group_items').data('update-url'), $(this).sortable('serialize'))
  }).disableSelection();