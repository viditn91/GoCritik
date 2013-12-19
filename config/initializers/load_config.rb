APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../config.yml', __FILE__)))
ResourceName = APP_CONFIG[:resource][:name]

InputTypeArray = ['String', 'Integer', 'Decimal', 'Time', 'Date', 'Boolean']

FieldTypeArray = [['Text Field','text_field'], ['Text Area', 'text_area'], ['Select Box', 'select'],
  ['Radio Buttons', 'radio_button_tag']]