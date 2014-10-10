$(function () {
  $('.datetimepicker').datetimepicker();
  $('[data-toggle="tooltip"]').tooltip();

  $('select[name="labels[]"]').select2({
    placeholder: 'Select a Label'
  });

  var snapper = new Snap({
    element: document.getElementById('content')
  });

  $('.toggle-menu').on('click', function(){
    if( snapper.state().state == 'left' ) {
        snapper.close();
    } else {
        snapper.open('left');
    }
  })

  snapper.open('left');
});
