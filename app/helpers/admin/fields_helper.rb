module Admin::FieldsHelper

  def get_input_types
    InputTypeHash.map do |hash|
      hash[:name]
    end
  end

  def make_hash_readable(options_hash)
    str = ''
    options_hash.each do |hash|
      str += "Option: #{hash[:text]}, Value: #{hash[:value]} \n"
    end
    str
  end

  def get_field_type_display_value(type)
    FieldTypeArray.each do |text, value|
      return text if value == type
    end
  end

end
