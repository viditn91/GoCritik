class Resource < ActiveRecord::Base

  has_many :fields_values, dependent: :destroy, validate: false
  accepts_nested_attributes_for :fields_values

  validate :validate_associated_fields

  private
  
  def validate_associated_fields
    fields_values.each do |field_value|
      if field_value.invalid?
        field_value.errors.messages[:value].each do |msg|
          errors.add fields_values.field.name, msg
        end
      end
    end
  end

end
