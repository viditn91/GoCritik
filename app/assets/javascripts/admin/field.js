var ready;

ready = function() {
  var scope = $(document).find('#field_type');
  field = new Field(scope);
  field.init();
}

function Field(scope) {
  this.field_type = scope.find('option:selected').text();
  this.scope = scope;
}

Field.prototype = {
  init: function() {
    var form_scope = this.scope.closest('.form');
    this.showOrHideElements(form_scope);
    this.bindEvents(form_scope);
  },

  bindEvents: function(form_scope) {
    // code to append options fields if selectbox/redio buttons are selected
    var that = this;
    form_scope.on('change','#field_type',function() {
      var scope = $(this);
      that.field_type = scope.find('option:selected').text();
      that.showOrHideElements(form_scope);
    });
    // code to append options if the add more options button is clicked
    form_scope.on('click','.link_to_add_option', function() {
      var scope = $(this).closest('.form');
      that.addOptions(scope);
      that.adjustOptions(scope);
    });
    // code to remove options if the remove button is clicked
    form_scope.on('click','.link_to_remove_option', function() {
      var scope = $(this).closest('.form');
      $(this).closest('div').remove();
      that.adjustOptions(scope);
    });
  },

  addOptions: function(scope) {
    var $options_container = scope.find('#options_container');
    $options_container.find('.link_to_add_option').remove();
    var appended_elements_string = '<div class="options-row"><input class="input-small" placeholder="Display Text" name="field[options][][text]" type="text" />'
     + '<input class="input-small" placeholder="Value" name="field[options][][value]" type="text" />' 
     + '<a class="link_to_remove_option">[-] Remove</a></div>'
     + '<a class="link_to_add_option">[+] Add Another Option</a>';
    $options_container.append(appended_elements_string);
  },

  adjustOptions: function(scope) {
    var option_rows = scope.find('.options-row');
    if(!option_rows.length) {
      this.addOptions(scope);
      option_rows = scope.find('.options-row');
      option_rows.first().find('.link_to_remove_option').hide();
    } else if(option_rows.length == 1) {
      option_rows.first().find('.link_to_remove_option').hide();
    } else {
      option_rows.first().find('.link_to_remove_option').show();
    }
  },

  showOrHideElements: function(scope) {
    scope.find('.default-field, .is-unique-field, .options-field, .input-type-field, .is-searchable-field, .is-sortable-field').show();
    if(this.field_type == 'Select Box' || this.field_type == 'Radio Buttons') {
      this.adjustOptions(scope);
      scope.find('.default-field, .is-unique-field, .is-searchable-field').hide();
    } else if(this.field_type == 'Check Box') {
      scope.find('.options-field, .default-field, .input-type-field, .is-unique-field, .is-searchable-field, .is-sortable-field').hide();
    } else {
      scope.find('.options-field, .is-sortable-field').hide();
    }
  }
};

  
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);