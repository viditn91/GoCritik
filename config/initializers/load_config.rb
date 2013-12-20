APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../config.yml', __FILE__)))
ResourceName = APP_CONFIG[:resource][:name]

InputTypeHash = [ {name: 'String' , regexp: /[\w]+/ },
{name: 'Text' , regexp: /[\w]+/ },
{name: 'Integer' , regexp: /[\d]+/ },
{name: 'Float' , regexp: /(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))/ },
{name: 'Boolean' , regexp: /[true|false]/ }]

FieldTypeArray = [['Text Field','text_field'], ['Text Area', 'text_area'], ['Select Box', 'select'],
  ['Radio Buttons', 'radio_button_tag']]