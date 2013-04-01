(document).ready(function() {
  if ($('input[name=daterange-picker]').length != 0){
    $('input[name=daterange-picker]').daterangepicker();
  }
  if ($('input[name=bootstrap-date-picker]').length != 0){
    $('input[name=bootstrap-date-picker]').datepicker();
  }
});
