$(document).ready(function() {
  $('input[type="radio"]').on('change', function() {
    if ($(this).is(':checked')) {
      $(this).closest('.option').addClass('active');
    } else {
      $(this).closest('.option').removeClass('active');
    }
  });
});
