module ResourcesHelper
  def get_field_value(resource, field)
    value = resource.fields_values.find_by(field_id: field.id).try(:value) 
    value = get_disp_text(field.options, value) if field.options.present?
    # Showing Check Box value as 'Yes' if checked
    value = "Yes" if field.type == 'CheckBoxField' && value.present?
    # handling boolean value 'false' exception
    value.blank? ? (value == false ? 'false' : '- NA -') : value
  end
end