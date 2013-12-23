var ready;
ready = function() {
  // code to uncheck a checked radio button once its clicked.
  // var radioChecked;
  $(':radio').mousedown(function(e){
    var $self = $(this);
    if( $self.is(':checked') ){
      var uncheck = function(){
        setTimeout(function(){$self.removeAttr('checked');},0);
      };
      var unbind = function(){
        $self.unbind('mouseup',up);
      };
      var up = function(){
        uncheck();
        unbind();
      };
      $self.bind('mouseup',up);
      $self.one('mouseout', unbind);
    }
  });
};
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);