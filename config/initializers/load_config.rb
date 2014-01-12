APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../config.yml', __FILE__)))
ResourceName = APP_CONFIG[:resource][:name]
ResourceTrivia = APP_CONFIG[:resource][:about_us]

InputTypeHash = [ {name: 'String' , regexp: /\A([^\t\n]{,256})\Z/ },
{name: 'Text' , regexp: /\A[^\t\n]+\Z/ },
{name: 'Integer' , regexp: /\A[\d]+\Z/ },
{name: 'Float' , regexp: /\A(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))\Z/ },
{name: 'Boolean' , regexp: /\A(true|false)\Z/i }]

FieldTypeArray = [['Text Field','TextField'], ['Text Area', 'TextAreaField'], ['Select Box', 'SelectBoxField'],
  ['Radio Buttons', 'RadioButtonField'], ['Check Box', 'CheckBoxField']]