module Admin::ResourcesHelper

  def get_field_value(resource, field)
    value = resource.fields_values.find_by(field_id: field.id).try(:value) 
    value = get_disp_text(field.options, value) if field.options.present?
    # handling boolean value 'false' exception
    value.blank? ? (value == false ? "false" : "- NA -") : value
  end

  def options_array_from_hash(options_hash)
    options_array = []
    options_hash.each do |hash|
      options_array << hash.values
    end
    options_array
  end
  
  def get_disp_text(options_hash, value)
    options_hash.each do |hash|
      return hash[:text] if hash[:value] == value.to_s
    end
    nil
  end
end
