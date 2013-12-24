APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../config.yml', __FILE__)))
ResourceName = APP_CONFIG[:resource][:name]

InputTypeHash = [ {name: 'String' , regexp: /\A([^\t\n]{,256})\Z/ },
{name: 'Text' , regexp: /\A[^\t\n]+\Z/ },
{name: 'Integer' , regexp: /\A[\d]+\Z/ },
{name: 'Float' , regexp: /(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))/ },
{name: 'Boolean' , regexp: /(true|false)/ }]

FieldTypeArray = [['Text Field','text_field'], ['Text Area', 'text_area'], ['Select Box', 'select'],
  ['Radio Buttons', 'radio_button'], ['Check Box', 'check_box']]