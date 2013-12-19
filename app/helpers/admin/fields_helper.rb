module Admin::FieldsHelper

  def make_hash_readable(options_hash)
    str = ''
    options_hash.each do |hash|
      str += "Option: #{hash[:text]}, Value: #{hash[:value]} \n"
    end
    str
  end

  def get_field_type_display_value(field_type)
    FieldTypeArray.each do |text, value|
      return text if value == field_type
    end
  end

end
