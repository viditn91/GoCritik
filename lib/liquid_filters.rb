module LiquidFilters

  def get_value_from_field(resource_id, field_id)
    resource = Resource.find_by(id: resource_id)
    field = Field.find_by(id: field_id)
    resource.get_field_value(field)
  end

end