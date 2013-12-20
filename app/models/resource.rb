class Resource < ActiveRecord::Base
  
  has_many :fields_values, inverse_of: :resource, dependent: :destroy, validate: false
  accepts_nested_attributes_for :fields_values

  before_validation :populate_field_values
  validate :validate_associated_fields

  # after_save :destroy_empty_associated_field_values

private

  def populate_field_values
    fields_values.each do |field_value|
      attribute = "#{field_value.field.input_type.downcase}_val"
      eval "field_value.#{attribute} = field_value.value"
    end
  end
        
  def validate_associated_fields
    fields_values.each do |field_value|
      if field_value.invalid?
        attribute = "#{field_value.field.input_type.downcase}_val".to_sym
        field_value.errors.messages[attribute].try(:each) do |msg|
          errors.add field_value.field.name, msg
        end
      end
    end
  end

  # def destroy_empty_associated_field_values
  #   empty_fields_collection = fields_values.map do |field_value|
  #     field_value if field_value.value.empty?
  #   end
  #   fields_values.destroy empty_fields_collection
  # end
end