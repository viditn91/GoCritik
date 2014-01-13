module Admin::ResourcesHelper

  def options_array_from_hash(options_hash)
    options_array = []
    options_hash.each do |hash|
      options_array << hash.values
    end
    options_array
  end
  
  def get_field_value_instance(resource, field)
    @resource.fields_values.find_by(field_id: field.id) || 
      @resource.fields_values.find { |fv| fv.field_id == field.id } || 
      @resource.fields_values.build
  end

end
