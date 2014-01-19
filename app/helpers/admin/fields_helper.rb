module Admin::FieldsHelper

  def get_input_types
    InputTypeHash.map do |hash|
      hash[:name]
    end
  end

  def make_hash_readable(options_hash)
    ## fixed
    ## This too would work:
    options_hash.inject('') { |str,hash| str += "Option: #{hash[:text]}, Value: #{hash[:value]} \n" }
  end

  def get_field_type_display_value(type)
    FieldTypeArray.each do |text, value|
      return text if value == type
    end
  end

  def options_field?(attr, field)
    attr == 'options' && field.try(attr.to_sym)
  end 

  def boolean_field?(attr)
    attr.in? ['required', 'unique', 'searchable', 'sortable']
  end

  def type_field?(attr)
    attr == 'type'
  end

end
