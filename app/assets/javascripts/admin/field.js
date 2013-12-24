var ready;

ready = function() {
  
  var scope = $(document).find('#field_field_type');
  show_or_hide_elements(scope);
  // code to append options fields if selectbox/redio buttons are selected
  $(document).on('change','#field_field_type',function() {
    var scope = $(this);
    scope.closest('.form').find('#options_container').html('');
    show_or_hide_elements(scope);
  });
  // code to append options if the add more options button is clicked
  $(document).on('click','.link_to_add_option', function() {
    var scope = $(this).closest('.form');
    add_options(scope);
    adjust_options(scope);
  });
  // code to remove options if the remove button is clicked
  $(document).on('click','.link_to_remove_option', function() {
    var scope = $(this).closest('.form');
    $(this).closest('div').remove();
    adjust_options(scope);
  });
};
// function to append option fields
add_options = function(form_scope) {
  var $options_container = form_scope.find('#options_container');
  $options_container.find('.link_to_add_option').remove();
  var appended_elements_string = '<div class="options-row"><input class="input-small" placeholder="Display Text" name="field[options][][text]" type="text" />'
   + '<input class="input-small" placeholder="Value" name="field[options][][value]" type="text" />' 
   + '<a class="link_to_remove_option">[-] Remove</a></div>'
   + '<a class="link_to_add_option">[+] Add Another Option</a>';
  $options_container.append(appended_elements_string);
}
// function to show/hide default/options fields according to the field type
show_or_hide_elements = function(scope) {
  var field_type = scope.find('option:selected').text();
  var form_scope = scope.closest('.form');
  form_scope.find('.default-field, .is-unique-field, .options-field, .input-type-field').show();
  if(field_type == 'Select Box' || field_type == 'Radio Buttons') {
    adjust_options(form_scope);
    form_scope.find('.default-field, .is-unique-field').hide();
    form_scope.find('#field_unique option').find('option[value="false"]').attr('selected', true);
  } else if(field_type == 'Check Box') {
    form_scope.find('.options-field, .default-field, .input-type-field, .is-unique-field').hide();
    form_scope.find('#field_input_type').find('option[value="Integer"]').attr('selected', true);
    form_scope.find('#field_unique').find('option[value="false"]').attr('selected', true);
  } else {
    form_scope.find('.options-field').hide();
  }
}

adjust_options = function(form_scope) {
  var option_rows = form_scope.find('.options-row');
  if(!option_rows.length) {
    add_options(form_scope);
    option_rows = form_scope.find('.options-row');
    option_rows.first().find('.link_to_remove_option').hide();
  } else if(option_rows.length == 1) {
    option_rows.first().find('.link_to_remove_option').hide();
  } else{
    option_rows.first().find('.link_to_remove_option').show();
  }
}

hide_fields = function(form_scope, fields) {

}

show_fields = function(form_scope, fields) {

}
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);