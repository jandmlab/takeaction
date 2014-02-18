jQuery.fn.exists = function() { return this.length > 0; }

$(document).ready(function() {

  if ($('.well').exists()) {
    $('.well').css('display', 'none');

    $('.actions').change(function() {
      $(this).parent().children('.notes').children('.well').css('display', 'none');
      $(this).parent().children('.notes').children('.' + $(this).val()).css('display', 'block');
    });
    
    $('input.prefix').keyup(function() {
      $(this).parent().children('.note').children('.label').children('.prefix-preview').html($(this).val());
    });
  }

});
