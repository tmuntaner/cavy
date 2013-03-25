jQuery(window).on('mercury:ready', function() {
   var link = $('#edit_link');
   if (typeof link.data('save-url') != 'undefined') {
      console.log('only set saveUrl if it exists');
      Mercury.saveUrl = link.data('save-url');
   }
  console.log(Mercury.saveUrl); //<-- should be valid
  link.hide();
});