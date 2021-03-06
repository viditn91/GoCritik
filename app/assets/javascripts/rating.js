var ready;

ready = function() {
  var scope = $('#resource-header .rateit');
  var orig_value = scope.rateit('value');
  var counter = 0;
  scope.on('rated', function (e) {
    var ri = $(this);
    var this_permalink = window.location.pathname.substring(1).split('/').pop();
    var value = ri.rateit('value');
    if(!counter && !orig_value) {
      ajaxCall('/ratings.js', { rating: { value: value, permalink: this_permalink }}, 'POST', '', '' );
      counter++;
    } else {
      ajaxCall('/ratings/update.js', { rating: { value: value, permalink: this_permalink }}, 'PUT', '', '' );
    }
  });
}

ajaxCall = function(url, data, type, on_success, on_error) {
  $.ajax({
    url: url,
    data: data,
    type: type,
    success: function (data) {
      eval(on_success);
    },
    error: function (jxhr, msg, err) {
      eval(on_error);
    }
  });
}
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load',ready);