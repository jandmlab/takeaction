jQuery.fn.exists = function() { return this.length > 0; }

$(document).ready(function() {

  if ($('.well').exists()) {
    $('.well').css('display', 'none');
    
    $('.actions').chosen();
    
    $('.actions').change(function() {
      $(this).parent().children('.notes').children('.well').css('display', 'none');
      $(this).parent().children('.notes').children('.' + $(this).val()).css('display', 'block');
    });
  }

});