class FieldsValue < ActiveRecord::Base
  
  attr_accessor :value

  belongs_to :resource
  belongs_to :field

  validates_with FieldValueValidator

  after_validation :populate_value_to_table
  # callbacks for delta-indexing resource once a field-value is changed corresponding to a searchable field
  after_save :set_resource_delta_flag
  after_update :set_resource_delta_flag
  after_destroy :set_resource_delta_flag
  # liquid template requirement
  liquid_methods :field, :value


  def is_value_unique?
    attribute = get_column_name
    FieldsValue.where(field_id: field_id).each do |field_value|
      return false if value == field_value.try(attribute) && id != field_value.id
    end
  end

  def value
    if new_record?
      @value
    else
      attribute = get_column_name
      @value ||= try(attribute)
    end
  end

private

  def populate_value_to_table
    attribute = get_column_name.to_s + '='
    send(attribute, value)
  end

  def get_column_name
    "#{ field.input_type.downcase }_val".to_sym
  end

  def set_resource_delta_flag
    unless !field.searchable
      resource_obj = self.resource
      resource_obj.delta = true
      resource_obj.save(validate: false)
    end
  end

end