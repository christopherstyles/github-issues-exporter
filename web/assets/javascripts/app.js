$(function () {
  $('.datetimepicker').datetimepicker();
  $('[data-toggle="tooltip"]').tooltip();

  $('select[name="labels[]"]').select2({
    placeholder: 'Select a Label'
  });
});
