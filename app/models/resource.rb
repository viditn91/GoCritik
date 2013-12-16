class Resource < ActiveRecord::Base

  has_many :fields_values, dependent: :destroy, validate: false
  accepts_nested_attributes_for :fields_values

  validate :validate_associated_fields
 
  after_save :destroy_empty_associated_field_values

  private
  
  def validate_associated_fields
    fields_values.each do |field_value|
      if field_value.invalid?
        field_value.errors.messages[:value].each do |msg|
          errors.add field_value.field.name, msg
        end
      end
    end
  end

  def destroy_empty_associated_field_values
    empty_fields_collection = fields_values.where(value: "")
    fields_values.destroy empty_fields_collection
  end

end