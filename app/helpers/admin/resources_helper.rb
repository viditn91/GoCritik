module Admin::ResourcesHelper

  def get_field_value(resource, field)
    resource.fields_values.find_by(field_id: field.id).try(:value) || "- NA -"
  end

  def options_array_from_hash(options_hash)
    options_array = []
    options_hash.each do |hash|
      options_array << hash.values
    end
    options_array
  end
  
end
